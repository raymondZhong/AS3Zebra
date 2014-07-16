package zebra.debug 
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import zebra.directEvent.DirectEventParameter;
	import zebra.Game;
	import zebra.thread.task.TaskAction;
	/**
	 * ...
	 * @author raymond
	 */
	 public class DebugCommand 
	{
		
		static public const DebugCommandChannel:String = "DebugCommandChannel";
		
		 private var _commandList:Dictionary = new Dictionary();
		
		public function DebugCommand() 
		{
			
		}
		
		public function installConsole(stage:Stage):void { 
				stage.addChild(new DebugConsoleGUI()); 
		} 
		 
		/**
		 * 追加一条指令
		 * @param	command
		 * @param	action
		 */
		 public function append(command:String, action:*):void {
			_commandList[command] = action;			
			Game.DirectEvent.receive(command,runCommandHandler,DebugCommandChannel);
		}
		
		 private function runCommandHandler(e:DirectEventParameter):void 
		{
			var command:String = e.eventName
			if(_commandList[command]!=null){
			
			if (_commandList[command] is TaskAction) {
				TaskAction(_commandList[command]).execute();
				}else if (_commandList[command] is Function) {
					_commandList[command]();
				}
			
			}
			
		}
		
	}

}