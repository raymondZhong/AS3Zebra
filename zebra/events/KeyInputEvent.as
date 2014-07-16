package zebra.events 
{
	import flash.events.Event;
	import zebra.input.KeyInputData;
	
	/**
	 * ...
	 * @author 
	 */
	public class KeyInputEvent extends Event 
	{
		
		public function KeyInputEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			keyGroupData = new Vector.<KeyInputData>();
		} 
		
		/**
		 * 热键组合值
		 */
		public var keyGroupData:Vector.<KeyInputData>;
		
		public var keysIntValue:Vector.<int>;
		
		/**
		 * 释放热键组合[抛出热键组合]
		 */
		static public const RELEASEKEYGROUP:String = "releaseKeyGroup";
		
		/**
		 * 激活热键组合程序
		 */
		static public const ACTIVEKEYGROUP:String = "activeKeyGroup";
		
		public override function clone():Event 
		{ 
			return new KeyInputEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("KeyInputEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}