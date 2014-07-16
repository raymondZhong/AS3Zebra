package zebraui.event
{
	import flash.events.Event;
	
	public class ColorPickerEvent extends Event
	{
		static public const CompleteColorSelection:String = "CompleteColorSelection";
		
		public function ColorPickerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new CheckboxEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("ColorPickerEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}