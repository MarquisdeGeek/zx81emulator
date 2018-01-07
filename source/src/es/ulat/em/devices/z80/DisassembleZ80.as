package es.ulat.em.devices.z80
{
	import es.ulat.em.framework.EMFMainBus;
	import es.ulat.em.framework.EMFUtils;

	public class DisassembleZ80
	{
		
		public static function disassemble(bus : EMFMainBus, addr : uint) : Object {
			return step(bus,addr);
		}
		
public static function step(bus : EMFMainBus, addr : uint) : Object {
var dis : Object = new Object();
dis.dis = "Unknown opcode";
dis.size = 1;
var instr : uint = bus.read8(addr);

switch(instr) {
	case 0x0:
// nop

dis.size=1; dis.dis = "nop"; return dis;

	break;

	case 0x1:
// LD @r,@n

dis.size=3; dis.dis = "LD bc,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0x2:
// LD (BC),A

dis.size=1; dis.dis = "LD (BC),A"; return dis;

	break;

	case 0x3:
// INC @r

dis.size=1; dis.dis = "INC bc"; return dis;

	break;

	case 0x4:
// INC @r

dis.size=1; dis.dis = "INC b"; return dis;

	break;

	case 0x5:
// DEC @r

dis.size=1; dis.dis = "DEC b"; return dis;

	break;

	case 0x6:
// LD @r,@n

dis.size=2; dis.dis = "LD b,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x7:
// RLCA

dis.size=1; dis.dis = "RLCA"; return dis;

	break;

	case 0x8:
// EX AF,AF’

dis.size=1; dis.dis = "EX AF,AF’"; return dis;

	break;

	case 0x9:
// ADD HL,@r

dis.size=1; dis.dis = "ADD HL,bc"; return dis;

	break;

	case 0xa:
// LD A,(BC)

dis.size=1; dis.dis = "LD A,(BC)"; return dis;

	break;

	case 0xb:
// DEC @r

dis.size=1; dis.dis = "DEC bc"; return dis;

	break;

	case 0xc:
// INC @r

dis.size=1; dis.dis = "INC c"; return dis;

	break;

	case 0xd:
// DEC @r

dis.size=1; dis.dis = "DEC c"; return dis;

	break;

	case 0xe:
// LD @r,@n

dis.size=2; dis.dis = "LD c,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xf:
// RRCA

dis.size=1; dis.dis = "RRCA"; return dis;

	break;

	case 0x10:
// DJNZ (addr+@n)

dis.size=2; dis.dis = "DJNZ (addr+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x11:
// LD @r,@n

dis.size=3; dis.dis = "LD de,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0x12:
// LD (DE),A

dis.size=1; dis.dis = "LD (DE),A"; return dis;

	break;

	case 0x13:
// INC @r

dis.size=1; dis.dis = "INC de"; return dis;

	break;

	case 0x14:
// INC @r

dis.size=1; dis.dis = "INC d"; return dis;

	break;

	case 0x15:
// DEC @r

dis.size=1; dis.dis = "DEC d"; return dis;

	break;

	case 0x16:
// LD @r,@n

dis.size=2; dis.dis = "LD d,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x17:
// RLA

dis.size=1; dis.dis = "RLA"; return dis;

	break;

	case 0x18:
// JR (addr+@n)

dis.size=2; dis.dis = "JR (addr+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x19:
// ADD HL,@r

dis.size=1; dis.dis = "ADD HL,de"; return dis;

	break;

	case 0x1a:
// LD A,(DE)

dis.size=1; dis.dis = "LD A,(DE)"; return dis;

	break;

	case 0x1b:
// DEC @r

dis.size=1; dis.dis = "DEC de"; return dis;

	break;

	case 0x1c:
// INC @r

dis.size=1; dis.dis = "INC e"; return dis;

	break;

	case 0x1d:
// DEC @r

dis.size=1; dis.dis = "DEC e"; return dis;

	break;

	case 0x1e:
// LD @r,@n

dis.size=2; dis.dis = "LD e,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x1f:
// RRA

dis.size=1; dis.dis = "RRA"; return dis;

	break;

	case 0x20:
// JR NZ,(addr+@n)

dis.size=2; dis.dis = "JR NZ,(addr+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x21:
// LD @r,@n

dis.size=3; dis.dis = "LD hl,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0x22:
// LD (@n),HL

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),HL"; return dis;

	break;

	case 0x23:
// INC @r

dis.size=1; dis.dis = "INC hl"; return dis;

	break;

	case 0x24:
// INC @r

dis.size=1; dis.dis = "INC h"; return dis;

	break;

	case 0x25:
// DEC @r

dis.size=1; dis.dis = "DEC h"; return dis;

	break;

	case 0x26:
// LD @r,@n

dis.size=2; dis.dis = "LD h,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x27:
// DAA

dis.size=1; dis.dis = "DAA"; return dis;

	break;

	case 0x28:
// JR Z,(addr+@n)

dis.size=2; dis.dis = "JR Z,(addr+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x29:
// ADD HL,@r

dis.size=1; dis.dis = "ADD HL,hl"; return dis;

	break;

	case 0x2a:
// LD HL,(@n)

dis.size=3; dis.dis = "LD HL,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x2b:
// DEC @r

dis.size=1; dis.dis = "DEC hl"; return dis;

	break;

	case 0x2c:
// INC @r

dis.size=1; dis.dis = "INC l"; return dis;

	break;

	case 0x2d:
// DEC @r

dis.size=1; dis.dis = "DEC l"; return dis;

	break;

	case 0x2e:
// LD @r,@n

dis.size=2; dis.dis = "LD l,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x2f:
// CPL

dis.size=1; dis.dis = "CPL"; return dis;

	break;

	case 0x30:
// JR NC,(addr+@n)

dis.size=2; dis.dis = "JR NC,(addr+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x31:
// LD @r,@n

dis.size=3; dis.dis = "LD sp,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0x32:
// LD (@n),A

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),A"; return dis;

	break;

	case 0x33:
// INC @r

dis.size=1; dis.dis = "INC sp"; return dis;

	break;

	case 0x34:
// INC @r
// INC (HL)

dis.size=1; dis.dis = "INC (HL)"; return dis;

	break;

	case 0x35:
// DEC @r
// DEC (HL)

dis.size=1; dis.dis = "DEC (HL)"; return dis;

	break;

	case 0x36:
// LD @r,@n
// LD (HL),@n

dis.size=2; dis.dis = "LD (HL),"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x37:
// SCF

dis.size=1; dis.dis = "SCF"; return dis;

	break;

	case 0x38:
// JR C,(addr+@n)

dis.size=2; dis.dis = "JR C,(addr+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x39:
// ADD HL,@r

dis.size=1; dis.dis = "ADD HL,sp"; return dis;

	break;

	case 0x3a:
// LD A,(@n)

dis.size=3; dis.dis = "LD A,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x3b:
// DEC @r

dis.size=1; dis.dis = "DEC sp"; return dis;

	break;

	case 0x3c:
// INC @r

dis.size=1; dis.dis = "INC a"; return dis;

	break;

	case 0x3d:
// DEC @r

dis.size=1; dis.dis = "DEC a"; return dis;

	break;

	case 0x3e:
// LD @r,@n

dis.size=2; dis.dis = "LD a,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x3f:
// CCF

dis.size=1; dis.dis = "CCF"; return dis;

	break;

	case 0x40:
// LD @r,@s

dis.size=1; dis.dis = "LD b,b"; return dis;

	break;

	case 0x41:
// LD @r,@s

dis.size=1; dis.dis = "LD b,c"; return dis;

	break;

	case 0x42:
// LD @r,@s

dis.size=1; dis.dis = "LD b,d"; return dis;

	break;

	case 0x43:
// LD @r,@s

dis.size=1; dis.dis = "LD b,e"; return dis;

	break;

	case 0x44:
// LD @r,@s

dis.size=1; dis.dis = "LD b,h"; return dis;

	break;

	case 0x45:
// LD @r,@s

dis.size=1; dis.dis = "LD b,l"; return dis;

	break;

	case 0x46:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD b,(HL)"; return dis;

	break;

	case 0x47:
// LD @r,@s

dis.size=1; dis.dis = "LD b,a"; return dis;

	break;

	case 0x48:
// LD @r,@s

dis.size=1; dis.dis = "LD c,b"; return dis;

	break;

	case 0x49:
// LD @r,@s

dis.size=1; dis.dis = "LD c,c"; return dis;

	break;

	case 0x4a:
// LD @r,@s

dis.size=1; dis.dis = "LD c,d"; return dis;

	break;

	case 0x4b:
// LD @r,@s

dis.size=1; dis.dis = "LD c,e"; return dis;

	break;

	case 0x4c:
// LD @r,@s

dis.size=1; dis.dis = "LD c,h"; return dis;

	break;

	case 0x4d:
// LD @r,@s

dis.size=1; dis.dis = "LD c,l"; return dis;

	break;

	case 0x4e:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD c,(HL)"; return dis;

	break;

	case 0x4f:
// LD @r,@s

dis.size=1; dis.dis = "LD c,a"; return dis;

	break;

	case 0x50:
// LD @r,@s

dis.size=1; dis.dis = "LD d,b"; return dis;

	break;

	case 0x51:
// LD @r,@s

dis.size=1; dis.dis = "LD d,c"; return dis;

	break;

	case 0x52:
// LD @r,@s

dis.size=1; dis.dis = "LD d,d"; return dis;

	break;

	case 0x53:
// LD @r,@s

dis.size=1; dis.dis = "LD d,e"; return dis;

	break;

	case 0x54:
// LD @r,@s

dis.size=1; dis.dis = "LD d,h"; return dis;

	break;

	case 0x55:
// LD @r,@s

dis.size=1; dis.dis = "LD d,l"; return dis;

	break;

	case 0x56:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD d,(HL)"; return dis;

	break;

	case 0x57:
// LD @r,@s

dis.size=1; dis.dis = "LD d,a"; return dis;

	break;

	case 0x58:
// LD @r,@s

dis.size=1; dis.dis = "LD e,b"; return dis;

	break;

	case 0x59:
// LD @r,@s

dis.size=1; dis.dis = "LD e,c"; return dis;

	break;

	case 0x5a:
// LD @r,@s

dis.size=1; dis.dis = "LD e,d"; return dis;

	break;

	case 0x5b:
// LD @r,@s

dis.size=1; dis.dis = "LD e,e"; return dis;

	break;

	case 0x5c:
// LD @r,@s

dis.size=1; dis.dis = "LD e,h"; return dis;

	break;

	case 0x5d:
// LD @r,@s

dis.size=1; dis.dis = "LD e,l"; return dis;

	break;

	case 0x5e:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD e,(HL)"; return dis;

	break;

	case 0x5f:
// LD @r,@s

dis.size=1; dis.dis = "LD e,a"; return dis;

	break;

	case 0x60:
// LD @r,@s

dis.size=1; dis.dis = "LD h,b"; return dis;

	break;

	case 0x61:
// LD @r,@s

dis.size=1; dis.dis = "LD h,c"; return dis;

	break;

	case 0x62:
// LD @r,@s

dis.size=1; dis.dis = "LD h,d"; return dis;

	break;

	case 0x63:
// LD @r,@s

dis.size=1; dis.dis = "LD h,e"; return dis;

	break;

	case 0x64:
// LD @r,@s

dis.size=1; dis.dis = "LD h,h"; return dis;

	break;

	case 0x65:
// LD @r,@s

dis.size=1; dis.dis = "LD h,l"; return dis;

	break;

	case 0x66:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD h,(HL)"; return dis;

	break;

	case 0x67:
// LD @r,@s

dis.size=1; dis.dis = "LD h,a"; return dis;

	break;

	case 0x68:
// LD @r,@s

dis.size=1; dis.dis = "LD l,b"; return dis;

	break;

	case 0x69:
// LD @r,@s

dis.size=1; dis.dis = "LD l,c"; return dis;

	break;

	case 0x6a:
// LD @r,@s

dis.size=1; dis.dis = "LD l,d"; return dis;

	break;

	case 0x6b:
// LD @r,@s

dis.size=1; dis.dis = "LD l,e"; return dis;

	break;

	case 0x6c:
// LD @r,@s

dis.size=1; dis.dis = "LD l,h"; return dis;

	break;

	case 0x6d:
// LD @r,@s

dis.size=1; dis.dis = "LD l,l"; return dis;

	break;

	case 0x6e:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD l,(HL)"; return dis;

	break;

	case 0x6f:
// LD @r,@s

dis.size=1; dis.dis = "LD l,a"; return dis;

	break;

	case 0x70:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),b"; return dis;

	break;

	case 0x71:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),c"; return dis;

	break;

	case 0x72:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),d"; return dis;

	break;

	case 0x73:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),e"; return dis;

	break;

	case 0x74:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),h"; return dis;

	break;

	case 0x75:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),l"; return dis;

	break;

	case 0x76:
// LD @r,@s
// LD @r,(HL)
// LD (HL),@r
// HALT

dis.size=1; dis.dis = "HALT"; return dis;

	break;

	case 0x77:
// LD @r,@s
// LD (HL),@r

dis.size=1; dis.dis = "LD (HL),a"; return dis;

	break;

	case 0x78:
// LD @r,@s

dis.size=1; dis.dis = "LD a,b"; return dis;

	break;

	case 0x79:
// LD @r,@s

dis.size=1; dis.dis = "LD a,c"; return dis;

	break;

	case 0x7a:
// LD @r,@s

dis.size=1; dis.dis = "LD a,d"; return dis;

	break;

	case 0x7b:
// LD @r,@s

dis.size=1; dis.dis = "LD a,e"; return dis;

	break;

	case 0x7c:
// LD @r,@s

dis.size=1; dis.dis = "LD a,h"; return dis;

	break;

	case 0x7d:
// LD @r,@s

dis.size=1; dis.dis = "LD a,l"; return dis;

	break;

	case 0x7e:
// LD @r,@s
// LD @r,(HL)

dis.size=1; dis.dis = "LD a,(HL)"; return dis;

	break;

	case 0x7f:
// LD @r,@s

dis.size=1; dis.dis = "LD a,a"; return dis;

	break;

	case 0x80:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,b"; return dis;

	break;

	case 0x81:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,c"; return dis;

	break;

	case 0x82:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,d"; return dis;

	break;

	case 0x83:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,e"; return dis;

	break;

	case 0x84:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,h"; return dis;

	break;

	case 0x85:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,l"; return dis;

	break;

	case 0x86:
// ADD A,@r
// ADD A,(HL)

dis.size=1; dis.dis = "ADD A,(HL)"; return dis;

	break;

	case 0x87:
// ADD A,@r

