package zebra.directEvent
{
	import flash.utils.Dictionary;
	
	/**
	 * 监听数据集合
	 */
	internal class DirectEventListenerPool
	{
		private var _directScope:DirectEventScope;
		public function DirectEventListenerPool(directScope:DirectEventScope)
		{
			this._directScope = directScope;
		}
		
		public function getRegisterEventName(scope:String):Vector.<String>  {
			if (_directScope.getScope(scope) == null) return null;
			  return _directScope.getScope(scope).listenerPool.EventName ;
			}
		
		public function getRegisterEventAction(scope:String):Array {
			if (_directScope.getScope(scope) == null) return null;
				return  _directScope.getScope(scope).listenerPool.EventAction ;
			}
		
		public  function getCount(scope:String):int {
			return _directScope.getScope(scope).listenerPool.EventName.length;  
			}
			
		/**
		 * 添加接受
		 * @param	eventName
		 * @param	action
		 */
		public function add(eventName:String, action:*,scope:String):void
		{
			if (!hasEvent(eventName,action,scope)) {
				getRegisterEventName(scope).push(eventName) ;
				getRegisterEventAction(scope).push(action);
			}
		}
		
		/**
		 * 存在事件KEY
		 * @param	eventName
		 * @return
		 */
		public function hasEventName(eventName:String,scope:String):Boolean
		{
			return getRegisterEventName(scope).indexOf(eventName) != -1;
		}
		
		public function hasEvent(eventName:String, action:*, scope:String):Boolean {
				var registerEventAction:Array = getRegisterEventAction(scope);
				var registerEventName:Vector.<String> =  getRegisterEventName(scope);
				var index:int =  registerEventAction.indexOf(action)    
				if (index == -1) return false
				if (index != -1 && registerEventName[index] != eventName ) return false;
				return true;
			}
		
		
		/**
		 * 移除接收{监听}
		 * @param	eventName
		 * @param	action
		 */
		public function remove(eventName:String, action:*,scope:String):void
		{
			var registerEventAction:Array = getRegisterEventAction(scope);
			var registerEventName:Vector.<String> =  getRegisterEventName(scope);
			
			var index:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < registerEventName.length; i++)
			{
				if (registerEventName[i] == eventName && registerEventAction[i] == action)
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
				registerEventName.splice(targetIndex, 1);
				registerEventAction.splice(targetIndex, 1);
			}
		}
	
	}

}