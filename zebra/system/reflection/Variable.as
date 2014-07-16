package zebra.system.reflection 
{
	/**
	 * 常规自定义变量
	 */
	public class Variable extends ReflectionMember
	{
		private var _variableInfo:Vector.<VariableInfo>;
		
		public function get variableInfo():Vector.<VariableInfo> 
		{
			return _variableInfo;
		}
		
		public function Variable(cls:*,data:XML) 
		{
			super(cls,data)
			_variableInfo = new Vector.<VariableInfo>();
			
			for each( var  item:XML  in _classXML.factory.variable) {
				var  vi:VariableInfo = new VariableInfo();
				     vi.key = item.@name.toString();
					 vi.value = _classObject[vi.key];
					 vi.type = item.@type.toString();
					 _variableInfo.push(vi);		 	 
					 _names.push(vi.key)		  
				}
			
		}

		public function  set(key:String,value:*):void {
			 for each (var item:VariableInfo in _variableInfo) 
			 {
				if (item.key == key) {
					_classObject[item.key] = value;
					item.value = value;
					break;
					}
			 }
		  }
		 
		  
		public function  get(key:String):* {
			 for each (var item:VariableInfo in _variableInfo) 
			 {
				if (item.key == key) {
					 return item.value;
					}
			 }
		  }
		
	}

}