package zebra.events 
{
	import flash.events.Event;
	import zebra.system.collections.FlashBytesReader;
	
	/**
	 * ...
	 * @author raymond
	 */
	public class GameSocketEvent extends Event 
	{
		
		public function GameSocketEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		static public const CONNECTSUCCESS:String = "connectSuccess";
		static public const CLOSE:String = "close";
		
		static public const IOERROR:String = "ioerror";
		static public const SECURITYERROR:String = "securityerror";
		
		static public const COMMANDREADER:String = "commandreader";
		
		public var bytesReader:FlashBytesReader;
		
		public override function clone():Event 
		{ 
			return new GameSocketEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameSocketEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}