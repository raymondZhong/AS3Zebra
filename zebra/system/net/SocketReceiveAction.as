package zebra.system.net 
{
	import zebra.directEvent.DirectEventAction;
	import zebra.system.collections.FlashBytesReader;

	public class SocketReceiveAction extends DirectEventAction
	{
		
		public function SocketReceiveAction() 
		{
			
		}
		
		public function get bytesReader():FlashBytesReader {
			  return  FlashBytesReader(this.eventParameter["bytesReader"]);
			}
		
	}

}