package zebraIso.event 
{
	import flash.events.Event;
	

	public class IsoLoaderEvent extends Event 
	{
		static public const PROGRESS:String = "progress";
		static public const COMPLETE:String = "complete";
		static public const Errors:String = "error";		
		
		public function IsoLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public var progress:Number;
		public override function clone():Event 
		{ 
			return new IsoLoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IsoLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}