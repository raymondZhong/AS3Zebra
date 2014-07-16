package zebraIso.event 
{
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class IsoAnimationEvent extends Event 
	{
		static public const PLAY:String = "play";	
		static public const STOP:String = "stop";
		
		/**
		 * 格子坐标
		 */
		public var currentCell:Vector3D;
		
		public var prevPosition:Vector3D;
		/**
		 * 像素坐标
		 */
		public var currentPosition:Vector3D;
		
		/**
		 * 方向
		 */
		public var currentDir:int;
		
		/**
		 * 下一个像素坐标的方向
		 */
		public var nextDir:int;
		
		/**
		 * 是否移动到下一个格子
		 */
		public var IsUpdateNextStep:Boolean;
		
		
		public function IsoAnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new IsoAnimationEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IsoAnimationEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}