dis.size=1; dis.dis = "ADD A,a"; return dis;

	break;

	case 0x88:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,b"; return dis;

	break;

	case 0x89:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,c"; return dis;

	break;

	case 0x8a:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,d"; return dis;

	break;

	case 0x8b:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,e"; return dis;

	break;

	case 0x8c:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,h"; return dis;

	break;

	case 0x8d:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,l"; return dis;

	break;

	case 0x8e:
// ADC A,@r
// ADC A,(HL)

dis.size=1; dis.dis = "ADC A,(HL)"; return dis;

	break;

	case 0x8f:
// ADC A,@r

dis.size=1; dis.dis = "ADC A,a"; return dis;

	break;

	case 0x90:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,b"; return dis;

	break;

	case 0x91:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,c"; return dis;

	break;

	case 0x92:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,d"; return dis;

	break;

	case 0x93:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,e"; return dis;

	break;

	case 0x94:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,h"; return dis;

	break;

	case 0x95:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,l"; return dis;

	break;

	case 0x96:
// SUB A,@r
// SUB A,(HL)

dis.size=1; dis.dis = "SUB A,(HL)"; return dis;

	break;

	case 0x97:
// SUB A,@r

dis.size=1; dis.dis = "SUB A,a"; return dis;

	break;

	case 0x98:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,b"; return dis;

	break;

	case 0x99:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,c"; return dis;

	break;

	case 0x9a:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,d"; return dis;

	break;

	case 0x9b:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,e"; return dis;

	break;

	case 0x9c:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,h"; return dis;

	break;

	case 0x9d:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,l"; return dis;

	break;

	case 0x9e:
// SBC A,@r
// SBC A,(HL)

dis.size=1; dis.dis = "SBC A,(HL)"; return dis;

	break;

	case 0x9f:
// SBC A,@r

dis.size=1; dis.dis = "SBC A,a"; return dis;

	break;

	case 0xa0:
// AND A,@r

dis.size=1; dis.dis = "AND A,b"; return dis;

	break;

	case 0xa1:
// AND A,@r

dis.size=1; dis.dis = "AND A,c"; return dis;

	break;

	case 0xa2:
// AND A,@r

dis.size=1; dis.dis = "AND A,d"; return dis;

	break;

	case 0xa3:
// AND A,@r

dis.size=1; dis.dis = "AND A,e"; return dis;

	break;

	case 0xa4:
// AND A,@r

dis.size=1; dis.dis = "AND A,h"; return dis;

	break;

	case 0xa5:
// AND A,@r

dis.size=1; dis.dis = "AND A,l"; return dis;

	break;

	case 0xa6:
// AND A,@r
// AND A,(HL)

dis.size=1; dis.dis = "AND A,(HL)"; return dis;

	break;

	case 0xa7:
// AND A,@r

dis.size=1; dis.dis = "AND A,a"; return dis;

	break;

	case 0xa8:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,b"; return dis;

	break;

	case 0xa9:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,c"; return dis;

	break;

	case 0xaa:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,d"; return dis;

	break;

	case 0xab:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,e"; return dis;

	break;

	case 0xac:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,h"; return dis;

	break;

	case 0xad:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,l"; return dis;

	break;

	case 0xae:
// XOR A,@r
// XOR A,(HL)

dis.size=1; dis.dis = "XOR A,(HL)"; return dis;

	break;

	case 0xaf:
// XOR A,@r

dis.size=1; dis.dis = "XOR A,a"; return dis;

	break;

	case 0xb0:
// OR A,@r

dis.size=1; dis.dis = "OR A,b"; return dis;

	break;

	case 0xb1:
// OR A,@r

dis.size=1; dis.dis = "OR A,c"; return dis;

	break;

	case 0xb2:
// OR A,@r

dis.size=1; dis.dis = "OR A,d"; return dis;

	break;

	case 0xb3:
// OR A,@r

dis.size=1; dis.dis = "OR A,e"; return dis;

	break;

	case 0xb4:
// OR A,@r

dis.size=1; dis.dis = "OR A,h"; return dis;

	break;

	case 0xb5:
// OR A,@r

dis.size=1; dis.dis = "OR A,l"; return dis;

	break;

	case 0xb6:
// OR A,@r
// OR A,(HL)

dis.size=1; dis.dis = "OR A,(HL)"; return dis;

	break;

	case 0xb7:
// OR A,@r

dis.size=1; dis.dis = "OR A,a"; return dis;

	break;

	case 0xb8:
// CP A,@r

dis.size=1; dis.dis = "CP A,b"; return dis;

	break;

	case 0xb9:
// CP A,@r

dis.size=1; dis.dis = "CP A,c"; return dis;

	break;

	case 0xba:
// CP A,@r

dis.size=1; dis.dis = "CP A,d"; return dis;

	break;

	case 0xbb:
// CP A,@r

dis.size=1; dis.dis = "CP A,e"; return dis;

	break;

	case 0xbc:
// CP A,@r

dis.size=1; dis.dis = "CP A,h"; return dis;

	break;

	case 0xbd:
// CP A,@r

dis.size=1; dis.dis = "CP A,l"; return dis;

	break;

	case 0xbe:
// CP A,@r
// CP A,(HL)

dis.size=1; dis.dis = "CP A,(HL)"; return dis;

	break;

	case 0xbf:
// CP A,@r

dis.size=1; dis.dis = "CP A,a"; return dis;

	break;

	case 0xc0:
// RET @r

dis.size=1; dis.dis = "RET fnz"; return dis;

	break;

	case 0xc1:
// POP @r

dis.size=1; dis.dis = "POP bc"; return dis;

	break;

	case 0xc2:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fnz,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xc3:
// JP (@n)

dis.size=3; dis.dis = "JP ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xc4:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fnz,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xc5:
// PUSH @r

dis.size=1; dis.dis = "PUSH bc"; return dis;

	break;

	case 0xc6:
// ADD A,@n

dis.size=2; dis.dis = "ADD A,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xc7:
// RST @r

dis.size=1; dis.dis = "RST 0x00"; return dis;

	break;

	case 0xc8:
// RET @r

dis.size=1; dis.dis = "RET fz"; return dis;

	break;

	case 0xc9:
// RET

dis.size=1; dis.dis = "RET"; return dis;

	break;

	case 0xca:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fz,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xcb:
// CB
dis = cb_ext(bus, addr+1);
dis.size += 1;
return dis;
	break;

	case 0xcc:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fz,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xcd:
// CALL (@n)

dis.size=3; dis.dis = "CALL ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xce:
// ADC A,@n

dis.size=2; dis.dis = "ADC A,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xcf:
// RST @r

dis.size=1; dis.dis = "RST 0x08"; return dis;

	break;

	case 0xd0:
// RET @r

dis.size=1; dis.dis = "RET fnc"; return dis;

	break;

	case 0xd1:
// POP @r

dis.size=1; dis.dis = "POP de"; return dis;

	break;

	case 0xd2:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fnc,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xd3:
// OUT (@n),A

dis.size=2; dis.dis = "OUT ("+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),A"; return dis;

	break;

	case 0xd4:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fnc,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xd5:
// PUSH @r

dis.size=1; dis.dis = "PUSH de"; return dis;

	break;

	case 0xd6:
// SUB @n

dis.size=2; dis.dis = "SUB "+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xd7:
// RST @r

dis.size=1; dis.dis = "RST 0x10"; return dis;

	break;

	case 0xd8:
// RET @r

dis.size=1; dis.dis = "RET fc"; return dis;

	break;

	case 0xd9:
// EXX

dis.size=1; dis.dis = "EXX"; return dis;

	break;

	case 0xda:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fc,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xdb:
