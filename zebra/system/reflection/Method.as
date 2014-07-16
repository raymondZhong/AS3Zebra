package zebra.system.reflection 
{

	public class Method extends  ReflectionMember
	{
		
		private var _methodInfo:Vector.<MethodInfo>;

		
		public function Method(cls:*,data:XML) 
		{
			super(cls, data);
			_methodInfo = new Vector.<MethodInfo>();		
			for each( var  item:XML  in _classXML.factory.method ) {				
				var  mi:MethodInfo = new MethodInfo();
				     mi.key = item.@name.toString();
					 mi.declaredBy = item.@declaredBy.toString();
					 mi.returnType = item.@returnType.toString();
					
					 for each (var param:XML in item.parameter) {
						  var mpi:MethodParameterInfo = new MethodParameterInfo();
							  mpi.index = int(param.@index);
							  mpi.type = param.@type.toString();
							  mpi.optional = Boolean(param.@optional);
							  mi.parameterInfo.push(mpi); 
						}
					 _methodInfo.push(mi); 	 
					 _names.push(mi.key)
				}	
		}
		
 
		public function executeMethod(name:String,data:Array=null):void {
			  for each (var mi:MethodInfo in _methodInfo) 
			  {
				  if (mi.key == name) {
					  if (mi.parameterInfo.length == 0) {
						  _classObject[mi.key]();
						  }else {
						  _classObject[mi.key](data);  
					    }
					  break;
					  }
			  }
			  
			    
			}
			
			public function get methodInfo():Vector.<MethodInfo> 
			{
				return _methodInfo;
			}
		
	}

}