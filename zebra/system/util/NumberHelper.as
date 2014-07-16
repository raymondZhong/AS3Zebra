package zebra.system.util 
{
	import zebra.system.collections.Int64;

	public class NumberHelper 
	{

		static public function  toArray(value:Number):Array {
			     var data:Array = new Array();
				 var val:String = value.toString();
				 for (var i:int=0;i<val.length;i++){
					   data.push(val.charAt(i));
					}
			     return data;
			}
			
			
		/**
		 * 修正浮点数
		 * @param	value
		 * @return
		 */
		static  public function FloatNumer(value:Number):Number
		{
			var m:Number = value;
			var result:Number = m - int(m);
			if (result < 1e-5)
				return Math.round(value);
			var pos_9:int = int.MAX_VALUE;
			var pos_0:int = int.MAX_VALUE;
			var sequenceStr_9:String = (result).toString();
			var sequenceStr_0:String = (result).toString();
			var reg9:RegExp = new RegExp(/9{5,}/);
			var reg0:RegExp = new RegExp(/0{5,}/);
			if (reg9.test(sequenceStr_9))
			{
				pos_9 = sequenceStr_9.search(reg9);
				if (pos_9 == -1)
					pos_9 = int.MAX_VALUE;
			}
			if (reg0.test(sequenceStr_0))
			{
				pos_0 = sequenceStr_0.search(reg0);
				if (pos_0 == -1)
					pos_0 = int.MAX_VALUE;
			}
			if (pos_0 == pos_9)
			{
				return value;
			}
			else
			{
				if (pos_9 < pos_0)
				{
					var carry:Number = Math.pow(10, -1 * (pos_9 -
						
						1));
					var str_9:String = String(m).substring(0, pos_9 +
						
						1);
					var num_9:Number = Number(Number(Number(str_9) +
						
						carry).toFixed(pos_9 - 1));
					return num_9;
				}
				else
				{
					var str_0:String = String(m).substring(0, pos_0);
					var num_0:Number = Number(str_0);
					return num_0;
				}
			}
		}
		
		
		
		/**
		 * 靠近值
		 * @param	value
		 * @param	data
		 * @return
		 */
		static public function approach(value:Number, data:Vector.<Number>):Number {
			  for (var i:int = 0; i < data.length; i++) 
			  {
				   if (value <= data[i]) return data[i];
			  }
			  return 0;
			}
			
		/**
		 * 数值转换成Int64
		 * @param	num
		 * @return
		 */
		static public function toInt64(num:Number):Int64 { 
				var long_l:uint = uint(num);				 
				var long_h:uint = (num - long_l)/4294967296;			
				var result:Int64 = new Int64();
					result.high = long_h;
					result.low = long_l;
					return result;
		}
	}

}