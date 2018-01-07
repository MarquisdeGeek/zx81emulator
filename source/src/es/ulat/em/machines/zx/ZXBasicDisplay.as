package es.ulat.em.machines.zx
{
	import com.sgxengine.sgx.graphics.display.SGXDisplayObject;
	
	import es.ulat.em.framework.EMFDisplayDriver;
	import es.ulat.em.framework.EMFMainBus;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class ZXBasicDisplay extends EMFDisplayDriver
	{
		[Embed(source="../../../../../../res/zx/font8.png", mimeType='image/png')]
		private var fontSingle:Class;

		[Embed(source="../../../../../../res/zx/font16.png", mimeType='image/png')]
		private var fontDouble:Class;		

		[Embed(source="../../../../../../res/zx81/keyboard.png", mimeType='image/png')]
		private var keyboardImage:Class;
		
		public var bitmap : BitmapData;
		public var displayObject : SGXDisplayObject;
		
		public var remapCharacters : Boolean = true;
		public var useMemoryMappedFont  : Boolean = false;
		
		private var screenBase : uint = 0x400;
		private var scale : uint = 2;
		private var screenArea : Rectangle;
		
		private var fontZX81:Bitmap;
		private var keyboard:Bitmap;
		
		private var prevChar : ByteArray;
		
		public function ZXBasicDisplay(s : uint)
		{
			scale = s;
			screenArea = new Rectangle(0,0, 320*scale, 240*scale);
			bitmap = new BitmapData(screenArea.width, screenArea.height, false);
			displayObject = new SGXDisplayObject(new Bitmap(bitmap));
			
			if (scale == 1) {
				fontZX81 = new fontSingle();	
			} else {
				fontZX81 = new fontDouble();					
			}
			
			if (scale == 2) {
				keyboard = new keyboardImage();
				var keyDisp : SGXDisplayObject = new SGXDisplayObject(keyboard);
				keyDisp.y = 240*scale + 10;
				displayObject.addChild(keyDisp);
			}
			
			prevChar = new ByteArray();
			prevChar.length = 24*32;
		}

		public static function getASCIIFromCode(code : uint) : uint {
			if (code == 0) {
				return 32;
			} else if (code >= 28 && code < 38) {
				return (code-28) + 48;
			} else if (code >= 38) {
				return (code-38) + 65;
			}
			return 32;
		}
	
		public function getCodeFromASCII(ascii : uint) : uint {
				var zxCode : uint = 19;	// ?
				
				if (ascii == 32) {
					zxCode = 0;
				} else if (ascii >= 48 && ascii < 59) {
					zxCode = (ascii - 48) + 28;
				} else {
					zxCode = (ascii - 65) + 38;
				}
				zxCode = ZXBasicKeymap.getKeyFromASCII(ascii);
				return zxCode;
		}

		public function getMemoryAt(x : int, y : int) : uint {
			var mem : uint = screenBase;
			
			x /= scale;
			y /= scale;
			
			mem += uint(x/8);
			mem += uint(y/8) * 32;
			
			return mem;
		}
		
		// Map the ZX80 character set, into indices in the ZX81 image map
		public static var remapTo81:Vector.<uint> = Vector.<uint>([
			0, 11, 5, 3+128, 1, 2, 4, 7+128, 
			6, 8, 9, 10, 12, 13, 14, 15,
			16, 17, 22, 21, 23, 24, 20, 18, 
			19, 25, 26, 27, 28,/**/ 29, 30, 31,
			32, 33, 34, 35, 36, 37, 38, 39, 
			40, 41, 42, 43, 44, 45, 46, 47,
			48, 49, 50, 51, 52, 53, 54, 55,
			56, 57, 58, 59, 60, 61, 62, 63,
		]);
		
		public function writeCharacter(bus : EMFMainBus, x : int, y : int, character : uint) : void {
			
			if (useMemoryMappedFont) {
				var blankColor : uint = 0xffffff;
				var inkColor : uint = 0;
				
				if (character > 0x80) {	// inverse video
					blankColor = 0;
					inkColor = 0xffffff;
				}
				var ptr : uint = 0x1e00 + (character&0x3f)*8;
				var destRect : Rectangle = new Rectangle(x*8*scale, y*8*scale, 8*scale, 8*scale); 

				bitmap.fillRect(destRect, blankColor);
				for(var yline : uint = 0; yline <8 ;++yline) {
					var v : uint = bus.read8(ptr + yline);
					var mask : uint = 128;
					
					for(var xline : uint = 0; xline <8 ;++xline, mask>>=1) {
						if (v & mask) {
							destRect.right = destRect.left+scale;
							destRect.bottom = destRect.top+scale;
							//bitmap.setPixel(destRect.left+xline, destRect.top+yline, inkColor);
							bitmap.fillRect(destRect, inkColor);
						}
						destRect.left += scale;
						
					}
					destRect.left -= scale * 8;
					destRect.top += scale;
					
				}
			} else {
				if (remapCharacters) {
					character = remapTo81[character & 0x3f] | (character & 0xc0);
				}

				// The image does't have all the characters: just 00-3f followed _immediately_ by 0x80
				if (character >= 0x40 && character < 0x80) {
					character = 31;	// ? for those in the missing zone
				} else if (character >= 0x80) {
					character -= 0x80;
					character += 64;
				}
				
				var destPoint : Point = new Point(x*8*scale, y*8*scale); 
				var sourceRect : Rectangle = new Rectangle((24 + (character%16)*16)*scale, (20 + ((uint)(character/16))*16)*scale, 8*scale, 8*scale);
				
				bitmap.copyPixels(fontZX81.bitmapData, sourceRect, destPoint);
			}
		}
		
		public function sgxRand(n : int) : int {
			return Math.random() * n;
		}
		
		public override function refreshDisplay(bus : EMFMainBus, ram : ByteArray) : void {

			var ptr : uint = bus.read16(0x400c);
			
			++ptr;	// skip HALT (as every emu appears to do)
			
			if (ptr == 0) {
				return;	// D_FILE is not initialized
			}
			
			for(var y : int = 0; y<24; ++y) {
				for(var x : int = 0; x < 32;++x) {
					var c : uint = bus.read8(ptr);
					
					if (c == 0x76) {
						// TODO: OPT: Just break out of the x loop
						c = 0;
						--ptr;
					} else {
						c &= 0xbf; 	// mask bit 6
					}
					
					// The quick (low-res way) is to use the pre-built font
					if (prevChar[y*32 + x] != c) {
						writeCharacter(bus, x, y, c);
						prevChar[y*32 + x] = c;
					}
					
					++ptr;
				}
				++ptr;
				
			}
		}

	
	}
}