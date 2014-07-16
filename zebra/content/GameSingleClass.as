package zebra.content
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 实例化放入对象,对象放入数据集合中。
	 * 建议对象构造函数不需要输入参数。
	 */
	internal class GameSingleClass extends GameContentItem
	{
	 
		
		public function GameSingleClass(content:GameContent)
		{
			_gameContent = content;
		}
		
		public function add(cls:*):void
		{
			var key:String = getQualifiedClassName(cls).split("::").join(".");
			
			if (_data[key] == null)
			{
				var clss:Class = getDefinitionByName(key) as Class;
				_data[key] = new clss();
			}
		}
		
		public function get(classORpackname:*):*
		{
		  
			return _data[classORpacknameUtil(classORpackname)];
		}
		
		public function contain(classORpackname:*):Boolean
		{
			
			return get(classORpackname) != null;
		}
		
		public function remove(classORpackname:*):void
		{
			 
			delete _data[classORpacknameUtil(classORpackname)];
		}
		
		public function clear():void
		{
			_data = new Dictionary();
		}
	}

}

