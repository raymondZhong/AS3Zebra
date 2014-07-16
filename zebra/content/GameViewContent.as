package zebra.content
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	internal class GameViewContent extends GameContentItem
	{
 
		
		public function GameViewContent(content:GameContent)
		{
			_gameContent = content;
		}

		
		public function add(view:*):void
		{
			var key:String = getQualifiedClassName(view).split("::").join(".");
			if (_data[key] == null)
			{
				_data[key] = view;
			}
		}
		
		public function update(view:*):void
		{
			var key:String = getQualifiedClassName(view).split("::").join(".");
			if (contain(key))
			{
				remove(key);
				add(view);
			}
		}
		
		public function get(classORpackname:*):*
		{
			 
			return _data[classORpacknameUtil(classORpackname)];
		}
		
		public function contain(key:*):Boolean
		{
			return get(key) != null;
		}
		
		public function remove(classORpackname:*):void
		{
			delete _data[classORpacknameUtil(classORpackname)];;
		}
		
		public function clear():void
		{
			_data = new Dictionary();
		}
	}

}