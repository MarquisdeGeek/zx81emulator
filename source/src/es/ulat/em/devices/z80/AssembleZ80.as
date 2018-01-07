package es.ulat.em.devices.z80
{
	import es.ulat.em.framework.EMFUtils;

	public class AssembleZ80
	{
		public static function getHex(str : String) : String {
			var pattern : String = getPattern(str);
			
			if (pattern == null) {
				return null;
			}
			
			return EMFUtils.bin2Hex(pattern);
		}
		
		public static function getPattern(str : String) : String {
			var pattern : String = null;
			var matched : Array;
// nop

if ((matched = str.match(/nop/i)) != null) {
pattern = "00000000";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+bc\s*,\s*(\d+)/i)) != null) {
pattern = "00000001nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// LD (BC),A

if ((matched = str.match(/LD\s+\s*\(\s*BC\s*\)\s*\s*,\s*A/i)) != null) {
pattern = "00000010";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+bc/i)) != null) {
pattern = "00000011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+b/i)) != null) {
pattern = "00000100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+b/i)) != null) {
pattern = "00000101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+b\s*,\s*(\d+)/i)) != null) {
pattern = "00000110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RLCA

if ((matched = str.match(/RLCA/i)) != null) {
pattern = "00000111";
return pattern;
}

// EX AF,AF’

if ((matched = str.match(/EX\s\s*\s*\s*\s*\s*+\s*\s*\s*\s*\s*AF\s*\s*\s*\s*\s*\s*,\s*\s*\s*\s*\s*\s*AF’/i)) != null) {
pattern = "00001000";
return pattern;
}

// ADD HL,@r

if ((matched = str.match(/ADD\s+HL\s*,\s*bc/i)) != null) {
pattern = "00001001";
return pattern;
}

// LD A,(BC)

if ((matched = str.match(/LD\s+A\s*,\s*\s*\(\s*BC\s*\)\s*/i)) != null) {
pattern = "00001010";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+bc/i)) != null) {
pattern = "00001011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+c/i)) != null) {
pattern = "00001100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+c/i)) != null) {
pattern = "00001101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+c\s*,\s*(\d+)/i)) != null) {
pattern = "00001110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RRCA

if ((matched = str.match(/RRCA/i)) != null) {
pattern = "00001111";
return pattern;
}

// DJNZ (addr+@n)

if ((matched = str.match(/DJNZ\s\s*+\s*\s*\\s*\(\s*\s*addr\s*\s*+\s*\s*\s*\(\s*\d\s*+\s*\s*\)\s*\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00010000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+de\s*,\s*(\d+)/i)) != null) {
pattern = "00010001nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// LD (DE),A

if ((matched = str.match(/LD\s+\s*\(\s*DE\s*\)\s*\s*,\s*A/i)) != null) {
pattern = "00010010";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+de/i)) != null) {
pattern = "00010011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+d/i)) != null) {
pattern = "00010100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+d/i)) != null) {
pattern = "00010101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+d\s*,\s*(\d+)/i)) != null) {
pattern = "00010110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RLA

if ((matched = str.match(/RLA/i)) != null) {
pattern = "00010111";
return pattern;
}

// JR (addr+@n)

if ((matched = str.match(/JR\s+\s*\(\s*addr\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00011000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// ADD HL,@r

if ((matched = str.match(/ADD\s+HL\s*,\s*de/i)) != null) {
pattern = "00011001";
return pattern;
}

// LD A,(DE)

if ((matched = str.match(/LD\s+A\s*,\s*\s*\(\s*DE\s*\)\s*/i)) != null) {
pattern = "00011010";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+de/i)) != null) {
pattern = "00011011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+e/i)) != null) {
pattern = "00011100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+e/i)) != null) {
pattern = "00011101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+e\s*,\s*(\d+)/i)) != null) {
pattern = "00011110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RRA

if ((matched = str.match(/RRA/i)) != null) {
pattern = "00011111";
return pattern;
}

// JR NZ,(addr+@n)

if ((matched = str.match(/JR\s+NZ\s*,\s*\s*\(\s*addr\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00100000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+hl\s*,\s*(\d+)/i)) != null) {
pattern = "00100001nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// LD (@n),HL

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*HL/i)) != null) {
pattern = "00100010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+hl/i)) != null) {
pattern = "00100011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+h/i)) != null) {
pattern = "00100100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+h/i)) != null) {
pattern = "00100101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+h\s*,\s*(\d+)/i)) != null) {
pattern = "00100110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// DAA

if ((matched = str.match(/DAA/i)) != null) {
pattern = "00100111";
return pattern;
}

// JR Z,(addr+@n)

if ((matched = str.match(/JR\s+Z\s*,\s*\s*\(\s*addr\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00101000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// ADD HL,@r

if ((matched = str.match(/ADD\s+HL\s*,\s*hl/i)) != null) {
pattern = "00101001";
return pattern;
}

// LD HL,(@n)

if ((matched = str.match(/LD\s+HL\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00101010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+hl/i)) != null) {
pattern = "00101011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+l/i)) != null) {
pattern = "00101100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+l/i)) != null) {
pattern = "00101101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+l\s*,\s*(\d+)/i)) != null) {
pattern = "00101110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// CPL

if ((matched = str.match(/CPL/i)) != null) {
pattern = "00101111";
return pattern;
}

// JR NC,(addr+@n)

if ((matched = str.match(/JR\s+NC\s*,\s*\s*\(\s*addr\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00110000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+sp\s*,\s*(\d+)/i)) != null) {
pattern = "00110001nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// LD (@n),A

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*A/i)) != null) {
pattern = "00110010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+sp/i)) != null) {
pattern = "00110011";
return pattern;
}

// INC @r
// INC (HL)

if ((matched = str.match(/INC\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110100";
return pattern;
}

// DEC @r
// DEC (HL)

if ((matched = str.match(/DEC\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110101";
return pattern;
}

// LD @r,@n
// LD (HL),@n

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*(\d+)/i)) != null) {
pattern = "00110110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// SCF

if ((matched = str.match(/SCF/i)) != null) {
pattern = "00110111";
return pattern;
}

// JR C,(addr+@n)

if ((matched = str.match(/JR\s+C\s*,\s*\s*\(\s*addr\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00111000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// ADD HL,@r

if ((matched = str.match(/ADD\s+HL\s*,\s*sp/i)) != null) {
pattern = "00111001";
return pattern;
}

// LD A,(@n)

if ((matched = str.match(/LD\s+A\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00111010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+sp/i)) != null) {
pattern = "00111011";
return pattern;
}

// INC @r

if ((matched = str.match(/INC\s+a/i)) != null) {
pattern = "00111100";
return pattern;
}

// DEC @r

if ((matched = str.match(/DEC\s+a/i)) != null) {
pattern = "00111101";
return pattern;
}

// LD @r,@n

if ((matched = str.match(/LD\s+a\s*,\s*(\d+)/i)) != null) {
pattern = "00111110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// CCF

if ((matched = str.match(/CCF/i)) != null) {
pattern = "00111111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*b/i)) != null) {
pattern = "01000000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*c/i)) != null) {
pattern = "01000001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*d/i)) != null) {
pattern = "01000010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*e/i)) != null) {
pattern = "01000011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*h/i)) != null) {
pattern = "01000100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*l/i)) != null) {
pattern = "01000101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+b\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01000110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+b\s*,\s*a/i)) != null) {
pattern = "01000111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*b/i)) != null) {
pattern = "01001000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*c/i)) != null) {
pattern = "01001001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*d/i)) != null) {
pattern = "01001010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*e/i)) != null) {
pattern = "01001011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*h/i)) != null) {
pattern = "01001100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*l/i)) != null) {
pattern = "01001101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+c\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01001110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+c\s*,\s*a/i)) != null) {
pattern = "01001111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*b/i)) != null) {
pattern = "01010000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*c/i)) != null) {
pattern = "01010001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*d/i)) != null) {
pattern = "01010010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*e/i)) != null) {
pattern = "01010011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*h/i)) != null) {
pattern = "01010100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*l/i)) != null) {
pattern = "01010101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+d\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01010110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+d\s*,\s*a/i)) != null) {
pattern = "01010111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*b/i)) != null) {
pattern = "01011000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*c/i)) != null) {
pattern = "01011001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*d/i)) != null) {
pattern = "01011010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*e/i)) != null) {
pattern = "01011011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*h/i)) != null) {
pattern = "01011100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*l/i)) != null) {
pattern = "01011101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+e\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01011110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+e\s*,\s*a/i)) != null) {
pattern = "01011111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*b/i)) != null) {
pattern = "01100000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*c/i)) != null) {
pattern = "01100001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*d/i)) != null) {
pattern = "01100010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*e/i)) != null) {
pattern = "01100011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*h/i)) != null) {
pattern = "01100100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*l/i)) != null) {
pattern = "01100101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+h\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01100110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+h\s*,\s*a/i)) != null) {
pattern = "01100111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*b/i)) != null) {
pattern = "01101000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*c/i)) != null) {
pattern = "01101001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*d/i)) != null) {
pattern = "01101010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*e/i)) != null) {
pattern = "01101011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*h/i)) != null) {
pattern = "01101100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*l/i)) != null) {
pattern = "01101101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+l\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01101110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+l\s*,\s*a/i)) != null) {
pattern = "01101111";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*b/i)) != null) {
pattern = "01110000";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*c/i)) != null) {
pattern = "01110001";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*d/i)) != null) {
pattern = "01110010";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*e/i)) != null) {
pattern = "01110011";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*h/i)) != null) {
pattern = "01110100";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*l/i)) != null) {
pattern = "01110101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)
// LD (HL),@r
// HALT

if ((matched = str.match(/HALT/i)) != null) {
pattern = "01110110";
return pattern;
}

// LD @r,@s
// LD (HL),@r

if ((matched = str.match(/LD\s+\s*\(\s*HL\s*\)\s*\s*,\s*a/i)) != null) {
pattern = "01110111";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*b/i)) != null) {
pattern = "01111000";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*c/i)) != null) {
pattern = "01111001";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*d/i)) != null) {
pattern = "01111010";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*e/i)) != null) {
pattern = "01111011";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*h/i)) != null) {
pattern = "01111100";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*l/i)) != null) {
pattern = "01111101";
return pattern;
}

