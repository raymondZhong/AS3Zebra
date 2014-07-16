package zebraIso.display.animation
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import zebraIso.data.IsoConfig;
	import zebraIso.display.IsoContainer;
	import zebraIso.event.IsoAnimationEvent;
	import zebraIso.util.IsoUtil;
	import zebra.events.TaskEvent;
	import zebra.thread.task.Task;
	
	
	
	
	[Event(name="play",type="zebraIso.event.IsoAnimationEvent")]
	[Event(name="stop",type="zebraIso.event.IsoAnimationEvent")]
	
	public class IsoAnimation extends EventDispatcher
	{
		private var _target:IsoContainer;
		private var _aniId:uint;
		private var _startIsoX:int;
		private var _startIsoY:int;
		private var _startIsoZ:int;
		private var _moveIndex:int;
		

		
		private var _posMoveStep:Vector.<IsoAnimationMoveStep>;
		private var _prevCell:Vector3D;
		
		//步长 
		private var _stepMax:int;
		public var stopMoveHandler:Function;
		public var moveHandler:Function;
		
		
		public function IsoAnimation(target:IsoContainer)
		{
			_stepMax = 15;
			_target = target;
			_startIsoX = _target.IsoX;
			_startIsoY = _target.IsoY;
			_startIsoZ = _target.IsoZ;
	
			
			_posMoveStep = new Vector.<IsoAnimationMoveStep>();
		}
		
		/**
		 * 移动到一个目的地
		 * @param	x
		 * @param	z
		 */
		public function moveTo(x:int,z:int):void
		{
			var currentDir:int;
			
			if (_posMoveStep.length == 0) {
				    currentDir = get45Dir(new Vector3D(_target.IsoX, _target.IsoY, _target.IsoZ),
											  new Vector3D(x, 0, z));
				}else {
					currentDir = get45Dir(_prevCell,
											  new Vector3D(x, 0, z));
				}
				
			if (Isslanting(currentDir)) 
			_stepMax = 20;
			else
			_stepMax = 15;
			
			_prevCell = new Vector3D(x, 0, z);
			var pos:Vector3D;
			for (var i:int = 1; i < _stepMax; i++)
			{
				var n:Number = linear(i, 0, 1, _stepMax);
				pos = new Vector3D(IsoConfig.IsoGridSize * (_startIsoX + n * (x-_startIsoX)),
											0,
											IsoConfig.IsoGridSize * (_startIsoZ + n * (z - _startIsoZ)));
				addNewIsoAnimationMoveStep(pos,currentDir);				
				
				if (i == _stepMax - 1 && n < 1) {
					 pos =  new Vector3D(IsoConfig.IsoGridSize * (_startIsoX + 1 * (x-_startIsoX)),
												0,
												IsoConfig.IsoGridSize * (_startIsoZ + 1 * (z-_startIsoZ)));
					 
					 addNewIsoAnimationMoveStep(pos,currentDir);
				}
			}
			
			_startIsoX = x; 
			_startIsoY = 0;
			_startIsoZ = z;
		}
		
		
		private function addNewIsoAnimationMoveStep(pos:Vector3D,currentDir:int):IsoAnimationMoveStep {			    
			var moveStep:IsoAnimationMoveStep = new IsoAnimationMoveStep();
				moveStep.position = pos;				
			 var cellPoint:Point = IsoUtil.screenToIsoGrid(IsoUtil.isoToScreen(pos));
				 moveStep.cell =  new Vector3D(cellPoint.x, 0, cellPoint.y);
				if (_posMoveStep.length > 0) {
					moveStep.isNextStep = isnextstep(_posMoveStep[_posMoveStep.length - 1].cell, moveStep.cell);
				}
				moveStep.dir = currentDir;
				_posMoveStep.push(moveStep);
				return moveStep;
			}
		
			
		private var prevPosition:Vector3D;	
		/**
		 *开始移动
		 */
		public function start():void {
			prevPosition = null;
			var event:IsoAnimationEvent;	
			if (_posMoveStep.length == 0) return;
				 _aniId = setInterval(function():void {				
					  if(_moveIndex<_posMoveStep.length){
						   var v:Vector3D = _posMoveStep[_moveIndex].position;
						    _target.setPosition(v);							
						   event = new IsoAnimationEvent(IsoAnimationEvent.PLAY);
						   event.prevPosition = prevPosition;
						   event.currentPosition = _posMoveStep[_moveIndex].position;
						   prevPosition = event.currentPosition;
						   event.currentCell = _posMoveStep[_moveIndex].cell;
						   event.currentDir =  _posMoveStep[_moveIndex].dir;
						   event.nextDir = _posMoveStep[Math.min(_moveIndex+1,_moveIndex)].dir;
						   event.IsUpdateNextStep = _posMoveStep[_moveIndex].isNextStep;  
						   if (moveHandler != null) moveHandler(event.currentDir,event.nextDir,event.prevPosition,event.currentPosition,event.currentCell,event.IsUpdateNextStep);
						   dispatchEvent(event);
						  _moveIndex++;
					 }else {
						 stopMove(); 
						 }
					 },10)
			}
			
		//45度的人物角度匹配 //后为正90度的值	
		private function  get45Dir(parentNode:Vector3D, node:Vector3D):int {
				//45°
				//左上  ↖
				if (parentNode.x-1 == node.x && parentNode.z - 1 == node.z) return 2;//1;
				//上    ↑
				if (parentNode.x == node.x && parentNode.z - 1 == node.z) return  3;//2;
				//右上  ↗
				if (parentNode.x + 1 == node.x && parentNode.z - 1 == node.z) return  6;// 3;
				//左    ←
				if (parentNode.x - 1 == node.x && parentNode.z  == node.z) return 1;// 4;
				//右    →
				if (parentNode.x + 1 == node.x && parentNode.z  == node.z) return 9; // 6;
				//左下  ↙
				if (parentNode.x-1 == node.x && parentNode.z+1  == node.z) return 4;//7;
				//下    ↓
				if (parentNode.x == node.x && parentNode.z+1  == node.z) return 7; //8;
				//右下  ↘
				if (parentNode.x+1 == node.x && parentNode.z+1  == node.z) return 8; //9;
				return 8;
			}
			
		//是否为斜角度	
		private function  Isslanting(num:int):Boolean {
			   if (num == 3 || num == 1 || num == 9 || num == 7) return false;
			   return true;
			}	
			
		private function isnextstep(parentPos:Vector3D, currentPos:Vector3D):Boolean {
			    return currentPos.x != parentPos.x || currentPos.y != parentPos.y || currentPos.z != parentPos.z;
			}
			
		/**
		 * 停止移动
		 */
		public function stopMove():void {
				
			     clearInterval(_aniId);	
				 
				 if (_posMoveStep.length > 0) {
				 var moveindex:int = Math.min(_posMoveStep.length-1,_moveIndex)
				 var event:IsoAnimationEvent = new IsoAnimationEvent(IsoAnimationEvent.STOP);
				     event.currentPosition = _posMoveStep[moveindex].position;
					 event.currentDir =  _posMoveStep[moveindex].dir;
					 event.currentCell =  _posMoveStep[moveindex].cell;
					 event.prevPosition = prevPosition;
					 event.currentPosition = _posMoveStep[moveindex].position;
					 prevPosition = event.currentPosition;
				    if(stopMoveHandler!=null)stopMoveHandler(event.currentDir,event.prevPosition,event.currentPosition,event.currentCell);
					dispatchEvent(event);
				 }

				 _moveIndex = 0;
				 _posMoveStep.length = 0;
				 _startIsoX = _target.IsoX;
				 _startIsoY = _target.IsoY;
				 _startIsoZ = _target.IsoZ;
			}
			
		private function linear(t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*t/d + b; 
		}
	
	}

}
import flash.geom.Point;
import flash.geom.Vector3D;

internal class IsoAnimationMoveStep {
	    public var position:Vector3D;
	    public var cell:Vector3D;
		public var dir:int;
		public var isNextStep:Boolean;
	
	}