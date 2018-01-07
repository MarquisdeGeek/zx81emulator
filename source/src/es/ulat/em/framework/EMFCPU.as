package es.ulat.em.framework
{
	import com.sgxengine.sgx.core.SGXArray;

	public class EMFCPU extends EMFDevice
	{
		private var clockSpeed : uint;
		public var bus : EMFMainBus;
		protected var hookAddress : Array;
		private var breakpointList : Array;
		public var pc : int;
		public var pc_at_start : int; //DEBUG ONLY
	
		public function EMFCPU(name_:String, bus_ : EMFMainBus, clockSpeed_ : uint)
		{
			super(name_);

			bus = bus_;
			clockSpeed = clockSpeed_;
			breakpointList = new Array();
			hookAddress = new Array(65536);
		}
		
		public override function initialize() : void {
			super.initialize();
			
			bus.initialize();
		}
		
		public function coldStart() : void
		{
			warmStart();
		}
		
		public function warmStart() : void
		{
		}
		
		public function step() : uint {
			return 0;
		}
		
		public function getDisassemblyObject(addr : uint) : Object {
			// TODO: Mark this as an assertion
			return null;
		}
		
		public function getAssemblerHex(str : String) : String {
			// TODO: Mark this as an assertion
			return null;
		}
		
		public function preChangeCheck() : Object {
			return new Object();
		}

		public function postChangeCheck(previousState : Object) : String {
			return "";
		}
		
		public function addBreakpoint(addr:uint) : void {
			if (!isBreakpoint(addr)) {
				breakpointList.push((addr));
			}
		}
		
		public function addHook(addr : uint, cb : Function) : void {
			hookAddress[addr] = cb;
		}
		
		public function getRegister(reg : String) : uint {
			return 0;
		}
		
		public function setRegister(reg : String, value : uint) : void {
		}
		
		public function removeBreakpoint(addr:uint) : void {
			SGXArray.remove(addr, breakpointList);
		}
		
		public function isBreakpoint(addr:uint) : Boolean {
			return SGXArray.isPresent(breakpointList, addr);
		}
		
		public function getBreakpointList() : String {
			return SGXArray.toString(breakpointList);
		}
		
		public function update(deltaTime : Number) : uint
		{
			var cycles : uint = 0;
			var maxCycles : uint = clockSpeed * deltaTime;
			
			do {
				cycles += step();
				//
				if (isBreakpoint(pc)) {
					return cycles;
				}
			} while (cycles < maxCycles);
			
			return cycles;
		}
			
	}
}