// LD @r,@s
// LD @r,(HL)

if ((matched = str.match(/LD\s+a\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01111110";
return pattern;
}

// LD @r,@s

if ((matched = str.match(/LD\s+a\s*,\s*a/i)) != null) {
pattern = "01111111";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*b/i)) != null) {
pattern = "10000000";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*c/i)) != null) {
pattern = "10000001";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*d/i)) != null) {
pattern = "10000010";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*e/i)) != null) {
pattern = "10000011";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*h/i)) != null) {
pattern = "10000100";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*l/i)) != null) {
pattern = "10000101";
return pattern;
}

// ADD A,@r
// ADD A,(HL)

if ((matched = str.match(/ADD\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10000110";
return pattern;
}

// ADD A,@r

if ((matched = str.match(/ADD\s+A\s*,\s*a/i)) != null) {
pattern = "10000111";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*b/i)) != null) {
pattern = "10001000";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*c/i)) != null) {
pattern = "10001001";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*d/i)) != null) {
pattern = "10001010";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*e/i)) != null) {
pattern = "10001011";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*h/i)) != null) {
pattern = "10001100";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*l/i)) != null) {
pattern = "10001101";
return pattern;
}

// ADC A,@r
// ADC A,(HL)

if ((matched = str.match(/ADC\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10001110";
return pattern;
}

// ADC A,@r

if ((matched = str.match(/ADC\s+A\s*,\s*a/i)) != null) {
pattern = "10001111";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*b/i)) != null) {
pattern = "10010000";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*c/i)) != null) {
pattern = "10010001";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*d/i)) != null) {
pattern = "10010010";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*e/i)) != null) {
pattern = "10010011";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*h/i)) != null) {
pattern = "10010100";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*l/i)) != null) {
pattern = "10010101";
return pattern;
}

// SUB A,@r
// SUB A,(HL)

if ((matched = str.match(/SUB\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10010110";
return pattern;
}

// SUB A,@r

if ((matched = str.match(/SUB\s+A\s*,\s*a/i)) != null) {
pattern = "10010111";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*b/i)) != null) {
pattern = "10011000";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*c/i)) != null) {
pattern = "10011001";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*d/i)) != null) {
pattern = "10011010";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*e/i)) != null) {
pattern = "10011011";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*h/i)) != null) {
pattern = "10011100";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*l/i)) != null) {
pattern = "10011101";
return pattern;
}

// SBC A,@r
// SBC A,(HL)

