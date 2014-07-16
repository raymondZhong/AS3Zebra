package zebraIso.event 
{
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class IsoRoleEvent extends Event 
	{
		static public const MOVE:String = "move";	
		static public const STOPMOVE:String = "stopmove";
		
		
		public var currentPosition:Vector3D;
		public var currentCell:Vector3D;
		public var currentDir:int;
		public var nextDir:int;
		
		/**
		 * 是否移动到下一个格子
		 */
		public var IsUpdateNextStep:Boolean;
		
		public function IsoRoleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new IsoRoleEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IsoRoleEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}