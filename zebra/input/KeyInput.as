package zebra.input 
{
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	import zebra.events.KeyInputEvent;
	import zebra.Game;

 
	
	[Event(name="activeKeyGroup",type="zebra.events.KeyInputEvent")]
	[Event(name = "releaseKeyGroup", type = "zebra.events.KeyInputEvent")]
	
	/**
	 * KeyCode,支持热键组合
	 */
	public class KeyInput extends EventDispatcher
	{
		
		/**
		 * 键盘操作失效间隔时间[毫秒]
		 */
		public var DestroyIntervalTime:int = 380;
		
		public function KeyInput() 
		{
			_keyInputTaskAction = new KeyInputTaskAction();
			Game.TimeUpdate.addTaskAction(_keyInputTaskAction);
			Game.graphicsDeviceManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,_keydownLogic)
		}
		
		private var _keyInputTaskAction:KeyInputTaskAction;
		
		private function _keydownLogic(e:KeyboardEvent):void 
		{
			_keyInputTaskAction.activeKeyGroupTime = getTimer();
			_keyInputTaskAction.keysIntValue.push(e.keyCode)
		}
		
       /**
        * @example  67_1 or 67 [keycode_keepdownCount]  67_2,79_1,12_1,34_1 
        * @param	data
        * @return
        */
		private function  _toKeyGroupData(data:*):Vector.<KeyInputData> {
			    var keygroupData:Vector.<KeyInputData> = new Vector.<KeyInputData>();
				if (data is String) {
					 var arrayCode:Array = String(data).split(",") 
					 for (var i:int = 0; i <arrayCode.length; i++) 
					 {
						 var currentkeydata:Array = String(arrayCode[i]).split("_");
						     if (currentkeydata.length == 1) currentkeydata.push(1);
						 var keyinputdata:KeyInputData = new KeyInputData();
						     keyinputdata.keyCode = currentkeydata[0];
							 keyinputdata.keepDownCount = currentkeydata[1];
							 keygroupData.push(keyinputdata);
					 }
				   }  
			 return  keygroupData;
			}
		 
		/**
		 * 匹配按键数据
		 * @param	listenKeyGroupData
		 * @param	matchData
		 * @return
		 */	
		public function  matchKeyGroupData(listenKeyGroupData:Vector.<KeyInputData>, matchData:*):Boolean {
			    var data:Vector.<KeyInputData>;
				if (matchData is String) { 
					 data = _toKeyGroupData(matchData);
				     }else {
					 data = matchData;
					}
				if (listenKeyGroupData.length != data.length) return false;
			    for (var i:int = 0; i < listenKeyGroupData.length; i++) 
				{
					if (listenKeyGroupData[i].keyCode != data[i].keyCode ||  listenKeyGroupData[i].keepDownCount<data[i].keepDownCount) {
						  return false;
						}
				}
				return true;
			}
		
		
	}

}