if ((matched = str.match(/SBC\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10011110";
return pattern;
}

// SBC A,@r

if ((matched = str.match(/SBC\s+A\s*,\s*a/i)) != null) {
pattern = "10011111";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*b/i)) != null) {
pattern = "10100000";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*c/i)) != null) {
pattern = "10100001";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*d/i)) != null) {
pattern = "10100010";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*e/i)) != null) {
pattern = "10100011";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*h/i)) != null) {
pattern = "10100100";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*l/i)) != null) {
pattern = "10100101";
return pattern;
}

// AND A,@r
// AND A,(HL)

if ((matched = str.match(/AND\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10100110";
return pattern;
}

// AND A,@r

if ((matched = str.match(/AND\s+A\s*,\s*a/i)) != null) {
pattern = "10100111";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*b/i)) != null) {
pattern = "10101000";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*c/i)) != null) {
pattern = "10101001";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*d/i)) != null) {
pattern = "10101010";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*e/i)) != null) {
pattern = "10101011";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*h/i)) != null) {
pattern = "10101100";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*l/i)) != null) {
pattern = "10101101";
return pattern;
}

// XOR A,@r
// XOR A,(HL)

if ((matched = str.match(/XOR\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10101110";
return pattern;
}

// XOR A,@r

if ((matched = str.match(/XOR\s+A\s*,\s*a/i)) != null) {
pattern = "10101111";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*b/i)) != null) {
pattern = "10110000";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*c/i)) != null) {
pattern = "10110001";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*d/i)) != null) {
pattern = "10110010";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*e/i)) != null) {
pattern = "10110011";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*h/i)) != null) {
pattern = "10110100";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*l/i)) != null) {
pattern = "10110101";
return pattern;
}

// OR A,@r
// OR A,(HL)

if ((matched = str.match(/OR\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10110110";
return pattern;
}

// OR A,@r

if ((matched = str.match(/OR\s+A\s*,\s*a/i)) != null) {
pattern = "10110111";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*b/i)) != null) {
pattern = "10111000";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*c/i)) != null) {
pattern = "10111001";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*d/i)) != null) {
pattern = "10111010";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*e/i)) != null) {
pattern = "10111011";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*h/i)) != null) {
pattern = "10111100";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*l/i)) != null) {
pattern = "10111101";
return pattern;
}

// CP A,@r
// CP A,(HL)

