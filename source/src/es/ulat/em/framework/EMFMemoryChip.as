package es.ulat.em.framework
{
	import flash.utils.ByteArray;

	public class EMFMemoryChip extends EMFDevice
	{
		public var memory : ByteArray;
		
		public function EMFMemoryChip(name : String, size : uint)
		{
			super(name);
			
			memory = new ByteArray();
			memory.length = size;
		}
		
		public function read8(address : uint) : uint
		{
			return memory[address];
		}
		
		public function write8(address : uint, data : uint) : void
		{
			memory[address] = data;
		}
		
		public function importBlock(address : uint, data : ByteArray) : void
		{
			for(var d : uint = 0;d<data.length;++d) {
				write8(address, data[d]);
				++address;
			}
		}
	}
}