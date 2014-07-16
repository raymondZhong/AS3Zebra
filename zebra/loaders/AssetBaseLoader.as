package zebra.loaders
{
	import flash.net.URLRequest;
	import zebra.directEvent.DirectEventParameter;
	
	public class AssetBaseLoader extends DirectEventParameter implements IAssetLoader
	{
		private var _param:Object;
		private var _state:int;
		private var _request:URLRequest;
		private var _loaderEntity:ILoader;
		
		public function AssetBaseLoader(loaderEntity:ILoader)
		{
			_loaderEntity = loaderEntity
		}
		
		/**
		 * 装载Url请求
		 */
		public function get request():URLRequest
		{
			return _request;
		}
		
		/**
		 * loader的实体对象
		 */
		public function get loader():ILoader
		{
			return _loaderEntity;
		}
		
		public function get type():String
		{
			return ""
		}
		
		public function load(request:URLRequest):void
		{
			_request = request;
		}
		
		public function dispose():void
		{
		}
		
		public function get content():*
		{
			return null
		}
		
		public function get param():Object
		{
			return _param;
		}
		
		public function set param(value:Object):void
		{
			_param = value;
		}
		
		public function get state():int
		{
			return _state;
		}
		
		public function set state(value:int):void
		{
			_state = value;
		}
	
			public function get key():String
		{
			return _request.url;
		}
	}

}