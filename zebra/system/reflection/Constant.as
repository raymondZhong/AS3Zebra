package zebra.system.reflection
{
	
	/**
	 * 常规自定义常量
	 */
	public class Constant extends ReflectionMember
	{
		
		private var _constantInfo:Vector.<ConstantInfo>;
		
		public function Constant(cls:*, data:XML)
		{
			super(cls, data);
			_constantInfo = new Vector.<ConstantInfo>();
			
			for each (var item:XML in _classXML.factory.constant)
			{
				var sci:ConstantInfo = new ConstantInfo();
				sci.key = item.@name.toString();
				sci.value = _classObject[sci.key];
				sci.type = item.@type.toString();
				_constantInfo.push(sci);
				_names.push(sci.key)
			}
		
		}
		
		public function get(key:String):*
		{
			for each (var item:ConstantInfo in _constantInfo)
			{
				if (item.key == key)
				{
					return item.value;
				}
			}
		}
		
		public function get constantInfo():Vector.<ConstantInfo>
		{
			return _constantInfo;
		}
	}

}