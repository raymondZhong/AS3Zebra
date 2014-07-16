package zebra.input
{
	import flash.utils.getTimer;
	import zebra.events.KeyInputEvent;
	import zebra.Game;
	import zebra.thread.task.TaskAction;
	
	internal class KeyInputTaskAction extends TaskAction
	{
		
		public function KeyInputTaskAction()
		{
		   keysIntValue = new Vector.<int>();
		}
		
		public var keysIntValue:Vector.<int>;
		
		private var _activeKeyGroupTime:int;
		
		public function get activeKeyGroupTime():int
		{
			return _activeKeyGroupTime;
		}
		
		/**
		 * 鼠标操作的时候 记录新时间
		 */
		public function set activeKeyGroupTime(value:int):void
		{
			if (_activeKeyGroupTime == 0)
			{
				//INFO: Create New KeyGroup 新的热键组合
				var  createEvent:KeyInputEvent = new KeyInputEvent(KeyInputEvent.ACTIVEKEYGROUP)
				Game.keyInput.dispatchEvent(createEvent)
			}
			_activeKeyGroupTime = value;
		}
		
		override public function execute():void
		{
			super.execute();
			if (_activeKeyGroupTime > 0)
			{
				if (getTimer() - _activeKeyGroupTime > Game.keyInput.DestroyIntervalTime)
				{
					
				
					//INFO: Release Key Group 释放热键组合
					var releaseEvent:KeyInputEvent = new KeyInputEvent(KeyInputEvent.RELEASEKEYGROUP);
					    releaseEvent.keyGroupData = 	_createKeyInpuDataList(keysIntValue);
						releaseEvent.keysIntValue =  keysIntValue;
				    Game.keyInput.dispatchEvent(releaseEvent)
					
					
					
					_activeKeyGroupTime = 0;
					keysIntValue = new Vector.<int>();
				}
				
			}
		
		}
		
		/**
		 * KEYS  转换成  KeyInputData List
		 * @param	keys
		 * @return
		 */
		private function  _createKeyInpuDataList(keys:Vector.<int>):Vector.<KeyInputData> {
				var  keydata:Vector.<KeyInputData> = new Vector.<KeyInputData>();				 
				 var  preveKeyCode:int;
				 var  currentKeyCode:int;				 
				 for each (var keycode:int in keys) {
					  var node:KeyInputData = new KeyInputData();
						 if (currentKeyCode == 0) {						
								 currentKeyCode = keycode;
								 node.keyCode = currentKeyCode;
								 node.keepDownCount  = 1;
								 keydata.push(node);
							 }
						 if (currentKeyCode != 0) {
								preveKeyCode = currentKeyCode;
								currentKeyCode = keycode;
								if (preveKeyCode == currentKeyCode) {
									  keydata[keydata.length - 1].keepDownCount ++;
									}else {
									   node.keyCode = currentKeyCode;
									   node.keepDownCount  = 1;
									   keydata.push(node);
									}
						}
				  }
			  return keydata;
			}
	
	}

}