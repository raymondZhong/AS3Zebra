package zebra.events
{
	import flash.events.Event;
	
	public class TaskActionEvent extends Event
	{
		
		public function TaskActionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		static public const COMPLETE:String = "complete";
		static public const STOP:String = "stop";
		static public const DISPOSE:String = "dispose";
	}

}