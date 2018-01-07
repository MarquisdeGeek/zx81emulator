package es.ulat.em.framework
{
	public class EMFUtils
	{
		public static function getHex8(v : uint) : String
		{
			return (("00"+v.toString(16)).substr(-2))+"H";
		}
		
		public static function getHex16(v : uint) : String
		{
			return (("0000"+v.toString(16)).substr(-4))+"H";
		}
		
		public static function getHex24(v : uint) : String
		{
			return (("0000"+v.toString(16)).substr(-6))+"H";
		}
		
		public static function getHex32(v : uint) : String
		{
			return (("0000"+v.toString(16)).substr(-8))+"H";
		}
		
		
		public static function getBin32(v : uint) : String
		{
			return (("00000000"+v.toString(2)).substr(-8));
		}
		
		public static function getBin16(v : uint) : String
		{
			return (("0000000000000000"+v.toString(2)).substr(-16));
		}
		
		public static function getBin8(v : uint) : String
		{
			return (("0000000000000000"+v.toString(2)).substr(-8));
		}
		
		
		public static function bin2Dec(b : String) : uint
		{
			var decimal : uint = 0;
			var multiplier : uint = 1;
			for(var i : int = b.length; i>0;) {
				--i;
				decimal += b.charAt(i)=='0' ? 0 : multiplier;
				multiplier *= 2;
			}
				
			return decimal;
		}
		
		public static function bin2Hex(b : String) : String
		{
			var decimal : uint = bin2Dec(b);
			
			if (decimal < 256) {
				return getHex8(decimal);
			}
			if (decimal < 65536) {
				return getHex16(decimal);
			}
			if (decimal < 65536*256) {
				return getHex24(decimal);
			}
			return getHex32(decimal);
		}
		
		public static function evalInput(v : String) : uint
		{
			return 0;	// TODO: parse H and 0x etc...
		}
	}
}