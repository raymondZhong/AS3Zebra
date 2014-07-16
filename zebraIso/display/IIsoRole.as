package zebraIso.display
{
	import flash.events.IEventDispatcher;
	[Event(name="move",type="IsoEngine.event.IsoRoleEvent")]
	[Event(name="stopmove",type="IsoEngine.event.IsoRoleEvent")]
	
	public interface IIsoRole extends IEventDispatcher
	{
		function move(pos:Array):void;
		
		function stopMove():void;
		/**
		 * 当前运动方向
		 */
		function get currentDirection():int;
	
	}

}