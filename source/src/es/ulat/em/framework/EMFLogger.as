package es.ulat.em.framework
{
	// Outputs to C:\Users\steev\AppData\Roaming\Macromedia\Flash Player\Logs
	public class EMFLogger
	{
		public static const logStartAt : int = 0;
		public static const logEndAt : int = 570000;//260000;
		public static var logCount : int = 0;
		public static var isLogger : Boolean = true;
		
		public static function message(msg : String) : void
		{
			if (logCount > logEndAt) {
				return;
			}
			if (isLogger && logCount >= logStartAt) {
				trace(logCount + ": "+ msg);
				if (logCount == 27) {
					msg ="";
				}
			}
			if (++logCount == logEndAt) {
				closeLog();
			}
		}
		
		public static function closeLog() : void {
			// NOP
		}
	}
}