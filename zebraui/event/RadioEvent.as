package zebraui.event 
{
	import flash.events.Event;

	public class RadioEvent extends Event 
	{
		
		public function RadioEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public var selected:Boolean;
		public var text:String;
		public var value:*;
		
		static public const Select:String = "select"; 
		
		public override function clone():Event 
		{ 
			return new RadioEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("RadioEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}