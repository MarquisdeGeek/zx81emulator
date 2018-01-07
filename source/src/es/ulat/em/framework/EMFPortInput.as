package es.ulat.em.framework
{
	public class EMFPortInput extends EMFDevice
	{
		public function EMFPortInput(name_:String)
		{
			super(name_);
		}
		
		public function read8(port : uint) : int {
			return 0;
		}
	}
}