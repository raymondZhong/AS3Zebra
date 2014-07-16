package zebra.thread.task 
{
	import flash.events.EventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import zebra.events.TaskActionEvent;
	import zebra.events.TaskEvent;

	
	[Event(name = "complete", type = "zebra.events.TaskEvent")]
	[Event(name = "stop", type = "zebra.events.TaskEvent")]
	[Event(name = "error", type = "zebra.events.TaskEvent")]
	//[Event(name = "readycomplete", type = "zebra.events.TaskEvent")]
	
	public  class Task extends EventDispatcher
	{
		private var  _taskActionList:Vector.<TaskAction>;
		private var _isFinish:Boolean;
		private var _isStart:Boolean;	
		private var _IsStop:Boolean;		
		private var _insideTaskLine:Boolean;	    
		private var _intervalTaskAction:int=0;
		private var _concurrent:int;
		private var _executeIndex:int;
		private var _currentFinsihCount:int;
		
		public function get count():int {
			return _taskActionList.length;
			}
		
		public function Task() 
		{
			_taskActionList = new Vector.<TaskAction>();
			_insideTaskLine = false;
			_concurrent = 1;
			_IsStop = false;
		}
		 
		
		/**
		 * 间隔毫秒
		 * @param	intervalTaskAction
		 */
		public function start(intervalTaskAction:int = 0):void {
			  _intervalTaskAction = intervalTaskAction;
			  if(!_isStart){
				   _isStart = true;
				   if (_taskActionList.length == 0) {
					  _taskCompleteLogic();
				   }else {
					   var startTaskCount:int = _concurrent > _taskActionList.length?_taskActionList.length:_concurrent;
					   _executeIndex = startTaskCount - 1;
					   for (var i:int = 0; i <startTaskCount; i++) 
					   {
						  _taskActionList[i].execute();
					   }
				   }
			}
		}
		 
		public function get currentTaskAction():TaskAction {
			  if (_taskActionList.length > 0) {
				  return _taskActionList[0];
				  }
			  return null;
			}
		public  function  get IsFinish():Boolean { return _isFinish; }	

		/**
		 * 任务并发数
		 */		
		public function get concurrent():int 
		{
			return _concurrent;
		}
		
		/**
		 * 任务并发数
		 */
		public function set concurrent(value:int):void 
		{
			_concurrent = value;
		}
		
		/**
		 * 当前完成的任务数
		 */
		public function get currentFinsihCount():int 
		{
			return _currentFinsihCount;
		}
		
		public function get IsStop():Boolean 
		{
			return _IsStop;
		}
		
		
		public function addAction(action:TaskAction):void {
			action.addEventListener(TaskActionEvent.COMPLETE, _removeTaskActin)
			action._task = this;
		    _taskActionList.push(action);
		}
		
		private function _removeTaskActin(e:TaskActionEvent):void 
		{
			TaskAction(e.target).removeEventListener(TaskActionEvent.COMPLETE, _removeTaskActin)
			_currentFinsihCount++;
			 
			if (_currentFinsihCount == _taskActionList.length) {
				  _taskCompleteLogic();
				}else { 
				var nextTaskActionIndex:int = ++_executeIndex;
				if (nextTaskActionIndex <= _taskActionList.length - 1) {
					//trace("nextTaskActionIndex",nextTaskActionIndex)
					if (_intervalTaskAction == 0) {
					    _taskActionList[nextTaskActionIndex].execute();
					  }else {
						
						var id:uint = setTimeout(function():void {	
												if (_IsStop) return;
												 _taskActionList[nextTaskActionIndex].execute();		
												 clearTimeout(id);},
												 _intervalTaskAction);
						  }
					}
			}
		 
		}
			
		private function _taskCompleteLogic():void {
			      _isFinish = true;
				  _isStart = false;
				  _currentFinsihCount = 0;
				  _taskActionList = new Vector.<TaskAction>();
				  dispatchEvent(new TaskEvent(TaskEvent.COMPLETE));
			}
		
		public function stop():void {
			     stoplogicHandler(true);
			   //if(action.IsFinish) throw new Error ("taskAction is running");
			}
		

			
		private function stoplogicHandler($dispatch:Boolean):void {
					 _IsStop = true;
					 for each( var action:TaskAction in _taskActionList) {
						 TaskAction(action).stop();
						 action.removeEventListener(TaskActionEvent.COMPLETE,_removeTaskActin)
					 } 
					_taskActionList =  new Vector.<TaskAction>();
					_isFinish = false;
					_isStart = false;
					_currentFinsihCount = 0;
					if($dispatch){dispatchEvent(new TaskEvent(TaskEvent.STOP))};
				}
			
		public function removeAction(action:TaskAction):void {
			 throw  new Error("taskAction  auto remove");
			}	
			
		public function clear():void {
			  for (var i:int = 0; i < _taskActionList.length; i++) 
			  {
				  _taskActionList[i].removeEventListener(TaskActionEvent.COMPLETE, _removeTaskActin)
			  }
			  _isFinish = false; 
			  _currentFinsihCount = 0;
			  _taskActionList.length = 0;
			}
			
		/**
		 * 抛出错误
		 * @param	message
		 */
		public function errorMessage(message:String):void {
				 stoplogicHandler(false);
				 errorMessageInfo = message;
				 var error:TaskEvent = new TaskEvent(TaskEvent.ERROR);
					 error.errorMessage = message;
					 //throw new Error(message);
					 dispatchEvent(error);
		}
		
		public var errorMessageInfo:String;
		
		/**
		 * 完成
		 */
		public function finish():void {
				_taskCompleteLogic();
			}
	}

}
 

 