if ((matched = str.match(/CP\s+A\s*,\s*\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10111110";
return pattern;
}

// CP A,@r

if ((matched = str.match(/CP\s+A\s*,\s*a/i)) != null) {
pattern = "10111111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fnz/i)) != null) {
pattern = "11000000";
return pattern;
}

// POP @r

if ((matched = str.match(/POP\s\s*+\s*bc/i)) != null) {
pattern = "11000001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fnz\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11000010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// JP (@n)

if ((matched = str.match(/JP\s+\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11000011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fnz\s*,\s*(\d+)/i)) != null) {
pattern = "11000100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// PUSH @r

if ((matched = str.match(/PUSH\s\s*+\s*bc/i)) != null) {
pattern = "11000101";
return pattern;
}

// ADD A,@n

if ((matched = str.match(/ADD\s+A\s*,\s*(\d+)/i)) != null) {
pattern = "11000110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x00/i)) != null) {
pattern = "11000111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fz/i)) != null) {
pattern = "11001000";
return pattern;
}

// RET

if ((matched = str.match(/RET/i)) != null) {
pattern = "11001001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fz\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11001010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// CB

if ((matched = str.match(/CB/i)) != null) {
pattern = "11001011";
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fz\s*,\s*(\d+)/i)) != null) {
pattern = "11001100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// CALL (@n)

if ((matched = str.match(/CALL\s\s*\s*+\s*\s*\s*\\s*\\s*\(\s*\s*\s*\s*\\s*\(\s*\s*\d\s*\s*+\s*\s*\s*\\s*\)\s*\s*\s*\\s*\\s*\)\s*\s*\s*/i)) != null) {
pattern = "11001101nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// ADC A,@n

if ((matched = str.match(/ADC\s+A\s*,\s*(\d+)/i)) != null) {
pattern = "11001110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x08/i)) != null) {
pattern = "11001111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fnc/i)) != null) {
pattern = "11010000";
return pattern;
}

// POP @r

if ((matched = str.match(/POP\s\s*+\s*de/i)) != null) {
pattern = "11010001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fnc\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11010010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// OUT (@n),A

if ((matched = str.match(/OUT\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*A/i)) != null) {
pattern = "11010011nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fnc\s*,\s*(\d+)/i)) != null) {
pattern = "11010100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// PUSH @r

if ((matched = str.match(/PUSH\s\s*+\s*de/i)) != null) {
pattern = "11010101";
return pattern;
}

// SUB @n

if ((matched = str.match(/SUB\s+(\d+)/i)) != null) {
pattern = "11010110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x10/i)) != null) {
pattern = "11010111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fc/i)) != null) {
pattern = "11011000";
return pattern;
}

// EXX

if ((matched = str.match(/EXX/i)) != null) {
pattern = "11011001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fc\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11011010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// IN A,(@n)

if ((matched = str.match(/IN\s+A\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11011011nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fc\s*,\s*(\d+)/i)) != null) {
pattern = "11011100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// DD

if ((matched = str.match(/DD/i)) != null) {
pattern = "11011101";
return pattern;
}

// SBC A,@n

if ((matched = str.match(/SBC\s+A\s*,\s*(\d+)/i)) != null) {
pattern = "11011110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x18/i)) != null) {
pattern = "11011111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fpo/i)) != null) {
pattern = "11100000";
return pattern;
}

// POP @r

if ((matched = str.match(/POP\s\s*+\s*hl/i)) != null) {
pattern = "11100001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fpo\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11100010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// EX (SP),HL

if ((matched = str.match(/EX\s\s*\s*+\s*\s*\s*\\s*\\s*\(\s*\s*\s*SP\s*\\s*\\s*\)\s*\s*\s*\s*\s*\s*,\s*\s*\s*HL/i)) != null) {
pattern = "11100011";
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fpo\s*,\s*(\d+)/i)) != null) {
pattern = "11100100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// PUSH @r

if ((matched = str.match(/PUSH\s\s*+\s*hl/i)) != null) {
pattern = "11100101";
return pattern;
}

// AND @n

if ((matched = str.match(/AND\s+(\d+)/i)) != null) {
pattern = "11100110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x20/i)) != null) {
pattern = "11100111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fpe/i)) != null) {
pattern = "11101000";
return pattern;
}

// JP (HL)

if ((matched = str.match(/JP\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11101001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fpe\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11101010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// EX DE,HL

if ((matched = str.match(/EX\s\s*\s*+\s*\s*DE\s*\s*\s*,\s*\s*\s*HL/i)) != null) {
pattern = "11101011";
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fpe\s*,\s*(\d+)/i)) != null) {
pattern = "11101100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// ED

if ((matched = str.match(/ED/i)) != null) {
pattern = "11101101";
return pattern;
}

// ld

if ((matched = str.match(/ld/i)) != null) {
pattern = "1110110101001011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// XOR A,@n

if ((matched = str.match(/XOR\s+A\s*,\s*(\d+)/i)) != null) {
pattern = "11101110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x28/i)) != null) {
pattern = "11101111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fp/i)) != null) {
pattern = "11110000";
return pattern;
}

// POP @r

if ((matched = str.match(/POP\s\s*+\s*af/i)) != null) {
pattern = "11110001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fp\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11110010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// DI

if ((matched = str.match(/DI/i)) != null) {
pattern = "11110011";
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fp\s*,\s*(\d+)/i)) != null) {
pattern = "11110100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// PUSH @r

if ((matched = str.match(/PUSH\s\s*+\s*af/i)) != null) {
pattern = "11110101";
return pattern;
}

// OR A,@n

if ((matched = str.match(/OR\s+A\s*,\s*(\d+)/i)) != null) {
pattern = "11110110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x30/i)) != null) {
pattern = "11110111";
return pattern;
}

// RET @r

if ((matched = str.match(/RET\s+fm/i)) != null) {
pattern = "11111000";
return pattern;
}

// LD SP,HL

if ((matched = str.match(/LD\s+SP\s*,\s*HL/i)) != null) {
pattern = "11111001";
return pattern;
}

// JP @r,(@n)

if ((matched = str.match(/JP\s+fm\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "11111010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// EI

if ((matched = str.match(/EI/i)) != null) {
pattern = "11111011";
return pattern;
}

// CALL @r,@n

if ((matched = str.match(/CALL\s+fm\s*,\s*(\d+)/i)) != null) {
pattern = "11111100nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// FD

if ((matched = str.match(/FD/i)) != null) {
pattern = "11111101";
return pattern;
}

// CP @n

if ((matched = str.match(/CP\s+(\d+)/i)) != null) {
pattern = "11111110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// RST @r

if ((matched = str.match(/RST\s\s*\s*+\s*\s*0x38/i)) != null) {
pattern = "11111111";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD IX,@r

if ((matched = str.match(/ADD\s+IX\s*,\s*bc/i)) != null) {
pattern = "00001001";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD IX,@r

if ((matched = str.match(/ADD\s+IX\s*,\s*de/i)) != null) {
pattern = "00011001";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD IX,@n

if ((matched = str.match(/LD\s+IX\s*,\s*(\d+)/i)) != null) {
pattern = "00100001nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// LD (@n),IX

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*IX/i)) != null) {
pattern = "00100010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// INC IX

if ((matched = str.match(/INC\s+IX/i)) != null) {
pattern = "00100011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD IX,@r

if ((matched = str.match(/ADD\s+IX\s*,\s*ix/i)) != null) {
pattern = "00101001";
return pattern;
}

// LD IX,(@n)

if ((matched = str.match(/LD\s+IX\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00101010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// DEC IX

if ((matched = str.match(/DEC\s+IX/i)) != null) {
pattern = "00101011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// INC (IX+@n)

if ((matched = str.match(/INC\s\s*+\s*\s*\\s*\(\s*\s*IX\s*\s*+\s*\s*\s*\(\s*\d\s*+\s*\s*\)\s*\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110100nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// DEC (IX+@n)

if ((matched = str.match(/DEC\s\s*+\s*\s*\\s*\(\s*\s*IX\s*\s*+\s*\s*\s*\(\s*\d\s*+\s*\s*\)\s*\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110101nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IX+@d),@n

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*(\d+)/i)) != null) {
pattern = "00110110ddddddddnnnnnnnn";
pattern = pattern.replace(/d+/, EMFUtils.getBin8(matched[1]));
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[2]));
return pattern;
}

	// Unknown operation
	// Unknown operation
// ADD IX,@r

if ((matched = str.match(/ADD\s+IX\s*,\s*sp/i)) != null) {
pattern = "00111001";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+b\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01000110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+c\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01001110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+d\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01010110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+e\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01011110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+h\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01100110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+l\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01101110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*b/i)) != null) {
pattern = "01110000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*c/i)) != null) {
pattern = "01110001nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*d/i)) != null) {
pattern = "01110010nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*e/i)) != null) {
pattern = "01110011nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*h/i)) != null) {
pattern = "01110100nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*l/i)) != null) {
pattern = "01110101nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD @r,(IX+@n)
// LD (IX+@n),@r
	// Unknown operation
// LD (IX+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*\s*,\s*a/i)) != null) {
pattern = "01110111nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IX+@n)

if ((matched = str.match(/LD\s+a\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01111110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD A,(IX+@n)

if ((matched = str.match(/ADD\s+A\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10000110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADC A,(IX+@n)

if ((matched = str.match(/ADC\s+A\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10001110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// SUB (IX+@n)

if ((matched = str.match(/SUB\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10010110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// SBC A,(IX+@n)

if ((matched = str.match(/SBC\s+A\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10011110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// AND (IX+@n)

if ((matched = str.match(/AND\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10100110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// XOR A,(IX+@n)

if ((matched = str.match(/XOR\s+A\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10101110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// OR (IX+@n)

if ((matched = str.match(/OR\s+\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10110110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD A,(IX+@n)

if ((matched = str.match(/ADD\s+A\s*,\s*\s*\(\s*IX\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10111110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// RLC @r

if ((matched = str.match(/RLC\s+b/i)) != null) {
pattern = "00000000";
return pattern;
}

// RLC @r

if ((matched = str.match(/RLC\s+c/i)) != null) {
pattern = "00000001";
return pattern;
}

// RLC @r

if ((matched = str.match(/RLC\s+d/i)) != null) {
pattern = "00000010";
return pattern;
}

// RLC @r

if ((matched = str.match(/RLC\s+e/i)) != null) {
pattern = "00000011";
return pattern;
}

// RLC @r

if ((matched = str.match(/RLC\s+h/i)) != null) {
pattern = "00000100";
return pattern;
}

// RLC @r

if ((matched = str.match(/RLC\s+l/i)) != null) {
pattern = "00000101";
return pattern;
}

// RLC @r
// RLC (HL)

if ((matched = str.match(/RLC\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00000110";
return pattern;
}

// RLC @r

if ((matched = str.match(/RLC\s+a/i)) != null) {
pattern = "00000111";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+b/i)) != null) {
pattern = "00001000";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+c/i)) != null) {
pattern = "00001001";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+d/i)) != null) {
pattern = "00001010";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+e/i)) != null) {
pattern = "00001011";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+h/i)) != null) {
pattern = "00001100";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+l/i)) != null) {
pattern = "00001101";
return pattern;
}

// RRC @r
// RRC (HL)

if ((matched = str.match(/RRC\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00001110";
return pattern;
}

// RL (HL)

if ((matched = str.match(/RL\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00001110";
return pattern;
}

// RRC @r

if ((matched = str.match(/RRC\s+a/i)) != null) {
pattern = "00001111";
return pattern;
}

// RL @r

if ((matched = str.match(/RL\s+b/i)) != null) {
pattern = "00010000";
return pattern;
}

// RL @r

if ((matched = str.match(/RL\s+c/i)) != null) {
pattern = "00010001";
return pattern;
}

// RL @r

if ((matched = str.match(/RL\s+d/i)) != null) {
pattern = "00010010";
return pattern;
}

// RL @r

if ((matched = str.match(/RL\s+e/i)) != null) {
pattern = "00010011";
return pattern;
}

// RL @r

if ((matched = str.match(/RL\s+h/i)) != null) {
pattern = "00010100";
return pattern;
}

// RL @r

if ((matched = str.match(/RL\s+l/i)) != null) {
pattern = "00010101";
return pattern;
}

// RL @r
	// Unknown operation
// RL @r

if ((matched = str.match(/RL\s+a/i)) != null) {
pattern = "00010111";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+b/i)) != null) {
pattern = "00011000";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+c/i)) != null) {
pattern = "00011001";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+d/i)) != null) {
pattern = "00011010";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+e/i)) != null) {
pattern = "00011011";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+h/i)) != null) {
pattern = "00011100";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+l/i)) != null) {
pattern = "00011101";
return pattern;
}

// RR @r
// RR (HL)

if ((matched = str.match(/RR\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00011110";
return pattern;
}

// RR @r

if ((matched = str.match(/RR\s+a/i)) != null) {
pattern = "00011111";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+b/i)) != null) {
pattern = "00100000";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+c/i)) != null) {
pattern = "00100001";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+d/i)) != null) {
pattern = "00100010";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+e/i)) != null) {
pattern = "00100011";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+h/i)) != null) {
pattern = "00100100";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+l/i)) != null) {
pattern = "00100101";
return pattern;
}

// SLA @r
// SLA (HL)

if ((matched = str.match(/SLA\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00100110";
return pattern;
}

// SLA @r

if ((matched = str.match(/SLA\s+a/i)) != null) {
pattern = "00100111";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+b/i)) != null) {
pattern = "00101000";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+c/i)) != null) {
pattern = "00101001";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+d/i)) != null) {
pattern = "00101010";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+e/i)) != null) {
pattern = "00101011";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+h/i)) != null) {
pattern = "00101100";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+l/i)) != null) {
pattern = "00101101";
return pattern;
}

// SRA @r
// SRA (HL)

if ((matched = str.match(/SRA\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00101110";
return pattern;
}

// SRA @r

if ((matched = str.match(/SRA\s+a/i)) != null) {
pattern = "00101111";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+b/i)) != null) {
pattern = "00110000";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+c/i)) != null) {
pattern = "00110001";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+d/i)) != null) {
pattern = "00110010";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+e/i)) != null) {
pattern = "00110011";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+h/i)) != null) {
pattern = "00110100";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+l/i)) != null) {
pattern = "00110101";
return pattern;
}

// SLL @r
// SLL (HL)

if ((matched = str.match(/SLL\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110110";
return pattern;
}

// SLL @r

if ((matched = str.match(/SLL\s+a/i)) != null) {
pattern = "00110111";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+b/i)) != null) {
pattern = "00111000";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+c/i)) != null) {
pattern = "00111001";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+d/i)) != null) {
pattern = "00111010";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+e/i)) != null) {
pattern = "00111011";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+h/i)) != null) {
pattern = "00111100";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+l/i)) != null) {
pattern = "00111101";
return pattern;
}

