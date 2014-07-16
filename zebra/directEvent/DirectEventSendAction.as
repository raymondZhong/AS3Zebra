package zebra.directEvent
{
	import zebra.Game;
	import zebra.thread.task.TaskAction;
	
	/**
	 * 发送消息处理逻辑
	 */
	internal class DirectEventSendAction extends TaskAction
	{
		
		private var _listenerData:DirectEventListenerPool;
		private var _eventName:String;
		private var _eventData:DirectEventParameter;
		private var _scope:String;
		
		public function DirectEventSendAction(listenerData:DirectEventListenerPool,eventName:String,eventData:DirectEventParameter,scope:String)
		{
			_listenerData = listenerData;
			this._eventName = eventName;
			this._scope = scope;
			eventData.eventName = eventName;
			eventData.scope = scope;
			this._eventData = eventData;
			super()
		}
		
		override public function execute():void
		{
			super.execute();
			var len:int = _listenerData.getCount(_scope);
			var type:String;
			for (var i:int = 0; i < len; i++)
			{
				if (_listenerData.getRegisterEventName(_scope)[i] == _eventName)
				{
					if (_listenerData.getRegisterEventAction(_scope)[i] is Function)
					{
						type = "Function";
						_listenerData.getRegisterEventAction(_scope)[i](_eventData);
					}
					if (_listenerData.getRegisterEventAction(_scope)[i] is DirectEventAction)
					{
						type = "DirectEventAction";
						DirectEventAction(_listenerData.getRegisterEventAction(_scope)[i]).eventParameter = _eventData;
						DirectEventAction(_listenerData.getRegisterEventAction(_scope)[i]).execute();
					}
					if (Game.IsDebugMode)
						trace("[DirectEvent recevie: " + type + " " + _eventName + "]")
				}
			}
			
			this.finish();
		
		}
		
		public function get eventName():String 
		{
			return _eventName;
		}
		
		public function get eventData():DirectEventParameter 
		{
			return _eventData;
		}
		
		public function get scope():String 
		{
			return _scope;
		}
		
		public function set scope(value:String):void 
		{
			_scope = value;
		}
	}

}