// IN A,(@n)

dis.size=2; dis.dis = "IN A,("+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0xdc:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fc,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xdd:
// DD
dis = dd_ext(bus, addr+1);
dis.size += 1;
return dis;
	break;

	case 0xde:
// SBC A,@n

dis.size=2; dis.dis = "SBC A,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xdf:
// RST @r

dis.size=1; dis.dis = "RST 0x18"; return dis;

	break;

	case 0xe0:
// RET @r

dis.size=1; dis.dis = "RET fpo"; return dis;

	break;

	case 0xe1:
// POP @r

dis.size=1; dis.dis = "POP hl"; return dis;

	break;

	case 0xe2:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fpo,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xe3:
// EX (SP),HL

dis.size=1; dis.dis = "EX (SP),HL"; return dis;

	break;

	case 0xe4:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fpo,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xe5:
// PUSH @r

dis.size=1; dis.dis = "PUSH hl"; return dis;

	break;

	case 0xe6:
// AND @n

dis.size=2; dis.dis = "AND "+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xe7:
// RST @r

dis.size=1; dis.dis = "RST 0x20"; return dis;

	break;

	case 0xe8:
// RET @r

dis.size=1; dis.dis = "RET fpe"; return dis;

	break;

	case 0xe9:
// JP (HL)

dis.size=1; dis.dis = "JP (HL)"; return dis;

	break;

	case 0xea:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fpe,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xeb:
// EX DE,HL

dis.size=1; dis.dis = "EX DE,HL"; return dis;

	break;

	case 0xec:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fpe,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xed:
// ED
dis = ed_ext(bus, addr+1);
dis.size += 1;
return dis;
// ld

dis.size=4; dis.dis = "ld"; return dis;

	break;

	case 0xee:
// XOR A,@n

dis.size=2; dis.dis = "XOR A,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xef:
// RST @r

dis.size=1; dis.dis = "RST 0x28"; return dis;

	break;

	case 0xf0:
// RET @r

dis.size=1; dis.dis = "RET fp"; return dis;

	break;

	case 0xf1:
// POP @r

dis.size=1; dis.dis = "POP af"; return dis;

	break;

	case 0xf2:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fp,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xf3:
// DI

dis.size=1; dis.dis = "DI"; return dis;

	break;

	case 0xf4:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fp,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xf5:
// PUSH @r

dis.size=1; dis.dis = "PUSH af"; return dis;

	break;

	case 0xf6:
// OR A,@n

dis.size=2; dis.dis = "OR A,"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xf7:
// RST @r

dis.size=1; dis.dis = "RST 0x30"; return dis;

	break;

	case 0xf8:
// RET @r

dis.size=1; dis.dis = "RET fm"; return dis;

	break;

	case 0xf9:
// LD SP,HL

dis.size=1; dis.dis = "LD SP,HL"; return dis;

	break;

	case 0xfa:
// JP @r,(@n)

dis.size=3; dis.dis = "JP fm,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0xfb:
// EI

dis.size=1; dis.dis = "EI"; return dis;

	break;

	case 0xfc:
// CALL @r,@n

dis.size=3; dis.dis = "CALL fm,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0xfd:
// FD
dis = fd_ext(bus, addr+1);
dis.size += 1;
return dis;
	break;

	case 0xfe:
// CP @n

dis.size=2; dis.dis = "CP "+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0xff:
// RST @r

dis.size=1; dis.dis = "RST 0x38"; return dis;

	break;

} // hctiws
return dis;
}
public static function dd_ext(bus : EMFMainBus, addr : uint) : Object {
var dis : Object = new Object();
dis.dis = "Unknown oaddrode";
dis.size = 1;
var instr : uint = bus.read8(addr);

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

dis.size=1; dis.dis = "ADD IX,bc"; return dis;

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

dis.size=1; dis.dis = "ADD IX,de"; return dis;

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

dis.size=3; dis.dis = "LD IX,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0x22:
// LD (@n),IX

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),IX"; return dis;

	break;

	case 0x23:
// INC IX

dis.size=1; dis.dis = "INC IX"; return dis;

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

dis.size=1; dis.dis = "ADD IX,ix"; return dis;

	break;

	case 0x2a:
// LD IX,(@n)

dis.size=3; dis.dis = "LD IX,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x2b:
// DEC IX

dis.size=1; dis.dis = "DEC IX"; return dis;

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

dis.size=2; dis.dis = "INC (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x35:
// DEC (IX+@n)

dis.size=2; dis.dis = "DEC (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x36:
// LD (IX+@d),@n

dis.size=3; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),"+(("0000"+bus.read8(addr+2).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x37:
	// Unknown operation
	break;

	case 0x38:
	// Unknown operation
	break;

	case 0x39:
// ADD IX,@r

dis.size=1; dis.dis = "ADD IX,sp"; return dis;

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

dis.size=2; dis.dis = "LD b,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD c,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD d,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD e,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD h,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD l,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x6f:
	// Unknown operation
	break;

	case 0x70:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),b"; return dis;

	break;

	case 0x71:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),c"; return dis;

	break;

	case 0x72:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),d"; return dis;

	break;

	case 0x73:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),e"; return dis;

	break;

	case 0x74:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),h"; return dis;

	break;

	case 0x75:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),l"; return dis;

	break;

	case 0x76:
// LD @r,(IX+@n)
// LD (IX+@n),@r
	// Unknown operation
	break;

	case 0x77:
// LD (IX+@n),@r

dis.size=2; dis.dis = "LD (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),a"; return dis;

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

