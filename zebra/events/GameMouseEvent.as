package zebra.events 
{
	import flash.events.Event;
	import flash.geom.Point;
	
 
	public class GameMouseEvent extends Event 
	{
		
		static public const BitmapClick:String = "bitmapClick";
		static public const BitmapMove:String = "bitmapMove";
		static public const BitmapHover:String = "bitmapHover";
		static public const BitmapOut:String = "bitmapOut";
		static public const BitmapDown:String = "bitmapDown";
		static public const BitmapUp:String = "bitmapUp";
		
		static public const UpdateMousePosition:String = "updateMousePosition";
		
		public function GameMouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		public var prevPoint:Point= new Point(0,0);
		public var currentPoint:Point= new Point(0,0);
		
		public function get changePoint():Point {
			return new Point(currentPoint.x - prevPoint.x, currentPoint.y - prevPoint.y);
		}
		
		
		public override function clone():Event 
		{ 
			return new GameMouseEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameMouseEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}