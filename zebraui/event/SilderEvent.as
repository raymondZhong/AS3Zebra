package zebraui.event 
{
	import flash.events.Event;
	
	public class SilderEvent extends Event 
	{
		
		public function SilderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);	
		}
		public var process:Number;
		public var currentValue:int;
		static public  const DRAGING:String = "draging";
		static public  const PROGRESS:String = "progress";
	}

}