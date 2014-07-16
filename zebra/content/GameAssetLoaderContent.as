package zebra.content 
{
	import flash.utils.Dictionary;
	import zebra.loaders.IAssetLoader;
	
	internal class GameAssetLoaderContent
	{
		
		private var _data:Dictionary = new Dictionary();
		private var _gameContent:GameContent;
		
		
		public function GameAssetLoaderContent(gameContent:GameContent)
		{
			_gameContent = gameContent;
		}
		
		public function add(key:*, value:IAssetLoader):void
		{
			if (_data[key] == null) {
				_data[key] = value;
				}
		}
		
		public function get(key:*):IAssetLoader
		{
			return _data[key]
		}
		
		public function contain(key:*):Boolean {
			  return  _data[key] != null;
		}
		
		public function remove(key:*):void
		{
			delete  _data[key];
		}

		
		public function clear():void {
			 _data = new Dictionary();
			}
	}

}






