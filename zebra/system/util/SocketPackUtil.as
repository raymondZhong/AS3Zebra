package zebra.system.util
{
	import flash.utils.ByteArray;
	import zebra.system.collections.ByteArrayCollection;
	
	/**
	 * ...
	 * @author
	 */
	public class SocketPackUtil
	{
		
		public function SocketPackUtil()
		{
		
		}
		
		static public function breakdownPack(data:ByteArray):ByteArray
		{
			data.position = 0;
			var mainPack:ByteArray = new ByteArray();
			mainPack.writeBytes(data, 3);
			return mainPack;
		}
		
		static public function setPackHeader(header:String,data:ByteArray):ByteArray
		{
			data.position = 0;
			var headerArr:Array = header.split("-");	
			//trace(data.length+4+2)
			var appendHeaderPack:ByteArrayCollection = new ByteArrayCollection();
				//整包长度= 包体长度+主包头+子包头;
				//4字节 表示包长度
				appendHeaderPack.toUInt32(data.length+4+1+1);
				appendHeaderPack.toUInt8(headerArr[0])
				appendHeaderPack.toUInt8(headerArr[1])
				appendHeaderPack.writeBytes(data);
			return appendHeaderPack;		
		}
	
	}

}