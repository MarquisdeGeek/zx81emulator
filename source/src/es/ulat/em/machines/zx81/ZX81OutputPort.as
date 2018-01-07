package es.ulat.em.machines.zx81
{
	import es.ulat.em.devices.z80.CPUZ80;
	import es.ulat.em.framework.EMFDevice;
	import es.ulat.em.framework.EMFPortOutput;
	
	public class ZX81OutputPort extends EMFPortOutput
	{
		private var z80 : CPUZ80;
		
		public function ZX81OutputPort(name_:String)
		{
			super(name_);
		}
		
		public override function initialize() : void {
			super.initialize();
			z80 = EMFDevice.getDeviceCpu("maincpu") as CPUZ80;
		}
		
		public override function write8(port : int, value : int) : void {
			switch(port) {
				case 0xFD:
					z80.bNMIGenerator = false;
					break;
				case 0xFE:
					// The current Flash implementation is a bit too slow to process NMIs all the time
					//z80.bNMIGenerator = true;
					break;
			}
		}
	}
}