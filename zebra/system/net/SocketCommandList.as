package zebra.system.net 
{
	import flash.utils.Dictionary;
	import zebra.system.collections.FlashBytesReader;
	/**
	 * ...
	 * @author raymond
	 */
	public class SocketCommandList 
	{
		static private var list:Dictionary = new Dictionary();	 
		
		public function SocketCommandList() 
		{
			
		}
		
		
		static public function add(code:String,cls:*):void {
			 	list[code] = cls;
		}
		
		
		static public function remove(code:String):void {
			 	list[code] = null;
		}
		
		/**
		 * 获得数据
		 * @param	data
		 * @return
		 */
		static public function getRecord($data:FlashBytesReader):*
		{
			var data :FlashBytesReader = $data.clone();
			if(list[data.mainId + "-" + data.childId]==null){
			trace(data.mainId + "-" + data.childId +"  没有在command list注册 ");
			}
			
			SocketCommandRecordImp(list[data.mainId + "-" + data.childId]).parse(data);
			return list[data.mainId + "-" + data.childId];
		}
		
	}

}