package es.ulat.em.devices.z80
{
	import es.ulat.em.framework.EMFCPU;
	import es.ulat.em.framework.EMFLogger;
	import es.ulat.em.framework.EMFMainBus;
	import es.ulat.em.framework.EMFUtils;
	
	public class CPUZ80 extends EMFCPU
	{
		
		public var cc_bit_0 : uint;
		public var cc_bit_1 : uint;
		public var cc_bit_2 : uint;	// v/p
		public var cc_bit_3 : uint;
		public var cc_bit_4 : uint;
		public var cc_bit_5 : uint;
		public var cc_bit_6 : uint;	// z
		public var cc_bit_7 : uint;	// s
		
		public var inHalt : Boolean;
		public var interruptEnabled : Boolean;
		public var interruptMode : uint;
		public var iff1 : uint;
		public var iff2 : uint;
		public var memrefresh : uint;
		public var radjust : uint;
		public var intv : uint;
		public var tstates : uint;
		public var iNMIFakeTStateCount : uint;
		
		public var bNMIGenerator : Boolean;
		public var interruptSample : Boolean;
		public var nmiPending : Boolean;
		public var interruptPending : Boolean;
		
		public function CPUZ80(bus : EMFMainBus)
		{
			super("maincpu", bus, 890000);
			
			//instance = this;
			iNMIFakeTStateCount = 208;
			
			coldStart();
		}
		
		public override function coldStart() : void
		{
			warmStart();
		}
		
		public override function warmStart() : void
		{
			pc = 0;
			cc_bit_3 = cc_bit_5 = 1;
			memrefresh = 0;		
			tstates = 0;
			interruptSample = true;
			bNMIGenerator = false;
			nmiPending = false;
			radjust=0xCA;
			intv = 0x1E;
			inHalt = false;
			im1();
		}
		
		public function read8(address : uint) : uint {
			return bus.read8(address);
		}
		
		public function read16(address : uint) : uint {
			return bus.read16(address);
		}
		
		public function write8(address : uint, data : uint) : void {
			bus.write8(address, data);
		}
		
		public function write16(address : uint, data : uint) : void {
			bus.write16(address, data);
		}
		//
		public override function getDisassemblyObject(addr : uint) : Object {
			return DisassembleZ80.disassemble(bus, addr);
		}
		
		public override function getAssemblerHex(str : String) : String {
			return AssembleZ80.getHex(str);
		}
		
		public override function toString() : String {
			var s : String = registersAsString();
			s += "\nFlags : ";
			s += (cc_bit_7) ? "s" : "-";
			s += (cc_bit_6) ? "z" : "-";
			s += (cc_bit_5) ? "?" : "-";
			s += (cc_bit_4) ? "h" : "-";
			s += (cc_bit_3) ? "?" : "-";
			s += (cc_bit_2) ? "v" : "-";
			s += (cc_bit_1) ? "n" : "-";
			s += (cc_bit_0) ? "c" : "-";
			s += "\n";
			
			return s;
		}
		//
		public var reg_a : int;
		public function set a(v : int) : void {
			reg_a = v;
		}
		public function get a() : int {
			return reg_a;
		}
		public var reg_b : int;
		public function set b(v : int) : void {
			reg_b = v;
		}
		public function get b() : int {
			return reg_b;
		}
		public var reg_c : int;
		public function set c(v : int) : void {
			reg_c = v;
		}
		public function get c() : int {
			return reg_c;
		}
		public var reg_d : int;
		public function set d(v : int) : void {
			reg_d = v;
		}
		public function get d() : int {
			return reg_d;
		}
		public var reg_e : int;
		public function set e(v : int) : void {
			reg_e = v;
		}
		public function get e() : int {
			return reg_e;
		}
		public var reg_hl : int;
		public function set hl(v : int) : void {
			reg_hl = v;
			if (reg_hl == 0x41fa || reg_hl == 0x421b) {
				//trace("HL change: pc="+pc);				
			}
		}
		public function get hl() : int {
			return reg_hl;
		}
		public function set h(v : int) : void {
			reg_hl &= 0x00ff;
			reg_hl |= v<<8;
		}
		public function get h() : int {
			return reg_hl>>8;
		}
		public function set l(v : int) : void {
			reg_hl &= 0xff00;
			reg_hl |= v&0xff;
		}
		public function get l() : int {
			return reg_hl&0xff;
		}
		
		public var reg_sp : int;
		public function set sp(v : int) : void {
			reg_sp = v;
		}
		public function get sp() : int {
			return reg_sp;
		}
		public function set s(v : int) : void {
			reg_sp &= 0x00ff;
			reg_sp |= v<<8;
		}
		public function get s() : int {
			return reg_sp>>8;
		}
		public function set p(v : int) : void {
			reg_sp &= 0xff00;
			reg_sp |= v&0xff;
		}
		public function get p() : int {
			return reg_sp&0xff;
		}
		public var reg_ix : int;
		public function set ix(v : int) : void {
			reg_ix = v;
		}
		public function get ix() : int {
			return reg_ix;
		}
		
		public function set x(v : int) : void {
			reg_ix &= 0xff00;
			reg_ix |= v&0xff;
		}
		public function get x() : int {
			return reg_ix&0xff;
		}
		public var reg_iy : int;
		public function set iy(v : int) : void {
			reg_iy = v;
		}
		public function get iy() : int {
			return reg_iy;
		}
		public function set y(v : int) : void {
			reg_iy &= 0xff00;
			reg_iy |= v&0xff;
		}
		public function get y() : int {
			return reg_iy&0xff;
		}
		// combined register pairs
		public function get f() : int {
			return (cc_bit_0<<0) | (cc_bit_1<<1) | (cc_bit_2<<2) | (cc_bit_3<<3) | (cc_bit_4<<4) | (cc_bit_5<<5) | (cc_bit_6<<6) | (cc_bit_7<<7);
		}
		public function set f(v : int) : void {
			cc_bit_0 = (v&0x01)>>0;
			cc_bit_1 = (v&0x02)>>1;
			cc_bit_2 = (v&0x04)>>2;
			cc_bit_3 = (v&0x08)>>3;
			cc_bit_4 = (v&0x10)>>4;
			cc_bit_5 = (v&0x20)>>5;
			cc_bit_6 = (v&0x40)>>6;
			cc_bit_7 = (v&0x80)>>7;
		}
		public function get af() : int {
			return (reg_a << 8) | f;
		}
		
		public function set af(v : int) : void {
			reg_a = v>>8;
			f = v&255;
		}
		
		public function set bc(v : int) : void {
			reg_b = v>>8;
			reg_c = v&0xff;
		}
		public function get bc() : int {
			return (reg_b << 8) | reg_c;
		}
		public function set de(v : int) : void {
			reg_d = v>>8;
			reg_e = v&0xff;
		}
		public function get de() : int {
			return (reg_d << 8) | reg_e;
		}
		// secondary register set
		public var reg_dep : int;
		public function set dep(v : int) : void {
			reg_dep = v;
		}
		public function get dep() : int {
			return reg_dep;
		}
		public var reg_hlp : int;
		public function set hlp(v : int) : void {
			reg_hlp = v;
		}
		public function get hlp() : int {
			return reg_hlp;
		}
		
		
		public var reg_ap : int;
		public function set ap(v : int) : void {
			reg_ap = v;
		}
		public function get ap() : int {
			return reg_ap;
		}
		public var reg_fp : int;
		public function set fp(v : int) : void {
			reg_fp = v;
		}
		public function get fp() : int {
			return reg_fp;
		}		
		public var reg_bcp : int;
		public function set bcp(v : int) : void {
			reg_bcp = v;
		}
		public function get bcp() : int {
			return reg_bcp;
		}
		
		//
		
		public function registersAsString() : String {
			var s : String = "";
			s += "a:"+EMFUtils.getHex16(a)+" ("+a+")   ";
			s += "b:"+EMFUtils.getHex16(b)+" ("+b+")   ";
			s += "c:"+EMFUtils.getHex16(c)+" ("+c+")   ";
			s += "d:"+EMFUtils.getHex16(d)+" ("+d+")   ";s += "\n";
			s += "e:"+EMFUtils.getHex16(e)+" ("+e+")   ";
			s += "h:"+EMFUtils.getHex16(h)+" ("+h+")   ";
			s += "l:"+EMFUtils.getHex16(l)+" ("+l+")   ";
			s += "f:"+EMFUtils.getHex16(f)+" ("+f+")   ";s += "\n";
			s += "bc:"+EMFUtils.getHex16(bc)+" ("+bc+")   ";
			s += "de:"+EMFUtils.getHex16(de)+" ("+de+")   ";
			s += "hl:"+EMFUtils.getHex16(hl)+" ("+hl+")   ";
			s += "pc:"+EMFUtils.getHex16(pc)+" ("+pc+")   ";s += "\n";
			s += "sp:"+EMFUtils.getHex16(sp)+" ("+sp+")   ";
			s += "ix:"+EMFUtils.getHex16(ix)+" ("+ix+")   ";
			s += "iy:"+EMFUtils.getHex16(iy)+" ("+iy+")   ";
			s += "ap:"+EMFUtils.getHex16(ap)+" ("+ap+")   ";s += "\n";
			s += "fp:"+EMFUtils.getHex16(fp)+" ("+fp+")   ";
			s += "bcp:"+EMFUtils.getHex16(bcp)+" ("+bcp+")   ";
			s += "dep:"+EMFUtils.getHex16(dep)+" ("+dep+")   ";
			s += "hlp:"+EMFUtils.getHex16(hlp)+" ("+hlp+")   ";
			s += "i:"+EMFUtils.getHex16(intv)+" ("+intv+")   \n";			
			s += "r:"+EMFUtils.getHex16(memrefresh)+" ("+memrefresh+")   \n";			
			return s;
		}
		public override function preChangeCheck() : Object {
			var obj : Object = new Object();
			obj.a = a;
			obj.b = b;
			obj.c = c;
			obj.d = d;
			obj.e = e;
			obj.h = h;
			obj.l = l;
			obj.f = f;
			obj.bc = bc;
			obj.de = de;
			obj.hl = hl;
			obj.pc = pc;
			obj.sp = sp;
			obj.ix = ix;
			obj.iy = iy;
			obj.ap = ap;
			obj.fp = fp;
			obj.bcp = bcp;
			obj.dep = dep;
			obj.hlp = hlp;
			return obj;
		}
		public override function postChangeCheck(original : Object) : String {
			if (original==null) return "";
			var obj : Object = preChangeCheck();
			var s : String = "";
			if (obj.a != original.a) s+="a:"+EMFUtils.getHex16(obj.a)+"  ("+obj.a+") ";
			if (obj.b != original.b) s+="b:"+EMFUtils.getHex16(obj.b)+"  ("+obj.b+") ";
			if (obj.c != original.c) s+="c:"+EMFUtils.getHex16(obj.c)+"  ("+obj.c+") ";
			if (obj.d != original.d) s+="d:"+EMFUtils.getHex16(obj.d)+"  ("+obj.d+") ";
			if (obj.e != original.e) s+="e:"+EMFUtils.getHex16(obj.e)+"  ("+obj.e+") ";
			if (obj.h != original.h) s+="h:"+EMFUtils.getHex16(obj.h)+"  ("+obj.h+") ";
			if (obj.l != original.l) s+="l:"+EMFUtils.getHex16(obj.l)+"  ("+obj.l+") ";
			if (obj.f != original.f) s+="f:"+EMFUtils.getHex16(obj.f)+"  ("+obj.f+") ";
			if (obj.bc != original.bc) s+="bc:"+EMFUtils.getHex16(obj.bc)+"  ("+obj.bc+") ";
			if (obj.de != original.de) s+="de:"+EMFUtils.getHex16(obj.de)+"  ("+obj.de+") ";
			if (obj.hl != original.hl) s+="hl:"+EMFUtils.getHex16(obj.hl)+"  ("+obj.hl+") ";
			if (obj.pc != original.pc) s+="pc:"+EMFUtils.getHex16(obj.pc)+"  ("+obj.pc+") ";
			if (obj.sp != original.sp) s+="sp:"+EMFUtils.getHex16(obj.sp)+"  ("+obj.sp+") ";
			if (obj.ix != original.ix) s+="ix:"+EMFUtils.getHex16(obj.ix)+"  ("+obj.ix+") ";
			if (obj.iy != original.iy) s+="iy:"+EMFUtils.getHex16(obj.iy)+"  ("+obj.iy+") ";
			if (obj.ap != original.ap) s+="ap:"+EMFUtils.getHex16(obj.ap)+"  ("+obj.ap+") ";
			if (obj.fp != original.fp) s+="fp:"+EMFUtils.getHex16(obj.fp)+"  ("+obj.fp+") ";
			if (obj.bcp != original.bcp) s+="bcp:"+EMFUtils.getHex16(obj.bcp)+"  ("+obj.bcp+") ";
			if (obj.dep != original.dep) s+="dep:"+EMFUtils.getHex16(obj.dep)+"  ("+obj.dep+") ";
			if (obj.hlp != original.hlp) s+="hlp:"+EMFUtils.getHex16(obj.hlp)+"  ("+obj.hlp+") ";
			return s;
		}
		public override function getRegister(reg : String) : uint {
			if (reg == "a") return a;
			if (reg == "b") return b;
			if (reg == "c") return c;
			if (reg == "d") return d;
			if (reg == "e") return e;
			if (reg == "h") return h;
			if (reg == "l") return l;
			if (reg == "f") return f;
			if (reg == "bc") return bc;
			if (reg == "de") return de;
			if (reg == "hl") return hl;
			if (reg == "pc") return pc;
			if (reg == "sp") return sp;
			if (reg == "ix") return ix;
			if (reg == "iy") return iy;
			if (reg == "ap") return ap;
			if (reg == "fp") return fp;
			if (reg == "bcp") return bcp;
			if (reg == "dep") return dep;
			if (reg == "hlp") return hlp;
			return 0;
		}
		public override function setRegister(reg : String, value : uint) : void {
			if (reg == "a") a = value;
			if (reg == "b") b = value;
			if (reg == "c") c = value;
			if (reg == "d") d = value;
			if (reg == "e") e = value;
			if (reg == "h") h = value;
			if (reg == "l") l = value;
			if (reg == "f") f = value;
			if (reg == "bc") bc = value;
			if (reg == "de") de = value;
			if (reg == "hl") hl = value;
			if (reg == "pc") pc = value;
			if (reg == "sp") sp = value;
			if (reg == "ix") ix = value;
			if (reg == "iy") iy = value;
			if (reg == "ap") ap = value;
			if (reg == "fp") fp = value;
			if (reg == "bcp") bcp = value;
			if (reg == "dep") dep = value;
			if (reg == "hlp") hlp = value;
		}
		
		
		// utility methods
		private var wasOverflow : uint;
		private var wasCarry : uint;
		private var wasHalfCarry : Boolean;
		public function sign(v : uint) : uint {
			return v & 0x80 ? 1 : 0;
		}
		public function sign16(v : uint) : uint {
			return v & 0x8000 ? 1 : 0;
		}
		public function zero(v : uint) : uint {
			return v == 0 ? 1 : 0;
		}
		public function halfcarry(v : uint) : uint {
			// ((a&0x0f)+(z&0x0f)+(c)>15)
			return wasHalfCarry ? 1 : 0;
		}
		public function overflow(v : uint) : uint {
			// adda(x,c)
			// a=a+x+c
			// (((~a^z)&0x80&(y^a))>>5) [z = last, y=sum
			return wasOverflow;
		}
		public function parity(v : uint) : uint {
			var bits : int = 0;
			for(var i:int = 0;i<8;++i) {
				if (v & (1<<i)) {
					++bits;
				}
			}
			return (bits&1)==0 ? 1 : 0;
		}
		public function carry(v : uint) : uint {
			return wasCarry;
		}
		
		public function complement(v1 : uint) : uint {
			return ~v1;
		}
		
		public static var flagHalfCarryAdd:Vector.<Boolean> = Vector.<Boolean>([ false, true,true,true,false,false,false,true]);
		public static var flagHalfCarrySub:Vector.<Boolean> = Vector.<Boolean>([ false, false,true,false,true,false,true,true]);
		
		public function add8(v1 : uint, v2 : uint, v3 : uint = 0) : uint {
			var result : uint = (v1+v2+v3);
			wasCarry = result > 0xff ? 1 : 0;
			
			// Did the calculation in the lowest 4 bits spill over into the upper 4 bits
			//wasHalfCarry = ((v1&0x0f)+(v2&0x0f)+v3) > 0xf ? 1 : 0;
			
			// The MSB is same on both src params, but changed between result and src param1
			var lookup : uint = ( (v1 & 0x88) >> 3 ) | ( ( (v2) & 0x88 ) >> 2 ) | ( (result & 0x88) >> 1 );
			wasHalfCarry = flagHalfCarryAdd[(lookup&7)];
			lookup >>= 4;			
			wasOverflow = (lookup==3 || lookup==4) ? 1 : 0;
			//			wasOverflow = ((v1&0x80) == (v2&0x80)) && (v1&0x80) != (result&0x80) ? 1 : 0;
			
			result &= 0xff;
			return result & 0xff;
		}
		
		public function add16(v1 : uint, v2 : uint, v3 : uint = 0) : uint {
			var result : uint = (v1+v2+v3);
			wasCarry = result > 0xffff ? 1 : 0;
			
			// 16 bit adds set 'H' on overflow of bit 11 (!?)
			//wasHalfCarry = ((v1&0xfff)+(v2&0xfff)+v3) > 0xfff ? 1 : 0;
			
			// The MSB is same on both src params, but changed between result and src param1
			var lookup : uint = ( (v1 & 0x8800) >> 11 ) | ( ( (v2) & 0x8800 ) >> 10 ) | ( (result & 0x8800) >> 9 );
			wasHalfCarry = flagHalfCarryAdd[(lookup&7)];
			lookup >>= 4;
			wasOverflow = (lookup==3 || lookup==4) ? 1 : 0;		// TODO: not convinced any Z80 instr checks the 'V' flag fter 16 bit adds
			//			wasOverflow = ((v1&0x8000) == (v2&0x8000)) && (v1&0x8000) != (result&0x8000) ? 1 : 0;
			
			return result & 0xffff;
		}
		
		public function add168x(v1 : uint, v2 : uint, v3 : uint = 0) : uint {
			var result : uint = (v1+v2+v3);
			if (v2 >= 128) {	// handle the negative bit of 8 bit numbers in v2
				result -= 256;
			}
			return result;
		}
		
		public function add168(v1 : uint, v2 : uint, v3 : uint = 0) : uint {
			var result : uint = (v1+v2+v3);
			if (v2 >= 128) {	// handle the negative bit of 8 bit numbers in v2
				result -= 256;
			}
			wasCarry = result > 0xffff ? 1 : 0;
			
			// 16 bit adds set 'H' on overflow of bit 11 (!?)
			//wasHalfCarry = ((v1&0xfff)+(v2&0xfff)+v3) > 0xfff ? 1 : 0;
			
			// The MSB is same on both src params, but changed between result and src param1
			var lookup : uint = ( (v1 & 0x8800) >> 11 ) | ( ( (v2) & 0x8800 ) >> 10 ) | ( (result & 0x8800) >> 9 );
			wasHalfCarry = flagHalfCarryAdd[(lookup&7)];
			lookup >>= 4;
			wasOverflow = (lookup==3 || lookup==4) ? 1 : 0;
			//			wasOverflow = ((v1&0x8000) == (v2&0x8000)) && (v1&0x8000) != (result&0x8000) ? 1 : 0;
			
			return result & 0xffff;
		}
		
		public function sub8(v1 : uint, v2 : uint, v3 : uint = 0) : uint {
			var result : uint = (v1-v2) - v3;
			wasCarry = result > 0xff ? 1 : 0;
			
			var wasCarry2 : uint = result & 0x100 ? 1 : 0;
			if (wasCarry != wasCarry2) {
				trace("different in wasCarry");
			}
			
			// Did the calculation in the lowest 4 bits spill under
			//wasHalfCarry = ((v1&0x0f) < (v2&0x0f)+v3) ? 1 : 0;
			
			// The MSB is same on both src params, but changed between result and src param1
			var lookup : uint = ( (v1 & 0x88) >> 3 ) | ( ( (v2) & 0x88 ) >> 2 ) | ( (result & 0x88) >> 1 );
			wasHalfCarry = flagHalfCarrySub[(lookup&7)];
			lookup >>= 4;			
			wasOverflow = (lookup==1 || lookup==6) ? 1 : 0;
			
			
			//wasOverflow = ((v1&0x80) == (v2&0x80)) && (v1&0x80) != (result&0x80) ? 1 : 0;
			
			return result & 0xff;
		}
		
		public function sub16(v1 : uint, v2 : uint, v3 : uint = 0) : uint {
			var result : uint = (v1-v2) - v3;
			wasCarry = result > 0xffff ? 1 : 0;
			
			var wasCarry2 : uint = result & 0x10000 ? 1 : 0;
			if (wasCarry != wasCarry2) {
				trace("different in wasCarry16");
			}
			
			// 16-bit half carry occurs on bit 11
			//			wasHalfCarry = ((v1&0xfff) < (v2&0xfff)+v3) ? 1 : 0;
			
			// The MSB is same on both src params, but changed between result and src param1
			var lookup : uint = ( (v1 & 0x8800) >> 11 ) | ( ( (v2) & 0x8800 ) >> 10 ) | ( (result & 0x8800) >> 9 );
			wasHalfCarry = flagHalfCarrySub[(lookup&7)];
			lookup >>= 4;
			wasOverflow = (lookup==1 || lookup==6) ? 1 : 0;
			
			return result & 0xffff;
		}
		
		public function daa(v : uint) : uint {
			wasCarry = cc_bit_0;
			
			if (cc_bit_1) { // last instr was subtraction	
				if ((v&0x0f) > 9) {
					v -= 6;
				}
				if ((v&0xf0) > 0x90) {
					v -= 0x60;
				}
			} else {	// post an addition
				if ((v&0x0f) > 9) {
					v += 6;
				}
				if ((v&0xf0) > 0x90) {
					v += 0x60;
				}
			}
			v = v&0xff;
			return v;
		}
		
		public function rrd():uint {
			var v : uint = read8(hl);
			var newHL : uint = ((a&0x0f)<<4) | (v>>4);
			a = (a & 0xf0) | (v&0x0f);
			write8(hl, newHL);
			return a;
		}
		
		public function rld():uint {
			var v : uint = read8(hl);
			var newHL : uint = (v<<4) | (a&0x0f);
			a = (a & 0xf0) | ((v&0xf0)>>4);
			write8(hl, newHL);
			return a;
		}
		
		//
		// CPU handlers
		public function halt():void {
			inHalt = true;
		}
		public function disableInterrupt():void {
			iff1=iff2=0;
			interruptEnabled = false;
		}
		public function enableInterrupt():void {
			iff1=iff2=1;
			interruptEnabled = true;
		}
		public function im0():void {
			interruptMode = 0;
		}
		
		public function im1():void {
			interruptMode = 1;
		}
		
		public function im2():void {
			interruptMode = 2;
		}
		
		public function inport(port : uint):uint {
			return bus.inport.read8(port);
		}
		public function outport(port : uint, value : uint):void {
			bus.outport.write8(port, value);
		}
		
		// Algorithmic and logical methods
		//
		public function rlc(v : uint) : uint {
			wasCarry = (v&0x80);
			v <<= 1;
			v |= wasCarry ? 1 : 0;
			v &= 0xff;
			return v;
		}
		public function rrc(v : uint) : uint {
			wasCarry = v&1;
			v >>= 1;
			v |= wasCarry ? 0x80 : 0;
			return v;
		}
		public function rla(v : uint) : uint {
			v <<= 1;
			v |= cc_bit_0 ? 1 : 0;
			wasCarry = (v & 0x100) ? 1 : 0;
			v &= 0xff;
			return v;
		}
		public function rra(v : uint) : uint {
			v |= cc_bit_0 ? 0x100 : 0;
			wasCarry = v & 1;
			v >>= 1;
			return v;
		}
		// SLL is undocumented it seems
		public function sll8(v : uint) : uint {
			wasCarry = v & 0x80 ? 1 : 0;
			v <<= 1;
			v |= 1;
			v = v & 0xff;
			return v;
		}
		
		public function sll16(v : uint) : uint {
			wasCarry = v & 0x8000 ? 1 : 0;
			v <<= 1;
			v |= 1;
			v = v & 0xffff;
			return v;
		}
		
		public function sla8(v : uint) : uint {
			wasCarry = v & 0x80 ? 1 : 0;
			v <<= 1;
			v = v & 0xff;
			return v;
		}
		public function sra8(v : uint) : uint {
			wasCarry = v & 1;
			v >>= 1;
			v |= (v&0x40)<<1;
			return v;
		}
		
		public function sla16(v : uint) : uint {
			wasCarry = v & 0x8000 ? 1 : 0;
			v <<= 1;
			v = v & 0xffff;
			return v;
		}
		public function sra16(v : uint) : uint {
			wasCarry = v & 1;
			v >>= 1;
			v |= (v&0x4000)<<1;
			return v;
		}
		
		public function srl8(v : uint) : uint {
			wasCarry = v & 1;
			v >>= 1;
			v = v & 0x7f;
			return v;
		}
		public function srl16(v : uint) : uint {
			wasCarry = v & 1;
			v >>= 1;
			v = v & 0x7fff;
			return v;
		}
		
		public function rlc8(v : uint) : uint {
			wasCarry = v & 0x80 ? 1 : 0;
			v <<= 1;
			v |= wasCarry;
			v = v & 0xff;
			return v;
		}
		public function rlc16(v : uint) : uint {
			wasCarry = v & 0x8000 ? 1 : 0;
			v <<= 1;
			v |= wasCarry;
			v = v & 0xffff;
			return v;
		}
		
		public function rl8(v : uint) : uint {
			wasCarry = v & 0x80 ? 1 : 0;
			v <<= 1;
			v |= cc_bit_0;
			v = v & 0xff;
			return v;
		}
		public function rl16(v : uint) : uint {
			wasCarry = v & 0x8000 ? 1 : 0;
			v <<= 1;
			v |= cc_bit_0;
			v = v & 0xffff;
			return v;
		}
		
		public function rr8(v : uint) : uint {
			wasCarry = v & 1 ? 1 : 0;
			v >>= 1;
			v |= cc_bit_0 ? 0x80 : 0;
			return v;
		}
		public function rr16(v : uint) : uint {
			wasCarry = v & 1 ? 1 : 0;
			v >>= 1;
			v |= cc_bit_0 ? 0x8000 : 0;
			return v;
		}
		
		public function rrc8(v : uint) : uint {
			wasCarry = v & 1 ? 1 : 0;
			v >>= 1;
			v |= wasCarry ? 0x80 : 0;
			return v;
		}
		public function rrc16(v : uint) : uint {
			wasCarry = v & 1 ? 1 : 0;
			v >>= 1;
			v |= wasCarry ? 0x8000 : 0;
			return v;
		}
		
		
		public function cpl(v : uint) : uint {
			return (~v) & 0xff;
		}
		//
		public function andlog(v : uint, v2 : uint) : uint {
			return v & v2;
		}
		public function xor(v : uint, v2 : uint) : uint {
			return v ^ v2;
		}
		public function or(v : uint, v2 : uint) : uint {
			return v | v2;
		}
		public function cmp(v : uint) : uint {
			return ~v;
		}
		
		public function setBit(bit : uint, value : uint) : uint {
			return value | (1<<bit);
		}	
		
		public function clearBit(bit : uint, value : uint) : uint {
			return value & ~(1<<bit);
		}	
		public function bittest(bit : uint, value : uint) : uint {
			return value & (1<<bit) ? 1 : 0;
		}	
		

		//static var canLoad : Boolean = true;
		public override function step() : uint {
			if(interruptSample && !(radjust&0x40)) {
				// From http://www.wearmouth.demon.co.uk/zx81.htm
				// An maskable interrupt is triggered when bit 6 of the Z80's Refresh register
				// changes from set to reset.
				interruptPending = true;
			}
			
			interruptSample=true;
			var cycles : uint = 1;
			var prevPc : uint = pc;

			pc_at_start = pc;
			
			var op : uint = bus.read8(pc);
				
			if (hookAddress[pc] == null || hookAddress[pc]()) {
				cycles = processOpcode();
				if (cycles == 0) {
					trace("Error: "+prevPc);
					cycles = 1;
				}
			} else {
				cycles = 100;
			}
	
			tstates += cycles;
			++radjust;
			++memrefresh;
			
			processNMI();
			processInterrupts();
			
			if (false) {
				traceCPUState();
			}

			return cycles;
		}
		
		public function traceCPUState() : void {
			var str : String = EMFUtils.getHex16(pc_at_start)+" : a "+EMFUtils.getHex8(a)+
				" b="+EMFUtils.getHex8(b)+
				" c="+EMFUtils.getHex8(c)+
				" d="+EMFUtils.getHex8(d)+
				" e="+EMFUtils.getHex8(e)+
				" h="+EMFUtils.getHex8(h)+
				" l="+EMFUtils.getHex8(l)+
				" f="+EMFUtils.getHex8(f&0xd7);
			EMFLogger.message(str);		
		}
		
		public function processNMI() : void {
			// Run at the vsync? (Faked by doing it every N instructions.)
			if (bNMIGenerator && tstates >= iNMIFakeTStateCount){//281){//108) {
				nmiPending = true;
				tstates -= iNMIFakeTStateCount;
			}
			
			// Run each frame
			if (interruptSample && nmiPending) {
				nmiPending = false;
				
				if (bNMIGenerator) {
					iff2=iff1;
					iff1=0;
				}
				if(inHalt) {
					inHalt = false;
					pc++;
					//tstates=linestart;
				} else
				{ 					/* this seems curiously long, but equally, seems
					* to be just about right. :-)
					*/
					tstates+=27;
				}
				
				sp -= 2;
				write16(sp, pc);
				pc=0x66;
			}
		}
		
		public function processInterrupts() : void {
			if (interruptSample && interruptPending) {
				interruptPending = false;
				
				if(iff1) { 
					/*      printf("int line %d tst %d\n",liney,tstates);*/
					if(inHalt) { 
						//pc++;	// BUGWARN: other emu's do this, but including this causes the zx80 to toggle the first character on the lower edit line (o<->p with print, e.g.)
						inHalt = false;
					}
					
					iff1=iff2=0;
					tstates+=5; /* accompanied by an input from the data bus */
					switch(interruptMode)
					{
						case 0: /* IM 0 */
						case 1: /* undocumented */
						case 2: /* IM 1 */
							/* there is little to distinguish between these cases */
							//tstates+=9; /* perhaps */
							sp -= 2;
							write16(sp, pc);
							pc=0x38;
							break;
						case 3: /* IM 2 */
							/* (seems unlikely it'd ever be used on the '81, but...) */
							tstates+=13; /* perhaps */
						{
							var addr : uint = read16((intv<<8)|0xff);
							sp -= 2;
							write16(sp, pc);
							pc=addr;
						}
					}
				}
			}
		}
		// --------------------- End of PreAmble ----------------------------
		
		
		
public  function processOpcode() : uint {
var t8 : uint;
var t16 : uint;
var bit : uint;
var instr : uint = bus.read8(pc);
var cycles : uint = 0;

switch(instr) {
	case 0x0:
// nop

;
pc += 1;
return 4;


	break;

	case 0x1:
// LD @r,@n

bc=bus.read16(pc+1);
pc += 3;
return 10;


	break;

	case 0x2:
// LD (BC),A

write8(bc, a);
pc += 1;
return 7;


	break;

	case 0x3:
// INC @r

bc=add16(bc,1);
pc += 1;
return 6;


	break;

	case 0x4:
// INC @r

b=add8(b,1);
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_4 = halfcarry(b);
cc_bit_2 = overflow(b);
pc += 1;
return 4;


	break;

	case 0x5:
// DEC @r

b=sub8(b,1);
cc_bit_1 = 1;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_4 = halfcarry(b);
cc_bit_2 = overflow(b);
pc += 1;
return 4;


	break;

	case 0x6:
// LD @r,@n

b=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0x7:
// RLCA

a=rlc(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x8:
// EX AF,AF’

t8=a;
a=ap;
ap=t8;
t8=f;
f=fp;
fp=t8;
pc += 1;
return 4;


	break;

	case 0x9:
// ADD HL,@r

hl=add16(hl,bc);
cc_bit_1 = 0;
cc_bit_4 = halfcarry(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 11;


	break;

	case 0xa:
// LD A,(BC)

a=read8(bc);
pc += 1;
return 7;


	break;

	case 0xb:
// DEC @r

bc=sub16(bc,1);
pc += 1;
return 6;


	break;

	case 0xc:
// INC @r

c=add8(c,1);
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_4 = halfcarry(c);
cc_bit_2 = overflow(c);
pc += 1;
return 4;


	break;

	case 0xd:
// DEC @r

c=sub8(c,1);
cc_bit_1 = 1;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_4 = halfcarry(c);
cc_bit_2 = overflow(c);
pc += 1;
return 4;


	break;

	case 0xe:
// LD @r,@n

c=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0xf:
// RRCA

a=rrc(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x10:
// DJNZ (PC+@n)

b = sub8(b,1);
if (b!=0) {
pc=add168(pc,bus.read8(pc+1));;
cycles = 5;
}
pc += 2;
return 8 + cycles;


	break;

	case 0x11:
// LD @r,@n

de=bus.read16(pc+1);
pc += 3;
return 10;


	break;

	case 0x12:
// LD (DE),A

write8(de,a);
pc += 1;
return 7;


	break;

	case 0x13:
// INC @r

de=add16(de,1);
pc += 1;
return 6;


	break;

	case 0x14:
// INC @r

d=add8(d,1);
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_4 = halfcarry(d);
cc_bit_2 = overflow(d);
pc += 1;
return 4;


	break;

	case 0x15:
// DEC @r

d=sub8(d,1);
cc_bit_1 = 1;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_4 = halfcarry(d);
cc_bit_2 = overflow(d);
pc += 1;
return 4;


	break;

	case 0x16:
// LD @r,@n

d=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0x17:
// RLA

a=rla(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x18:
// JR (PC+@n)

pc=add168(pc,bus.read8(pc+1));
pc += 2;
return 12;


	break;

	case 0x19:
// ADD HL,@r

hl=add16(hl,de);
cc_bit_1 = 0;
cc_bit_4 = halfcarry(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 11;


	break;

	case 0x1a:
// LD A,(DE)

a=read8(de);
pc += 1;
return 7;


	break;

	case 0x1b:
// DEC @r

de=sub16(de,1);
pc += 1;
return 6;


	break;

	case 0x1c:
// INC @r

e=add8(e,1);
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_4 = halfcarry(e);
cc_bit_2 = overflow(e);
pc += 1;
return 4;


	break;

	case 0x1d:
// DEC @r

e=sub8(e,1);
cc_bit_1 = 1;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_4 = halfcarry(e);
cc_bit_2 = overflow(e);
pc += 1;
return 4;


	break;

	case 0x1e:
// LD @r,@n

e=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0x1f:
// RRA

a=rra(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x20:
// JR NZ,(PC+@n)

if (cc_bit_6 == 0) {
pc=add168(pc,bus.read8(pc+1));;
cycles = 5;
}
pc += 2;
return 7 + cycles;


	break;

	case 0x21:
// LD @r,@n

hl=bus.read16(pc+1);
pc += 3;
return 10;


	break;

	case 0x22:
// LD (@n),HL

write16(bus.read16(pc+1), hl);
pc += 3;
return 16;


	break;

	case 0x23:
// INC @r

hl=add16(hl,1);
pc += 1;
return 6;


	break;

	case 0x24:
// INC @r

h=add8(h,1);
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_4 = halfcarry(h);
cc_bit_2 = overflow(h);
pc += 1;
return 4;


	break;

	case 0x25:
// DEC @r

h=sub8(h,1);
cc_bit_1 = 1;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_4 = halfcarry(h);
cc_bit_2 = overflow(h);
pc += 1;
return 4;


	break;

	case 0x26:
// LD @r,@n

h=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0x27:
// DAA

a=daa(a);
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x28:
// JR Z,(PC+@n)

if (cc_bit_6 == 1) {
pc=add168(pc,bus.read8(pc+1));
cycles = 5;
}
pc += 2;
return 7 + cycles;


	break;

	case 0x29:
// ADD HL,@r

hl=add16(hl,hl);
cc_bit_1 = 0;
cc_bit_4 = halfcarry(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 11;


	break;

	case 0x2a:
// LD HL,(@n)

hl=read16(bus.read16(pc+1));
pc += 3;
return 16;


	break;

	case 0x2b:
// DEC @r

hl=sub16(hl,1);
pc += 1;
return 6;


	break;

	case 0x2c:
// INC @r

l=add8(l,1);
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_4 = halfcarry(l);
cc_bit_2 = overflow(l);
pc += 1;
return 4;


	break;

	case 0x2d:
// DEC @r

l=sub8(l,1);
cc_bit_1 = 1;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_4 = halfcarry(l);
cc_bit_2 = overflow(l);
pc += 1;
return 4;


	break;

	case 0x2e:
// LD @r,@n

l=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0x2f:
// CPL

a=cpl(a);
cc_bit_4 = 1;
cc_bit_1 = 1;
pc += 1;
return 4;


	break;

	case 0x30:
// JR NC,(PC+@n)

if (cc_bit_0 == 0) {
pc=add168(pc,bus.read8(pc+1));
cycles = 5;
}
pc += 2;
return 7 + cycles;


	break;

	case 0x31:
// LD @r,@n

sp=bus.read16(pc+1);
pc += 3;
return 10;


	break;

	case 0x32:
// LD (@n),A

write8(bus.read16(pc+1),a);
pc += 3;
return 13;


	break;

	case 0x33:
// INC @r

sp=add16(sp,1);
pc += 1;
return 6;


	break;

	case 0x34:
// INC @r
// INC (HL)

t8=add8(read8(hl),1);
write8(hl,t8);
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
pc += 1;
return 11;


	break;

	case 0x35:
// DEC @r
// DEC (HL)

t8=sub8(read8(hl),1);
write8(hl,t8);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
/*
fPV = (ans == 0x80);
fH = ((((ans & 0xF) - 1) & 16) != 0);

ans = (ans - 1) & 0xFF;

fS = ((ans & 128) != 0);
f3 = ((ans & 8) != 0);
f5 = ((ans & 32) != 0);
fZ = (ans == 0);
fN = true;
*/
pc += 1;
return 11;


	break;

	case 0x36:
// LD @r,@n
// LD (HL),@n

write8(hl,bus.read8(pc+1));
pc += 2;
return 10;


	break;

	case 0x37:
// SCF

;
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_0 = 1;
pc += 1;
return 4;


	break;

	case 0x38:
// JR C,(PC+@n)

if (cc_bit_0 == 1) {
pc=add168(pc,bus.read8(pc+1));
cycles = 5;
}
pc += 2;
return 7 + cycles;


	break;

	case 0x39:
// ADD HL,@r

hl=add16(hl,sp);
cc_bit_1 = 0;
cc_bit_4 = halfcarry(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 11;


	break;

	case 0x3a:
// LD A,(@n)

a=read8(bus.read16(pc+1));
pc += 3;
return 13;


	break;

	case 0x3b:
// DEC @r

sp=sub16(sp,1);
pc += 1;
return 6;


	break;

	case 0x3c:
// INC @r

a=add8(a,1);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
pc += 1;
return 4;


	break;

	case 0x3d:
// DEC @r

a=sub8(a,1);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
pc += 1;
return 4;


	break;

	case 0x3e:
// LD @r,@n

a=bus.read8(pc+1);
pc += 2;
return 7;


	break;

	case 0x3f:
// CCF

cc_bit_0=(cc_bit_0)?0:1;
cc_bit_1 = 0;
cc_bit_4 = halfcarry(cc_bit_0);
pc += 1;
return 4;


	break;

	case 0x40:
// LD @r,@s

b=b;
pc += 1;
return 4;


	break;

	case 0x41:
// LD @r,@s

b=c;
pc += 1;
return 4;


	break;

	case 0x42:
// LD @r,@s

b=d;
pc += 1;
return 4;


	break;

	case 0x43:
// LD @r,@s

b=e;
pc += 1;
return 4;


	break;

	case 0x44:
// LD @r,@s

b=h;
pc += 1;
return 4;


	break;

	case 0x45:
// LD @r,@s

b=l;
pc += 1;
return 4;


	break;

	case 0x46:
// LD @r,@s
// LD @r,(HL)

b=read8(hl);
pc += 1;
return 7;


	break;

	case 0x47:
// LD @r,@s

b=a;
pc += 1;
return 4;


	break;

	case 0x48:
// LD @r,@s

c=b;
pc += 1;
return 4;


	break;

	case 0x49:
// LD @r,@s

c=c;
pc += 1;
return 4;


	break;

	case 0x4a:
// LD @r,@s

c=d;
pc += 1;
return 4;


	break;

	case 0x4b:
// LD @r,@s

c=e;
pc += 1;
return 4;


	break;

	case 0x4c:
// LD @r,@s

c=h;
pc += 1;
return 4;


	break;

	case 0x4d:
// LD @r,@s

c=l;
pc += 1;
return 4;


	break;

	case 0x4e:
// LD @r,@s
// LD @r,(HL)

c=read8(hl);
pc += 1;
return 7;


	break;

	case 0x4f:
// LD @r,@s

c=a;
pc += 1;
return 4;


	break;

	case 0x50:
// LD @r,@s

d=b;
pc += 1;
return 4;


	break;

	case 0x51:
// LD @r,@s

d=c;
pc += 1;
return 4;


	break;

	case 0x52:
// LD @r,@s

d=d;
pc += 1;
return 4;


	break;

	case 0x53:
// LD @r,@s

d=e;
pc += 1;
return 4;


	break;

	case 0x54:
// LD @r,@s

d=h;
pc += 1;
return 4;


	break;

	case 0x55:
// LD @r,@s

d=l;
pc += 1;
return 4;


	break;

	case 0x56:
// LD @r,@s
// LD @r,(HL)

d=read8(hl);
pc += 1;
return 7;


	break;

	case 0x57:
// LD @r,@s

d=a;
pc += 1;
return 4;


	break;

	case 0x58:
// LD @r,@s

e=b;
pc += 1;
return 4;


	break;

	case 0x59:
// LD @r,@s

e=c;
pc += 1;
return 4;


	break;

	case 0x5a:
// LD @r,@s

e=d;
pc += 1;
return 4;


	break;

	case 0x5b:
// LD @r,@s

e=e;
pc += 1;
return 4;


	break;

	case 0x5c:
// LD @r,@s

e=h;
pc += 1;
return 4;


	break;

	case 0x5d:
// LD @r,@s

e=l;
pc += 1;
return 4;


	break;

	case 0x5e:
// LD @r,@s
// LD @r,(HL)

e=read8(hl);
pc += 1;
return 7;


	break;

	case 0x5f:
// LD @r,@s

e=a;
pc += 1;
return 4;


	break;

	case 0x60:
// LD @r,@s

h=b;
pc += 1;
return 4;


	break;

	case 0x61:
// LD @r,@s

h=c;
pc += 1;
return 4;


	break;

	case 0x62:
// LD @r,@s

h=d;
pc += 1;
return 4;


	break;

	case 0x63:
// LD @r,@s

h=e;
pc += 1;
return 4;


	break;

	case 0x64:
// LD @r,@s

h=h;
pc += 1;
return 4;


	break;

	case 0x65:
// LD @r,@s

h=l;
pc += 1;
return 4;


	break;

	case 0x66:
// LD @r,@s
// LD @r,(HL)

h=read8(hl);
pc += 1;
return 7;


	break;

	case 0x67:
// LD @r,@s

h=a;
pc += 1;
return 4;


	break;

	case 0x68:
// LD @r,@s

l=b;
pc += 1;
return 4;


	break;

	case 0x69:
// LD @r,@s

l=c;
pc += 1;
return 4;


	break;

	case 0x6a:
// LD @r,@s

l=d;
pc += 1;
return 4;


	break;

	case 0x6b:
// LD @r,@s

l=e;
pc += 1;
return 4;


	break;

	case 0x6c:
// LD @r,@s

l=h;
pc += 1;
return 4;


	break;

	case 0x6d:
// LD @r,@s

l=l;
pc += 1;
return 4;


	break;

	case 0x6e:
// LD @r,@s
// LD @r,(HL)

l=read8(hl);
pc += 1;
return 7;


	break;

	case 0x6f:
// LD @r,@s

l=a;
pc += 1;
return 4;


	break;

	case 0x70:
// LD @r,@s
// LD (HL),@r

write8(hl,b);
pc += 1;
return 7;


	break;

	case 0x71:
// LD @r,@s
// LD (HL),@r

write8(hl,c);
pc += 1;
return 7;


	break;

	case 0x72:
// LD @r,@s
// LD (HL),@r

write8(hl,d);
pc += 1;
return 7;


	break;

	case 0x73:
// LD @r,@s
// LD (HL),@r

write8(hl,e);
pc += 1;
return 7;


	break;

	case 0x74:
// LD @r,@s
// LD (HL),@r

write8(hl,h);
pc += 1;
return 7;


	break;

	case 0x75:
// LD @r,@s
// LD (HL),@r

write8(hl,l);
pc += 1;
return 7;


	break;

	case 0x76:
// LD @r,@s
// LD @r,(HL)
// LD (HL),@r
// HALT

halt();
pc -= 1;
pc += 1;
return 7;


	break;

	case 0x77:
// LD @r,@s
// LD (HL),@r

write8(hl,a);
pc += 1;
return 7;


	break;

	case 0x78:
// LD @r,@s

a=b;
pc += 1;
return 4;


	break;

	case 0x79:
// LD @r,@s

a=c;
pc += 1;
return 4;


	break;

	case 0x7a:
// LD @r,@s

a=d;
pc += 1;
return 4;


	break;

	case 0x7b:
// LD @r,@s

a=e;
pc += 1;
return 4;


	break;

	case 0x7c:
// LD @r,@s

a=h;
pc += 1;
return 4;


	break;

	case 0x7d:
// LD @r,@s

a=l;
pc += 1;
return 4;


	break;

	case 0x7e:
// LD @r,@s
// LD @r,(HL)

a=read8(hl);
pc += 1;
return 7;


	break;

	case 0x7f:
// LD @r,@s

a=a;
pc += 1;
return 4;


	break;

	case 0x80:
// ADD A,@r

a=add8(a,b);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x81:
// ADD A,@r

a=add8(a,c);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x82:
// ADD A,@r

a=add8(a,d);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x83:
// ADD A,@r

a=add8(a,e);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x84:
// ADD A,@r

a=add8(a,h);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x85:
// ADD A,@r

a=add8(a,l);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x86:
// ADD A,@r
// ADD A,(HL)

a=add8(a,read8(hl));
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 7;


	break;

	case 0x87:
// ADD A,@r

a=add8(a,a);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x88:
// ADC A,@r

a=add8(a,b,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x89:
// ADC A,@r

a=add8(a,c,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x8a:
// ADC A,@r

a=add8(a,d,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x8b:
// ADC A,@r

a=add8(a,e,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x8c:
// ADC A,@r

a=add8(a,h,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x8d:
// ADC A,@r

a=add8(a,l,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x8e:
// ADC A,@r
// ADC A,(HL)

a=add8(a,read8(hl),cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 7;


	break;

	case 0x8f:
// ADC A,@r

a=add8(a,a,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x90:
// SUB A,@r

a=sub8(a,b);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x91:
// SUB A,@r

a=sub8(a,c);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x92:
// SUB A,@r

a=sub8(a,d);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x93:
// SUB A,@r

a=sub8(a,e);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x94:
// SUB A,@r

a=sub8(a,h);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x95:
// SUB A,@r

a=sub8(a,l);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x96:
// SUB A,@r
// SUB A,(HL)

a=sub8(a,read8(hl));
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 7;


	break;

	case 0x97:
// SUB A,@r

a=sub8(a,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x98:
// SBC A,@r

a=sub8(a,b,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x99:
// SBC A,@r

a=sub8(a,c,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x9a:
// SBC A,@r

a=sub8(a,d,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x9b:
// SBC A,@r

a=sub8(a,e,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x9c:
// SBC A,@r

a=sub8(a,h,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x9d:
// SBC A,@r

a=sub8(a,l,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x9e:
// SBC A,@r
// SBC A,(HL)

a=sub8(a,read8(hl),cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 7;


	break;

	case 0x9f:
// SBC A,@r

a=sub8(a,a,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0xa0:
// AND A,@r

a=andlog(a,b);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa1:
// AND A,@r

a=andlog(a,c);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa2:
// AND A,@r

a=andlog(a,d);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa3:
// AND A,@r

a=andlog(a,e);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa4:
// AND A,@r

a=andlog(a,h);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa5:
// AND A,@r

a=andlog(a,l);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa6:
// AND A,@r
// AND A,(HL)

a=andlog(a,read8(hl));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 7;


	break;

	case 0xa7:
// AND A,@r

a=andlog(a,a);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xa8:
// XOR A,@r
a=xor(a,b);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xa9:
// XOR A,@r

a=xor(a,c);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xaa:
// XOR A,@r

a=xor(a,d);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xab:
// XOR A,@r

a=xor(a,e);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xac:
// XOR A,@r

a=xor(a,h);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xad:
// XOR A,@r

a=xor(a,l);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xae:
// XOR A,@r
// XOR A,(HL)

a=xor(a,read8(hl));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 7;


	break;

	case 0xaf:
// XOR A,@r

a=xor(a,a);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_4 = 0;
pc += 1;
return 4;


	break;

	case 0xb0:
// OR A,@r

a=or(a,b);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb1:
// OR A,@r

a=or(a,c);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb2:
// OR A,@r

a=or(a,d);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb3:
// OR A,@r

a=or(a,e);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb4:
// OR A,@r

a=or(a,h);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb5:
// OR A,@r

a=or(a,l);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb6:
// OR A,@r
// OR A,(HL)

a=or(a,read8(hl));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 7;


	break;

	case 0xb7:
// OR A,@r

a=or(a,a);
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 1;
return 4;


	break;

	case 0xb8:
// CP A,@r

t8=sub8(a,b);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xb9:
// CP A,@r

t8=sub8(a,c);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xba:
// CP A,@r

t8=sub8(a,d);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xbb:
// CP A,@r

t8=sub8(a,e);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xbc:
// CP A,@r

t8=sub8(a,h);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xbd:
// CP A,@r

t8=sub8(a,l);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xbe:
// CP A,@r
// CP A,(HL)

t8=sub8(a,read8(hl));
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 7;


	break;

	case 0xbf:
// CP A,@r

t8=sub8(a,a);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 4;


	break;

	case 0xc0:
// RET @r

if (cc_bit_6 == 0) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xc1:
// POP @r

bc=read16(sp);
sp=add16(sp,2);
pc += 1;
return 10;


	break;

	case 0xc2:
// JP @r,(@n)

if (cc_bit_6 == 0) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xc3:
// JP (@n)

pc=bus.read16(pc+1) - 3;
pc += 3;
return 10;


	break;

	case 0xc4:
// CALL @r,@n

if (cc_bit_6 == 0) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xc5:
// PUSH @r

sp=sub16(sp,2);
write16(sp,bc);
pc += 1;
return 10;


	break;

	case 0xc6:
// ADD A,@n

a=add8(a,bus.read8(pc+1));
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 7;


	break;

	case 0xc7:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x00 - 1;
pc += 1;
return 11;


	break;

	case 0xc8:
// RET @r

if (cc_bit_6 == 1) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xc9:
// RET

pc=read16(sp)-1;
sp=add16(sp,2);
pc += 1;
return 10;


	break;

	case 0xca:
// JP @r,(@n)

if (cc_bit_6 == 1) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xcb:
// CB
pc += 1;
return cb_ext();
	break;

	case 0xcc:
// CALL @r,@n

if (cc_bit_6 == 1) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xcd:
// CALL (@n)

sp=sub16(sp,2);
write16(sp,pc+3);
pc=sub16(bus.read16(pc+1),3);
pc += 3;
return 17;


	break;

	case 0xce:
// ADC A,@n

a=add8(a,bus.read8(pc+1),cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 7;


	break;

	case 0xcf:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x08 - 1;
pc += 1;
return 11;


	break;

	case 0xd0:
// RET @r

if (cc_bit_0 == 0) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xd1:
// POP @r

de=read16(sp);
sp=add16(sp,2);
pc += 1;
return 10;


	break;

	case 0xd2:
// JP @r,(@n)

if (cc_bit_0 == 0) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xd3:
// OUT (@n),A

outport(bus.read8(pc+1),a);
pc += 2;
return 11;


	break;

	case 0xd4:
// CALL @r,@n

if (cc_bit_0 == 0) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xd5:
// PUSH @r

sp=sub16(sp,2);
write16(sp,de);
pc += 1;
return 10;


	break;

	case 0xd6:
// SUB @n

a=sub8(a,bus.read8(pc+1));
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 7;


	break;

	case 0xd7:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x10 - 1;
pc += 1;
return 11;


	break;

	case 0xd8:
// RET @r

if (cc_bit_0 == 1) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xd9:
// EXX

t16=bc;
bc=bcp;
bcp=t16;
t16=de;
de=dep;
dep=t16;
t16=hl;
hl=hlp;
hlp=t16;
pc += 1;
return 4;


	break;

	case 0xda:
// JP @r,(@n)

if (cc_bit_0 == 1) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xdb:
// IN A,(@n)

a=inport((a*256) | bus.read8(pc+1));
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 2;
return 11;


	break;

	case 0xdc:
// CALL @r,@n

if (cc_bit_0 == 1) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xdd:
// DD
pc += 1;
return dd_ext();
	break;

	case 0xde:
// SBC A,@n

a=sub8(a,bus.read8(pc+1),cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 11;


	break;

	case 0xdf:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x18 - 1;
pc += 1;
return 11;


	break;

	case 0xe0:
// RET @r

if (cc_bit_2 == 0) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xe1:
// POP @r

hl=read16(sp);
sp=add16(sp,2);
pc += 1;
return 10;


	break;

	case 0xe2:
// JP @r,(@n)

if (cc_bit_2 == 0) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xe3:
// EX (SP),HL

t16=hl;
hl=read16(sp);
write16(sp,t16);
pc += 1;
return 4;


	break;

	case 0xe4:
// CALL @r,@n

if (cc_bit_2 == 0) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xe5:
// PUSH @r

sp=sub16(sp,2);
write16(sp,hl);
pc += 1;
return 10;


	break;

	case 0xe6:
// AND @n

a=andlog(a,bus.read8(pc+1));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 2;
return 11;


	break;

	case 0xe7:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x20 - 1;
pc += 1;
return 11;


	break;

	case 0xe8:
// RET @r

if (cc_bit_2 == 1) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xe9:
// JP (HL)

pc=sub16(hl,1);
pc += 1;
return 4;


	break;

	case 0xea:
// JP @r,(@n)

if (cc_bit_2 == 1) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xeb:
// EX DE,HL

t16=hl;
hl=de;
de=t16;
pc += 1;
return 4;


	break;

	case 0xec:
// CALL @r,@n

if (cc_bit_2 == 1) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xed:
// ED
pc += 1;
return ed_ext();
// ld

d=read16(bus.read16(pc+1));
pc += 4;
return 20;


	break;

	case 0xee:
// XOR A,@n

a=xor(a,bus.read8(pc+1));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 2;
return 11;


	break;

	case 0xef:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x28 - 1;
pc += 1;
return 11;


	break;

	case 0xf0:
// RET @r

if (cc_bit_7 == 0) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xf1:
// POP @r

af=read16(sp);
sp=add16(sp,2);
pc += 1;
return 10;


	break;

	case 0xf2:
// JP @r,(@n)

if (cc_bit_7 == 0) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xf3:
// DI

disableInterrupt();
pc += 1;
return 4;


	break;

	case 0xf4:
// CALL @r,@n

if (cc_bit_7 == 0) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xf5:
// PUSH @r

sp=sub16(sp,2);
write16(sp,af);
pc += 1;
return 10;


	break;

	case 0xf6:
// OR A,@n

a=or(a,bus.read8(pc+1));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 2;
return 11;


	break;

	case 0xf7:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x30 - 1;
pc += 1;
return 11;


	break;

	case 0xf8:
// RET @r

if (cc_bit_7 == 1) {
pc=read16(sp)-1;sp=add16(sp,2); ;
cycles = 6;
}
pc += 1;
return 5 + cycles;


	break;

	case 0xf9:
// LD SP,HL

sp=hl;
pc += 1;
return 11;


	break;

	case 0xfa:
// JP @r,(@n)

if (cc_bit_7 == 1) {
pc=bus.read16(pc+1)-3;
}
pc += 3;
return 10;


	break;

	case 0xfb:
// EI

enableInterrupt();
pc += 1;
return 4;


	break;

	case 0xfc:
// CALL @r,@n

if (cc_bit_7 == 1) {
sp=sub16(sp,2);write16(sp,pc+3);pc=bus.read16(pc+1) - 3;;
cycles = 7;
}
pc += 3;
return 10 + cycles;


	break;

	case 0xfd:
// FD
pc += 1;
return fd_ext();
	break;

	case 0xfe:
// CP @n

t8=sub8(a,bus.read8(pc+1));
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 2;
return 11;


	break;

	case 0xff:
// RST @r

sp=sub16(sp,2);
write16(sp,pc+1);
pc=0x38 - 1;
pc += 1;
return 11;


	break;

} // hctiws
return 1;
}
public  function dd_ext() : uint {
var t8 : uint;
var t16 : uint;
var bit : uint;
var instr : uint = bus.read8(pc);
var cycles : uint = 1;

switch(instr) {
	case 0x0:
	// Unknown operation
	break;

	case 0x1:
	// Unknown operation
	break;

	case 0x2:
	// Unknown operation
	break;

	case 0x3:
	// Unknown operation
	break;

	case 0x4:
	// Unknown operation
	break;

	case 0x5:
	// Unknown operation
	break;

	case 0x6:
	// Unknown operation
	break;

	case 0x7:
	// Unknown operation
	break;

	case 0x8:
	// Unknown operation
	break;

	case 0x9:
// ADD IX,@r

ix=add16(ix,bc);
cc_bit_1 = 0;
cc_bit_0 = carry(ix);
pc += 1;
return 15;


	break;

	case 0xa:
	// Unknown operation
	break;

	case 0xb:
	// Unknown operation
	break;

	case 0xc:
	// Unknown operation
	break;

	case 0xd:
	// Unknown operation
	break;

	case 0xe:
	// Unknown operation
	break;

	case 0xf:
	// Unknown operation
	break;

	case 0x10:
	// Unknown operation
	break;

	case 0x11:
	// Unknown operation
	break;

	case 0x12:
	// Unknown operation
	break;

	case 0x13:
	// Unknown operation
	break;

	case 0x14:
	// Unknown operation
	break;

	case 0x15:
	// Unknown operation
	break;

	case 0x16:
	// Unknown operation
	break;

	case 0x17:
	// Unknown operation
	break;

	case 0x18:
	// Unknown operation
	break;

	case 0x19:
// ADD IX,@r

ix=add16(ix,de);
cc_bit_1 = 0;
cc_bit_0 = carry(ix);
pc += 1;
return 15;


	break;

	case 0x1a:
	// Unknown operation
	break;

	case 0x1b:
	// Unknown operation
	break;

	case 0x1c:
	// Unknown operation
	break;

	case 0x1d:
	// Unknown operation
	break;

	case 0x1e:
	// Unknown operation
	break;

	case 0x1f:
	// Unknown operation
	break;

	case 0x20:
	// Unknown operation
	break;

	case 0x21:
// LD IX,@n

ix=bus.read16(pc+1);
pc += 3;
return 15;


	break;

	case 0x22:
// LD (@n),IX

write16(bus.read16(pc+1),ix);
pc += 3;
return 15;


	break;

	case 0x23:
// INC IX

ix=add16(ix,1);
pc += 1;
return 15;


	break;

	case 0x24:
	// Unknown operation
	break;

	case 0x25:
	// Unknown operation
	break;

	case 0x26:
	// Unknown operation
	break;

	case 0x27:
	// Unknown operation
	break;

	case 0x28:
	// Unknown operation
	break;

	case 0x29:
// ADD IX,@r

ix=add16(ix,ix);
cc_bit_1 = 0;
cc_bit_0 = carry(ix);
pc += 1;
return 15;


	break;

	case 0x2a:
// LD IX,(@n)

ix=read16(bus.read16(pc+1));
pc += 3;
return 15;


	break;

	case 0x2b:
// DEC IX

ix=sub16(ix,1);
pc += 1;
return 15;


	break;

	case 0x2c:
	// Unknown operation
	break;

	case 0x2d:
	// Unknown operation
	break;

	case 0x2e:
	// Unknown operation
	break;

	case 0x2f:
	// Unknown operation
	break;

	case 0x30:
	// Unknown operation
	break;

	case 0x31:
	// Unknown operation
	break;

	case 0x32:
	// Unknown operation
	break;

	case 0x33:
	// Unknown operation
	break;

	case 0x34:
// INC (IX+@n)

t16=add16(read16(add168x(ix,bus.read8(pc+1))),1);
write16(add168x(ix,bus.read8(pc+1)),t16);
cc_bit_1 = 0;
cc_bit_7 = sign16(t16);
cc_bit_6 = zero(t16);
cc_bit_4 = halfcarry(t16);
cc_bit_2 = overflow(t16);
pc += 2;
return 15;


	break;

	case 0x35:
// DEC (IX+@n)

t16=sub16(read16(add168x(ix,bus.read8(pc+1))),1);
write16(add168x(ix,bus.read8(pc+1)),t16);
cc_bit_1 = 1;
cc_bit_7 = sign16(t16);
cc_bit_6 = zero(t16);
cc_bit_4 = halfcarry(t16);
cc_bit_2 = overflow(t16);
pc += 2;
return 15;


	break;

	case 0x36:
// LD (IX+@d),@n

write8(add168(ix,bus.read8(pc+1)),bus.read8(pc+2));
pc += 3;
return 15;


	break;

	case 0x37:
	// Unknown operation
	break;

	case 0x38:
	// Unknown operation
	break;

	case 0x39:
// ADD IX,@r

ix=add16(ix,sp);
cc_bit_1 = 0;
cc_bit_0 = carry(ix);
pc += 1;
return 15;


	break;

	case 0x3a:
	// Unknown operation
	break;

	case 0x3b:
	// Unknown operation
	break;

	case 0x3c:
	// Unknown operation
	break;

	case 0x3d:
	// Unknown operation
	break;

	case 0x3e:
	// Unknown operation
	break;

	case 0x3f:
	// Unknown operation
	break;

	case 0x40:
	// Unknown operation
	break;

	case 0x41:
	// Unknown operation
	break;

	case 0x42:
	// Unknown operation
	break;

	case 0x43:
	// Unknown operation
	break;

	case 0x44:
	// Unknown operation
	break;

	case 0x45:
	// Unknown operation
	break;

	case 0x46:
// LD @r,(IX+@n)

b=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x47:
	// Unknown operation
	break;

	case 0x48:
	// Unknown operation
	break;

	case 0x49:
	// Unknown operation
	break;

	case 0x4a:
	// Unknown operation
	break;

	case 0x4b:
	// Unknown operation
	break;

	case 0x4c:
	// Unknown operation
	break;

	case 0x4d:
	// Unknown operation
	break;

	case 0x4e:
// LD @r,(IX+@n)

c=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x4f:
	// Unknown operation
	break;

	case 0x50:
	// Unknown operation
	break;

	case 0x51:
	// Unknown operation
	break;

	case 0x52:
	// Unknown operation
	break;

	case 0x53:
	// Unknown operation
	break;

	case 0x54:
	// Unknown operation
	break;

	case 0x55:
	// Unknown operation
	break;

	case 0x56:
// LD @r,(IX+@n)

d=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x57:
	// Unknown operation
	break;

	case 0x58:
	// Unknown operation
	break;

	case 0x59:
	// Unknown operation
	break;

	case 0x5a:
	// Unknown operation
	break;

	case 0x5b:
	// Unknown operation
	break;

	case 0x5c:
	// Unknown operation
	break;

	case 0x5d:
	// Unknown operation
	break;

	case 0x5e:
// LD @r,(IX+@n)

e=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x5f:
	// Unknown operation
	break;

	case 0x60:
	// Unknown operation
	break;

	case 0x61:
	// Unknown operation
	break;

	case 0x62:
	// Unknown operation
	break;

	case 0x63:
	// Unknown operation
	break;

	case 0x64:
	// Unknown operation
	break;

	case 0x65:
	// Unknown operation
	break;

	case 0x66:
// LD @r,(IX+@n)

h=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x67:
	// Unknown operation
	break;

	case 0x68:
	// Unknown operation
	break;

	case 0x69:
	// Unknown operation
	break;

	case 0x6a:
	// Unknown operation
	break;

	case 0x6b:
	// Unknown operation
	break;

	case 0x6c:
	// Unknown operation
	break;

	case 0x6d:
	// Unknown operation
	break;

	case 0x6e:
// LD @r,(IX+@n)

l=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x6f:
	// Unknown operation
	break;

	case 0x70:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), b);
pc += 2;
return 19;


	break;

	case 0x71:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), c);
pc += 2;
return 19;


	break;

	case 0x72:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), d);
pc += 2;
return 19;


	break;

	case 0x73:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), e);
pc += 2;
return 19;


	break;

	case 0x74:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), h);
pc += 2;
return 19;


	break;

	case 0x75:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), l);
pc += 2;
return 19;


	break;

	case 0x76:
// LD @r,(IX+@n)
// LD (IX+@n),@r
	// Unknown operation
	break;

	case 0x77:
// LD (IX+@n),@r

write8(add168(ix,bus.read8(pc+1)), a);
pc += 2;
return 19;


	break;

	case 0x78:
	// Unknown operation
	break;

	case 0x79:
	// Unknown operation
	break;

	case 0x7a:
	// Unknown operation
	break;

	case 0x7b:
	// Unknown operation
	break;

	case 0x7c:
	// Unknown operation
	break;

	case 0x7d:
	// Unknown operation
	break;

	case 0x7e:
// LD @r,(IX+@n)

a=read8(add168(ix,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x7f:
	// Unknown operation
	break;

	case 0x80:
	// Unknown operation
	break;

	case 0x81:
	// Unknown operation
	break;

	case 0x82:
	// Unknown operation
	break;

	case 0x83:
	// Unknown operation
	break;

	case 0x84:
	// Unknown operation
	break;

	case 0x85:
	// Unknown operation
	break;

	case 0x86:
// ADD A,(IX+@n)

a=add8(a,read8(add168x(ix,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
pc += 2;
return 15;


	break;

	case 0x87:
	// Unknown operation
	break;

	case 0x88:
	// Unknown operation
	break;

	case 0x89:
	// Unknown operation
	break;

	case 0x8a:
	// Unknown operation
	break;

	case 0x8b:
	// Unknown operation
	break;

	case 0x8c:
	// Unknown operation
	break;

	case 0x8d:
	// Unknown operation
	break;

	case 0x8e:
// ADC A,(IX+@n)

a=add8(a,read8(add168x(ix,bus.read8(pc+1))),cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
pc += 2;
return 15;


	break;

	case 0x8f:
	// Unknown operation
	break;

	case 0x90:
	// Unknown operation
	break;

	case 0x91:
	// Unknown operation
	break;

	case 0x92:
	// Unknown operation
	break;

	case 0x93:
	// Unknown operation
	break;

	case 0x94:
	// Unknown operation
	break;

	case 0x95:
	// Unknown operation
	break;

	case 0x96:
// SUB (IX+@n)

a=sub8(a,read8(add168x(ix,bus.read8(pc+1))));
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 15;


	break;

	case 0x97:
	// Unknown operation
	break;

	case 0x98:
	// Unknown operation
	break;

	case 0x99:
	// Unknown operation
	break;

	case 0x9a:
	// Unknown operation
	break;

	case 0x9b:
	// Unknown operation
	break;

	case 0x9c:
	// Unknown operation
	break;

	case 0x9d:
	// Unknown operation
	break;

	case 0x9e:
// SBC A,(IX+@n)

a=sub8(a,read8(add168x(ix,bus.read8(pc+1))),cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 15;


	break;

	case 0x9f:
	// Unknown operation
	break;

	case 0xa0:
	// Unknown operation
	break;

	case 0xa1:
	// Unknown operation
	break;

	case 0xa2:
	// Unknown operation
	break;

	case 0xa3:
	// Unknown operation
	break;

	case 0xa4:
	// Unknown operation
	break;

	case 0xa5:
	// Unknown operation
	break;

	case 0xa6:
// AND (IX+@n)

a=andlog(a,read8(add168x(ix,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 2;
return 15;


	break;

	case 0xa7:
	// Unknown operation
	break;

	case 0xa8:
	// Unknown operation
	break;

	case 0xa9:
	// Unknown operation
	break;

	case 0xaa:
	// Unknown operation
	break;

	case 0xab:
	// Unknown operation
	break;

	case 0xac:
	// Unknown operation
	break;

	case 0xad:
	// Unknown operation
	break;

	case 0xae:
// XOR A,(IX+@n)

a=xor(a,read8(add168(ix,bus.read8(pc+1))));
pc += 2;
return 15;


	break;

	case 0xaf:
	// Unknown operation
	break;

	case 0xb0:
	// Unknown operation
	break;

	case 0xb1:
	// Unknown operation
	break;

	case 0xb2:
	// Unknown operation
	break;

	case 0xb3:
	// Unknown operation
	break;

	case 0xb4:
	// Unknown operation
	break;

	case 0xb5:
	// Unknown operation
	break;

	case 0xb6:
// OR (IX+@n)

a=or(a,read8(add168(ix,bus.read8(pc+1))));
pc += 2;
return 15;


	break;

	case 0xb7:
	// Unknown operation
	break;

	case 0xb8:
	// Unknown operation
	break;

	case 0xb9:
	// Unknown operation
	break;

	case 0xba:
	// Unknown operation
	break;

	case 0xbb:
	// Unknown operation
	break;

	case 0xbc:
	// Unknown operation
	break;

	case 0xbd:
	// Unknown operation
	break;

	case 0xbe:
// ADD A,(IX+@n)

t8=add8(a,read8(add168x(ix,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
cc_bit_0 = carry(t8);
pc += 2;
return 15;


	break;

	case 0xbf:
	// Unknown operation
	break;

	case 0xc0:
	// Unknown operation
	break;

	case 0xc1:
	// Unknown operation
	break;

	case 0xc2:
	// Unknown operation
	break;

	case 0xc3:
	// Unknown operation
	break;

	case 0xc4:
	// Unknown operation
	break;

	case 0xc5:
	// Unknown operation
	break;

	case 0xc6:
	// Unknown operation
	break;

	case 0xc7:
	// Unknown operation
	break;

	case 0xc8:
	// Unknown operation
	break;

	case 0xc9:
	// Unknown operation
	break;

	case 0xca:
	// Unknown operation
	break;

	case 0xcb:
// RLC (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x6) {
t8=rlc(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// RRC (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0xe) {
t8=rrc(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// RL (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x16) {
t8=rl8(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// RR (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x1e) {
t8=rr8(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SLA (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x26) {
t8=sla8(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SRA (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x2e) {
t8=sra8(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SLL (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x36) {
t8=sll8(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SRL (IX+@n)
if ((bus.read8(pc+2) & 0xff) == 0x3e) {
t8=srl8(read8(add168x(ix,bus.read8(pc+1))));
write8(add168x(ix,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// BIT @r,(IX+@n)
if ((bus.read8(pc+2) & 0xc7) == 0x46) {
bit=(bus.read8(pc+2) & 0x38)>>3;
t8=bittest(bit,read8(add168x(ix,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 3;
return 15;

}
// RES @r,(IX+@n)
if ((bus.read8(pc+2) & 0xc7) == 0x86) {
bit=(bus.read8(pc+2) & 0x38)>>3;
write8(add168(ix,bus.read8(pc+1)), clearBit(bit,read8(add168(ix,bus.read8(pc+1)))));
pc += 3;
return 15;

}
// SET @r,(IX+@n)
if ((bus.read8(pc+2) & 0xc7) == 0xc6) {
bit=(bus.read8(pc+2) & 0x38)>>3;
write8(add168(ix,bus.read8(pc+1)), setBit(bit,read8(add168(ix,bus.read8(pc+1)))));
pc += 3;
return 15;

}
	break;

	case 0xcc:
	// Unknown operation
	break;

	case 0xcd:
	// Unknown operation
	break;

	case 0xce:
	// Unknown operation
	break;

	case 0xcf:
	// Unknown operation
	break;

	case 0xd0:
	// Unknown operation
	break;

	case 0xd1:
	// Unknown operation
	break;

	case 0xd2:
	// Unknown operation
	break;

	case 0xd3:
	// Unknown operation
	break;

	case 0xd4:
	// Unknown operation
	break;

	case 0xd5:
	// Unknown operation
	break;

	case 0xd6:
	// Unknown operation
	break;

	case 0xd7:
	// Unknown operation
	break;

	case 0xd8:
	// Unknown operation
	break;

	case 0xd9:
	// Unknown operation
	break;

	case 0xda:
	// Unknown operation
	break;

	case 0xdb:
	// Unknown operation
	break;

	case 0xdc:
	// Unknown operation
	break;

	case 0xdd:
	// Unknown operation
	break;

	case 0xde:
	// Unknown operation
	break;

	case 0xdf:
	// Unknown operation
	break;

	case 0xe0:
	// Unknown operation
	break;

	case 0xe1:	// pop ix
		// BUGWARN: No disass - was this hacked in?
		ix=read16(sp);
		sp=add16(sp,2);
		pc += 1;
		return 10;
	break;

	case 0xe2:
	// Unknown operation
	break;

	case 0xe3:
	// Unknown operation
	break;

	case 0xe4:
	// Unknown operation
	break;

	case 0xe5:
	// Unknown operation
	break;

	case 0xe6:
	// Unknown operation
	break;

	case 0xe7:
	// Unknown operation
	break;

	case 0xe8:
	// Unknown operation
	break;

	case 0xe9:
	// Unknown operation
		pc = ix;
	return 9;

	case 0xea:
	// Unknown operation
	break;

	case 0xeb:
	// Unknown operation
	break;

	case 0xec:
	// Unknown operation
	break;

	case 0xed:
	// Unknown operation
	break;

	case 0xee:
	// Unknown operation
	break;

	case 0xef:
	// Unknown operation
	break;

	case 0xf0:
	// Unknown operation
	break;

	case 0xf1:
	// Unknown operation
	break;

	case 0xf2:
	// Unknown operation
	break;

	case 0xf3:
	// Unknown operation
	break;

	case 0xf4:
	// Unknown operation
	break;

	case 0xf5:
	// Unknown operation
	break;

	case 0xf6:
	// Unknown operation
	break;

	case 0xf7:
	// Unknown operation
	break;

	case 0xf8:
	// Unknown operation
	break;

	case 0xf9:
	// Unknown operation
	break;

	case 0xfa:
	// Unknown operation
	break;

	case 0xfb:
	// Unknown operation
	break;

	case 0xfc:
	// Unknown operation
	break;

	case 0xfd:
	// Unknown operation
	break;

	case 0xfe:
	// Unknown operation
	break;

	case 0xff:
	// Unknown operation
	break;

} // hctiws
return 0;
}
public  function cb_ext() : uint {
var t8 : uint;
var t16 : uint;
var bit : uint;
var instr : uint = bus.read8(pc);
var cycles : uint = 0;

switch(instr) {
	case 0x0:
// RLC @r

b=rlc8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x1:
// RLC @r

c=rlc8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0x2:
// RLC @r

d=rlc8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0x3:
// RLC @r

e=rlc8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0x4:
// RLC @r

h=rlc8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0x5:
// RLC @r

l=rlc8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0x6:
// RLC @r
// RLC (HL)

t8=rlc8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0x7:
// RLC @r

a=rlc8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x8:
// RRC @r

b=rrc8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x9:
// RRC @r

c=rrc8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0xa:
// RRC @r

d=rrc8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0xb:
// RRC @r

e=rrc8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0xc:
// RRC @r

h=rrc8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0xd:
// RRC @r

l=rrc8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0xe:
// RRC @r
// RRC (HL)

t8=rrc8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


// RL (HL)

t8=rl8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0xf:
// RRC @r

a=rrc8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x10:
// RL @r

b=rl8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x11:
// RL @r

c=rl8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0x12:
// RL @r

d=rl8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0x13:
// RL @r

e=rl8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0x14:
// RL @r

h=rl8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0x15:
// RL @r

l=rl8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0x16:
// RL @r
	// Unknown operation
		t8=rl8(read8(hl));
		write8(hl, t8);
		cc_bit_4 = 0;
		cc_bit_1 = 0;
		cc_bit_7 = sign(t8);
		cc_bit_6 = zero(t8);
		cc_bit_2 = parity(t8);
		cc_bit_0 = carry(t8);
		pc += 1;
		return 8;
		
	break;

	case 0x17:
// RL @r

a=rl8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x18:
// RR @r

b=rr8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x19:
// RR @r

c=rr8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0x1a:
// RR @r

d=rr8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0x1b:
// RR @r

e=rr8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0x1c:
// RR @r

h=rr8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0x1d:
// RR @r

l=rr8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0x1e:
// RR @r
// RR (HL)

t8=rr8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0x1f:
// RR @r

a=rr8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x20:
// SLA @r

b=sla8(b);
pc += 1;
return 8;


	break;

	case 0x21:
// SLA @r

c=sla8(c);
pc += 1;
return 8;


	break;

	case 0x22:
// SLA @r

d=sla8(d);
pc += 1;
return 8;


	break;

	case 0x23:
// SLA @r

e=sla8(e);
pc += 1;
return 8;


	break;

	case 0x24:
// SLA @r

h=sla8(h);
pc += 1;
return 8;


	break;

	case 0x25:
// SLA @r

l=sla8(l);
pc += 1;
return 8;


	break;

	case 0x26:
// SLA @r
// SLA (HL)

t8=sla8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0x27:
// SLA @r

a=sla8(a);
pc += 1;
return 8;


	break;

	case 0x28:
// SRA @r

b=sra8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x29:
// SRA @r

c=sra8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0x2a:
// SRA @r

d=sra8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0x2b:
// SRA @r

e=sra8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0x2c:
// SRA @r

h=sra8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0x2d:
// SRA @r

l=sra8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0x2e:
// SRA @r
// SRA (HL)

t8=sra8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0x2f:
// SRA @r

a=sra8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x30:
// SLL @r

b=sll8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x31:
// SLL @r

c=sll8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0x32:
// SLL @r

d=sll8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0x33:
// SLL @r

e=sll8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0x34:
// SLL @r

h=sll8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0x35:
// SLL @r

l=sll8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0x36:
// SLL @r
// SLL (HL)

t8=sll8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0x37:
// SLL @r

a=sll8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x38:
// SRL @r

b=srl8(b);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_2 = parity(b);
cc_bit_0 = carry(b);
pc += 1;
return 8;


	break;

	case 0x39:
// SRL @r

c=srl8(c);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_2 = parity(c);
cc_bit_0 = carry(c);
pc += 1;
return 8;


	break;

	case 0x3a:
// SRL @r

d=srl8(d);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_2 = parity(d);
cc_bit_0 = carry(d);
pc += 1;
return 8;


	break;

	case 0x3b:
// SRL @r

e=srl8(e);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_2 = parity(e);
cc_bit_0 = carry(e);
pc += 1;
return 8;


	break;

	case 0x3c:
// SRL @r

h=srl8(h);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_2 = parity(h);
cc_bit_0 = carry(h);
pc += 1;
return 8;


	break;

	case 0x3d:
// SRL @r

l=srl8(l);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_2 = parity(l);
cc_bit_0 = carry(l);
pc += 1;
return 8;


	break;

	case 0x3e:
// SRL @r
// SRL (HL)

t8=srl8(read8(hl));
write8(hl,t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 1;
return 15;


	break;

	case 0x3f:
// SRL @r

a=srl8(a);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 8;


	break;

	case 0x40:
// BIT @r,@s

t8=bittest(0,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x41:
// BIT @r,@s

t8=bittest(0,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x42:
// BIT @r,@s

t8=bittest(0,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x43:
// BIT @r,@s

t8=bittest(0,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x44:
// BIT @r,@s

t8=bittest(0,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x45:
// BIT @r,@s

t8=bittest(0,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x46:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(0,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x47:
// BIT @r,@s

t8=bittest(0,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x48:
// BIT @r,@s

t8=bittest(1,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x49:
// BIT @r,@s

t8=bittest(1,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x4a:
// BIT @r,@s

t8=bittest(1,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x4b:
// BIT @r,@s

t8=bittest(1,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x4c:
// BIT @r,@s

t8=bittest(1,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x4d:
// BIT @r,@s

t8=bittest(1,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x4e:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(1,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x4f:
// BIT @r,@s

t8=bittest(1,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x50:
// BIT @r,@s

t8=bittest(2,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x51:
// BIT @r,@s

t8=bittest(2,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x52:
// BIT @r,@s

t8=bittest(2,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x53:
// BIT @r,@s

t8=bittest(2,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x54:
// BIT @r,@s

t8=bittest(2,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x55:
// BIT @r,@s

t8=bittest(2,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x56:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(2,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x57:
// BIT @r,@s

t8=bittest(2,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x58:
// BIT @r,@s

t8=bittest(3,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x59:
// BIT @r,@s

t8=bittest(3,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x5a:
// BIT @r,@s

t8=bittest(3,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x5b:
// BIT @r,@s

t8=bittest(3,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x5c:
// BIT @r,@s

t8=bittest(3,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x5d:
// BIT @r,@s

t8=bittest(3,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x5e:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(3,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x5f:
// BIT @r,@s

t8=bittest(3,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x60:
// BIT @r,@s

t8=bittest(4,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x61:
// BIT @r,@s

t8=bittest(4,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x62:
// BIT @r,@s

t8=bittest(4,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x63:
// BIT @r,@s

t8=bittest(4,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x64:
// BIT @r,@s

t8=bittest(4,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x65:
// BIT @r,@s

t8=bittest(4,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x66:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(4,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x67:
// BIT @r,@s

t8=bittest(4,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x68:
// BIT @r,@s

t8=bittest(5,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x69:
// BIT @r,@s

t8=bittest(5,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x6a:
// BIT @r,@s

t8=bittest(5,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x6b:
// BIT @r,@s

t8=bittest(5,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x6c:
// BIT @r,@s

t8=bittest(5,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x6d:
// BIT @r,@s

t8=bittest(5,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x6e:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(5,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x6f:
// BIT @r,@s

t8=bittest(5,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x70:
// BIT @r,@s

t8=bittest(6,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x71:
// BIT @r,@s

t8=bittest(6,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x72:
// BIT @r,@s

t8=bittest(6,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x73:
// BIT @r,@s

t8=bittest(6,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x74:
// BIT @r,@s

t8=bittest(6,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x75:
// BIT @r,@s

t8=bittest(6,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x76:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(6,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x77:
// BIT @r,@s

t8=bittest(6,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x78:
// BIT @r,@s

t8=bittest(7,b);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x79:
// BIT @r,@s

t8=bittest(7,c);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x7a:
// BIT @r,@s

t8=bittest(7,d);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x7b:
// BIT @r,@s

t8=bittest(7,e);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x7c:
// BIT @r,@s

t8=bittest(7,h);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x7d:
// BIT @r,@s

t8=bittest(7,l);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x7e:
// BIT @r,@s
// BIT @r, (HL)

t8=bittest(7,read8(hl));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 15;


	break;

	case 0x7f:
// BIT @r,@s

t8=bittest(7,a);
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 8;


	break;

	case 0x80:
// RES @r,@s

b=clearBit(0,b);
pc += 1;
return 8;


	break;

	case 0x81:
// RES @r,@s

c=clearBit(0,c);
pc += 1;
return 8;


	break;

	case 0x82:
// RES @r,@s

d=clearBit(0,d);
pc += 1;
return 8;


	break;

	case 0x83:
// RES @r,@s

e=clearBit(0,e);
pc += 1;
return 8;


	break;

	case 0x84:
// RES @r,@s

h=clearBit(0,h);
pc += 1;
return 8;


	break;

	case 0x85:
// RES @r,@s

l=clearBit(0,l);
pc += 1;
return 8;


	break;

	case 0x86:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(0,read8(hl)));
pc += 1;
return 15;


	break;

	case 0x87:
// RES @r,@s

a=clearBit(0,a);
pc += 1;
return 8;


	break;

	case 0x88:
// RES @r,@s

b=clearBit(1,b);
pc += 1;
return 8;


	break;

	case 0x89:
// RES @r,@s

c=clearBit(1,c);
pc += 1;
return 8;


	break;

	case 0x8a:
// RES @r,@s

d=clearBit(1,d);
pc += 1;
return 8;


	break;

	case 0x8b:
// RES @r,@s

e=clearBit(1,e);
pc += 1;
return 8;


	break;

	case 0x8c:
// RES @r,@s

h=clearBit(1,h);
pc += 1;
return 8;


	break;

	case 0x8d:
// RES @r,@s

l=clearBit(1,l);
pc += 1;
return 8;


	break;

	case 0x8e:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(1,read8(hl)));
pc += 1;
return 15;


	break;

	case 0x8f:
// RES @r,@s

a=clearBit(1,a);
pc += 1;
return 8;


	break;

	case 0x90:
// RES @r,@s

b=clearBit(2,b);
pc += 1;
return 8;


	break;

	case 0x91:
// RES @r,@s

c=clearBit(2,c);
pc += 1;
return 8;


	break;

	case 0x92:
// RES @r,@s

d=clearBit(2,d);
pc += 1;
return 8;


	break;

	case 0x93:
// RES @r,@s

e=clearBit(2,e);
pc += 1;
return 8;


	break;

	case 0x94:
// RES @r,@s

h=clearBit(2,h);
pc += 1;
return 8;


	break;

	case 0x95:
// RES @r,@s

l=clearBit(2,l);
pc += 1;
return 8;


	break;

	case 0x96:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(2,read8(hl)));
pc += 1;
return 15;


	break;

	case 0x97:
// RES @r,@s

a=clearBit(2,a);
pc += 1;
return 8;


	break;

	case 0x98:
// RES @r,@s

b=clearBit(3,b);
pc += 1;
return 8;


	break;

	case 0x99:
// RES @r,@s

c=clearBit(3,c);
pc += 1;
return 8;


	break;

	case 0x9a:
// RES @r,@s

d=clearBit(3,d);
pc += 1;
return 8;


	break;

	case 0x9b:
// RES @r,@s

e=clearBit(3,e);
pc += 1;
return 8;


	break;

	case 0x9c:
// RES @r,@s

h=clearBit(3,h);
pc += 1;
return 8;


	break;

	case 0x9d:
// RES @r,@s

l=clearBit(3,l);
pc += 1;
return 8;


	break;

	case 0x9e:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(3,read8(hl)));
pc += 1;
return 15;


	break;

	case 0x9f:
// RES @r,@s

a=clearBit(3,a);
pc += 1;
return 8;


	break;

	case 0xa0:
// RES @r,@s

b=clearBit(4,b);
pc += 1;
return 8;


	break;

	case 0xa1:
// RES @r,@s

c=clearBit(4,c);
pc += 1;
return 8;


	break;

	case 0xa2:
// RES @r,@s

d=clearBit(4,d);
pc += 1;
return 8;


	break;

	case 0xa3:
// RES @r,@s

e=clearBit(4,e);
pc += 1;
return 8;


	break;

	case 0xa4:
// RES @r,@s

h=clearBit(4,h);
pc += 1;
return 8;


	break;

	case 0xa5:
// RES @r,@s

l=clearBit(4,l);
pc += 1;
return 8;


	break;

	case 0xa6:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(4,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xa7:
// RES @r,@s

a=clearBit(4,a);
pc += 1;
return 8;


	break;

	case 0xa8:
// RES @r,@s

b=clearBit(5,b);
pc += 1;
return 8;


	break;

	case 0xa9:
// RES @r,@s

c=clearBit(5,c);
pc += 1;
return 8;


	break;

	case 0xaa:
// RES @r,@s

d=clearBit(5,d);
pc += 1;
return 8;


	break;

	case 0xab:
// RES @r,@s

e=clearBit(5,e);
pc += 1;
return 8;


	break;

	case 0xac:
// RES @r,@s

h=clearBit(5,h);
pc += 1;
return 8;


	break;

	case 0xad:
// RES @r,@s

l=clearBit(5,l);
pc += 1;
return 8;


	break;

	case 0xae:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(5,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xaf:
// RES @r,@s

a=clearBit(5,a);
pc += 1;
return 8;


	break;

	case 0xb0:
// RES @r,@s

b=clearBit(6,b);
pc += 1;
return 8;


	break;

	case 0xb1:
// RES @r,@s

c=clearBit(6,c);
pc += 1;
return 8;


	break;

	case 0xb2:
// RES @r,@s

d=clearBit(6,d);
pc += 1;
return 8;


	break;

	case 0xb3:
// RES @r,@s

e=clearBit(6,e);
pc += 1;
return 8;


	break;

	case 0xb4:
// RES @r,@s

h=clearBit(6,h);
pc += 1;
return 8;


	break;

	case 0xb5:
// RES @r,@s

l=clearBit(6,l);
pc += 1;
return 8;


	break;

	case 0xb6:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(6,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xb7:
// RES @r,@s

a=clearBit(6,a);
pc += 1;
return 8;


	break;

	case 0xb8:
// RES @r,@s

b=clearBit(7,b);
pc += 1;
return 8;


	break;

	case 0xb9:
// RES @r,@s

c=clearBit(7,c);
pc += 1;
return 8;


	break;

	case 0xba:
// RES @r,@s

d=clearBit(7,d);
pc += 1;
return 8;


	break;

	case 0xbb:
// RES @r,@s

e=clearBit(7,e);
pc += 1;
return 8;


	break;

	case 0xbc:
// RES @r,@s

h=clearBit(7,h);
pc += 1;
return 8;


	break;

	case 0xbd:
// RES @r,@s

l=clearBit(7,l);
pc += 1;
return 8;


	break;

	case 0xbe:
// RES @r,@s
// RES @r, (HL)

write8(hl, clearBit(7,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xbf:
// RES @r,@s

a=clearBit(7,a);
pc += 1;
return 8;


	break;

	case 0xc0:
// SET @r,@s

b=setBit(0,b);
pc += 1;
return 8;


	break;

	case 0xc1:
// SET @r,@s

c=setBit(0,c);
pc += 1;
return 8;


	break;

	case 0xc2:
// SET @r,@s

d=setBit(0,d);
pc += 1;
return 8;


	break;

	case 0xc3:
// SET @r,@s

e=setBit(0,e);
pc += 1;
return 8;


	break;

	case 0xc4:
// SET @r,@s

h=setBit(0,h);
pc += 1;
return 8;


	break;

	case 0xc5:
// SET @r,@s

l=setBit(0,l);
pc += 1;
return 8;


	break;

	case 0xc6:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(0,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xc7:
// SET @r,@s

a=setBit(0,a);
pc += 1;
return 8;


	break;

	case 0xc8:
// SET @r,@s

b=setBit(1,b);
pc += 1;
return 8;


	break;

	case 0xc9:
// SET @r,@s

c=setBit(1,c);
pc += 1;
return 8;


	break;

	case 0xca:
// SET @r,@s

d=setBit(1,d);
pc += 1;
return 8;


	break;

	case 0xcb:
// SET @r,@s

e=setBit(1,e);
pc += 1;
return 8;


	break;

	case 0xcc:
// SET @r,@s

h=setBit(1,h);
pc += 1;
return 8;


	break;

	case 0xcd:
// SET @r,@s

l=setBit(1,l);
pc += 1;
return 8;


	break;

	case 0xce:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(1,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xcf:
// SET @r,@s

a=setBit(1,a);
pc += 1;
return 8;


	break;

	case 0xd0:
// SET @r,@s

b=setBit(2,b);
pc += 1;
return 8;


	break;

	case 0xd1:
// SET @r,@s

c=setBit(2,c);
pc += 1;
return 8;


	break;

	case 0xd2:
// SET @r,@s

d=setBit(2,d);
pc += 1;
return 8;


	break;

	case 0xd3:
// SET @r,@s

e=setBit(2,e);
pc += 1;
return 8;


	break;

	case 0xd4:
// SET @r,@s

h=setBit(2,h);
pc += 1;
return 8;


	break;

	case 0xd5:
// SET @r,@s

l=setBit(2,l);
pc += 1;
return 8;


	break;

	case 0xd6:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(2,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xd7:
// SET @r,@s

a=setBit(2,a);
pc += 1;
return 8;


	break;

	case 0xd8:
// SET @r,@s

b=setBit(3,b);
pc += 1;
return 8;


	break;

	case 0xd9:
// SET @r,@s

c=setBit(3,c);
pc += 1;
return 8;


	break;

	case 0xda:
// SET @r,@s

d=setBit(3,d);
pc += 1;
return 8;


	break;

	case 0xdb:
// SET @r,@s

e=setBit(3,e);
pc += 1;
return 8;


	break;

	case 0xdc:
// SET @r,@s

h=setBit(3,h);
pc += 1;
return 8;


	break;

	case 0xdd:
// SET @r,@s

l=setBit(3,l);
pc += 1;
return 8;


	break;

	case 0xde:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(3,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xdf:
// SET @r,@s

a=setBit(3,a);
pc += 1;
return 8;


	break;

	case 0xe0:
// SET @r,@s

b=setBit(4,b);
pc += 1;
return 8;


	break;

	case 0xe1:
// SET @r,@s

c=setBit(4,c);
pc += 1;
return 8;


	break;

	case 0xe2:
// SET @r,@s

d=setBit(4,d);
pc += 1;
return 8;


	break;

	case 0xe3:
// SET @r,@s

e=setBit(4,e);
pc += 1;
return 8;


	break;

	case 0xe4:
// SET @r,@s

h=setBit(4,h);
pc += 1;
return 8;


	break;

	case 0xe5:
// SET @r,@s

l=setBit(4,l);
pc += 1;
return 8;


	break;

	case 0xe6:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(4,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xe7:
// SET @r,@s

a=setBit(4,a);
pc += 1;
return 8;


	break;

	case 0xe8:
// SET @r,@s

b=setBit(5,b);
pc += 1;
return 8;


	break;

	case 0xe9:
// SET @r,@s

c=setBit(5,c);
pc += 1;
return 8;


	break;

	case 0xea:
// SET @r,@s

d=setBit(5,d);
pc += 1;
return 8;


	break;

	case 0xeb:
// SET @r,@s

e=setBit(5,e);
pc += 1;
return 8;


	break;

	case 0xec:
// SET @r,@s

h=setBit(5,h);
pc += 1;
return 8;


	break;

	case 0xed:
// SET @r,@s

l=setBit(5,l);
pc += 1;
return 8;


	break;

	case 0xee:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(5,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xef:
// SET @r,@s

a=setBit(5,a);
pc += 1;
return 8;


	break;

	case 0xf0:
// SET @r,@s

b=setBit(6,b);
pc += 1;
return 8;


	break;

	case 0xf1:
// SET @r,@s

c=setBit(6,c);
pc += 1;
return 8;


	break;

	case 0xf2:
// SET @r,@s

d=setBit(6,d);
pc += 1;
return 8;


	break;

	case 0xf3:
// SET @r,@s

e=setBit(6,e);
pc += 1;
return 8;


	break;

	case 0xf4:
// SET @r,@s

h=setBit(6,h);
pc += 1;
return 8;


	break;

	case 0xf5:
// SET @r,@s

l=setBit(6,l);
pc += 1;
return 8;


	break;

	case 0xf6:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(6,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xf7:
// SET @r,@s

a=setBit(6,a);
pc += 1;
return 8;


	break;

	case 0xf8:
// SET @r,@s

b=setBit(7,b);
pc += 1;
return 8;


	break;

	case 0xf9:
// SET @r,@s

c=setBit(7,c);
pc += 1;
return 8;


	break;

	case 0xfa:
// SET @r,@s

d=setBit(7,d);
pc += 1;
return 8;


	break;

	case 0xfb:
// SET @r,@s

e=setBit(7,e);
pc += 1;
return 8;


	break;

	case 0xfc:
// SET @r,@s

h=setBit(7,h);
pc += 1;
return 8;


	break;

	case 0xfd:
// SET @r,@s

l=setBit(7,l);
pc += 1;
return 8;


	break;

	case 0xfe:
// SET @r,@s
// SET @r, (HL)

write8(hl, setBit(7,read8(hl)));
pc += 1;
return 15;


	break;

	case 0xff:
// SET @r,@s

a=setBit(7,a);
pc += 1;
return 8;


	break;

} // hctiws
return 0;
}
public  function ed_ext() : uint {
var t8 : uint;
var t16 : uint;
var bit : uint;
var instr : uint = bus.read8(pc);
var cycles : uint = 0;

switch(instr) {
	case 0x0:
	// Unknown operation
	break;

	case 0x1:
	// Unknown operation
	break;

	case 0x2:
	// Unknown operation
	break;

	case 0x3:
	// Unknown operation
	break;

	case 0x4:
	// Unknown operation
	break;

	case 0x5:
	// Unknown operation
	break;

	case 0x6:
	// Unknown operation
	break;

	case 0x7:
	// Unknown operation
	break;

	case 0x8:
	// Unknown operation
	break;

	case 0x9:
	// Unknown operation
	break;

	case 0xa:
	// Unknown operation
	break;

	case 0xb:
	// Unknown operation
	break;

	case 0xc:
	// Unknown operation
	break;

	case 0xd:
	// Unknown operation
	break;

	case 0xe:
	// Unknown operation
	break;

	case 0xf:
	// Unknown operation
	break;

	case 0x10:
	// Unknown operation
	break;

	case 0x11:
	// Unknown operation
	break;

	case 0x12:
	// Unknown operation
	break;

	case 0x13:
	// Unknown operation
	break;

	case 0x14:
	// Unknown operation
	break;

	case 0x15:
	// Unknown operation
	break;

	case 0x16:
	// Unknown operation
	break;

	case 0x17:
	// Unknown operation
	break;

	case 0x18:
	// Unknown operation
	break;

	case 0x19:
	// Unknown operation
	break;

	case 0x1a:
	// Unknown operation
	break;

	case 0x1b:
	// Unknown operation
	break;

	case 0x1c:
	// Unknown operation
	break;

	case 0x1d:
	// Unknown operation
	break;

	case 0x1e:
	// Unknown operation
	break;

	case 0x1f:
	// Unknown operation
	break;

	case 0x20:
	// Unknown operation
	break;

	case 0x21:
	// Unknown operation
	break;

	case 0x22:
	// Unknown operation
	break;

	case 0x23:
	// Unknown operation
	break;

	case 0x24:
	// Unknown operation
	break;

	case 0x25:
	// Unknown operation
	break;

	case 0x26:
	// Unknown operation
	break;

	case 0x27:
	// Unknown operation
	break;

	case 0x28:
	// Unknown operation
	break;

	case 0x29:
	// Unknown operation
	break;

	case 0x2a:
	// Unknown operation
	break;

	case 0x2b:
	// Unknown operation
	break;

	case 0x2c:
	// Unknown operation
	break;

	case 0x2d:
	// Unknown operation
	break;

	case 0x2e:
	// Unknown operation
	break;

	case 0x2f:
	// Unknown operation
	break;

	case 0x30:
	// Unknown operation
	break;

	case 0x31:
	// Unknown operation
	break;

	case 0x32:
	// Unknown operation
	break;

	case 0x33:
	// Unknown operation
	break;

	case 0x34:
	// Unknown operation
	break;

	case 0x35:
	// Unknown operation
	break;

	case 0x36:
	// Unknown operation
	break;

	case 0x37:
	// Unknown operation
	break;

	case 0x38:
	// Unknown operation
	break;

	case 0x39:
	// Unknown operation
	break;

	case 0x3a:
	// Unknown operation
	break;

	case 0x3b:
	// Unknown operation
	break;

	case 0x3c:
	// Unknown operation
	break;

	case 0x3d:
	// Unknown operation
	break;

	case 0x3e:
	// Unknown operation
	break;

	case 0x3f:
	// Unknown operation
	break;

	case 0x40:
// IN @r,(C)

b=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(b);
cc_bit_6 = zero(b);
cc_bit_4 = halfcarry(b);
cc_bit_2 = parity(b);
pc += 1;
return 12;


	break;

	case 0x41:
// OUT (C),@r

outport(bc, b);
pc += 1;
return 12;


	break;

	case 0x42:
// SBC HL,@r

hl=sub16(hl,bc,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x43:
// LD (@n),@r

write16(bus.read16(pc+1),bc);
pc += 3;
return 15;


	break;

	case 0x44:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x45:
// RETN

pc=read16(sp)-1;
sp=add16(sp,2);
iff1=iff2;
pc += 1;
return 14;


	break;

	case 0x46:
// IM 0

im0();
pc += 1;
return 8;


	break;

	case 0x47:
// LD I,A

intv=a;
pc += 1;
return 9;


	break;

	case 0x48:
// IN @r,(C)

c=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(c);
cc_bit_6 = zero(c);
cc_bit_4 = halfcarry(c);
cc_bit_2 = parity(c);
pc += 1;
return 12;


	break;

	case 0x49:
// OUT (C),@r

outport(bc, c);
pc += 1;
return 12;


	break;

	case 0x4a:
// ADC HL,@r

hl=add16(hl,bc,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x4b:
// LD @r,(@n)

bc=read16(bus.read16(pc+1));
pc += 3;
return 20;


	break;

	case 0x4c:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x4d:
// RETI

pc=read16(sp)-1;
sp=add16(sp,2);
pc += 1;
return 14;


	break;

	case 0x4e:
// IM 1

im1();
pc += 1;
return 8;


	break;

	case 0x4f:
// LD R,A

memrefresh=a;
radjust=memrefresh;
pc += 1;
return 9;


	break;

	case 0x50:
// IN @r,(C)

d=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(d);
cc_bit_6 = zero(d);
cc_bit_4 = halfcarry(d);
cc_bit_2 = parity(d);
pc += 1;
return 12;


	break;

	case 0x51:
// OUT (C),@r

outport(bc, d);
pc += 1;
return 12;


	break;

	case 0x52:
// SBC HL,@r

hl=sub16(hl,de,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x53:
// LD (@n),@r

write16(bus.read16(pc+1),de);
pc += 3;
return 15;


	break;

	case 0x54:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x55:
// RETN

pc=read16(sp)-1;
sp=add16(sp,2);
iff1=iff2;
pc += 1;
return 14;


	break;

	case 0x56:
// IM 1

im1();
pc += 1;
return 8;


	break;

	case 0x57:
// LD A,I

a=intv;
pc += 1;
return 9;


	break;

	case 0x58:
// IN @r,(C)

e=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(e);
cc_bit_6 = zero(e);
cc_bit_4 = halfcarry(e);
cc_bit_2 = parity(e);
pc += 1;
return 12;


	break;

	case 0x59:
// OUT (C),@r

outport(bc, e);
pc += 1;
return 12;


	break;

	case 0x5a:
// ADC HL,@r

hl=add16(hl,de,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x5b:
// LD @r,(@n)

de=read16(bus.read16(pc+1));
pc += 3;
return 20;


	break;

	case 0x5c:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x5d:
// RETN

pc=read16(sp)-1;
sp=add16(sp,2);
iff1=iff2;
pc += 1;
return 14;


	break;

	case 0x5e:
// IM 2

im2();
pc += 1;
return 8;


	break;

	case 0x5f:
// LD A,R

a=(memrefresh & 0x80) | (radjust & 0x7f);
memrefresh = a;
cc_bit_2 = iff2 ? 1 : 0;
cc_bit_6 = zero(a);
pc += 1;
return 9;


	break;

	case 0x60:
// IN @r,(C)

h=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(h);
cc_bit_6 = zero(h);
cc_bit_4 = halfcarry(h);
cc_bit_2 = parity(h);
pc += 1;
return 12;


	break;

	case 0x61:
// OUT (C),@r

outport(bc, h);
pc += 1;
return 12;


	break;

	case 0x62:
// SBC HL,@r

hl=sub16(hl,hl,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x63:
// LD (@n),@r

write16(bus.read16(pc+1),hl);
pc += 3;
return 15;


	break;

	case 0x64:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x65:
	// Unknown operation
	break;

	case 0x66:
	// Unknown operation
	break;

	case 0x67:
// RRD

t8=rrd();
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 18;


	break;

	case 0x68:
// IN @r,(C)

l=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(l);
cc_bit_6 = zero(l);
cc_bit_4 = halfcarry(l);
cc_bit_2 = parity(l);
pc += 1;
return 12;


	break;

	case 0x69:
// OUT (C),@r

outport(bc, l);
pc += 1;
return 12;


	break;

	case 0x6a:
// ADC HL,@r

hl=add16(hl,hl,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x6b:
// LD @r,(@n)

hl=read16(bus.read16(pc+1));
pc += 3;
return 20;


	break;

	case 0x6c:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x6d:
	// Unknown operation
	break;

	case 0x6e:
	// Unknown operation
	break;

	case 0x6f:
// RLD

t8=rld();
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 18;


	break;

	case 0x70:
// IN @r,(C)
// IN (C)

t8=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = parity(t8);
pc += 1;
return 12;


	break;

	case 0x71:
// OUT (C),@r
// OUT (C),0

outport(bc, 0);
pc += 1;
return 12;


	break;

	case 0x72:
// SBC HL,@r

hl=sub16(hl,sp,cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x73:
// LD (@n),@r

write16(bus.read16(pc+1),sp);
pc += 3;
return 15;


	break;

	case 0x74:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x75:
	// Unknown operation
	break;

	case 0x76:
	// Unknown operation
	break;

	case 0x77:
	// Unknown operation
	break;

	case 0x78:
// IN @r,(C)

a=inport(bc);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
pc += 1;
return 12;


	break;

	case 0x79:
// OUT (C),@r

outport(bc, a);
pc += 1;
return 12;


	break;

	case 0x7a:
// ADC HL,@r

hl=add16(hl,sp,cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign16(hl);
cc_bit_6 = zero(hl);
cc_bit_4 = halfcarry(hl);
cc_bit_2 = overflow(hl);
cc_bit_0 = carry(hl);
pc += 1;
return 15;


	break;

	case 0x7b:
// LD @r,(@n)

sp=read16(bus.read16(pc+1));
pc += 3;
return 20;


	break;

	case 0x7c:
// NEG

a=sub8(0,a);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = parity(a);
cc_bit_0 = carry(a);
pc += 1;
return 4;


	break;

	case 0x7d:
	// Unknown operation
	break;

	case 0x7e:
	// Unknown operation
	break;

	case 0x7f:
	// Unknown operation
	break;

	case 0x80:
	// Unknown operation
	break;

	case 0x81:
	// Unknown operation
	break;

	case 0x82:
	// Unknown operation
	break;

	case 0x83:
	// Unknown operation
	break;

	case 0x84:
	// Unknown operation
	break;

	case 0x85:
	// Unknown operation
	break;

	case 0x86:
	// Unknown operation
	break;

	case 0x87:
	// Unknown operation
	break;

	case 0x88:
	// Unknown operation
	break;

	case 0x89:
	// Unknown operation
	break;

	case 0x8a:
	// Unknown operation
	break;

	case 0x8b:
	// Unknown operation
	break;

	case 0x8c:
	// Unknown operation
	break;

	case 0x8d:
	// Unknown operation
	break;

	case 0x8e:
	// Unknown operation
	break;

	case 0x8f:
	// Unknown operation
	break;

	case 0x90:
	// Unknown operation
	break;

	case 0x91:
	// Unknown operation
	break;

	case 0x92:
	// Unknown operation
	break;

	case 0x93:
	// Unknown operation
	break;

	case 0x94:
	// Unknown operation
	break;

	case 0x95:
	// Unknown operation
	break;

	case 0x96:
	// Unknown operation
	break;

	case 0x97:
	// Unknown operation
	break;

	case 0x98:
	// Unknown operation
	break;

	case 0x99:
	// Unknown operation
	break;

	case 0x9a:
	// Unknown operation
	break;

	case 0x9b:
	// Unknown operation
	break;

	case 0x9c:
	// Unknown operation
	break;

	case 0x9d:
	// Unknown operation
	break;

	case 0x9e:
	// Unknown operation
	break;

	case 0x9f:
	// Unknown operation
	break;

	case 0xa0:
// LDI

write8(de, read8(hl));
hl=add16(hl,1);
de=add16(de,1);
bc=sub16(bc,1);
if(bc==0)cc_bit_2=0;else cc_bit_2=1;
pc += 1;
return 16;


	break;

	case 0xa1:
// CPI

t8=a-read8(hl);
hl=(hl+1);
bc=(bc-1);
if(bc==0)cc_bit_2=0;else cc_bit_2=1;
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
pc += 1;
return 16;


	break;

	case 0xa2:
// INI

t8=inport(bc);
write8(hl,t8);
hl=add16(hl,1);
b=sub8(b,1);
if(bc==0)cc_bit_6=1;else cc_bit_6=0;
cc_bit_1 = 1;
cc_bit_2 = parity(t8);
pc += 1;
return 16;


	break;

	case 0xa3:
// OUTI

outport(bc, read8(hl));
hl=add16(hl,1);
b=sub8(b,1);
if(bc==0)cc_bit_6=1;else cc_bit_6=0;
pc += 1;
return 16;


	break;

	case 0xa4:
	// Unknown operation
	break;

	case 0xa5:
	// Unknown operation
	break;

	case 0xa6:
	// Unknown operation
	break;

	case 0xa7:
	// Unknown operation
	break;

	case 0xa8:
// LDD

write8(de, read8(hl));
de=sub16(de,1);
hl=sub16(hl,1);
bc=sub16(bc,1);
if(bc==0)cc_bit_2=0;else cc_bit_2=1;
cc_bit_4 = 0;
cc_bit_1 = 0;
pc += 1;
return 16;


	break;

	case 0xa9:
// CPD

t8=a-read8(hl);
hl=(hl-1);
bc=(bc-1);
if(bc==0)cc_bit_2=0;else cc_bit_2=1;
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
pc += 1;
return 16;


	break;

	case 0xaa:
// IND

t8=inport(bc);
write8(hl,t8);
b=sub8(b,1);
hl=sub16(hl,1);
if(bc==0)cc_bit_6=1;else cc_bit_6=0;
cc_bit_1 = 1;
cc_bit_2 = parity(t8);
pc += 1;
return 16;


	break;

	case 0xab:
// OUTD

outport(bc, read8(hl));
hl=sub16(hl,1);
b=sub8(b,1);
if(bc==0)cc_bit_6=1;else cc_bit_6=0;
cc_bit_1 = 1;
pc += 1;
return 16;


	break;

	case 0xac:
	// Unknown operation
	break;

	case 0xad:
	// Unknown operation
	break;

	case 0xae:
	// Unknown operation
	break;

	case 0xaf:
	// Unknown operation
	break;

	case 0xb0:
// LDIR

do{;
write8(de, read8(hl));
de=add16(de,1);
hl=add16(hl,1);
bc=sub16(bc,1);
}while(bc!=0);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_2 = 0;
pc += 1;
return 16;


	break;

	case 0xb1:
// CPIR

do{;
t8=a-read8(hl);
hl=(hl+1);
bc=(bc-1);
}while(bc!=0 && t8!=0);
if(bc==0)cc_bit_2=0;else cc_bit_2=1;
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
pc += 1;
return 16;


	break;

	case 0xb2:
// INIR

do{;
t8=inport(bc);
write8(hl,t8);
hl=add16(hl,1);
b=sub8(b,1);
}while(b!=0);
cc_bit_1 = 1;
cc_bit_2 = parity(t8);
pc += 1;
return 16;


	break;

	case 0xb3:
// OTIR

do{;
outport(bc, read8(hl));
hl=sub16(hl,1);
b=sub8(b,1);
}while(b!=0);
cc_bit_1 = 1;
cc_bit_2 = parity(hl);
pc += 1;
return 16;


	break;

	case 0xb4:
	// Unknown operation
	break;

	case 0xb5:
	// Unknown operation
	break;

	case 0xb6:
	// Unknown operation
	break;

	case 0xb7:
	// Unknown operation
	break;

	case 0xb8:
// LDDR

do{;
write8(de, read8(hl));
de=(de-1);
hl=(hl-1);
bc=(bc-1);
}while(bc!=0);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_2 = 0;
pc += 1;
return 16;


	break;

	case 0xb9:
// CPDR

do{;
t8=a-read8(hl);
hl=(hl-1);
bc=(bc-1);
if(bc==0)cc_bit_2=0;else cc_bit_2=1;
}while(bc!=0 && t8!=0);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
pc += 1;
return 16;


	break;

	case 0xba:
// INDR

do{;
t8=inport(bc);
write8(hl,t8);
hl=sub16(hl,1);
b=sub8(b,1);
}while(b!=0);
cc_bit_1 = 1;
cc_bit_2 = parity(t8);
pc += 1;
return 16;


	break;

	case 0xbb:
// OTDR

do{;
outport(bc, read8(hl));
hl=sub16(hl,1);
b=sub8(b,1);
}while(b!=0);
cc_bit_1 = 1;
pc += 1;
return 16;


	break;

	case 0xbc:
	// Unknown operation
	break;

	case 0xbd:
	// Unknown operation
	break;

	case 0xbe:
	// Unknown operation
	break;

	case 0xbf:
	// Unknown operation
	break;

	case 0xc0:
	// Unknown operation
	break;

	case 0xc1:
	// Unknown operation
	break;

	case 0xc2:
	// Unknown operation
	break;

	case 0xc3:
	// Unknown operation
	break;

	case 0xc4:
	// Unknown operation
	break;

	case 0xc5:
	// Unknown operation
	break;

	case 0xc6:
	// Unknown operation
	break;

	case 0xc7:
	// Unknown operation
	break;

	case 0xc8:
	// Unknown operation
	break;

	case 0xc9:
	// Unknown operation
	break;

	case 0xca:
	// Unknown operation
	break;

	case 0xcb:
	// Unknown operation
	break;

	case 0xcc:
	// Unknown operation
	break;

	case 0xcd:
	// Unknown operation
	break;

	case 0xce:
	// Unknown operation
	break;

	case 0xcf:
	// Unknown operation
	break;

	case 0xd0:
	// Unknown operation
	break;

	case 0xd1:
	// Unknown operation
	break;

	case 0xd2:
	// Unknown operation
	break;

	case 0xd3:
	// Unknown operation
	break;

	case 0xd4:
	// Unknown operation
	break;

	case 0xd5:
	// Unknown operation
	break;

	case 0xd6:
	// Unknown operation
	break;

	case 0xd7:
	// Unknown operation
	break;

	case 0xd8:
	// Unknown operation
	break;

	case 0xd9:
	// Unknown operation
	break;

	case 0xda:
	// Unknown operation
	break;

	case 0xdb:
	// Unknown operation
	break;

	case 0xdc:
	// Unknown operation
	break;

	case 0xdd:
	// Unknown operation
	break;

	case 0xde:
	// Unknown operation
	break;

	case 0xdf:
	// Unknown operation
	break;

	case 0xe0:
	// Unknown operation
	break;

	case 0xe1:
	// Unknown operation
	break;

	case 0xe2:
	// Unknown operation
	break;

	case 0xe3:
	// Unknown operation
	break;

	case 0xe4:
	// Unknown operation
	break;

	case 0xe5:
	// Unknown operation
	break;

	case 0xe6:
	// Unknown operation
	break;

	case 0xe7:
	// Unknown operation
	break;

	case 0xe8:
	// Unknown operation
	break;

	case 0xe9:
	// Unknown operation
	break;

	case 0xea:
	// Unknown operation
	break;

	case 0xeb:
	// Unknown operation
	break;

	case 0xec:
	// Unknown operation
	break;

	case 0xed:
	// Unknown operation
	break;

	case 0xee:
	// Unknown operation
	break;

	case 0xef:
	// Unknown operation
	break;

	case 0xf0:
	// Unknown operation
	break;

	case 0xf1:
	// Unknown operation
	break;

	case 0xf2:
	// Unknown operation
	break;

	case 0xf3:
	// Unknown operation
	break;

	case 0xf4:
	// Unknown operation
	break;

	case 0xf5:
	// Unknown operation
	break;

	case 0xf6:
	// Unknown operation
	break;

	case 0xf7:
	// Unknown operation
	break;

	case 0xf8:
	// Unknown operation
	break;

	case 0xf9:
	// Unknown operation
	break;

	case 0xfa:
	// Unknown operation
	break;

	case 0xfb:
	// Unknown operation
	break;

	case 0xfc:
	// Unknown operation
	break;

	case 0xfd:
	// Unknown operation
	break;

	case 0xfe:
	// Unknown operation
	break;

	case 0xff:
	// Unknown operation
	break;

} // hctiws
return 0;
}
public  function fd_ext() : uint {
var t8 : uint;
var t16 : uint;
var bit : uint;
var instr : uint = bus.read8(pc);
var cycles : uint = 0;

switch(instr) {
	case 0x0:
	// Unknown operation
	break;

	case 0x1:
	// Unknown operation
	break;

	case 0x2:
	// Unknown operation
	break;

	case 0x3:
	// Unknown operation
	break;

	case 0x4:
	// Unknown operation
	break;

	case 0x5:
	// Unknown operation
	break;

	case 0x6:
	// Unknown operation
	break;

	case 0x7:
	// Unknown operation
	break;

	case 0x8:
	// Unknown operation
	break;

	case 0x9:
// ADD IY,@r

iy=add16(iy,bc);
cc_bit_1 = 0;
cc_bit_0 = carry(iy);
pc += 1;
return 15;


	break;

	case 0xa:
	// Unknown operation
	break;

	case 0xb:
	// Unknown operation
	break;

	case 0xc:
	// Unknown operation
	break;

	case 0xd:
	// Unknown operation
	break;

	case 0xe:
	// Unknown operation
	break;

	case 0xf:
	// Unknown operation
	break;

	case 0x10:
	// Unknown operation
	break;

	case 0x11:
	// Unknown operation
	break;

	case 0x12:
	// Unknown operation
	break;

	case 0x13:
	// Unknown operation
	break;

	case 0x14:
	// Unknown operation
	break;

	case 0x15:
	// Unknown operation
	break;

	case 0x16:
	// Unknown operation
	break;

	case 0x17:
	// Unknown operation
	break;

	case 0x18:
	// Unknown operation
	break;

	case 0x19:
// ADD IY,@r

iy=add16(iy,de);
cc_bit_1 = 0;
cc_bit_0 = carry(iy);
pc += 1;
return 15;


	break;

	case 0x1a:
	// Unknown operation
	break;

	case 0x1b:
	// Unknown operation
	break;

	case 0x1c:
	// Unknown operation
	break;

	case 0x1d:
	// Unknown operation
	break;

	case 0x1e:
	// Unknown operation
	break;

	case 0x1f:
	// Unknown operation
	break;

	case 0x20:
	// Unknown operation
	break;

	case 0x21:
// LD IY,@n

iy=bus.read16(pc+1);
pc += 3;
return 15;


	break;

	case 0x22:
// LD (@n),IY

write16(bus.read16(pc+1),iy);
pc += 3;
return 15;


	break;

	case 0x23:
// INC IY

iy=add16(iy,1);
cc_bit_1 = 0;
cc_bit_7 = sign16(iy);
cc_bit_6 = zero(iy);
cc_bit_4 = halfcarry(iy);
cc_bit_2 = overflow(iy);
pc += 1;
return 15;


	break;

	case 0x24:
	// Unknown operation
	break;

	case 0x25:
	// Unknown operation
	break;

	case 0x26:
	// Unknown operation
	break;

	case 0x27:
	// Unknown operation
	break;

	case 0x28:
	// Unknown operation
	break;

	case 0x29:
// ADD IY,@r

iy=add16(iy,iy);
cc_bit_1 = 0;
cc_bit_0 = carry(iy);
pc += 1;
return 15;


	break;

	case 0x2a:
// LD IY,(@n)

iy=read16(bus.read16(pc+1));
pc += 3;
return 15;


	break;

	case 0x2b:
// DEC IY

iy=sub16(iy,1);
pc += 1;
return 15;


	break;

	case 0x2c:
	// Unknown operation
	break;

	case 0x2d:
	// Unknown operation
	break;

	case 0x2e:
	// Unknown operation
	break;

	case 0x2f:
	// Unknown operation
	break;

	case 0x30:
	// Unknown operation
	break;

	case 0x31:
	// Unknown operation
	break;

	case 0x32:
	// Unknown operation
	break;

	case 0x33:
	// Unknown operation
	break;

	case 0x34:
// INC (IY+@n)
		t8=add8(read8(add168x(iy,bus.read8(pc+1))),1);
		write8(add168x(iy,bus.read8(pc+1)),t8);

cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
pc += 2;
return 15;


	break;

	case 0x35:
// DEC (IY+@n)
		if (pc_at_start == 0x0843) {
			t8 = 3;
			//EMFLogger.message("offset="+bus.read8(pc+1)+"  byte="+read8(add168(iy,bus.read8(pc+1))));
		}
t8=sub8(read8(add168x(iy,bus.read8(pc+1))),1);
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_1 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_4 = halfcarry(t8);
cc_bit_2 = overflow(t8);
pc += 2;
return 15;


	break;

	case 0x36:
// LD (IY+@d),@n

write8(add168(iy,bus.read8(pc+1)),bus.read8(pc+2));
pc += 3;
return 15;


	break;

	case 0x37:
	// Unknown operation
	break;

	case 0x38:
	// Unknown operation
	break;

	case 0x39:
// ADD IY,@r

iy=add16(iy,sp);
cc_bit_1 = 0;
cc_bit_0 = carry(iy);
pc += 1;
return 15;


	break;

	case 0x3a:
	// Unknown operation
	break;

	case 0x3b:
	// Unknown operation
	break;

	case 0x3c:
	// Unknown operation
	break;

	case 0x3d:
	// Unknown operation
	break;

	case 0x3e:
	// Unknown operation
	break;

	case 0x3f:
	// Unknown operation
	break;

	case 0x40:
	// Unknown operation
	break;

	case 0x41:
	// Unknown operation
	break;

	case 0x42:
	// Unknown operation
	break;

	case 0x43:
	// Unknown operation
	break;

	case 0x44:
	// Unknown operation
	break;

	case 0x45:
	// Unknown operation
	break;

	case 0x46:
// LD @r,(IY+@n)

b=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x47:
	// Unknown operation
	break;

	case 0x48:
	// Unknown operation
	break;

	case 0x49:
	// Unknown operation
	break;

	case 0x4a:
	// Unknown operation
	break;

	case 0x4b:
	// Unknown operation
	break;

	case 0x4c:
	// Unknown operation
	break;

	case 0x4d:
	// Unknown operation
	break;

	case 0x4e:
// LD @r,(IY+@n)

c=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x4f:
	// Unknown operation
	break;

	case 0x50:
	// Unknown operation
	break;

	case 0x51:
	// Unknown operation
	break;

	case 0x52:
	// Unknown operation
	break;

	case 0x53:
	// Unknown operation
	break;

	case 0x54:
	// Unknown operation
	break;

	case 0x55:
	// Unknown operation
	break;

	case 0x56:
// LD @r,(IY+@n)

d=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x57:
	// Unknown operation
	break;

	case 0x58:
	// Unknown operation
	break;

	case 0x59:
	// Unknown operation
	break;

	case 0x5a:
	// Unknown operation
	break;

	case 0x5b:
	// Unknown operation
	break;

	case 0x5c:
	// Unknown operation
	break;

	case 0x5d:
	// Unknown operation
	break;

	case 0x5e:
// LD @r,(IY+@n)

e=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x5f:
	// Unknown operation
	break;

	case 0x60:
	// Unknown operation
	break;

	case 0x61:
	// Unknown operation
	break;

	case 0x62:
	// Unknown operation
	break;

	case 0x63:
	// Unknown operation
	break;

	case 0x64:
	// Unknown operation
	break;

	case 0x65:
	// Unknown operation
	break;

	case 0x66:
// LD @r,(IY+@n)

h=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x67:
	// Unknown operation
	break;

	case 0x68:
	// Unknown operation
	break;

	case 0x69:
	// Unknown operation
	break;

	case 0x6a:
	// Unknown operation
	break;

	case 0x6b:
	// Unknown operation
	break;

	case 0x6c:
	// Unknown operation
	break;

	case 0x6d:
	// Unknown operation
	break;

	case 0x6e:
// LD @r,(IY+@n)

l=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x6f:
	// Unknown operation
	break;

	case 0x70:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), b);
pc += 2;
return 19;


	break;

	case 0x71:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), c);
pc += 2;
return 19;


	break;

	case 0x72:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), d);
pc += 2;
return 19;


	break;

	case 0x73:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), e);
pc += 2;
return 19;


	break;

	case 0x74:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), h);
pc += 2;
return 19;


	break;

	case 0x75:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), l);
pc += 2;
return 19;


	break;

	case 0x76:
// LD @r,(IY+@n)
// LD (IY+@n),@r
	// Unknown operation
	break;

	case 0x77:
// LD (IY+@n),@r

write8(add168(iy,bus.read8(pc+1)), a);
pc += 2;
return 19;


	break;

	case 0x78:
	// Unknown operation
	break;

	case 0x79:
	// Unknown operation
	break;

	case 0x7a:
	// Unknown operation
	break;

	case 0x7b:
	// Unknown operation
	break;

	case 0x7c:
	// Unknown operation
	break;

	case 0x7d:
	// Unknown operation
	break;

	case 0x7e:
// LD @r,(IY+@n)

a=read8(add168(iy,bus.read8(pc+1)));
pc += 2;
return 15;


	break;

	case 0x7f:
	// Unknown operation
	break;

	case 0x80:
	// Unknown operation
	break;

	case 0x81:
	// Unknown operation
	break;

	case 0x82:
	// Unknown operation
	break;

	case 0x83:
	// Unknown operation
	break;

	case 0x84:
	// Unknown operation
	break;

	case 0x85:
	// Unknown operation
	break;

	case 0x86:
// ADD A,(IY+@n)

a=add8(a,read8(add168x(iy,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
pc += 2;
return 15;


	break;

	case 0x87:
	// Unknown operation
	break;

	case 0x88:
	// Unknown operation
	break;

	case 0x89:
	// Unknown operation
	break;

	case 0x8a:
	// Unknown operation
	break;

	case 0x8b:
	// Unknown operation
	break;

	case 0x8c:
	// Unknown operation
	break;

	case 0x8d:
	// Unknown operation
	break;

	case 0x8e:
// ADC A,(IY+@n)

a=add8(a,read8(add168x(iy,bus.read8(pc+1))),cc_bit_0);
cc_bit_1 = 0;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
pc += 2;
return 15;


	break;

	case 0x8f:
	// Unknown operation
	break;

	case 0x90:
	// Unknown operation
	break;

	case 0x91:
	// Unknown operation
	break;

	case 0x92:
	// Unknown operation
	break;

	case 0x93:
	// Unknown operation
	break;

	case 0x94:
	// Unknown operation
	break;

	case 0x95:
	// Unknown operation
	break;

	case 0x96:
// SUB (IY+@n)

a=sub8(a,read8(add168x(iy,bus.read8(pc+1))));
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 15;


	break;

	case 0x97:
	// Unknown operation
	break;

	case 0x98:
	// Unknown operation
	break;

	case 0x99:
	// Unknown operation
	break;

	case 0x9a:
	// Unknown operation
	break;

	case 0x9b:
	// Unknown operation
	break;

	case 0x9c:
	// Unknown operation
	break;

	case 0x9d:
	// Unknown operation
	break;

	case 0x9e:
// SBC A,(IY+@n)

a=sub8(a,read8(add168x(iy,bus.read8(pc+1))),cc_bit_0);
cc_bit_1 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_4 = halfcarry(a);
cc_bit_2 = overflow(a);
cc_bit_0 = carry(a);
pc += 2;
return 15;


	break;

	case 0x9f:
	// Unknown operation
	break;

	case 0xa0:
	// Unknown operation
	break;

	case 0xa1:
	// Unknown operation
	break;

	case 0xa2:
	// Unknown operation
	break;

	case 0xa3:
	// Unknown operation
	break;

	case 0xa4:
	// Unknown operation
	break;

	case 0xa5:
	// Unknown operation
	break;

	case 0xa6:
// AND (IY+@n)

a=andlog(a,read8(add168x(iy,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_0 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(a);
cc_bit_6 = zero(a);
cc_bit_2 = parity(a);
pc += 2;
return 15;


	break;

	case 0xa7:
	// Unknown operation
	break;

	case 0xa8:
	// Unknown operation
	break;

	case 0xa9:
	// Unknown operation
	break;

	case 0xaa:
	// Unknown operation
	break;

	case 0xab:
	// Unknown operation
	break;

	case 0xac:
	// Unknown operation
	break;

	case 0xad:
	// Unknown operation
	break;

	case 0xae:
// XOR A,(IY+@n)

a=xor(a,read8(add168(iy,bus.read8(pc+1))));
pc += 2;
return 15;


	break;

	case 0xaf:
	// Unknown operation
	break;

	case 0xb0:
	// Unknown operation
	break;

	case 0xb1:
	// Unknown operation
	break;

	case 0xb2:
	// Unknown operation
	break;

	case 0xb3:
	// Unknown operation
	break;

	case 0xb4:
	// Unknown operation
	break;

	case 0xb5:
	// Unknown operation
	break;

	case 0xb6:
// OR (IY+@n)

a=or(a,read8(add168(iy,bus.read8(pc+1))));
pc += 2;
return 15;


	break;

	case 0xb7:
	// Unknown operation
	break;

	case 0xb8:
	// Unknown operation
	break;

	case 0xb9:
	// Unknown operation
	break;

	case 0xba:
	// Unknown operation
	break;

	case 0xbb:
	// Unknown operation
	break;

	case 0xbc:
	// Unknown operation
	break;

	case 0xbd:
	// Unknown operation
	break;

	case 0xbe:
		// ADD A,(IY+@n)
		// TODO: BUGWARN
		// ERR - SURELY CP A,(IY+@n)
		t8=sub8(a,read8(add168x(iy,bus.read8(pc+1))));
		cc_bit_1 = 1;
		cc_bit_7 = sign(t8);
		cc_bit_6 = zero(t8);
		cc_bit_4 = halfcarry(t8);
		cc_bit_2 = overflow(t8);
		cc_bit_0 = carry(t8);
		pc += 2;
		return 15;

	break;

	case 0xbf:
	// Unknown operation
	break;

	case 0xc0:
	// Unknown operation
	break;

	case 0xc1:
	// Unknown operation
	break;

	case 0xc2:
	// Unknown operation
	break;

	case 0xc3:
	// Unknown operation
	break;

	case 0xc4:
	// Unknown operation
	break;

	case 0xc5:
	// Unknown operation
	break;

	case 0xc6:
	// Unknown operation
	break;

	case 0xc7:
	// Unknown operation
	break;

	case 0xc8:
	// Unknown operation
	break;

	case 0xc9:
	// Unknown operation
	break;

	case 0xca:
	// Unknown operation
	break;

	case 0xcb:
// RLC (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x6) {
t8=rlc(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// RRC (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0xe) {
t8=rrc(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// RL (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x16) {
t8=rl8(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// RR (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x1e) {
t8=rr8(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SLA (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x26) {
t8=sla8(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SRA (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x2e) {
t8=sra8(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SLL (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x36) {
t8=sll8(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// SRL (IY+@n)
if ((bus.read8(pc+2) & 0xff) == 0x3e) {
t8=srl8(read8(add168x(iy,bus.read8(pc+1))));
write8(add168x(iy,bus.read8(pc+1)),t8);
cc_bit_4 = 0;
cc_bit_1 = 0;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
cc_bit_0 = carry(t8);
pc += 3;
return 15;

}
// BIT @r,(IY+@n)
if ((bus.read8(pc+2) & 0xc7) == 0x46) {
bit=(bus.read8(pc+2) & 0x38)>>3;
t8=bittest(bit,read8(add168x(iy,bus.read8(pc+1))));
cc_bit_1 = 0;
cc_bit_4 = 1;
cc_bit_7 = sign(t8);
cc_bit_6 = zero(t8);
cc_bit_2 = parity(t8);
pc += 3;
return 15;

}
// RES @r,(IY+@n)
if ((bus.read8(pc+2) & 0xc7) == 0x86) {
bit=(bus.read8(pc+2) & 0x38)>>3;
write8(add168(iy,bus.read8(pc+1)), clearBit(bit,read8(add168(iy,bus.read8(pc+1)))));
pc += 3;
return 15;

}
// SET @r,(IY+@n)
if ((bus.read8(pc+2) & 0xc7) == 0xc6) {
bit=(bus.read8(pc+2) & 0x38)>>3;
write8(add168(iy,bus.read8(pc+1)), setBit(bit,read8(add168(iy,bus.read8(pc+1)))));
pc += 3;
return 15;

}
	break;

	case 0xcc:
	// Unknown operation
	break;

	case 0xcd:
	// Unknown operation
	break;

	case 0xce:
	// Unknown operation
	break;

	case 0xcf:
	// Unknown operation
	break;

	case 0xd0:
	// Unknown operation
	break;

	case 0xd1:
	// Unknown operation
	break;

	case 0xd2:
	// Unknown operation
	break;

	case 0xd3:
	// Unknown operation
	break;

	case 0xd4:
	// Unknown operation
	break;

	case 0xd5:
	// Unknown operation
	break;

	case 0xd6:
	// Unknown operation
	break;

	case 0xd7:
	// Unknown operation
	break;

	case 0xd8:
	// Unknown operation
	break;

	case 0xd9:
	// Unknown operation
	break;

	case 0xda:
	// Unknown operation
	break;

	case 0xdb:
	// Unknown operation
	break;

	case 0xdc:
	// Unknown operation
	break;

	case 0xdd:
	// Unknown operation
	break;

	case 0xde:
	// Unknown operation
	break;

	case 0xdf:
	// Unknown operation
	break;

	case 0xe0:
	// Unknown operation
	break;

	case 0xe1:
	// Unknown operation
	break;

	case 0xe2:
	// Unknown operation
	break;

	case 0xe3:
	// Unknown operation
	break;

	case 0xe4:
	// Unknown operation
	break;

	case 0xe5:
	// Unknown operation
	break;

	case 0xe6:
	// Unknown operation
	break;

	case 0xe7:
	// Unknown operation
	break;

	case 0xe8:
	// Unknown operation
	break;

	case 0xe9:
	// Unknown operation
	break;

	case 0xea:
	// Unknown operation
	break;

	case 0xeb:
	// Unknown operation
	break;

	case 0xec:
	// Unknown operation
	break;

	case 0xed:
	// Unknown operation
	break;

	case 0xee:
	// Unknown operation
	break;

	case 0xef:
	// Unknown operation
	break;

	case 0xf0:
	// Unknown operation
	break;

	case 0xf1:
	// Unknown operation
	break;

	case 0xf2:
	// Unknown operation
	break;

	case 0xf3:
	// Unknown operation
	break;

	case 0xf4:
	// Unknown operation
	break;

	case 0xf5:
	// Unknown operation
	break;

	case 0xf6:
	// Unknown operation
	break;

	case 0xf7:
	// Unknown operation
	break;

	case 0xf8:
	// Unknown operation
	break;

	case 0xf9:
	// Unknown operation
	break;

	case 0xfa:
	// Unknown operation
	break;

	case 0xfb:
	// Unknown operation
	break;

	case 0xfc:
	// Unknown operation
	break;

	case 0xfd:
	// Unknown operation
	break;

	case 0xfe:
	// Unknown operation
	break;

	case 0xff:
	// Unknown operation
	break;

} // hctiws
return 0;
}
	}
}

