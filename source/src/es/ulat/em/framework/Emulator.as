package es.ulat.em.framework
{
	
	import com.sgxengine.sgx.core.helpers.DebugConsole;
	
	import es.ulat.em.machines.zx.ZXBasicDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.utils.getTimer;
	
	import no.doomsday.console.utilities.HexUtil;
	
	public class Emulator extends Sprite
	{
		protected var machine : EMFMachine;
		protected var running : Boolean;
		protected var lastUpdateTime : Number;
		private var timecum : Number = 0;
	
	
		protected var displayText : EMFDisplayDriver;
		
		public function initialize() : void {
			machine.initialize();
		}
		
		public function setupDebugConsole() : void
		{
			addChild(new DebugConsole());

			DebugConsole.hide();
			
			DebugConsole.createCommand("reset", reset, "", "");
			DebugConsole.createCommand("read8", read8, "", "");
			DebugConsole.createCommand("write8", write8, "", "");
			DebugConsole.createCommand("step", step, "", "");
			DebugConsole.createCommand("over", over, "", "");
			DebugConsole.createCommand("start", startSimulator, "", "");
			DebugConsole.createCommand("stop", stopSimulator, "", "");
			DebugConsole.createCommand("dump", dump, "", "");
			DebugConsole.createCommand("dis", disassemble, "", "");
			DebugConsole.createCommand("asm", assemble, "", "");
			DebugConsole.createCommand("hex", hexdump, "", "");
			DebugConsole.createCommand("cpu", cpu, "", "");
			DebugConsole.createCommand("fill", fillMemory, "", "");
			DebugConsole.createCommand("bp", toggleBreakpoint, "", "");
			DebugConsole.createCommand("setr", setReg, "", "");
			DebugConsole.createCommand("getr", getReg, "", "");
			
		}

		public function setupEventListeners() : void
		{
			addEventListener(Event.ENTER_FRAME, 		updateMe,				false,0,true);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, applyKeyDown, false, 0, true );
			stage.addEventListener(KeyboardEvent.KEY_UP, applyKeyUp, false, 0, true );
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private var lastAddr : uint = 0;
		private var lastValue : uint = 0;
		
		private function onMouseMove(ev:MouseEvent) : void {
		}
		
		protected function refreshVideo() : void {
		}
	
		private function applyKeyDown(ev:KeyboardEvent) : void {
			if (ev.keyCode == 112) {
				DebugConsole.toggle();
				return;
			} else if (ev.keyCode == 113) {
				if (running) {
					stopSimulator();	
					DebugConsole.toggle();
				} 
				
				return;
			} else if (DebugConsole.isOpen()) {
				return;
			}
			
			machine.applyKeyDown(ev.keyCode);
		}
		
		private function applyKeyUp(ev:KeyboardEvent) : void {
			if (!DebugConsole.isOpen()) {
				machine.applyKeyUp(ev.keyCode);
			}
			
		}
		
		
		public function reset() : String {
			machine.reset();
			return cpu();
		}
		
		public function startSimulator() : String {
			running = true;
			lastUpdateTime = getTimer();
			return "Now running";
		}
		
		private function stopSimulator() : String {
			running = false;
			return "Now stopped";
		}
		
		
		private function reviewLine() : String {
			
			var result : String = machine.disassembleLine(machine.cpu.pc).dis + "\n";
			
			return result;
		}
		
		private function over() : String {
			var a : uint = getAddr(null);
			a += machine.cpu.getDisassemblyObject(a).size;
			
			machine.cpu.addBreakpoint(a);
			machine.cpu.update(1);
			if (machine.cpu.pc == a) {
				machine.cpu.removeBreakpoint(a);
			}
			
			return reviewLine();
		}
		
		private function step(addr : String = null) : String {
			var previousState : Object = null;
			
			if (addr != null) {
				var a : uint = getAddr(addr);
				machine.cpu.addBreakpoint(a);
				machine.cpu.update(1);
				if (machine.cpu.pc == a) {
					machine.cpu.removeBreakpoint(a);
				}
			} else {
				previousState = machine.cpu.preChangeCheck();
				var r : uint = machine.cpu.step();
			}
			refreshVideo();
			
			return machine.cpu.postChangeCheck(previousState) + "\n" + reviewLine();
		}
		
		private function toggleBreakpoint(addr:String) : String {
			if (addr == "list") {
				return machine.cpu.getBreakpointList();
			}
			var a : uint = getAddr(addr);
			
			if (machine.cpu.isBreakpoint(a)) {
				machine.cpu.removeBreakpoint(a);
			} else {
				machine.cpu.addBreakpoint(a);
			}
			
			return "";
		}
		  		
		
		private function setReg(reg : String, value : String) : String {
			machine.cpu.setRegister(reg, getAddr(value));
			if (reg == "pc") {
				return machine.disassembleLine(machine.cpu.pc).dis + "\n";
			}
			return "";
		}
		
		
		private function getReg(reg : String) : String {
			return reg + ":" + EMFUtils.getHex16(machine.cpu.getRegister(reg));
		}
		
		private function getAddr(addr : String) : uint {
			if (addr == null) {
				return machine.cpu.pc;	
			}
			//
			if (addr.match(/[a-f]/) != null) {
				return parseInt(addr, 16);
			}
			if (addr.substr(-1).toLowerCase() == "h") {
				return parseInt(addr, 16);
			}
			if (addr.substr(0,2).toLowerCase() == "0x") {
				return parseInt(addr.substr(2), 16);
			}
			if (addr.substr(0,1).toLowerCase() == "$") {
				return parseInt(addr.substr(1), 16);
			}
			if (addr.substr(-1).toLowerCase() == "b") {
				return parseInt(addr, 2);
			}
			return uint(addr);
		}
		
		
		private function assemble(code : String) : String {
			return machine.cpu.getAssemblerHex(code);
			
		}
			
		private function disassemble(addr : String = null, addrEnd : String = null) : String {
			var s : String = "";
			var lineLimited : uint = 250;
			var a : uint = getAddr(addr);
			var end : uint = getAddr(addrEnd);
			var lastText : String = "";
			
			var obj : Object;
			for(var i: int = 0;;++i) {
				obj = machine.disassembleLine(a);
				
				lastText += obj.dis;
				DebugConsole.log(0, obj.dis);
				a += obj.size;
				
				if (addrEnd != null) {
					if (a >= end) {
						break;
					}
				} else if (i>=5) {
					break;
				}
			}
			
			System.setClipboard(lastText);
			return "";
		}
		
		private function cpu() : String {
			return machine.cpu.toString();
		}
		
		private function dump(addr : String) : String {
			// Print cpu and machine state
			// serial to printable (rather than XML)
			var r : uint = machine.bus.read8(getAddr(addr));
			return addr + " : " + r;
		}
		
		private function fillMemory(addr : String, length : String = "1", byte : String = "0") : String {
			var a : uint = getAddr(addr);
			var numBytes : uint = getAddr(length);
			
			for(var i : uint = a;i<a + numBytes; ++i) {
				machine.bus.write8(i, uint(byte));	
			}
			refreshVideo();
			return null;
		}
		
		private function hexdump(addr : String=null, rowCount : String = "5") : String {
			// Print line of 16 hex values
			var address : uint = getAddr(addr);
			var rows : uint = getAddr(rowCount);
			
			return machine.hexLine(address, uint(rows));
		}
		
		private function read8(addr : String) : String {
			var r : uint = machine.bus.read8(getAddr(addr));
			return addr + " : " + r;
		}
		
		private function write8(addr : String, data : String) : String {
			machine.bus.write8(getAddr(addr), getAddr(data));
			refreshVideo();
			
			return addr + " : " + data;
		}

		final private function updateMe(e:Event):void						//main loop - calls engine.update(dt) - dt is time between frame updates
		{
			if (running) {
				//calculate difference in time
				var currentTime:Number = getTimer();
				var dt:Number = (currentTime - lastUpdateTime) / 1000;
				lastUpdateTime
				
				if (true || dt > 1/60) {
					dt = 1/60;
				}
				
				timecum += dt;
				
				EMFDevice.getDeviceCpu("maincpu").update(dt);
				//
				if (machine.cpu.isBreakpoint(machine.cpu.pc)) {
					DebugConsole.log(0, "Breakpoint hit at "+EMFUtils.getHex16(machine.cpu.pc));
					DebugConsole.log(0, machine.disassembleLine(machine.cpu.pc).dis);
					stopSimulator();
					DebugConsole.show();
				}
				
				refreshVideo();
			}
			//lastUpdateTime = currentTime;
			
			//update engine
			//engine.update(dt);
		}
		
	}
}