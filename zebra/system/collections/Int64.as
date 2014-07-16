package zebra.system.collections
{
	import flash.utils.Endian;
	
	/**
	 *
	 * AS3 读写 C++ 64位数字
	 *
	 * 核心思路：
	 * 低位——对DEC和BIN，低位都是用十进制表达的；
	 * 高位——BIN的高位的值等于DEC高位值乘以2^32
	 *
	 * */
	public class Int64
	{
		private var _endian:String; // = Endian.BIG_ENDIAN;
		
		public var high:uint;
		public var low:uint;
		
		public function Int64(high:uint=0,low:uint=0,endian:String="bigEndian")
		{
			_endian = endian;
			this.high = high;
			this.low = low;
		}
		
		
		static public function fromNumber(num:Number):Int64 {
			var value:Int64 = new Int64();
			   if(num<Math.pow(2,32)){
                value.high = 0;
				value.low=num;
				}else{
					value.high = int(num/Math.pow(2,32));
					value.low = num - value.high*Math.pow(2,32);
				}
			 return value;
		}
		
		public function toNumber():Number{
            var num:Number = 0;
            switch(_endian){
                case Endian.BIG_ENDIAN:
                    num= this.high * Math.pow(2, 32) + this.low;
                    break;
                case Endian.LITTLE_ENDIAN:
                    num= this.low * Math.pow(2, 32) + this.high;
                    break;
            }
            return num;
        }
		
		static public function toNumber(value:Int64):Number {
            var num:Number = 0;
            switch(value.endian){
                case Endian.BIG_ENDIAN:
                    num= value.high * Math.pow(2, 32) + value.low;
                    break;
                case Endian.LITTLE_ENDIAN:
                    num= value.low * Math.pow(2, 32) + value.high;
                    break;
            }
            return num;
        }
		
		
		public function toString():String {
			   return  "[Int64] high:" + high + "  low:" + low + " number:" + toNumber();		
			}
			
		public function get endian():String 
		{
			return _endian;
		}
		
		
		public function isZero():Boolean
		{
			return this.toNumber() == 0;
		}
		
		public function isEqual(target:Int64):Boolean
		{
			return this.toNumber() == target.toNumber();
		}
		
		/**
		 * 大于或等于
		 * @param	target
		 * @return
		 */
		public function isBiggerOrEqual(target:Int64):Boolean
		{
			return this.toNumber() >= target.toNumber();
		}
		
		
	/*	public function clone():Int64
		{
			var result:Int64 = new Int64;
				result.high = this.high;
				result.low = this.low;
			return result;
		}
		
		static public function get Empty():Int64
		{
			return new Int64();
		}
		
		
		
		public function isZero():Boolean
		{
			return this.toNumber() == 0;
		}
		
		public function isEqual(target:Int64):Boolean
		{
			return this.toNumber() == target.toNumber();
		}
		
		public function isBiggerOrEqual(target:Int64):Boolean
		{
			return this.toNumber() >= target.toNumber();
		}
		
		public function toStr():String
		{
			var result:Number = high * Math.pow(2, 32) + low;
			return result.toString();
		}
		
		public function toNumber():Number
		{
			var result:Number = high * Math.pow(2, 32) + low;
			return result;
		}
		
		private function _toFullStr($data:uint, $length:int):String
		{
			var str:String = $data.toString();
			while (str.length < $length)
			{
				str = "0" + str;
			}
			return str;
		}*/
		
	
	}

}