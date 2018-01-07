package es.ulat.em.machines.zx
{
	public class ZXBasicKeymap
	{
		private static var keymap : Array;
		
		public static function buildKeyMap() : void
		{
			keymap = new Array();
			
			for (var idx : uint = 0; idx<layout.length;++idx) {
				keymap[layout.charCodeAt(idx)] = idx;
			} 
		}
		
		public static function isValidKeycode(code : uint) : Boolean
		{
			return keymap[code] == null ? false : true;
		}
		
		public static function getKeyFromASCII(code : uint) : int
		{
			
			if (keymap == null) {
				buildKeyMap();
			} 
			
			if (code == 13 || code == 10) {
				return 12 * 8 + 0;	// new line
			} else if (code == 16) {
				return 12 * 8 + 1;	// shift
			}
			return keymap[code] == null ? -1 : keymap[code];
		}
		
		private static var layout : String = 
			" ?\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
			
		public static var keymapdata:Vector.<uint> = Vector.<uint>([
			/*  SP      !          "          #          $          %          &          '  */
			7,0xfe,0,   8,0xff,0,   3,0xfd,1,   8,0xff,0,   5,0xf7,1,   8,0xff,0,   8,0xff,0,   8,0xff,0,
			/*  (       )          *          +          ,          -          .          /  */
			5,0xfb,1,   5,0xfd,1,   4,0xfb,1,   6,0xfb,1,   7,0xfd,1,   6,0xf7,1,   7,0xfd,0,   0,0xef,1,
			/*  0       1          2          3          4        5        6        7  */
			4,0xfe,0,   3,0xfe,0,   3,0xfd,0,   3,0xfb,0,   3,0xf7,0,   3,0xef,0,   4,0xef,0,   4,0xf7,0,
			/*  8       9          :          ;          <          =          >          ?  */
			4,0xfb,0,   4,0xfd,0,   0,0xfd,1,   0,0xfb,1,   7,0xf7,1,   6,0xfb,1,   7,0xfb,1,   0,0xef,1,
			/*  @       A          B          C          D          E          F        G  */
			8,0xff,0,   1,0xfe,0,   7,0xef,0,   0,0xf7,0,   1,0xfb,0,   2,0xfb,0,   1,0xf7,0,   1,0xef,0,
			/*  H       I          J          K          L        M        N        O  */
			6,0xef,0,   5,0xfb,0,   6,0xf7,0,   6,0xfb,0,   6,0xfd,0,   7,0xfb,0,   7,0xf7,0,   5,0xfd,0,
			/*  P       Q          R          S          T        U        V        W  */
			5,0xfe,0,   2,0xfe,0,   2,0xf7,0,   1,0xfd,0,   2,0xef,0,   5,0xf7,0,   0,0xef,0,   2,0xfd,0,
			/*  X       Y          Z          [          \        ]        ^        _  */
			0,0xfb,0,   5,0xef,0,   0,0xfd,0,   8,0xff,0,   8,0xff,0,   8,0xff,0,   8,0xff,0,   8,0xff,0,
			/*  `       a          b          c          d        e        f        g  */
			8,0xff,0,   1,0xfe,0,   7,0xef,0,   0,0xf7,0,   1,0xfb,0,   2,0xfb,0,   1,0xf7,0,   1,0xef,0,
			/*  h       i          j          k          l        m        n        o  */
			6,0xef,0,   5,0xfb,0,   6,0xf7,0,   6,0xfb,0,   6,0xfd,0,   7,0xfb,0,   7,0xf7,0,   5,0xfd,0,
			/*  p       q          r          s          t        u        v          w  */
			5,0xfe,0,   2,0xfe,0,   2,0xf7,0,   1,0xfd,0,   2,0xef,0,   5,0xf7,0,   0,0xef,0,   2,0xfd,0,
			/*  x       y          z            {               |        }            ~          DEL */
			0,0xfb,0,   5,0xef,0,   0,0xfd,0,   8,0xff,0,   8,0xff,0,   8,0xff,0,   8,0xff,0,   4,0xfe,1,
			/* ENTER    SHIFT  */
			6,0xfe,0,   0,0xfe,0,
			
			/*  EDIT    AND        THEN       TO         LEFT       DOWN      UP */
			3,0xfe,1,   3,0xfd,1,   3,0xfb,1,   3,0xf7,1,   3,0xef,1,   4,0xef,1,   4,0xf7,1,
			/*  LEFT    GRAPHICS   RUBOUT */
			4,0xfb,1,   4,0xfd,1,   4,0xfe,1,
			
			2,0xfe,1, /* DBLDBLQUOTE */
			2,0xfd,1, /* OR */
			2,0xfb,1, /* STEP */
			2,0xf7,1, /* LE */
			2,0xef,1, /* NE */
			5,0xef,1, /* GE */
			1,0xfe,1, /* STOP */
			
			1,0xfd,1, /* LPRINT */
			1,0xfb,1, /* SLOW */
			1,0xf7,1, /* FAST */
			1,0xef,1, /* LLIST */
			6,0xef,1, /* DBLSTAR */
			6,0xfe,1, /* FUNCTION */
			7,0xfe,1  /* POUND */
		]);

	}
}