dis.size=2; dis.dis = "LD a,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "ADD A,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "ADC A,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "SUB (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "SBC A,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "AND (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "XOR A,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "OR (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "ADD A,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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
if ((bus.read8(addr+2) & 0xff) == 0x6) {
dis.size=3; dis.dis = "RLC (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RRC (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0xe) {
dis.size=3; dis.dis = "RRC (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RL (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0x16) {
dis.size=3; dis.dis = "RL (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RR (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0x1e) {
dis.size=3; dis.dis = "RR (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SLA (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0x26) {
dis.size=3; dis.dis = "SLA (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SRA (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0x2e) {
dis.size=3; dis.dis = "SRA (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SLL (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0x36) {
dis.size=3; dis.dis = "SLL (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SRL (IX+@n)
if ((bus.read8(addr+2) & 0xff) == 0x3e) {
dis.size=3; dis.dis = "SRL (IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// BIT @r,(IX+@n)
if ((bus.read8(addr+2) & 0xc7) == 0x46) {
dis.size=3; dis.dis = "BIT 0,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RES @r,(IX+@n)
if ((bus.read8(addr+2) & 0xc7) == 0x86) {
dis.size=3; dis.dis = "RES 0,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SET @r,(IX+@n)
if ((bus.read8(addr+2) & 0xc7) == 0xc6) {
dis.size=3; dis.dis = "SET 0,(IX+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
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
return dis;
}
public static function cb_ext(bus : EMFMainBus, addr : uint) : Object {
var dis : Object = new Object();
dis.dis = "Unknown oaddrode";
dis.size = 1;
var instr : uint = bus.read8(addr);

switch(instr) {
	case 0x0:
// RLC @r

dis.size=1; dis.dis = "RLC b"; return dis;

	break;

	case 0x1:
// RLC @r

dis.size=1; dis.dis = "RLC c"; return dis;

	break;

	case 0x2:
// RLC @r

dis.size=1; dis.dis = "RLC d"; return dis;

	break;

	case 0x3:
// RLC @r

dis.size=1; dis.dis = "RLC e"; return dis;

	break;

	case 0x4:
// RLC @r

dis.size=1; dis.dis = "RLC h"; return dis;

	break;

	case 0x5:
// RLC @r

dis.size=1; dis.dis = "RLC l"; return dis;

	break;

	case 0x6:
// RLC @r
// RLC (HL)

dis.size=1; dis.dis = "RLC (HL)"; return dis;

	break;

	case 0x7:
// RLC @r

dis.size=1; dis.dis = "RLC a"; return dis;

	break;

	case 0x8:
// RRC @r

dis.size=1; dis.dis = "RRC b"; return dis;

	break;

	case 0x9:
// RRC @r

dis.size=1; dis.dis = "RRC c"; return dis;

	break;

	case 0xa:
// RRC @r

dis.size=1; dis.dis = "RRC d"; return dis;

	break;

	case 0xb:
// RRC @r

dis.size=1; dis.dis = "RRC e"; return dis;

	break;

	case 0xc:
// RRC @r

dis.size=1; dis.dis = "RRC h"; return dis;

	break;

	case 0xd:
// RRC @r

dis.size=1; dis.dis = "RRC l"; return dis;

	break;

	case 0xe:
// RRC @r
// RRC (HL)

dis.size=1; dis.dis = "RRC (HL)"; return dis;

// RL (HL)

dis.size=1; dis.dis = "RL (HL)"; return dis;

	break;

	case 0xf:
// RRC @r

dis.size=1; dis.dis = "RRC a"; return dis;

	break;

	case 0x10:
// RL @r

dis.size=1; dis.dis = "RL b"; return dis;

	break;

	case 0x11:
// RL @r

dis.size=1; dis.dis = "RL c"; return dis;

	break;

	case 0x12:
// RL @r

dis.size=1; dis.dis = "RL d"; return dis;

	break;

	case 0x13:
// RL @r

dis.size=1; dis.dis = "RL e"; return dis;

	break;

	case 0x14:
// RL @r

dis.size=1; dis.dis = "RL h"; return dis;

	break;

	case 0x15:
// RL @r

dis.size=1; dis.dis = "RL l"; return dis;

	break;

	case 0x16:
// RL @r
	// Unknown operation
	break;

	case 0x17:
// RL @r

dis.size=1; dis.dis = "RL a"; return dis;

	break;

	case 0x18:
// RR @r

dis.size=1; dis.dis = "RR b"; return dis;

	break;

	case 0x19:
// RR @r

dis.size=1; dis.dis = "RR c"; return dis;

	break;

	case 0x1a:
// RR @r

dis.size=1; dis.dis = "RR d"; return dis;

	break;

	case 0x1b:
// RR @r

dis.size=1; dis.dis = "RR e"; return dis;

	break;

	case 0x1c:
// RR @r

dis.size=1; dis.dis = "RR h"; return dis;

	break;

	case 0x1d:
// RR @r

dis.size=1; dis.dis = "RR l"; return dis;

	break;

	case 0x1e:
// RR @r
// RR (HL)

dis.size=1; dis.dis = "RR (HL)"; return dis;

	break;

	case 0x1f:
// RR @r

dis.size=1; dis.dis = "RR a"; return dis;

	break;

	case 0x20:
// SLA @r

dis.size=1; dis.dis = "SLA b"; return dis;

	break;

	case 0x21:
// SLA @r

dis.size=1; dis.dis = "SLA c"; return dis;

	break;

	case 0x22:
// SLA @r

dis.size=1; dis.dis = "SLA d"; return dis;

	break;

	case 0x23:
// SLA @r

dis.size=1; dis.dis = "SLA e"; return dis;

	break;

	case 0x24:
// SLA @r

dis.size=1; dis.dis = "SLA h"; return dis;

	break;

	case 0x25:
// SLA @r

dis.size=1; dis.dis = "SLA l"; return dis;

	break;

	case 0x26:
// SLA @r
// SLA (HL)

dis.size=1; dis.dis = "SLA (HL)"; return dis;

	break;

	case 0x27:
// SLA @r

dis.size=1; dis.dis = "SLA a"; return dis;

	break;

	case 0x28:
// SRA @r

dis.size=1; dis.dis = "SRA b"; return dis;

	break;

	case 0x29:
// SRA @r

dis.size=1; dis.dis = "SRA c"; return dis;

	break;

	case 0x2a:
// SRA @r

dis.size=1; dis.dis = "SRA d"; return dis;

	break;

	case 0x2b:
// SRA @r

dis.size=1; dis.dis = "SRA e"; return dis;

	break;

	case 0x2c:
// SRA @r

dis.size=1; dis.dis = "SRA h"; return dis;

	break;

	case 0x2d:
// SRA @r

dis.size=1; dis.dis = "SRA l"; return dis;

	break;

	case 0x2e:
// SRA @r
// SRA (HL)

dis.size=1; dis.dis = "SRA (HL)"; return dis;

	break;

	case 0x2f:
// SRA @r

dis.size=1; dis.dis = "SRA a"; return dis;

	break;

	case 0x30:
// SLL @r

dis.size=1; dis.dis = "SLL b"; return dis;

	break;

	case 0x31:
// SLL @r

dis.size=1; dis.dis = "SLL c"; return dis;

	break;

	case 0x32:
// SLL @r

dis.size=1; dis.dis = "SLL d"; return dis;

	break;

	case 0x33:
// SLL @r

dis.size=1; dis.dis = "SLL e"; return dis;

	break;

	case 0x34:
// SLL @r

dis.size=1; dis.dis = "SLL h"; return dis;

	break;

	case 0x35:
// SLL @r

dis.size=1; dis.dis = "SLL l"; return dis;

	break;

	case 0x36:
// SLL @r
// SLL (HL)

dis.size=1; dis.dis = "SLL (HL)"; return dis;

	break;

	case 0x37:
// SLL @r

dis.size=1; dis.dis = "SLL a"; return dis;

	break;

	case 0x38:
// SRL @r

dis.size=1; dis.dis = "SRL b"; return dis;

	break;

	case 0x39:
// SRL @r

dis.size=1; dis.dis = "SRL c"; return dis;

	break;

	case 0x3a:
// SRL @r

dis.size=1; dis.dis = "SRL d"; return dis;

	break;

	case 0x3b:
// SRL @r

dis.size=1; dis.dis = "SRL e"; return dis;

	break;

	case 0x3c:
// SRL @r

dis.size=1; dis.dis = "SRL h"; return dis;

	break;

	case 0x3d:
// SRL @r

dis.size=1; dis.dis = "SRL l"; return dis;

	break;

	case 0x3e:
// SRL @r
// SRL (HL)

dis.size=1; dis.dis = "SRL (HL)"; return dis;

	break;

	case 0x3f:
// SRL @r

dis.size=1; dis.dis = "SRL a"; return dis;

	break;

	case 0x40:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,b"; return dis;

	break;

	case 0x41:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,c"; return dis;

	break;

	case 0x42:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,d"; return dis;

	break;

	case 0x43:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,e"; return dis;

	break;

	case 0x44:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,h"; return dis;

	break;

	case 0x45:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,l"; return dis;

	break;

	case 0x46:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 0, (HL)"; return dis;

	break;

	case 0x47:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 0,a"; return dis;

	break;

	case 0x48:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,b"; return dis;

	break;

	case 0x49:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,c"; return dis;

	break;

	case 0x4a:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,d"; return dis;

	break;

	case 0x4b:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,e"; return dis;

	break;

	case 0x4c:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,h"; return dis;

	break;

	case 0x4d:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,l"; return dis;

	break;

	case 0x4e:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 1, (HL)"; return dis;

	break;

	case 0x4f:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 1,a"; return dis;

	break;

	case 0x50:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,b"; return dis;

	break;

	case 0x51:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,c"; return dis;

	break;

	case 0x52:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,d"; return dis;

	break;

	case 0x53:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,e"; return dis;

	break;

	case 0x54:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,h"; return dis;

	break;

	case 0x55:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,l"; return dis;

	break;

	case 0x56:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 2, (HL)"; return dis;

	break;

	case 0x57:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 2,a"; return dis;

	break;

	case 0x58:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,b"; return dis;

	break;

	case 0x59:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,c"; return dis;

	break;

	case 0x5a:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,d"; return dis;

	break;

	case 0x5b:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,e"; return dis;

	break;

	case 0x5c:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,h"; return dis;

	break;

	case 0x5d:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,l"; return dis;

	break;

	case 0x5e:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 3, (HL)"; return dis;

	break;

	case 0x5f:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 3,a"; return dis;

	break;

	case 0x60:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,b"; return dis;

	break;

	case 0x61:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,c"; return dis;

	break;

	case 0x62:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,d"; return dis;

	break;

	case 0x63:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,e"; return dis;

	break;

	case 0x64:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,h"; return dis;

	break;

	case 0x65:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,l"; return dis;

	break;

	case 0x66:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 4, (HL)"; return dis;

	break;

	case 0x67:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 4,a"; return dis;

	break;

	case 0x68:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,b"; return dis;

	break;

	case 0x69:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,c"; return dis;

	break;

	case 0x6a:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,d"; return dis;

	break;

	case 0x6b:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,e"; return dis;

	break;

	case 0x6c:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,h"; return dis;

	break;

	case 0x6d:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,l"; return dis;

	break;

	case 0x6e:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 5, (HL)"; return dis;

	break;

	case 0x6f:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 5,a"; return dis;

	break;

	case 0x70:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,b"; return dis;

	break;

	case 0x71:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,c"; return dis;

	break;

	case 0x72:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,d"; return dis;

	break;

	case 0x73:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,e"; return dis;

	break;

	case 0x74:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,h"; return dis;

	break;

	case 0x75:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,l"; return dis;

	break;

	case 0x76:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 6, (HL)"; return dis;

	break;

	case 0x77:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 6,a"; return dis;

	break;

	case 0x78:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,b"; return dis;

	break;

	case 0x79:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,c"; return dis;

	break;

	case 0x7a:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,d"; return dis;

	break;

	case 0x7b:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,e"; return dis;

	break;

	case 0x7c:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,h"; return dis;

	break;

	case 0x7d:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,l"; return dis;

	break;

	case 0x7e:
// BIT @r,@s
// BIT @r, (HL)

dis.size=1; dis.dis = "BIT 7, (HL)"; return dis;

	break;

	case 0x7f:
// BIT @r,@s

dis.size=1; dis.dis = "BIT 7,a"; return dis;

	break;

	case 0x80:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,b"; return dis;

	break;

	case 0x81:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,c"; return dis;

	break;

	case 0x82:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,d"; return dis;

	break;

	case 0x83:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,e"; return dis;

	break;

	case 0x84:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,h"; return dis;

	break;

	case 0x85:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,l"; return dis;

	break;

	case 0x86:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 0, (HL)"; return dis;

	break;

	case 0x87:
// RES @r,@s

dis.size=1; dis.dis = "RES 0,a"; return dis;

	break;

	case 0x88:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,b"; return dis;

	break;

	case 0x89:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,c"; return dis;

	break;

	case 0x8a:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,d"; return dis;

	break;

	case 0x8b:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,e"; return dis;

	break;

	case 0x8c:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,h"; return dis;

	break;

	case 0x8d:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,l"; return dis;

	break;

	case 0x8e:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 1, (HL)"; return dis;

	break;

	case 0x8f:
// RES @r,@s

dis.size=1; dis.dis = "RES 1,a"; return dis;

	break;

	case 0x90:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,b"; return dis;

	break;

	case 0x91:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,c"; return dis;

	break;

	case 0x92:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,d"; return dis;

	break;

	case 0x93:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,e"; return dis;

	break;

	case 0x94:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,h"; return dis;

	break;

	case 0x95:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,l"; return dis;

	break;

	case 0x96:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 2, (HL)"; return dis;

	break;

	case 0x97:
// RES @r,@s

dis.size=1; dis.dis = "RES 2,a"; return dis;

	break;

	case 0x98:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,b"; return dis;

	break;

	case 0x99:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,c"; return dis;

	break;

	case 0x9a:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,d"; return dis;

	break;

	case 0x9b:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,e"; return dis;

	break;

	case 0x9c:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,h"; return dis;

	break;

	case 0x9d:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,l"; return dis;

	break;

	case 0x9e:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 3, (HL)"; return dis;

	break;

	case 0x9f:
// RES @r,@s

dis.size=1; dis.dis = "RES 3,a"; return dis;

	break;

	case 0xa0:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,b"; return dis;

	break;

	case 0xa1:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,c"; return dis;

	break;

	case 0xa2:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,d"; return dis;

	break;

	case 0xa3:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,e"; return dis;

	break;

	case 0xa4:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,h"; return dis;

	break;

	case 0xa5:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,l"; return dis;

	break;

	case 0xa6:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 4, (HL)"; return dis;

	break;

	case 0xa7:
// RES @r,@s

dis.size=1; dis.dis = "RES 4,a"; return dis;

	break;

	case 0xa8:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,b"; return dis;

	break;

	case 0xa9:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,c"; return dis;

	break;

	case 0xaa:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,d"; return dis;

	break;

	case 0xab:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,e"; return dis;

	break;

	case 0xac:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,h"; return dis;

	break;

	case 0xad:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,l"; return dis;

	break;

	case 0xae:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 5, (HL)"; return dis;

	break;

	case 0xaf:
// RES @r,@s

dis.size=1; dis.dis = "RES 5,a"; return dis;

	break;

	case 0xb0:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,b"; return dis;

	break;

	case 0xb1:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,c"; return dis;

	break;

	case 0xb2:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,d"; return dis;

	break;

	case 0xb3:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,e"; return dis;

	break;

	case 0xb4:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,h"; return dis;

	break;

	case 0xb5:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,l"; return dis;

	break;

	case 0xb6:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 6, (HL)"; return dis;

	break;

	case 0xb7:
// RES @r,@s

dis.size=1; dis.dis = "RES 6,a"; return dis;

	break;

	case 0xb8:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,b"; return dis;

	break;

	case 0xb9:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,c"; return dis;

	break;

	case 0xba:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,d"; return dis;

	break;

	case 0xbb:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,e"; return dis;

	break;

	case 0xbc:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,h"; return dis;

	break;

	case 0xbd:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,l"; return dis;

	break;

	case 0xbe:
// RES @r,@s
// RES @r, (HL)

dis.size=1; dis.dis = "RES 7, (HL)"; return dis;

	break;

	case 0xbf:
// RES @r,@s

dis.size=1; dis.dis = "RES 7,a"; return dis;

	break;

	case 0xc0:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,b"; return dis;

	break;

	case 0xc1:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,c"; return dis;

	break;

	case 0xc2:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,d"; return dis;

	break;

	case 0xc3:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,e"; return dis;

	break;

	case 0xc4:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,h"; return dis;

	break;

	case 0xc5:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,l"; return dis;

	break;

	case 0xc6:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 0, (HL)"; return dis;

	break;

	case 0xc7:
// SET @r,@s

dis.size=1; dis.dis = "SET 0,a"; return dis;

	break;

	case 0xc8:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,b"; return dis;

	break;

	case 0xc9:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,c"; return dis;

	break;

	case 0xca:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,d"; return dis;

	break;

	case 0xcb:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,e"; return dis;

	break;

	case 0xcc:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,h"; return dis;

	break;

	case 0xcd:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,l"; return dis;

	break;

	case 0xce:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 1, (HL)"; return dis;

	break;

	case 0xcf:
// SET @r,@s

dis.size=1; dis.dis = "SET 1,a"; return dis;

	break;

	case 0xd0:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,b"; return dis;

	break;

	case 0xd1:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,c"; return dis;

	break;

	case 0xd2:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,d"; return dis;

	break;

	case 0xd3:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,e"; return dis;

	break;

	case 0xd4:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,h"; return dis;

	break;

	case 0xd5:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,l"; return dis;

	break;

	case 0xd6:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 2, (HL)"; return dis;

	break;

	case 0xd7:
// SET @r,@s

dis.size=1; dis.dis = "SET 2,a"; return dis;

	break;

	case 0xd8:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,b"; return dis;

	break;

	case 0xd9:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,c"; return dis;

	break;

	case 0xda:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,d"; return dis;

	break;

	case 0xdb:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,e"; return dis;

	break;

	case 0xdc:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,h"; return dis;

	break;

	case 0xdd:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,l"; return dis;

	break;

	case 0xde:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 3, (HL)"; return dis;

	break;

	case 0xdf:
// SET @r,@s

dis.size=1; dis.dis = "SET 3,a"; return dis;

	break;

	case 0xe0:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,b"; return dis;

	break;

	case 0xe1:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,c"; return dis;

	break;

	case 0xe2:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,d"; return dis;

	break;

	case 0xe3:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,e"; return dis;

	break;

	case 0xe4:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,h"; return dis;

	break;

	case 0xe5:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,l"; return dis;

	break;

	case 0xe6:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 4, (HL)"; return dis;

	break;

	case 0xe7:
// SET @r,@s

dis.size=1; dis.dis = "SET 4,a"; return dis;

	break;

	case 0xe8:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,b"; return dis;

	break;

	case 0xe9:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,c"; return dis;

	break;

	case 0xea:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,d"; return dis;

	break;

	case 0xeb:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,e"; return dis;

	break;

	case 0xec:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,h"; return dis;

	break;

	case 0xed:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,l"; return dis;

	break;

	case 0xee:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 5, (HL)"; return dis;

	break;

	case 0xef:
// SET @r,@s

dis.size=1; dis.dis = "SET 5,a"; return dis;

	break;

	case 0xf0:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,b"; return dis;

	break;

	case 0xf1:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,c"; return dis;

	break;

	case 0xf2:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,d"; return dis;

	break;

	case 0xf3:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,e"; return dis;

	break;

	case 0xf4:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,h"; return dis;

	break;

	case 0xf5:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,l"; return dis;

	break;

	case 0xf6:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 6, (HL)"; return dis;

	break;

	case 0xf7:
// SET @r,@s

dis.size=1; dis.dis = "SET 6,a"; return dis;

	break;

	case 0xf8:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,b"; return dis;

	break;

	case 0xf9:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,c"; return dis;

	break;

	case 0xfa:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,d"; return dis;

	break;

	case 0xfb:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,e"; return dis;

	break;

	case 0xfc:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,h"; return dis;

	break;

	case 0xfd:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,l"; return dis;

	break;

	case 0xfe:
// SET @r,@s
// SET @r, (HL)

dis.size=1; dis.dis = "SET 7, (HL)"; return dis;

	break;

	case 0xff:
// SET @r,@s

dis.size=1; dis.dis = "SET 7,a"; return dis;

	break;

} // hctiws
return dis;
}
public static function ed_ext(bus : EMFMainBus, addr : uint) : Object {
var dis : Object = new Object();
dis.dis = "Unknown oaddrode";
dis.size = 1;
var instr : uint = bus.read8(addr);

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

dis.size=1; dis.dis = "IN b,(C)"; return dis;

	break;

	case 0x41:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),b"; return dis;

	break;

	case 0x42:
// SBC HL,@r

dis.size=1; dis.dis = "SBC HL,bc"; return dis;

	break;

	case 0x43:
// LD (@n),@r

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),bc"; return dis;

	break;

	case 0x44:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

	break;

	case 0x45:
// RETN

dis.size=1; dis.dis = "RETN"; return dis;

	break;

	case 0x46:
// IM 0

dis.size=1; dis.dis = "IM 0"; return dis;

	break;

	case 0x47:
// LD I,A

dis.size=1; dis.dis = "LD I,A"; return dis;

	break;

	case 0x48:
// IN @r,(C)

dis.size=1; dis.dis = "IN c,(C)"; return dis;

	break;

	case 0x49:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),c"; return dis;

	break;

	case 0x4a:
// ADC HL,@r

dis.size=1; dis.dis = "ADC HL,bc"; return dis;

	break;

	case 0x4b:
// LD @r,(@n)

dis.size=3; dis.dis = "LD bc,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x4c:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

	break;

	case 0x4d:
// RETI

dis.size=1; dis.dis = "RETI"; return dis;

	break;

	case 0x4e:
// IM 1

dis.size=1; dis.dis = "IM 1"; return dis;

	break;

	case 0x4f:
// LD R,A

dis.size=1; dis.dis = "LD R,A"; return dis;

	break;

	case 0x50:
// IN @r,(C)

dis.size=1; dis.dis = "IN d,(C)"; return dis;

	break;

	case 0x51:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),d"; return dis;

	break;

	case 0x52:
// SBC HL,@r

dis.size=1; dis.dis = "SBC HL,de"; return dis;

	break;

	case 0x53:
// LD (@n),@r

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),de"; return dis;

	break;

	case 0x54:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

	break;

	case 0x55:
// RETN

dis.size=1; dis.dis = "RETN"; return dis;

	break;

	case 0x56:
// IM 1

dis.size=1; dis.dis = "IM 1"; return dis;

	break;

	case 0x57:
// LD A,I

dis.size=1; dis.dis = "LD A,I"; return dis;

	break;

	case 0x58:
// IN @r,(C)

dis.size=1; dis.dis = "IN e,(C)"; return dis;

	break;

	case 0x59:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),e"; return dis;

	break;

	case 0x5a:
// ADC HL,@r

dis.size=1; dis.dis = "ADC HL,de"; return dis;

	break;

	case 0x5b:
// LD @r,(@n)

dis.size=3; dis.dis = "LD de,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x5c:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

	break;

	case 0x5d:
// RETN

dis.size=1; dis.dis = "RETN"; return dis;

	break;

	case 0x5e:
// IM 2

dis.size=1; dis.dis = "IM 2"; return dis;

	break;

	case 0x5f:
// LD A,R

dis.size=1; dis.dis = "LD A,R"; return dis;

	break;

	case 0x60:
// IN @r,(C)

dis.size=1; dis.dis = "IN h,(C)"; return dis;

	break;

	case 0x61:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),h"; return dis;

	break;

	case 0x62:
// SBC HL,@r

dis.size=1; dis.dis = "SBC HL,hl"; return dis;

	break;

	case 0x63:
// LD (@n),@r

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),hl"; return dis;

	break;

	case 0x64:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

	break;

	case 0x65:
	// Unknown operation
	break;

	case 0x66:
	// Unknown operation
	break;

	case 0x67:
