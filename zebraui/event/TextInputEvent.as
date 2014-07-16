package zebraui.event
{
	import flash.events.Event;
	
	public class TextInputEvent extends Event
	{
		
		static public const TEXTINPUT:String = "textinput_change";
		
		public function TextInputEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var text:String;
		
		public override function clone():Event
		{
			return new TextInputEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("TextInputEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}