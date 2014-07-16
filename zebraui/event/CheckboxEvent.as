package zebraui.event 
{
	import flash.events.Event;

	public class CheckboxEvent extends Event 
	{
		
		public function CheckboxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public var selected:Boolean;
		public var text:String;
		public var value:*;
		
		static public const Select:String = "select"; 
		
		public override function clone():Event 
		{ 
			return new CheckboxEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CheckboxEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}