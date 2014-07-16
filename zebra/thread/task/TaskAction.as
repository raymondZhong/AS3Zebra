package zebra.thread.task 
{
	import flash.events.EventDispatcher;
	import zebra.events.TaskActionEvent;
	
	[Event(name = "complete", type = "zebra.events.TaskActionEvent")]
	[Event(name = "dispose", type = "zebra.events.TaskActionEvent")]
	[Event(name = "stop", type = "zebra.events.TaskActionEvent")]
	
	public class TaskAction extends EventDispatcher implements ITaskAction 
	{
	
		static internal var _tid:int = 0;
		private var _actionid:String;
		private var _isStart:Boolean; 
		private var _isFinish:Boolean;
		internal var _task:Task;
		
		
		
		public function TaskAction() 
		{
           _actionid = String(_tid++);
		}
		 
		public function get IsStart():Boolean { return _isStart; }
		public function get IsFinish():Boolean {return _isFinish}
		public function finish():void { 
			_isFinish = true;
			this.dispatchEvent(new TaskActionEvent(TaskActionEvent.COMPLETE));
			}
		
		internal function  initializte():void{}
		
		public function set id(value:String):void { 
			   _actionid = value+ "-"+_actionid;
		}
			
		public function get id():String { return _actionid; }
		
		public function get task():Task 
		{
			return _task;
		}
		
		public function execute():void {
			_isStart = true;
			_isFinish = false;
		}
		
		public function  dispose():void {
			this.dispatchEvent(new TaskActionEvent(TaskActionEvent.DISPOSE));
			}
		 
		public function  stop():void {
			this.dispatchEvent(new TaskActionEvent(TaskActionEvent.STOP));
			}
	}

}
