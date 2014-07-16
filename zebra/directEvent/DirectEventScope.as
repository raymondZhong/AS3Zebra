package zebra.directEvent 
{ 
	import flash.utils.Dictionary;
	public class DirectEventScope 
	{
		
		private var _scopepool:Dictionary;
		public function DirectEventScope() { 
			  _scopepool = new Dictionary();
			}
		
		/**
		 * 添加一个事件机制范围
		 * @param	scope
		 */
		public function add(scope:String):void{ 
			  if (_scopepool[scope] == null) {				  
				  _scopepool[scope] = new DirectEventScopePool();
				  }
			}
			
		public function hasScope(scope:String):Boolean {
			return _scopepool[scope] != null
			}
			
		public function getScope(scope:String):DirectEventScopePool {
			return  DirectEventScopePool(_scopepool[scope]);
			}
		/**
		 * 移除一个事件机制范围
		 * @param	scope
		 */
		public function remove(scope:String):void { 
				delete _scopepool[scope];
			}
	}

}


internal class DirectEventScopePool {
	     private var _listenerPool:DirectEventScopeModel;
	     private var _destroyPool:DirectEventScopeModel;
		 
	     public function DirectEventScopePool() {
		      _listenerPool = new DirectEventScopeModel();
		      _destroyPool = new DirectEventScopeModel();
		  }
		  
		  public function get listenerPool():DirectEventScopeModel 
		  {
			  return _listenerPool;
		  }
		  
		  public function get destroyPool():DirectEventScopeModel 
		  {
			  return _destroyPool;
		  }
	}

internal class DirectEventScopeModel{
	     private var _eventName:Vector.<String>;  //1-1
		 private var _eventAction:Array;  //Function Or DirectEventAction
		 
		 public function DirectEventScopeModel() {
				 _eventName = new Vector.<String>();
				 _eventAction = new Array();
			 }
			 
			 public function get EventName():Vector.<String> 
			 {
				 return _eventName;
			 }
			 
			 public function get EventAction():Array 
			 {
				 return _eventAction;
			 }
		 
	}


		
 