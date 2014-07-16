package zebra.events 
{
	import flash.events.Event;
 
	public class TaskEvent extends Event
	{
 
		public function TaskEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var errorMessage:String;
		
		//static public const READYCOMPLETE:String = "readycomplete";
		static public const COMPLETE:String = "complete";
		static public const STOP:String = "stop";
		static public const ERROR:String = "error";
		
	}

}