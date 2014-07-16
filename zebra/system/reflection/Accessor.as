package zebra.system.reflection 
{
	import flash.utils.getDefinitionByName;
	/**
	 * 常规自定义属性构造器
	 */
	public class Accessor extends ReflectionMember
	{
		private var _accessorInfo:Vector.<AccessorInfo>;
		
		public function Accessor(cls:*,data:XML) 
		{
            super(cls, data);
			_accessorInfo = new Vector.<AccessorInfo>();
			
			for each( var  item:XML  in _classXML.factory.accessor) {				
				var  ai:AccessorInfo = new AccessorInfo();
				     ai.key = item.@name.toString();
					 ai.value = _classObject[ai.key];
					 ai.access = item.@access.toString();
					 ai.type = item.@type.toString();
					 _accessorInfo.push(ai);
					 this._names.push(ai.key)
				}
		}

		
		public function  set(key:String,value:*):void {
			 for each (var item:AccessorInfo in _accessorInfo) 
			 {
				if (item.key == key) {
					_classObject[item.key] = value;
					item.value = value;
					break;
					}
			 }
		  }
		 
		  
		public function  get(key:String):* {
			 for each (var item:AccessorInfo in _accessorInfo) 
			 {
				if (item.key == key) {
					 return item.value;
					}
			 }
		  }
		 
		  
		public function get accessorInfo():Vector.<AccessorInfo> 
		{
			return _accessorInfo;
		}
	}

}