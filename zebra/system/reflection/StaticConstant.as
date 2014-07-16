package zebra.system.reflection 
{
	import flash.utils.getDefinitionByName;
	
	/**
	 * 静态常量
	 */
	public class StaticConstant  extends ReflectionMember
	{
 
		private var _staticConstantInfo:Vector.<StaticConstantInfo>;
 
		
		public function StaticConstant(cls:*,data:XML) 
		{
			super(cls, data);
			_staticConstantInfo = new Vector.<StaticConstantInfo>();
			
			for each( var  item:XML  in _classXML.constant) {				
				var  sci:StaticConstantInfo = new StaticConstantInfo();
				     sci.key = item.@name.toString();
					 sci.value = this._class[sci.key];
					 sci.type = item.@type.toString();
					 _staticConstantInfo.push(sci);
					 _names.push(sci.key)
				}
			
		}
		
		public function  get(key:String):* {
			 for each (var item:StaticConstantInfo in _staticConstantInfo) 
			 {
				if (item.key == key) {
					 return item.value;
					}
			 }
		  }
		  
		  public function get staticConstantInfo():Vector.<StaticConstantInfo> 
		  {
			  return _staticConstantInfo;
		  }
		
		
	}

}