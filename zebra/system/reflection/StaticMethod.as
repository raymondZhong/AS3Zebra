package zebra.system.reflection 
{

	/**
	 * 静态方法
	 */
	public class StaticMethod extends ReflectionMember
	{
		
	
		private var _staticMethodInfo:Vector.<StaticMethodInfo>;

		
		public function StaticMethod(cls:*,data:XML) 
		{
			super(cls, data);
			_staticMethodInfo = new Vector.<StaticMethodInfo>();		
			for each( var  item:XML  in _classXML.method ) {				
				var  smi:StaticMethodInfo = new StaticMethodInfo();
				     smi.key = item.@name.toString();
					 smi.declaredBy = item.@declaredBy.toString();
					 smi.returnType = item.@returnType.toString();
					
					 for each (var param:XML in item.parameter) {
						  var smp:StaticMethodParameterInfo = new StaticMethodParameterInfo();
							  smp.index = int(param.@index);
							  smp.type = param.@type.toString();
							  smp.optional = Boolean(param.@optional);
							  smi.parameterInfo.push(smp); 
						}
					 _staticMethodInfo.push(smi); 	 
					 _names.push(smi.key)
				}	
		}
		
 
		public function executeMethod(name:String,data:Array=null):void {
			  for each (var smp:StaticMethodInfo in _staticMethodInfo) 
			  {
				  if (smp.key == name) {
					  if (smp.parameterInfo.length == 0) {
						  this._class[smp.key]();
						  }else {
						   this._class[smp.key](data);  
					    }
					  break;
					  }
			  }
			  
			    
			}
			
			public function get staticMethodInfo():Vector.<StaticMethodInfo> 
			{
				return _staticMethodInfo;
			}
		
	}

}