// RRD

dis.size=1; dis.dis = "RRD"; return dis;

	break;

	case 0x68:
// IN @r,(C)

dis.size=1; dis.dis = "IN l,(C)"; return dis;

	break;

	case 0x69:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),l"; return dis;

	break;

	case 0x6a:
// ADC HL,@r

dis.size=1; dis.dis = "ADC HL,hl"; return dis;

	break;

	case 0x6b:
// LD @r,(@n)

dis.size=3; dis.dis = "LD hl,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x6c:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

	break;

	case 0x6d:
	// Unknown operation
	break;

	case 0x6e:
	// Unknown operation
	break;

	case 0x6f:
// RLD

dis.size=1; dis.dis = "RLD"; return dis;

	break;

	case 0x70:
// IN @r,(C)
// IN (C)

dis.size=1; dis.dis = "IN (C)"; return dis;

	break;

	case 0x71:
// OUT (C),@r
// OUT (C),0

dis.size=1; dis.dis = "OUT (C),0"; return dis;

	break;

	case 0x72:
// SBC HL,@r

dis.size=1; dis.dis = "SBC HL,sp"; return dis;

	break;

	case 0x73:
// LD (@n),@r

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),sp"; return dis;

	break;

	case 0x74:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

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

dis.size=1; dis.dis = "IN a,(C)"; return dis;

	break;

	case 0x79:
