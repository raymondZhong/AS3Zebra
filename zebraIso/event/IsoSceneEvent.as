package zebraIso.event 
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	
	public class IsoSceneEvent extends Event 
	{
		
		static public const Pick:String = "pick";
		static public const SelectActive:String = "selectActive";
		static public const SelectExecute:String = "SelectExecute";
		static public const SelectRelease:String = "SelectRelease";
		
		public var pickPosition:Vector3D;
		
		/**
		 * 挑选的单元格
		 */
		public var pickCell:Vector3D;
		
		public var selectIsoBound:IsoBound;
		
		
		public function IsoSceneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new IsoSceneEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IsoSceneEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}