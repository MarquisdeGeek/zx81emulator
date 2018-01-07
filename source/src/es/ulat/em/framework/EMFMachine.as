package es.ulat.em.framework
{
	import flash.events.KeyboardEvent;

	public class EMFMachine extends EMFDevice
	{
		public var cpu : EMFCPU;
		public var bus : EMFMainBus;

		public function EMFMachine(name_ : String)
		{
			super(name_);
		}
		
		public override function initialize() : void {
			super.initialize();

			cpu.initialize();
			bus.initialize();
		}
		
		public function reset() : void {
			cpu.warmStart();
		}
			
		public function step(cpuID : String) : uint {			
			var cpu_ : EMFCPU = getCPU(cpuID);
			if (cpu_ != null) {
				return cpu_.step();
			}
			return 0;
		}
		
		public function disassembleLine(a : uint) : Object {
			var obj : Object = cpu.getDisassemblyObject(a);
			var s : String = bus.hexRow(a, obj.size);
			s += "                    ";	//20 padding spaces
			s = s.substr(0,20);
			s += obj.dis;
			s += "\n";
			obj.dis = s;
			return obj;
		}
		
		public function hexLine(address : uint, rows : uint) : String {
			// Print line of 16 hex values
			var result : String = "";
			// add printable character			
			for(var r:uint = 0;r<rows;++r) {
				result += bus.hexRow(address, 16);
				result += "  ";
				
				for(var c:uint = 0;c<16;++c) {
					var ch : uint = bus.read8(address + c);
					if (ch < 32 || c > 123) {
						result += "?";
					} else {
						result += String.fromCharCode(ch);
					}
				}
				
				result += "\n";
				
				address += 16;
			}
			
			return result;
		}
		
		public function getCPU(cpuID : String) : EMFCPU {
			return getDevice(cpuID) as EMFCPU;
		}
		
		public function getBus(busID : String) : EMFMainBus {
			return getDevice(busID) as EMFMainBus;
		}
		
		public function applyKeyDown(key : uint) : void {
		}
		
		public function applyKeyUp(key : uint) : void {
		}
		
		public override function toString() : String {
			var s : String = "";
			s += cpu.toString();
			s += bus.toString();
			return s;
		}
	}
}