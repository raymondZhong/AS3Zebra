package zebra.core 
{
	import flash.events.Event;
	import flash.utils.getTimer;
	import zebra.Game;
	import zebra.thread.task.TaskAction;
	
	public class GameTimeUpdate 
	{
		 
		
		private var _timeNodeList:Vector.<GameTimeNode>;
		
		public function GameTimeUpdate() 
		{
			_timeNodeList= new Vector.<GameTimeNode>();
		    //Game.graphicsDevice.addEventListener(Event.ENTER_FRAME, _updateLogic);	
		}
		 
		private function _updateLogic(e:Event):void 
		{
			//for each( var node:GameTimeNode in  _timeNodeList) {
			//}
			var node:GameTimeNode;
			for (var i:int = 0; i <_timeNodeList.length ; i++)
			{
				node = _timeNodeList[i];
				node.currentTime = getTimer();
				if ( node.currentTime- node.startTime >= node.intervalTime) {
					node.taskAction.execute();
					node.startTime = node.currentTime;
				if (node.autoremove) removeTaskAction(node.taskAction);
				}
			}
				
		}
		
		
		
		/**
		 * 添加一个Action, intervalTime 毫秒 默认FPS时间计算。
		 * @param	fn
		 * @param	intervalTime
		 */
		public function  addTaskAction(taskAction:TaskAction, intervalTime:uint = 0):void {
			      if (intervalTime == 0) intervalTime  = 1000 / Game.graphicsDeviceManager.fps;
			     _addTaskActionLogic(taskAction, intervalTime, false);
		}
		 
		
		
		public function  addOnceTaskAction(taskAction:TaskAction, intervalTime:uint = 0):void {
				 if (intervalTime == 0) intervalTime  = 1000 / Game.graphicsDeviceManager.fps;
				 _addTaskActionLogic(taskAction, intervalTime, true);
			}
			
		private function _addTaskActionLogic(taskAction:TaskAction, intervalTime:uint, autoremove:Boolean ):void {
			    if(!hasTaskAction(taskAction)){
			     var node:GameTimeNode = new GameTimeNode();
					node.startTime =  getTimer();
					node.currentTime = node.startTime;
					node.intervalTime = intervalTime;
					node.taskAction = taskAction;
					node.autoremove = autoremove;
			        _timeNodeList.push(node);
					if (_timeNodeList.length == 1) {
					 Game.graphicsDeviceManager.stage.addEventListener(Event.ENTER_FRAME, _updateLogic);	
				   }
				}
			}	
		 
		public function hasTaskAction(taskAction:TaskAction):Boolean {
			    for each ( var item:GameTimeNode  in  _timeNodeList) {
					    if (item.taskAction == taskAction) return true;
					}
				return false;
			}	
			
		 
			
		public function removeTaskAction(taskAction:TaskAction):void {
			for (var i:int = _timeNodeList.length - 1; i >= 0; i-- ){
				if (_timeNodeList[i].taskAction == taskAction) {
					  taskAction.dispose();
					  _timeNodeList.splice(i, 1);
					  if (_timeNodeList.length == 0)
					  Game.graphicsDeviceManager.stage.removeEventListener(Event.ENTER_FRAME, _updateLogic);
					 }
			}
		}
	}

}
import zebra.thread.task.TaskAction;

 internal class GameTimeNode {
		public function GameTimeNode() { };
		internal var  startTime:uint;
		internal var  currentTime:uint;
		internal var  intervalTime:uint;
		internal var  taskAction:TaskAction;
		internal var  autoremove:Boolean;
	}