package zebra.directEvent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import zebra.events.TaskActionEvent;
	import zebra.Game;
	
	//TODO: 加入异步事件触发	
	/**
	 * AS3 Message 是一个同步的事件触发
	 */
	public class DirectEventManager  implements IDirectEventManager
	{
		
		private var _listenerData:DirectEventListenerPool;
		private var _destroyData:DirectEventDestroyPool;
		private var _directScope:DirectEventScope;
		
		public function DirectEventManager()
		{
			_directScope = new DirectEventScope();
			_listenerData = new DirectEventListenerPool(_directScope);
			_destroyData = new DirectEventDestroyPool(_directScope,_listenerData);
		
		}
		
		/**
		 * 接受消息 == addEventListener
		 * @param	eventName
		 * @param	action
		 */
		public function receive(eventName:String, action:*,scope:String="Global"):void
		{
			_directScope.add(scope);
			_listenerData.add(eventName, action,scope);
		}
		
		//包含url 和 action  方便外部数据修改
		public function getReceiveData(scope:String = "Global"):Array {
			
			   var eventKey:Vector.<String> = _listenerData.getRegisterEventName(scope);
			   if (eventKey == null) return  null;
			   var eventAction:Array = _listenerData.getRegisterEventAction(scope);
			   return  [eventKey, eventAction];
			}
		
		
		/**
		 * 发送消息
		 * @param	eventName
		 * @param	eventData
		 */
		public function send(eventName:String, eventData:DirectEventParameter=null,scope:String="Global"):void
		{
			if (eventData == null) eventData = new DirectEventParameter();
			if (_directScope.getScope(scope) == null)
			{
			   // trace("DirectEventScope send ERROR>>> :"+scope+" not exist");
				return;
			}
			if (_listenerData.hasEventName(eventName,scope))
			{
				if (Game.IsDebugMode){trace("[DirectEvent SEND: " + eventName + " Succeed]")}				
				var _sendAction:DirectEventSendAction = new DirectEventSendAction(_listenerData,eventName,eventData,scope);
					 _sendAction.addEventListener(TaskActionEvent.COMPLETE, _destroyEventLogic);
					 _sendAction.execute();
			}
			else
			{
				if (Game.IsDebugMode)
					trace("[DirectEvent SEND: " + eventName + " Not Register]")
			}
			
		}
		
		/**
		 * 销毁监听消息  == removeEventListener
		 * @param	eventName
		 * @param	action
		 */
		public function destroy(eventName:String, action:*,scope:String="Global"):void
		{
			if (_directScope.getScope(scope) == null)
			{
			    //trace("DirectEventScope destroy ERROR>>> :"+scope+" not exist");
				return;
			}
			//监听队列有才可以放入到销毁队列
			if(_listenerData.hasEvent(eventName,action,scope)){
				_destroyData.add(eventName, action,scope);
			}
		}
		
		private function _destroyEventLogic(e:TaskActionEvent):void
		{
			var senderAction:DirectEventSendAction = DirectEventSendAction(e.target);
			_destroyData.remove(senderAction.scope);
			senderAction.removeEventListener(TaskActionEvent.COMPLETE, _destroyEventLogic);
		}
	}

}

