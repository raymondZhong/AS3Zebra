
package zebra.system.collections 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class ByteArrayReader
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
		
		protected var _bytes:ByteArray;
		protected var _encoding:String = 'utf-8';	
		protected var _length:uint;
		protected var _iscopy:Boolean;
		protected var _position:uint;
		
		public function ByteArrayReader(bytes:ByteArray,position:uint=0,iscopy:Boolean=false) 
		{
			_iscopy = iscopy;
			if (iscopy) {
				 _bytes = new ByteArray();
				 bytes.readBytes(_bytes);
				}else{
				_bytes = bytes;
				}
			_bytes.position = position;
		}
 

		
		/**
		 * 1字节 8位整数 范围(-128~+127)
		 */
		public function readInt8():int {
			return _bytes.readByte();
		}
		
		/**
		 * 1字节 8位整数 0 和 255 之间的 32 位无符号整数
		 */
		public function readUInt8():int {
			return _bytes.readUnsignedByte();
		}
		
		
		/**
		 * 2字节 代表有符号16位整数，取值范围在-32768~32767之间。
		 * @param	value
		 */
		public function readInt16():int
		{
			return _bytes.readShort();
		}
		
		
			/**
		 * 2字节 代表有符号16位整数，取值范围在-32768~32767之间。
		 * @param	value
		 */
		public function readUInt16():int
		{
			return _bytes.readUnsignedShort();
		}
		
		/**
		 * 4字节 代表无符号32位整数，取值范围在 0 ~ 4,294,967,295之间
		 * @param	value
		 */
		public function readUInt32():uint
		{
			return _bytes.readUnsignedInt();
		}
		
		/**
		 * 4字节 代表有符号32位整数，取值范围在-2147483648 ~ 2147483647之间
		 * @param	value
		 */
		public function readInt32():int
		{				
			return _bytes.readInt(); 
		}
				
		
		/**
		 * 8字节   64位有符号整数，取值范围在-9,223,372,036,854,775,808~ 9,223,372,036,854,775,807之间。
		 * @param	value
		 */
		//现在的Node.JS 服务器端 只能接收正整数0-9223372036854776000
		public function readInt64():Number
		{
			return readUInt64();
		}
		
		/**
		 * 8字节  64位无符号整数，取值范围在0 ~ 18,446,744,073,709,551,615之间。
		 * @param	value
		 */
		public function readUInt64():Number
		{
			return  _bytes.readDouble();
			
			/*var value:Int64 = new Int64();
			 switch(_bytes.endian){
                case Endian.BIG_ENDIAN:
                    value.high = _bytes.readUnsignedInt();
                    value.low = _bytes.readUnsignedInt();
                    break;
                case Endian.LITTLE_ENDIAN:
                    value.low = _bytes.readUnsignedInt();
					value.high = _bytes.readUnsignedInt();
                    break;
            }
			return value;*/
		}
		
		/**
		 * N字节 字符串  (4字节 string长度)
		 * @param	msg
		 * @return
		 */
		public function readString():String
		{
            var stringLenth:int = _bytes.readUnsignedInt();
			var result:String = _bytes.readMultiByte(stringLenth,_encoding);
			return  result;
		}
		
		
		/**
		 * 1字节  一个Boolean值
		 * @param	value
		 */
		public function readBoolean():Boolean
		{
			return _bytes.readBoolean();
		}		
		
		/**
		 * 4字节 浮点数 带符号的 32 位整数。 
		 * @param	msg
		 * @param	$decimal
		 * @return
		 */
		public  function readFloat():Number
		{
			return _bytes.readFloat();
		}
		
		public function get position():uint 
		{
			return _bytes.position;
		}
		
		public function set position(value:uint):void 
		{
			_bytes.position = value;
		}
		
		public function get encoding():String
		{
			return _encoding;
		}
		
		public function set encoding(value:String):void 
		{
			_encoding = value;
		}
		
		public function get endian():String 
		{
			return _bytes.endian;
		}
		
		public function set endian(value:String):void 
		{
			_bytes.endian = value;
		}
		
		public function get length():uint 
		{
			return _bytes.length;
		}
		
		public function get bytes():ByteArray 
		{
			return _bytes;
		}
 
		public function clear():void {
			_bytes.clear();
		}
		
		public function clone():*{
			_bytes.position = 0;
			var bytes:ByteArray  = new ByteArray();
				bytes.writeBytes(_bytes);
			    return  new ByteArrayReader(bytes, 0, _iscopy);
			}
	}

}