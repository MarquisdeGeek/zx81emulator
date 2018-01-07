package es.ulat.em.framework
{
	import flash.utils.ByteArray;

	public class EMFMainBus extends EMFDevice
	{
		public var rom : EMFMemoryChip;
		public var ram : EMFMemoryChip;
		public var inport : EMFPortInput;
		public var outport : EMFPortOutput;
		
		public function EMFMainBus(name_:String)
		{
			super(name_);
		}
		
		public override function initialize() : void {
			super.initialize();
			
			rom.initialize();
			ram.initialize();
			inport.initialize();
			outport.initialize();
		}
		
		public function read8(address : uint) : uint {
			return 0;	
		}
		
		public function write8(address : uint, data : uint) : void {
		}
		
		public function read16(address : uint) : uint
		{
			return read8(address + Endian.BYTE_0) + read8(address + Endian.BYTE_1) * 256;
		}
		
		public function write16(address : uint, data : uint) : void
		{
			write8(address + Endian.BYTE_0, (data & 0xff));
			write8(address + Endian.BYTE_1, (data & 0xff00) >> 8);
		}	
		
		public function writeBlock(address : uint, data : ByteArray) : void
		{
			for(var d : uint = 0;d<data.length;++d) {
				write8(address, data[d]);
				++address;
			}
		}
		
		public function hexRow(address : uint, columns : uint) : String {
			var pad : String = "0000";
			var s : String = (pad+address.toString(16)).substr(-4) + " : ";
			
			for(var a : uint = address; a < address + columns; ++a) {
				var byte : uint = read8(a);
				if (byte < 16) {
					s += "0";
				}
				s += byte.toString(16);
				s += " ";
			}
			
			return s;
		}
		
	}
}