// SRL @r
// SRL (HL)

if ((matched = str.match(/SRL\s\s*+\s*\s*\\s*\(\s*\s*HL\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00111110";
return pattern;
}

// SRL @r

if ((matched = str.match(/SRL\s+a/i)) != null) {
pattern = "00111111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*b/i)) != null) {
pattern = "01000000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*c/i)) != null) {
pattern = "01000001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*d/i)) != null) {
pattern = "01000010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*e/i)) != null) {
pattern = "01000011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*h/i)) != null) {
pattern = "01000100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*l/i)) != null) {
pattern = "01000101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+0\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01000110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+0\s*,\s*a/i)) != null) {
pattern = "01000111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*b/i)) != null) {
pattern = "01001000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*c/i)) != null) {
pattern = "01001001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*d/i)) != null) {
pattern = "01001010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*e/i)) != null) {
pattern = "01001011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*h/i)) != null) {
pattern = "01001100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*l/i)) != null) {
pattern = "01001101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+1\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01001110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+1\s*,\s*a/i)) != null) {
pattern = "01001111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*b/i)) != null) {
pattern = "01010000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*c/i)) != null) {
pattern = "01010001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*d/i)) != null) {
pattern = "01010010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*e/i)) != null) {
pattern = "01010011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*h/i)) != null) {
pattern = "01010100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*l/i)) != null) {
pattern = "01010101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+2\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01010110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+2\s*,\s*a/i)) != null) {
pattern = "01010111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*b/i)) != null) {
pattern = "01011000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*c/i)) != null) {
pattern = "01011001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*d/i)) != null) {
pattern = "01011010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*e/i)) != null) {
pattern = "01011011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*h/i)) != null) {
pattern = "01011100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*l/i)) != null) {
pattern = "01011101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+3\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01011110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+3\s*,\s*a/i)) != null) {
pattern = "01011111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*b/i)) != null) {
pattern = "01100000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*c/i)) != null) {
pattern = "01100001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*d/i)) != null) {
pattern = "01100010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*e/i)) != null) {
pattern = "01100011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*h/i)) != null) {
pattern = "01100100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*l/i)) != null) {
pattern = "01100101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+4\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01100110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+4\s*,\s*a/i)) != null) {
pattern = "01100111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*b/i)) != null) {
pattern = "01101000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*c/i)) != null) {
pattern = "01101001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*d/i)) != null) {
pattern = "01101010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*e/i)) != null) {
pattern = "01101011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*h/i)) != null) {
pattern = "01101100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*l/i)) != null) {
pattern = "01101101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+5\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01101110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+5\s*,\s*a/i)) != null) {
pattern = "01101111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*b/i)) != null) {
pattern = "01110000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*c/i)) != null) {
pattern = "01110001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*d/i)) != null) {
pattern = "01110010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*e/i)) != null) {
pattern = "01110011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*h/i)) != null) {
pattern = "01110100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*l/i)) != null) {
pattern = "01110101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+6\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01110110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+6\s*,\s*a/i)) != null) {
pattern = "01110111";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*b/i)) != null) {
pattern = "01111000";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*c/i)) != null) {
pattern = "01111001";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*d/i)) != null) {
pattern = "01111010";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*e/i)) != null) {
pattern = "01111011";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*h/i)) != null) {
pattern = "01111100";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*l/i)) != null) {
pattern = "01111101";
return pattern;
}

