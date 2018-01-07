package  es.ulat.em.machines.zx81
{

	import es.ulat.em.devices.z80.CPUZ80;
	import es.ulat.em.framework.EMFCPU;
	import es.ulat.em.framework.EMFMachine;
	
	import flash.utils.ByteArray;
	import es.ulat.em.machines.zx.ZXBasicInport;
	import es.ulat.em.machines.zx.ZXBasicKeymap;

	public class ZX81 extends EMFMachine
	{
		public var keystate : ByteArray;

		public function ZX81()
		{
			super("zx81");
			
			bus = new ZX81MainBus();
			cpu = new CPUZ80(bus);
			
			keystate = new ByteArray();
			keystate.length = 256;
		}
	
		public override function applyKeyDown(key : uint) : void {
			
			var zxkey : int = ZXBasicKeymap.getKeyFromASCII(key);
			
			if (zxkey == -1) {
				return;
			}
			
			var zxPort : uint = ZXBasicKeymap.keymapdata[zxkey * 3 + 0];
			var zxMask : uint = ZXBasicKeymap.keymapdata[zxkey * 3 + 1];
			var zxShift : uint = ZXBasicKeymap.keymapdata[zxkey * 3 + 2];
			
			
			if (zxShift== 0) {//shift
				keystate[0] &= 0xfe;
			} else {
				keystate[0] |= 0x01;
			}
			//
			(bus.inport as ZXBasicInport).keyports[zxPort] &= zxMask;
			//trace(bus.inport.toString());
			keystate[key] = 1;
			
			//bus.write8(16421, zxkey);
		}
		
		public override function applyKeyUp(key : uint) : void {
			var zxkey : int = ZXBasicKeymap.getKeyFromASCII(key);
			if (zxkey == -1) {
				return;
			}
			
			var zxPort : uint = ZXBasicKeymap.keymapdata[zxkey * 3 + 0];
			var zxMask : uint = ZXBasicKeymap.keymapdata[zxkey * 3 + 1];
			
			(bus.inport as ZXBasicInport).keyports[zxPort] |= ~zxMask;
			//trace(bus.inport.toString());
			
			keystate[key] = 0;
		}

	}
}