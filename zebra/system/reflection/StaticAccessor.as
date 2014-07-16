package zebra.system.reflection 
{
		import flash.utils.getDefinitionByName;
	/**
	 * 静态属性构造器
	 */
	public class StaticAccessor extends  ReflectionMember
	{
 
		private var _staticAccessorInfo:Vector.<StaticAccessorInfo>;
 
		public function StaticAccessor(cls:*,data:XML) 
		{
			super(cls, data);
			_staticAccessorInfo = new Vector.<StaticAccessorInfo>();
			for each( var  item:XML  in _classXML.accessor) {				
				var  sai:StaticAccessorInfo = new StaticAccessorInfo();
				     sai.key = item.@name.toString();
					 sai.value = this._class[sai.key];
					 sai.access = item.@access.toString();
					 sai.type = item.@type.toString();
					 _staticAccessorInfo.push(sai);
					 _names.push(sai.key)
				}
			
		}
		
		public function  set(key:String,value:*):void {
			 for each (var item:StaticAccessorInfo in _staticAccessorInfo) 
			 {
				if (item.key == key) {
					this._class[item.key] = value;
					item.value = value;
					break;
					}
			 }
		  }
		 
		  
		public function  get(key:String):* {
			 for each (var item:StaticAccessorInfo in _staticAccessorInfo) 
			 {
				if (item.key == key) {
					 return item.value;
					}
			 }
		  }
		  
		public function get staticAccessorInfo():Vector.<StaticAccessorInfo> 
		{
			return _staticAccessorInfo;
		}
	}

}