// OUT (C),@r

dis.size=1; dis.dis = "OUT (C),a"; return dis;

	break;

	case 0x7a:
// ADC HL,@r

dis.size=1; dis.dis = "ADC HL,sp"; return dis;

	break;

	case 0x7b:
// LD @r,(@n)

dis.size=3; dis.dis = "LD sp,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x7c:
// NEG

dis.size=1; dis.dis = "NEG"; return dis;

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

dis.size=1; dis.dis = "LDI"; return dis;

	break;

	case 0xa1:
// CPI

dis.size=1; dis.dis = "CPI"; return dis;

	break;

	case 0xa2:
// INI

dis.size=1; dis.dis = "INI"; return dis;

	break;

	case 0xa3:
// OUTI

dis.size=1; dis.dis = "OUTI"; return dis;

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

dis.size=1; dis.dis = "LDD"; return dis;

	break;

	case 0xa9:
// CPD

dis.size=1; dis.dis = "CPD"; return dis;

	break;

	case 0xaa:
// IND

dis.size=1; dis.dis = "IND"; return dis;

	break;

	case 0xab:
// OUTD

dis.size=1; dis.dis = "OUTD"; return dis;

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

dis.size=1; dis.dis = "LDIR"; return dis;

	break;

	case 0xb1:
// CPIR

