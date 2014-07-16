package zebra.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BitmapBatchEvent extends Event 
	{
		static public const DISPOSE:String = "dispose";		
		static public const BITMAPCLICK:String = "bitmapClick";
		static public const BITMAPDOWN:String = "bitmapDown";
		static public const BITMAPHOVER:String = "bitmapHover";
		static public const BITMAPOUT:String = "bitmapOut"; 
		
		public function BitmapBatchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new BitmapBatchEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("BitmapBatchEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}