// BIT @r,@s
// BIT @r, (HL)

if ((matched = str.match(/BIT\s+7\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "01111110";
return pattern;
}

// BIT @r,@s

if ((matched = str.match(/BIT\s+7\s*,\s*a/i)) != null) {
pattern = "01111111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*b/i)) != null) {
pattern = "10000000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*c/i)) != null) {
pattern = "10000001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*d/i)) != null) {
pattern = "10000010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*e/i)) != null) {
pattern = "10000011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*h/i)) != null) {
pattern = "10000100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*l/i)) != null) {
pattern = "10000101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+0\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10000110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+0\s*,\s*a/i)) != null) {
pattern = "10000111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*b/i)) != null) {
pattern = "10001000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*c/i)) != null) {
pattern = "10001001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*d/i)) != null) {
pattern = "10001010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*e/i)) != null) {
pattern = "10001011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*h/i)) != null) {
pattern = "10001100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*l/i)) != null) {
pattern = "10001101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+1\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10001110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+1\s*,\s*a/i)) != null) {
pattern = "10001111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*b/i)) != null) {
pattern = "10010000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*c/i)) != null) {
pattern = "10010001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*d/i)) != null) {
pattern = "10010010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*e/i)) != null) {
pattern = "10010011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*h/i)) != null) {
pattern = "10010100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*l/i)) != null) {
pattern = "10010101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+2\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10010110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+2\s*,\s*a/i)) != null) {
pattern = "10010111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*b/i)) != null) {
pattern = "10011000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*c/i)) != null) {
pattern = "10011001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*d/i)) != null) {
pattern = "10011010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*e/i)) != null) {
pattern = "10011011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*h/i)) != null) {
pattern = "10011100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*l/i)) != null) {
pattern = "10011101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+3\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10011110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+3\s*,\s*a/i)) != null) {
pattern = "10011111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*b/i)) != null) {
pattern = "10100000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*c/i)) != null) {
pattern = "10100001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*d/i)) != null) {
pattern = "10100010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*e/i)) != null) {
pattern = "10100011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*h/i)) != null) {
pattern = "10100100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*l/i)) != null) {
pattern = "10100101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+4\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10100110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+4\s*,\s*a/i)) != null) {
pattern = "10100111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*b/i)) != null) {
pattern = "10101000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*c/i)) != null) {
pattern = "10101001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*d/i)) != null) {
pattern = "10101010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*e/i)) != null) {
pattern = "10101011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*h/i)) != null) {
pattern = "10101100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*l/i)) != null) {
pattern = "10101101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+5\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10101110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+5\s*,\s*a/i)) != null) {
pattern = "10101111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*b/i)) != null) {
pattern = "10110000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*c/i)) != null) {
pattern = "10110001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*d/i)) != null) {
pattern = "10110010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*e/i)) != null) {
pattern = "10110011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*h/i)) != null) {
pattern = "10110100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*l/i)) != null) {
pattern = "10110101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+6\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10110110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+6\s*,\s*a/i)) != null) {
pattern = "10110111";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*b/i)) != null) {
pattern = "10111000";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*c/i)) != null) {
pattern = "10111001";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*d/i)) != null) {
pattern = "10111010";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*e/i)) != null) {
pattern = "10111011";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*h/i)) != null) {
pattern = "10111100";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*l/i)) != null) {
pattern = "10111101";
return pattern;
}

// RES @r,@s
// RES @r, (HL)

if ((matched = str.match(/RES\s+7\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "10111110";
return pattern;
}

// RES @r,@s

if ((matched = str.match(/RES\s+7\s*,\s*a/i)) != null) {
pattern = "10111111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*b/i)) != null) {
pattern = "11000000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*c/i)) != null) {
pattern = "11000001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*d/i)) != null) {
pattern = "11000010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*e/i)) != null) {
pattern = "11000011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*h/i)) != null) {
pattern = "11000100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*l/i)) != null) {
pattern = "11000101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+0\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11000110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+0\s*,\s*a/i)) != null) {
pattern = "11000111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*b/i)) != null) {
pattern = "11001000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*c/i)) != null) {
pattern = "11001001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*d/i)) != null) {
pattern = "11001010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*e/i)) != null) {
pattern = "11001011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*h/i)) != null) {
pattern = "11001100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*l/i)) != null) {
pattern = "11001101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+1\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11001110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+1\s*,\s*a/i)) != null) {
pattern = "11001111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*b/i)) != null) {
pattern = "11010000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*c/i)) != null) {
pattern = "11010001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*d/i)) != null) {
pattern = "11010010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*e/i)) != null) {
pattern = "11010011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*h/i)) != null) {
pattern = "11010100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*l/i)) != null) {
pattern = "11010101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+2\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11010110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+2\s*,\s*a/i)) != null) {
pattern = "11010111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*b/i)) != null) {
pattern = "11011000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*c/i)) != null) {
pattern = "11011001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*d/i)) != null) {
pattern = "11011010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*e/i)) != null) {
pattern = "11011011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*h/i)) != null) {
pattern = "11011100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*l/i)) != null) {
pattern = "11011101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+3\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11011110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+3\s*,\s*a/i)) != null) {
pattern = "11011111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*b/i)) != null) {
pattern = "11100000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*c/i)) != null) {
pattern = "11100001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*d/i)) != null) {
pattern = "11100010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*e/i)) != null) {
pattern = "11100011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*h/i)) != null) {
pattern = "11100100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*l/i)) != null) {
pattern = "11100101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+4\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11100110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+4\s*,\s*a/i)) != null) {
pattern = "11100111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*b/i)) != null) {
pattern = "11101000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*c/i)) != null) {
pattern = "11101001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*d/i)) != null) {
pattern = "11101010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*e/i)) != null) {
pattern = "11101011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*h/i)) != null) {
pattern = "11101100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*l/i)) != null) {
pattern = "11101101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+5\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11101110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+5\s*,\s*a/i)) != null) {
pattern = "11101111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*b/i)) != null) {
pattern = "11110000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*c/i)) != null) {
pattern = "11110001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*d/i)) != null) {
pattern = "11110010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*e/i)) != null) {
pattern = "11110011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*h/i)) != null) {
pattern = "11110100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*l/i)) != null) {
pattern = "11110101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+6\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11110110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+6\s*,\s*a/i)) != null) {
pattern = "11110111";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*b/i)) != null) {
pattern = "11111000";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*c/i)) != null) {
pattern = "11111001";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*d/i)) != null) {
pattern = "11111010";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*e/i)) != null) {
pattern = "11111011";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*h/i)) != null) {
pattern = "11111100";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*l/i)) != null) {
pattern = "11111101";
return pattern;
}

