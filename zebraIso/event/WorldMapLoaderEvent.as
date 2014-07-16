package zebraIso.event 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import zebraIso.display.IsoSprite;
	
	public class WorldMapLoaderEvent extends Event 
	{
		
		
		
		static public const ELEMENTCHILDCOMPLETE:String = "elementChildComplete";
		static public const COMPLETE:String = "complete";
		
		
		public var element:Vector.<DisplayObject>;
		public var container:IsoSprite;
		
		public function WorldMapLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new WorldMapLoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WorldMapLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}