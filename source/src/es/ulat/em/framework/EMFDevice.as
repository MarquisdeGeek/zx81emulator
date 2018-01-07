package es.ulat.em.framework
{

	public class EMFDevice
	{
		private var name : String;
		private static var deviceList : Object;
			
		{
			deviceList = new Object();
		}
		
		public function EMFDevice(name_ : String)
		{
			name = name_;
			
			deviceList[name] = this;
		}
		
		// init is called after ctor of all items, so that it can
		// use getDeviceCpu etc
		public function initialize() : void {
			
		}

		public function toString() : String {
			var s : String = "Device : "+name+"\n";
			return s;
		}
		
		public static function getDevice(name_ : String) : EMFDevice {
			return deviceList[name_];
		}
		
		public static function getDeviceBus(name_ : String) : EMFMainBus {
			return deviceList[name_] as EMFMainBus;
		}
		
		public static function getDeviceCpu(name_ : String) : EMFCPU {
			return deviceList[name_] as EMFCPU;
		}
		
	}
}