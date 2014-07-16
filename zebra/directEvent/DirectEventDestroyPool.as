package zebra.directEvent
{
	
	import flash.utils.Dictionary;
	
	
	/**
	 * 销毁信息集合
	 */
	internal class DirectEventDestroyPool
	{ 
		private var _listenerEventPool:DirectEventListenerPool;
		private var _directScope:DirectEventScope;
       
		public function DirectEventDestroyPool(directScope:DirectEventScope,listenerEventPool:DirectEventListenerPool)
		{
			this._directScope = directScope;
			_listenerEventPool = listenerEventPool;
		}
		 
		public function getDestroyEventAction(scope:String):Array {
			 return _directScope.getScope(scope).destroyPool.EventAction;
			}
			
		public function getDestroyEventName(scope:String):Vector.<String> {
			 return _directScope.getScope(scope).destroyPool.EventName;
			}
		
		/**
		 * 把eventName和Action放入销毁池,准备销毁.
		 * @param	eventName
		 * @param	action
		 * @param	scope
		 */
		public function add(eventName:String, action:*,scope:String):void
		{
			if(!hasEvent(eventName,action,scope)){
				getDestroyEventName(scope).push(eventName);
				getDestroyEventAction(scope).push(action);
			}
		}
		
		public function hasEvent(eventName:String, action:*, scope:String):Boolean {
				var destroyEventAction:Array = getDestroyEventAction(scope);
				var destroyEventName:Vector.<String> = getDestroyEventName(scope);
				var index:int = destroyEventAction.indexOf(action)    
				if (index == -1) return false
				if (index != -1 && destroyEventName[index] != eventName ) return false;
				return true;
			}
		
		
		
		public function remove(scope:String):void
		{
			var destroyEventAction:Array = getDestroyEventAction(scope);
			var destroyEventName:Vector.<String> = getDestroyEventName(scope);
			
			var destroyLen:int = destroyEventName.length - 1;
			var currentEventName:String;
			var currentEventAction:*;
			
			var registerEventName:Vector.<String>;
			var registerEventAction:Array;
			for (var j:int = destroyLen; j >= 0; j--)
			{
				//以要销毁的作为标准,先移除监听的对应数据在移除要销毁的队列数据
				currentEventName = destroyEventName[j];
				currentEventAction = destroyEventAction[j];
		 
				for (var i:int = _listenerEventPool.getCount(scope)-1; i >= 0; i--)
				{
					//匹配消息号和消息脚本
					if (currentEventName == _listenerEventPool.getRegisterEventName(scope)[i] && currentEventAction == _listenerEventPool.getRegisterEventAction(scope)[i]) {
						  _listenerEventPool.remove(currentEventName, currentEventAction,scope);
						  _destroypoolRemoveLgoic(currentEventName, currentEventAction,scope);
						}
				}
			}	
		}
		
		private function _destroypoolRemoveLgoic(eventName:String, action:*,scope:String):void
		{
			var destroyEventAction:Array = getDestroyEventAction(scope);
			var destroyEventName:Vector.<String> = getDestroyEventName(scope);
			
			var index:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < destroyEventName.length; i++)
			{
				if (destroyEventName[i] == eventName && destroyEventAction[i] == action)
				{
					index.push(i);
				}
			}
			index.reverse();
			var len:int = index.length - 1;
			var targetIndex:int;
			for (var j:int = len; j >= 0; j--)
			{
				targetIndex = index[j]
				destroyEventName.splice(targetIndex, 1);
				destroyEventAction.splice(targetIndex, 1);
			}
		}
	}

}