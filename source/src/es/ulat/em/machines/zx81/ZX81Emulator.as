package es.ulat.em.machines.zx81
{
	import com.sgxengine.sgx.core.helpers.DebugConsole;
	import com.sgxengine.sgx.filesystem.*;
	import com.sgxengine.sgx.filesystem.CSGXFile;
	import com.sgxengine.sgx.filesystem.CSGXFileSystem;
	
	import es.ulat.em.devices.z80.CPUZ80;
	import es.ulat.em.framework.EmulatorSettings;
	import es.ulat.em.machines.zx.ZXBasicDisplay;
	import es.ulat.em.machines.zx.ZXBasicEmulator;
	
	public class ZX81Emulator extends ZXBasicEmulator
	{
		[Embed(source="../../../../../../../../res/machines/zx81/zx81.rom", mimeType='application/octet-stream')]
		private var zx81ROM:Class;		

		public var canLoad : Boolean;	 // a mutex to stop two requests happening at once
		
		public function ZX81Emulator(settings : EmulatorSettings)
		{
			displayText = new ZXBasicDisplay(settings.displayScale);

			canLoad = true;
		
			machine = new ZX81();	
			machine.bus.rom.importBlock(0, new zx81ROM());
			machine.cpu.addHook(0x347, loadZX81);
			(displayText as ZXBasicDisplay).remapCharacters = false;

			super(settings);
		}
		
		protected function loadZX81() : Boolean {
			if (!canLoad) {
				return false;
			}
			
			var filename : String = (machine.bus as ZX81MainBus).readString((machine.cpu as CPUZ80).de);
			filename = "http://em.ulat.es/res/machines/zx81/software/" + filename;
			filename = filename.toLowerCase();
			filename += ".p";
			
			canLoad = false;
			
			var res : CSGXFile = CSGXFileSystem.instance.importFile(filename);
			
			res.addEventListener(SGXFileSystemEvent.FILE_FAILED, function(e : SGXFileSystemEvent) : void {
				DebugConsole.log(0, "Failed to load '"+filename+"'...");
				machine.cpu.setRegister("pc", 0x0207);
				canLoad = true;
			});

			res.addEventListener(SGXFileSystemEvent.FILE_LOADED, function(e : SGXFileSystemEvent) : void {
				
				machine.bus.writeBlock(0x4009, e.fileRef.data);
				machine.cpu.setRegister("pc", 0x0207);
				
				DebugConsole.log(0, "File '"+filename+"' loaded OK.");
				canLoad = true;
				displayText.refreshDisplay(machine.bus, machine.bus.ram.memory);
			});
			
			return false;
		}
		
		protected override function refreshVideo() : void {
			displayText.refreshDisplay(machine.bus, machine.bus.ram.memory);
		}

	}
}