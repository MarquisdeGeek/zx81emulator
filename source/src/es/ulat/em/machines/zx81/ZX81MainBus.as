package es.ulat.em.machines.zx81
{
	import es.ulat.em.devices.z80.CPUZ80;
	import es.ulat.em.framework.EMFCPU;
	import es.ulat.em.framework.EMFPortInput;
	import es.ulat.em.framework.EMFLogger;
	import es.ulat.em.framework.EMFMemoryChip;
	import es.ulat.em.framework.EMFPortOutput;
	import es.ulat.em.framework.EMFUtils;
	import es.ulat.em.machines.zx.ZXBasicDisplay;
	import es.ulat.em.machines.zx.ZXBasicInport;
	import es.ulat.em.framework.EMFMainBus;

	public class ZX81MainBus extends EMFMainBus
	{		
		public function ZX81MainBus()
		{
			super("mainbus");
			
			rom = new EMFMemoryChip("ROM", 8192);
			ram = new EMFMemoryChip("RAM", 16384);
			
			inport = new ZXBasicInport("in");
			outport = new ZX81OutputPort("out");
		}
		
		public function readString(address : uint) : String {
			var s : String = "";
			var character : uint;
			do {
				character = read8(address);
				s += String.fromCharCode(ZXBasicDisplay.getASCIIFromCode(character & 0x7f));
				++address;
			} while(character < 128);
			//
			return s;				
		}
		
		public override function read8(address : uint) : uint
		{
			address &= 0xffff;

			if (address >= 0 && address < 8192) {	// main ROM
				return rom.read8(address);
			}
			if (address >= 8192 && address < 16384) {	// shadow
				return rom.read8(address-8192);
			}
			if (address >= 16384 && address < 32768) {
				return ram.read8(address-16384);
			}
			// ASSERT, technically
			return 0;
		}
		
		public override function write8(address : uint, data : uint) : void
		{
			address &= 0xffff;
			
			if (address >= 16384 && address < 32768) {
				return ram.write8(address-16384, data);
			}
		}
		
	}
}