dis.size=1; dis.dis = "CPIR"; return dis;

	break;

	case 0xb2:
// INIR

dis.size=1; dis.dis = "INIR"; return dis;

	break;

	case 0xb3:
// OTIR

dis.size=1; dis.dis = "OTIR"; return dis;

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

dis.size=1; dis.dis = "LDDR"; return dis;

	break;

	case 0xb9:
// CPDR

dis.size=1; dis.dis = "CPDR"; return dis;

	break;

	case 0xba:
// INDR

dis.size=1; dis.dis = "INDR"; return dis;

	break;

	case 0xbb:
// OTDR

dis.size=1; dis.dis = "OTDR"; return dis;

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
return dis;
}
public static function fd_ext(bus : EMFMainBus, addr : uint) : Object {
var dis : Object = new Object();
dis.dis = "Unknown oaddrode";
dis.size = 1;
var instr : uint = bus.read8(addr);

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

dis.size=1; dis.dis = "ADD IY,bc"; return dis;

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

dis.size=1; dis.dis = "ADD IY,de"; return dis;

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

dis.size=3; dis.dis = "LD IY,"+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H"; return dis;

	break;

	case 0x22:
// LD (@n),IY

dis.size=3; dis.dis = "LD ("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H),IY"; return dis;

	break;

	case 0x23:
// INC IY

dis.size=1; dis.dis = "INC IY"; return dis;

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

dis.size=1; dis.dis = "ADD IY,iy"; return dis;

	break;

	case 0x2a:
// LD IY,(@n)

dis.size=3; dis.dis = "LD IY,("+(("0000"+bus.read16(addr+1).toString(16)).substr(-4))+"H)"; return dis;

	break;

	case 0x2b:
// DEC IY

dis.size=1; dis.dis = "DEC IY"; return dis;

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

dis.size=2; dis.dis = "INC (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x35:
// DEC (IY+@n)

dis.size=2; dis.dis = "DEC (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x36:
// LD (IY+@d),@n

dis.size=3; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),"+(("0000"+bus.read8(addr+2).toString(16)).substr(-2))+"H"; return dis;

	break;

	case 0x37:
	// Unknown operation
	break;

	case 0x38:
	// Unknown operation
	break;

	case 0x39:
// ADD IY,@r

dis.size=1; dis.dis = "ADD IY,sp"; return dis;

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

dis.size=2; dis.dis = "LD b,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD c,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD d,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD e,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD h,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "LD l,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

	break;

	case 0x6f:
	// Unknown operation
	break;

	case 0x70:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),b"; return dis;

	break;

	case 0x71:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),c"; return dis;

	break;

	case 0x72:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),d"; return dis;

	break;

	case 0x73:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),e"; return dis;

	break;

	case 0x74:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),h"; return dis;

	break;

	case 0x75:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),l"; return dis;

	break;

	case 0x76:
// LD @r,(IY+@n)
// LD (IY+@n),@r
	// Unknown operation
	break;

	case 0x77:
// LD (IY+@n),@r

dis.size=2; dis.dis = "LD (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H),a"; return dis;

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

dis.size=2; dis.dis = "LD a,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "ADD A,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "ADC A,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "SUB (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "SBC A,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "AND (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "XOR A,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "OR (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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

dis.size=2; dis.dis = "ADD A,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;

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
if ((bus.read8(addr+2) & 0xff) == 0x6) {
dis.size=3; dis.dis = "RLC (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RRC (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0xe) {
dis.size=3; dis.dis = "RRC (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RL (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0x16) {
dis.size=3; dis.dis = "RL (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// RR (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0x1e) {
dis.size=3; dis.dis = "RR (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SLA (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0x26) {
dis.size=3; dis.dis = "SLA (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SRA (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0x2e) {
dis.size=3; dis.dis = "SRA (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SLL (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0x36) {
dis.size=3; dis.dis = "SLL (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
// SRL (IY+@n)
if ((bus.read8(addr+2) & 0xff) == 0x3e) {
dis.size=3; dis.dis = "SRL (IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
//   BIT @r,(IY+@n)
      
if ((bus.read8(addr+2) & 0xc7) == 0x46) {
dis.size=3; dis.dis = "BIT 0,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
}
//   RES @r,(IY+@n)
      
if ((bus.read8(addr+2) & 0xc7) == 0x86) {
dis.size=3; dis.dis = "RES 0,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H) "; return dis;
}
//     SET @r,(IY+@n)
      
if ((bus.read8(addr+2) & 0xc7) == 0xc6) {
dis.size=3; dis.dis = "SET 0,(IY+"+(("0000"+bus.read8(addr+1).toString(16)).substr(-2))+"H)"; return dis;
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
return dis;
}

	}
	
}
