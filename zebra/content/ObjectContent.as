package zebra.content 
{
import flash.utils.Dictionary;
	
	internal class ObjectContent
	{
		
		private var _data:Dictionary = new Dictionary();
		private var _gameContent:GameContent;
		
		
		public function ObjectContent(gameContent:GameContent)
		{
			_gameContent = gameContent;
		}
		
		public function add(key:*, value:Object):void
		{
			if (_data[key] == null) {
				_data[key] = value;
				}
		}
		
		public function get(key:*):Object
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