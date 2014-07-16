package zebra.content
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import zebra.core.GameModel;
	
	internal class GameModelContent  extends GameContentItem
	{
		
		public function GameModelContent(content:GameContent)
		{
			_gameContent = content;
		}
		
		public function add(model:*):void
		{
			var key:String = getQualifiedClassName(model).split("::").join(".");
			if (_data[key] == null)
			{
				_data[key] = model;
			}
		}
		
		public function get(classORpackname:*):*
		{
			return _data[classORpacknameUtil(classORpackname)]
		}
		
		public function contain(key:*):Boolean
		{
			return  get(key) != null;
		}
		
		public function remove(classORpackname:*):void
		{
			delete _data[classORpacknameUtil(classORpackname)]
		}
		
		public function clear():void
		{
			_data = new Dictionary();
		}
	}

}