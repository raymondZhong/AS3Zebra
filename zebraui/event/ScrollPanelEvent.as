package zebraui.event 
{
	import flash.events.Event;
	
	public class ScrollPanelEvent extends Event 
	{
		
		public function ScrollPanelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public var processWidth:Number;
		public var processHeight:Number;
		static public  const DRAGING:String = "draging";
		
		public override function clone():Event 
		{ 
			return new ScrollPanelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScrollPanelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}