package zebraui.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ContainerEvent extends Event 
	{
		
		public function ContainerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		static public const SOURCEUPDATE:String = "SourceUpdate";
		
		public override function clone():Event 
		{ 
			return new ContainerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ContainerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}