// SET @r,@s
// SET @r, (HL)

if ((matched = str.match(/SET\s+7\s*,\s*\s+\s*\(\s*HL\s*\)\s*/i)) != null) {
pattern = "11111110";
return pattern;
}

// SET @r,@s

if ((matched = str.match(/SET\s+7\s*,\s*a/i)) != null) {
pattern = "11111111";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// IN @r,(C)

if ((matched = str.match(/IN\s+b\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01000000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*b/i)) != null) {
pattern = "01000001";
return pattern;
}

// SBC HL,@r

if ((matched = str.match(/SBC\s+HL\s*,\s*bc/i)) != null) {
pattern = "01000010";
return pattern;
}

// LD (@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*bc/i)) != null) {
pattern = "01000011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

// RETN

if ((matched = str.match(/RETN/i)) != null) {
pattern = "01000101";
return pattern;
}

// IM 0

if ((matched = str.match(/IM\s+0/i)) != null) {
pattern = "01000110";
return pattern;
}

// LD I,A

if ((matched = str.match(/LD\s+I\s*,\s*A/i)) != null) {
pattern = "01000111";
return pattern;
}

// IN @r,(C)

if ((matched = str.match(/IN\s+c\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01001000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*c/i)) != null) {
pattern = "01001001";
return pattern;
}

// ADC HL,@r

if ((matched = str.match(/ADC\s+HL\s*,\s*bc/i)) != null) {
pattern = "01001010";
return pattern;
}

// LD @r,(@n)

if ((matched = str.match(/LD\s+bc\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01001011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

// RETI

if ((matched = str.match(/RETI/i)) != null) {
pattern = "01001101";
return pattern;
}

// IM 1

if ((matched = str.match(/IM\s+1/i)) != null) {
pattern = "01001110";
return pattern;
}

// LD R,A

if ((matched = str.match(/LD\s\s*+\s*R\s*\s*,\s*\s*A/i)) != null) {
pattern = "01001111";
return pattern;
}

// IN @r,(C)

if ((matched = str.match(/IN\s+d\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01010000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*d/i)) != null) {
pattern = "01010001";
return pattern;
}

// SBC HL,@r

if ((matched = str.match(/SBC\s+HL\s*,\s*de/i)) != null) {
pattern = "01010010";
return pattern;
}

// LD (@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*de/i)) != null) {
pattern = "01010011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

// RETN

if ((matched = str.match(/RETN/i)) != null) {
pattern = "01010101";
return pattern;
}

// IM 1

if ((matched = str.match(/IM\s+1/i)) != null) {
pattern = "01010110";
return pattern;
}

// LD A,I

if ((matched = str.match(/LD\s+A\s*,\s*I/i)) != null) {
pattern = "01010111";
return pattern;
}

// IN @r,(C)

if ((matched = str.match(/IN\s+e\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01011000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*e/i)) != null) {
pattern = "01011001";
return pattern;
}

// ADC HL,@r

if ((matched = str.match(/ADC\s+HL\s*,\s*de/i)) != null) {
pattern = "01011010";
return pattern;
}

// LD @r,(@n)

if ((matched = str.match(/LD\s+de\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01011011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

// RETN

if ((matched = str.match(/RETN/i)) != null) {
pattern = "01011101";
return pattern;
}

// IM 2

if ((matched = str.match(/IM\s+2/i)) != null) {
pattern = "01011110";
return pattern;
}

// LD A,R

if ((matched = str.match(/LD\s\s*\s*+\s*\s*A\s*\s*\s*,\s*\s*\s*R/i)) != null) {
pattern = "01011111";
return pattern;
}

// IN @r,(C)

if ((matched = str.match(/IN\s+h\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01100000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*h/i)) != null) {
pattern = "01100001";
return pattern;
}

// SBC HL,@r

if ((matched = str.match(/SBC\s+HL\s*,\s*hl/i)) != null) {
pattern = "01100010";
return pattern;
}

// LD (@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*hl/i)) != null) {
pattern = "01100011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

	// Unknown operation
	// Unknown operation
// RRD

if ((matched = str.match(/RRD/i)) != null) {
pattern = "01100111";
return pattern;
}

// IN @r,(C)

if ((matched = str.match(/IN\s+l\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01101000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*l/i)) != null) {
pattern = "01101001";
return pattern;
}

// ADC HL,@r

if ((matched = str.match(/ADC\s+HL\s*,\s*hl/i)) != null) {
pattern = "01101010";
return pattern;
}

// LD @r,(@n)

if ((matched = str.match(/LD\s+hl\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01101011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

	// Unknown operation
	// Unknown operation
// RLD

if ((matched = str.match(/RLD/i)) != null) {
pattern = "01101111";
return pattern;
}

// IN @r,(C)
// IN (C)

if ((matched = str.match(/IN\s+\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01110000";
return pattern;
}

// OUT (C),@r
// OUT (C),0

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*0/i)) != null) {
pattern = "01110001";
return pattern;
}

// SBC HL,@r

if ((matched = str.match(/SBC\s+HL\s*,\s*sp/i)) != null) {
pattern = "01110010";
return pattern;
}

// LD (@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*sp/i)) != null) {
pattern = "01110011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
// IN @r,(C)

if ((matched = str.match(/IN\s+a\s*,\s*\s*\(\s*C\s*\)\s*/i)) != null) {
pattern = "01111000";
return pattern;
}

// OUT (C),@r

if ((matched = str.match(/OUT\s+\s*\(\s*C\s*\)\s*\s*,\s*a/i)) != null) {
pattern = "01111001";
return pattern;
}

// ADC HL,@r

if ((matched = str.match(/ADC\s+HL\s*,\s*sp/i)) != null) {
pattern = "01111010";
return pattern;
}

// LD @r,(@n)

if ((matched = str.match(/LD\s+sp\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01111011nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// NEG

if ((matched = str.match(/NEG/i)) != null) {
pattern = "01rrr100";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LDI

if ((matched = str.match(/LDI/i)) != null) {
pattern = "10100000";
return pattern;
}

// CPI

if ((matched = str.match(/CPI/i)) != null) {
pattern = "10100001";
return pattern;
}

// INI

if ((matched = str.match(/INI/i)) != null) {
pattern = "10100010";
return pattern;
}

// OUTI

if ((matched = str.match(/OUTI/i)) != null) {
pattern = "10100011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LDD

if ((matched = str.match(/LDD/i)) != null) {
pattern = "10101000";
return pattern;
}

// CPD

if ((matched = str.match(/CPD/i)) != null) {
pattern = "10101001";
return pattern;
}

// IND

if ((matched = str.match(/IND/i)) != null) {
pattern = "10101010";
return pattern;
}

// OUTD

if ((matched = str.match(/OUTD/i)) != null) {
pattern = "10101011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LDIR

if ((matched = str.match(/LDIR/i)) != null) {
pattern = "10110000";
return pattern;
}

// CPIR

if ((matched = str.match(/CPIR/i)) != null) {
pattern = "10110001";
return pattern;
}

// INIR

if ((matched = str.match(/INIR/i)) != null) {
pattern = "10110010";
return pattern;
}

// OTIR

if ((matched = str.match(/OTIR/i)) != null) {
pattern = "10110011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LDDR

if ((matched = str.match(/LDDR/i)) != null) {
pattern = "10111000";
return pattern;
}

// CPDR

if ((matched = str.match(/CPDR/i)) != null) {
pattern = "10111001";
return pattern;
}

// INDR

if ((matched = str.match(/INDR/i)) != null) {
pattern = "10111010";
return pattern;
}

// OTDR

if ((matched = str.match(/OTDR/i)) != null) {
pattern = "10111011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD IY,@r

if ((matched = str.match(/ADD\s+IY\s*,\s*bc/i)) != null) {
pattern = "00001001";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD IY,@r

if ((matched = str.match(/ADD\s+IY\s*,\s*de/i)) != null) {
pattern = "00011001";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD IY,@n

if ((matched = str.match(/LD\s+IY\s*,\s*(\d+)/i)) != null) {
pattern = "00100001nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// LD (@n),IY

if ((matched = str.match(/LD\s+\s*\(\s*(\d+)\s*\)\s*\s*,\s*IY/i)) != null) {
pattern = "00100010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// INC IY

if ((matched = str.match(/INC\s+IY/i)) != null) {
pattern = "00100011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD IY,@r

if ((matched = str.match(/ADD\s+IY\s*,\s*iy/i)) != null) {
pattern = "00101001";
return pattern;
}

// LD IY,(@n)

if ((matched = str.match(/LD\s+IY\s*,\s*\s*\(\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "00101010nnnnnnnnnnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin16(matched[1]));
return pattern;
}

// DEC IY

if ((matched = str.match(/DEC\s+IY/i)) != null) {
pattern = "00101011";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// INC (IY+@n)

if ((matched = str.match(/INC\s\s*+\s*\s*\\s*\(\s*\s*IY\s*\s*+\s*\s*\s*\(\s*\d\s*+\s*\s*\)\s*\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110100nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// DEC (IY+@n)

if ((matched = str.match(/DEC\s\s*+\s*\s*\\s*\(\s*\s*IY\s*\s*+\s*\s*\s*\(\s*\d\s*+\s*\s*\)\s*\s*\\s*\)\s*\s*/i)) != null) {
pattern = "00110101nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IY+@d),@n

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*(\d+)/i)) != null) {
pattern = "00110110ddddddddnnnnnnnn";
pattern = pattern.replace(/d+/, EMFUtils.getBin8(matched[1]));
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[2]));
return pattern;
}

	// Unknown operation
	// Unknown operation
// ADD IY,@r

if ((matched = str.match(/ADD\s+IY\s*,\s*sp/i)) != null) {
pattern = "00111001";
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+b\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01000110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+c\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01001110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+d\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01010110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+e\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01011110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+h\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01100110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+l\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01101110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*b/i)) != null) {
pattern = "01110000nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*c/i)) != null) {
pattern = "01110001nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*d/i)) != null) {
pattern = "01110010nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*e/i)) != null) {
pattern = "01110011nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*h/i)) != null) {
pattern = "01110100nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*l/i)) != null) {
pattern = "01110101nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

// LD @r,(IY+@n)
// LD (IY+@n),@r
	// Unknown operation
// LD (IY+@n),@r

if ((matched = str.match(/LD\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*\s*,\s*a/i)) != null) {
pattern = "01110111nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// LD @r,(IY+@n)

if ((matched = str.match(/LD\s+a\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "01111110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD A,(IY+@n)

if ((matched = str.match(/ADD\s+A\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10000110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADC A,(IY+@n)

if ((matched = str.match(/ADC\s+A\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10001110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// SUB (IY+@n)

if ((matched = str.match(/SUB\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10010110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// SBC A,(IY+@n)

if ((matched = str.match(/SBC\s+A\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10011110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// AND (IY+@n)

if ((matched = str.match(/AND\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10100110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// XOR A,(IY+@n)

if ((matched = str.match(/XOR\s+A\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10101110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// OR (IY+@n)

if ((matched = str.match(/OR\s+\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10110110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// ADD A,(IY+@n)

if ((matched = str.match(/ADD\s+A\s*,\s*\s*\(\s*IY\s*+\s*(\d+)\s*\)\s*/i)) != null) {
pattern = "10111110nnnnnnnn";
pattern = pattern.replace(/n+/, EMFUtils.getBin8(matched[1]));
return pattern;
}

	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
	// Unknown operation
// RLC (IY+@n)
return pattern;

}

	}
}
