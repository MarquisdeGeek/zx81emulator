package es.ulat.em.machines.zx
{
	import com.sgxengine.sgx.core.helpers.DebugConsole;
	import com.sgxengine.sgx.filesystem.SGXFileSystemEvent;
	import com.sgxengine.sgx.filesystem.CSGXFile;
	import com.sgxengine.sgx.filesystem.CSGXFileSystem;
	
	import es.ulat.em.framework.Emulator;
	import es.ulat.em.framework.EmulatorSettings;


	public class ZXBasicEmulator extends Emulator
	{	
		public function ZXBasicEmulator(settings : EmulatorSettings)
		{
			super();
			
			initialize();

			addChild((displayText as ZXBasicDisplay).displayObject);

			setupDebugConsole();
			setupEventListeners();
			
			if (settings.autoStart) {
				startSimulator();
			}
			
			refreshVideo();
		}
		
		protected override function refreshVideo() : void {
			displayText.refreshDisplay(machine.bus, machine.bus.ram.memory);
		}

	}
}