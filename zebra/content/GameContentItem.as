package zebra.content 
{ 
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	internal class GameContentItem 
	{
		protected var _data:Dictionary = new Dictionary();
		protected var _gameContent:GameContent;
		
		public function GameContentItem() 
		{
			
		}
		
		protected function classORpacknameUtil(value:*):String {
			var key:String;
			if (value is Class)
			{
				key = getQualifiedClassName(value).split("::").join(".");
			}
			else
			{
				key = value;
			}
			return key;
		}
			 
		
	}

}