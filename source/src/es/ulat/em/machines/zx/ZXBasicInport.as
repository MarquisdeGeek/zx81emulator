package es.ulat.em.machines.zx
{
	import es.ulat.em.framework.EMFPortInput;
	
	import flash.utils.ByteArray;

	public class ZXBasicInport extends EMFPortInput
	{
		public var keyports : ByteArray;

		public function ZXBasicInport(name_:String)
		{
			super(name_);
			
			keyports = new ByteArray();
			keyports.length = 9;
			for(var i : uint = 0;i<9;++i) {
				keyports[i] = 0xff;
			}
		}
		
		public override function toString() : String {
			var s : String = "Keys: ";
			s += keyports[0]+" "+keyports[1]+" "+keyports[2]+" "+keyports[3]+" "+keyports[4]+" "+keyports[5]+" "+keyports[6]+" "+keyports[7];
			return s;
		}

		public override function read8(port : uint) : int {
			var high : uint = (port >> 8) & 0xff;
			var low : uint = (port & 0xff);
			
			if(!(low&4)) low=0xfb;
			if(!(low&1)) low=0xfe;
			//
			var tapezeromask : uint = 0x80;// saw this elsewhere, and used it
			switch(low) {
				case 0xFB:
					// Printer
					return 0;
					
				case 0xFE:
					// TODO: hsync et al
					
					// Normal keyboard stuff
					switch(high)
					{
						case 0xfe:	return((keyports[0]^tapezeromask));
						case 0xfd:	return((keyports[1]^tapezeromask));
						case 0xfb:	return((keyports[2]^tapezeromask));
						case 0xf7:	return((keyports[3]^tapezeromask));
						case 0xef:	return((keyports[4]^tapezeromask));
						case 0xdf:	return((keyports[5]^tapezeromask));
						case 0xbf:	return((keyports[6]^tapezeromask));
						case 0x7f:	return((keyports[7]^tapezeromask));
						
						default:
							var i : uint;
							var mask : uint;
							var retval : uint = 0xff;
							
							/* some games (e.g. ZX Galaxians) do smart-arse things
							* like zero more than one bit. What we have to do to
							* support this is AND together any for which the corresponding
							* bit is zero.
							*/
							
							for(i=0,mask=1;i<8;i++,mask<<=1) {
								if(!(high&mask)) {
									retval &= keyports[i];
								}
							}
							return((retval^tapezeromask));
					}
			}
/*
			
			unsigned int 
			in(int h,int l)
			{
			int ts=0;		/* additional cycles*256 /
			int tapezeromask=0x80;	/* = 0x80 if no tape noise (?) /
			
			
			switch(l)
			{
				case 0xfb:
					return(printer_inout(0,0));
					
				case 0xfe:
					/* also disables hsync/vsync if nmi off
					* (yes, vsync requires nmi off too, Flight Simulation confirms this)
					*
					if(!nmigen)
					{
						hsyncgen=0;
						
						/* if vsync was on before, record position 
						if(!vsync)
							vsync_raise();
						vsync=1;
						#ifdef OSS_SOUND_SUPPORT
						sound_beeper(vsync);
						#endif
					}
					
					switch(h)
					{
						case 0xfe:	return(ts|(keyports[0]^tapezeromask));
						case 0xfd:	return(ts|(keyports[1]^tapezeromask));
						case 0xfb:	return(ts|(keyports[2]^tapezeromask));
						case 0xf7:	return(ts|(keyports[3]^tapezeromask));
						case 0xef:	return(ts|(keyports[4]^tapezeromask));
						case 0xdf:	return(ts|(keyports[5]^tapezeromask));
						case 0xbf:	return(ts|(keyports[6]^tapezeromask));
						case 0x7f:	return(ts|(keyports[7]^tapezeromask));
						default:
						{
							int i,mask,retval=0xff;
							
							/* some games (e.g. ZX Galaxians) do smart-arse things
							* like zero more than one bit. What we have to do to
							* support this is AND together any for which the corresponding
							* bit is zero.
							
							for(i=0,mask=1;i<8;i++,mask<<=1)
								if(!(h&mask))
									retval&=keyports[i];
							return(ts|(retval^tapezeromask));
						}
					}
					break;
			}
			
			return(ts|255);
		}
*/
			return 0;
		}
	}
}