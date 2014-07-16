package zebra.system.collections 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import zebra.system.net.GameSocketThread;
	import zebra.system.util.SocketServerType;
	public class ByteArrayCollection extends ByteArray
	{
		
		//-----测试占据字节
		/*
		var byte:ByteArray = new ByteArray();
		byte.writeByte(2);       //占1个字节
		byte.writeInt(100000);   //占4个字节
		byte.writeUTFBytes("AAA");   //占3个字节
		byte.writeUTF("bbb");       //占5个字节
		byte.writeShort(1000);     //占2个字节
		byte.writeBoolean(true);   //占1个字节
		byte.writeDouble(10000);   //占8个字节
		byte.writeMultiByte("aaa","iso-8859-1");  //占3个字节
		byte.writeObject(new Object());        //占4个字节
		byte.writeObject({a:15,b:"123123"});    //占18个字节(不知道怎么算出来的)
		*/
		public function ByteArrayCollection() 
		{

		}
		
		static public function get Empty():ByteArrayCollection{return  new ByteArrayCollection()}
		
		
		
		/**
		 * 1字节 8位整数 范围(-128~+127)
		 */
		public function toInt8(value:int):void {
			 if (value < -128) value = -128;
		   	 if (value > 127) value = 127;
			this.writeByte(value);
		}
			
		/**
		 * 1字节 8位整数 范围(0-255)
		 */
		public function toUInt8(value:int):void {
		   	 if (value > 255) value = 255;
			this.writeByte(value);
		}
		
		
		/**
		 * 2字节 代表有符号16位整数，取值范围在-32768~32767之间。
		 * @param	value
		 */
		public function toInt16(value:int):void
		{
			if (value < -32768) value = -32768;
		   	if (value > 32767) value = 32767;
			this.writeShort(value);
		}
		
		
		
		/**
		 * 4字节 代表无符号32位整数，取值范围在 0 ~ 4,294,967,295之间
		 * @param	value
		 */
		public function toUInt32(value:uint):void
		{
		   	if (value > 4294967295) value = 4294967295;			
			this.writeUnsignedInt(value);
		}
		
		/**
		 * 4字节 代表有符号32位整数，取值范围在-2147483648 ~ 2147483647之间
		 * @param	value
		 */
		public function toInt32(value:int):void
		{				
			if (value < -2147483648) value = -2147483648;
		   	if (value > 2147483648) value = 2147483648;
			this.writeInt(value); 
		}
				
		
		/**
		 * 8字节   64位有符号整数，取值范围在-9,223,372,036,854,775,808~ 9,223,372,036,854,775,807之间。
		 * @param	value
		 */
		//现在的Node.JS 服务器端 只能接收正整数0-9223372036854776000
		public function toInt64(value:*):void
		{
			// this.writeDouble(value)
			 
			switch (GameSocketThread.serverType) {
				case SocketServerType.NodeJS:
					toNodeJSInt64(value)
				break;
			}
		}
		
		
		private function toNodeJSInt64(value:Number):void 
		{
			   if (value < -9223372036854775000) value = -9223372036854775000;
		   	   if (value > 9223372036854775000) value = 9223372036854775000;
			   this.writeDouble(value)
		}
		
		
		private function toNodeJSUInt64(value:Number):void 
		{
			   if (value < 0) value = 0;
		   	   if (value > 9223372036854775000) value = 9223372036854775000;
			   this.writeDouble(value)
		}
		
		
		/**
		 * 8字节  64位无符号整数，取值范围在0 ~ 18,446,744,073,709,551,615之间。
		 * @param	value
		 */
		public function toUInt64(value:Number):void
		{
			switch (GameSocketThread.serverType) {
				case SocketServerType.NodeJS:
					toNodeJSUInt64(value)
				break;
			}
			/*switch(this.endian){
                case Endian.BIG_ENDIAN:
                    this.writeUnsignedInt(value.high);
                    this.writeUnsignedInt(value.low);
                    break;
                case Endian.LITTLE_ENDIAN:
                    this.writeUnsignedInt(value.low);
                    this.writeUnsignedInt(value.high);
                    break;
            }*/
		}
		 
		 /**
		  * N字节 字符串  (4字节 string长度)
		  * @param	value
		  * @param	byteType
		  * @param	IsNodeJs
		  */
		public function toStr(value:String,byteType:String="utf-8"):void
		{
            var  bytes:ByteArray = new ByteArray();
				 bytes.writeMultiByte(value, byteType);
				 //写入4字节的字符串长度 UInt32
				/*if(IsNodeJs){
					 this.toUInt32(NodeJsChineseLength(value));
					}else {
					 this.toUInt32(bytes.length);
					}*/
				 this.toUInt32(bytes.length);
				 this.writeMultiByte(value, byteType);
		}
		
		
	//字符串真实长度包括中文字符
	/*	private function NodeJsChineseLength(str):Number {
			var len:Number = 0;
			for (var i:int = 0; i < str.length; i++) {
				var c = str.charCodeAt(i);
				//单字节加1   
				if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
					len++;
				}
				else {
					len += 2;
				}
			}
			return len;
		}*/
		
		
		/**
		 * 1字节  一个Boolean值
		 * @param	value
		 */
		public function toBoolean(value:Boolean):void
		{
			this.writeBoolean(value);
		}		
		
		/**
		 * 4字节 浮点数 带符号的 32 位整数。 
		 * @param	msg
		 * @param	$decimal
		 * @return
		 */
		public  function toFloat(value:Number):void
		{
			this.writeFloat(value);
		}
		
		
		 

	}

}