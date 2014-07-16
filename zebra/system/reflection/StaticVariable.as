package zebra.system.reflection 
{
	import flash.utils.getDefinitionByName;
	
	/**
	 * 静态变量
	 */
	public class StaticVariable extends ReflectionMember
	{
		
		private var _staticVariableInfo:Vector.<StaticVariableInfo>;
		public function StaticVariable(cls:*,data:XML) 
		{
			super(cls,data)
			_staticVariableInfo = new Vector.<StaticVariableInfo>();
			
			for each( var  item:XML  in _classXML.variable) {
				var  svi:StaticVariableInfo = new StaticVariableInfo();
				     svi.key = item.@name.toString();
					 svi.value = this._class[svi.key];
					 svi.type = item.@type.toString();
					 _staticVariableInfo.push(svi);		 	 
					 _names.push(svi.key)		  
				}
			
		}

		public function  set(key:String,value:*):void {
			 for each (var item:StaticVariableInfo in _staticVariableInfo) 
			 {
				if (item.key == key) {
					this._class[item.key] = value;
					item.value = value;
					break;
					}
			 }
		  }
		 
		  
		public function  get(key:String):* {
			 for each (var item:StaticVariableInfo in _staticVariableInfo) 
			 {
				if (item.key == key) {
					 return item.value;
					}
			 }
		  }
		  
		  public function get staticVariableInfo():Vector.<StaticVariableInfo> 
		  {
			  return _staticVariableInfo;
		  }
		
	}

}