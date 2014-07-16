package zebraIso.display
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.display.animation.IsoAnimation;
	import zebraIso.event.IsoRoleEvent;
	
	[Event(name="move",type="zebraIso.event.IsoRoleEvent")]
	[Event(name="stopmove",type="zebraIso.event.IsoRoleEvent")]
	
	public class IsoRole extends IsoContainer implements IIsoRole
	{
		private var animation:IsoAnimation;
		private var _IsMoved:Boolean;
		private var _currentDirection:int;
		public function IsoRole(width:Number = 0, height:Number = 0, length:Number = 0)
		{
			super(width, height, length);
			animation = new IsoAnimation(this);
			//初始化角色的方位
			_currentDirection = 8;
		}
		
		public function get currentDirection():int {
			   return _currentDirection;
			}
		
		//增加移动节点。
		public function move(pos:Array):void
		{
			pos.shift();
			for (var i:int = 0; i < pos.length; i++)
			{
				animation.moveTo(pos[i].x, pos[i].y);
			}
			animation.moveHandler = roleMoveHandler;
			animation.stopMoveHandler = stopMoveHandler;
			animation.start();
		}
		
		public function stopMove():void
		{
			animation.stopMove();
		}
		
		private function stopMoveHandler(currentDir:int,prevPosition:Vector3D, currentPosition:Vector3D,cell:Vector3D):void
		{
			// layout.world.moveViewPort(prevPosition.x - currentPosition.x, prevPosition.z - currentPosition.z);
			// layout.world.lookAt(currentPosition);
			var event:IsoRoleEvent = new IsoRoleEvent(IsoRoleEvent.STOPMOVE);
				event.currentPosition = currentPosition;
				event.currentCell = cell;
				event.currentDir = currentDir;
				dispatchEvent(event);
		}
		
		private function roleMoveHandler(currentDir:int, nextDir:int, prevPosition:Vector3D,currentPosition:Vector3D,cell:Vector3D,isUpdateNextStep:Boolean):void
		{
			// if(prevPosition)layout.world.moveViewPort(prevPosition.x - currentPosition.x, prevPosition.z - currentPosition.z);
			layout.world.lookAt(currentPosition);
			if (isUpdateNextStep) {
				  setIsoBound(new IsoBound(cell));
				  layout.sortElements(this);
				}
			_currentDirection = currentDir;
			
			var event:IsoRoleEvent = new IsoRoleEvent(IsoRoleEvent.MOVE);
				event.currentPosition = currentPosition;
				event.currentCell = cell;
				event.currentDir = currentDir;
				event.IsUpdateNextStep = isUpdateNextStep
				event.nextDir = nextDir;
				dispatchEvent(event);
			
		}
	
	}

}