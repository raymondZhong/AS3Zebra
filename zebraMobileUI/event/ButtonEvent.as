package zebraMobileUI.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author raymond
	 */
	public class ButtonEvent extends Event 
	{
		
		static public const TRIGGER:String = "trigger";
		
		public function ButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ButtonEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}