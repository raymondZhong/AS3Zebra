package zebra.system.reflection
{
	import flash.utils.getDefinitionByName;
	
	public class ReflectionMember
	{
		protected var _class:Class;
		protected var _classObject:*;
		protected var _classXML:XML;
		protected var _names:Vector.<String>;
		
		/**
		 * 反射成员基本结构
		 * @param	cls
		 * @param	data
		 */
		public function ReflectionMember(cls:*, data:XML)
		{
			_classObject = cls;
			_class = getDefinitionByName(Reflection.getClassPath(_classObject)) as Class;
			_classXML = data;		
			_names = new Vector.<String>();
		}
		
		/**
		 * 成员所有的key
		 */
		public function get names():Vector.<String> { return _names; }
	
	}

}