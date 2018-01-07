package es.ulat.em.framework
{
	// TODO: Move this in the correct place
	public class Endian
	{
		// Byte order of types > 1 bytes
		public static var BYTE_0 : uint = 0;
		public static var BYTE_1 : uint = 1;
		
		// i.e. Byte1 Byte0; with the low-order byte at the lowest memory location
		public static function setLittleEndian() : void {
			BYTE_0 = 0;
			BYTE_1 = 1;
		}

		// i.e. byte0 byte 1; high-order byte at lowest memory location		
		public static function setBigEndian() : void {
			BYTE_0 = 1;
			BYTE_1 = 0;
		}
		

	}
}