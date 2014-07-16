package zebra.system.reflection 
{
	import flash.utils.Dictionary;
	internal class ReflectionDescribeTypePool 
	{
		
		public function ReflectionDescribeTypePool() 
		{
			
		}
		static private var refList:Dictionary = new Dictionary();
		static public function add(classPath:String, data:XML):void {
			     if (refList[classPath] == null) {
					   refList[classPath] = data;
					 }
			}
		static public function has(classPath:String):Boolean {
				return  refList[classPath]!=null;
			}
		static public function get(classPath:String):XML {
				return  XML(refList[classPath]);
			}
	}

}