package zebra.system.util
{
	import flash.utils.Dictionary;
	
	public class ArrayUtil
	{
		
		//在at位置刪除
		public static function deleteAt(inputArr:Array, at:uint):Array
		{
			var resultArray:Array = new Array;
			resultArray = inputArr
			resultArray.splice(at, 1);
			return resultArray;
		}
		
		/**
		 * 转换成字符串  char 字符间隔
		 * @param	source
		 * @param	char
		 * @return
		 */
		public static function toString(source:Array, char:String):String
		{
			var s:String = "";
			for (var i:int = 0; i < source.length; i++)
			{
				if (i == 0)
				{
					s = source[i].toString();
				}
				else
				{
					s += char + source[i].toString()
				}
			}
			return s;
		}
		
		/**
		 * 字符串转换成2维数组
		 * @param	str
		 * @param	col
		 * @param	row
		 * @return
		 */
		public static function strToArray2D(str:String,col:int,row:int):Array
		{
			var sourceStr:Array = str.split(",");
			var array2D:Array=new Array();
			for (var k:int=0; k<row; k++)
			{
				array2D.push(new Array());
			}
			for (var j:int=0; j<row; j++)
			{
				for (var i:int=0; i<col; i++)
				{
					array2D[j].push(sourceStr.shift());
				}
			}
			return array2D;
		}
		
		
		/**
		 * 是否存在相同项目
		 * @param	arr
		 * @return
		 */
		static public function hasSameItem(arr:Array):Boolean {			 
				var newArray:Array = [];
				for(var i:int = 0; i < arr.length; i++) {
					if (newArray.indexOf(arr[i]) == -1) {
						newArray.push(arr[i]);
					}else {
					  return  true;	
					}
				}
				return false;
			}
		
		/**
		 * 根据值删除项
		 * @param	value
		 * @param	inputArr
		 * @return
		 */
		public static function deleteByItemValue(value:*, inputArr:Array):Array
		{
			var resultArray:Array = inputArr;
			var index:int = -1;
			for (var i:int = 0; i < resultArray.length; i++)
			{
				if (resultArray[i].toString() == value.toString())
				{
					index = i;
				}
			}
			if (index != -1)
			{
				resultArray = deleteAt(resultArray, index);
			}
			return resultArray;
		
		}
		
		/**
		 * 根据值删除项
		 * @param	key
		 * @param	value
		 * @param	inputArr
		 * @return
		 */
		public static function deleteByObjectItemValue(key:*, value:*, inputArr:Array):Array
		{
			var resultArray:Array = inputArr;
			var index:int = -1;
			for (var i:int = 0; i < resultArray.length; i++)
			{
				if (resultArray[i][key] == value)
				{
					index = i;
				}
			}
			if (index != -1)
			{
				resultArray = deleteAt(resultArray, index);
			}
			return resultArray;
		}
		
		
		
		 
		
		
		
		//在at位置添加element
		
		public static function insertAt(element:Object, at:uint, inputArr:Array):Array
		{
			var resultArray:Array = new Array;
			
			resultArray = inputArr;
			
			resultArray.splice(at, 0, element);
			
			return resultArray;
		
		}
		
		/**
		 * 移除空值
		 * @param	inputArr
		 * @return
		 */
		//public static function removeEmtry(inputArr:Array):Array
		//{
			//
			//var resultArray:Array = new Array();
			//
			//for (var i:int = 0; i < inputArr.length; i++)
			//{
				//if (!StringUtil.isWhitespace(inputArr[i]))
				//{
					//resultArray.push(inputArr[i]);
				//}
			//}
			//
			//return resultArray;
		//
		//}
		
		/**
		 * 移除相同的值
		 * @param	dataCollection
		 * @return
		 */
		public static function removeDuplicateElements(dataCollection:Array):Array
		{
			if (dataCollection == null)
				return null;
			if (dataCollection.length <= 1)
				return dataCollection;
			var hash:Dictionary = new Dictionary(false);
			var len:uint = dataCollection.length;
			for (var i:uint = 0; i < len; i++)
			{
				hash[dataCollection[i]] = null;
			}
			
			dataCollection = new Array();
			
			for (var pro:*in hash)
			{
				
				dataCollection.push(pro);
				
			}
			return dataCollection;
		}
		
		/**
		 * 移除相同的项
		 * @param	$arr
		 * @return
		 */
		public static function removeDuplicateItem($arr:Array):Array
		{
			var obj:Object = new Object();
			var arr:Array = new Array();
			for (var i:String in $arr)
				obj[$arr[i]] = i;
			for (var j:Object in obj)
				arr[arr.length] = j;
			return arr;
		}
		
		/**
		 * 是否包含该值
		 * @param	inArray
		 * @param	item
		 * @return
		 */
		public static function contains(inArray:Array, item:*):uint
		{
			var i:int = inArray.indexOf(item, 0);
			var t:uint = 0;
			
			while (i != -1)
			{
				i = inArray.indexOf(item, i + 1);
				t++;
			}
			
			return t;
		}
		
		/**
		 * 在指定范圍內產生一個序列
		 * @param	low
		 * @param	high
		 * @return
		 */
		public static function getSequence(low:Number, high:Number):Array
		{
			var result:Array = [];
			for (var i:uint = low; i <= high; i++)
			{
				result.push(i);
			}
			return result;
		}
		
		/**
		 * 随机数组
		 * @param	ary
		 * @return
		 */
		public static function aryRandom(ary:Array):Array
		{
			var ary_temp:Array = new Array();
			for (var i:int = ary.length; i > 0; i--)
			{
				var int_num:Number = int(Math.random() * ary.length);
				ary_temp.push(ary[int_num]);
				//从原数组中删除刚才的值，防止重复
				ary.splice(int_num, 1);
					//trace(ary_temp);
			}
			return ary_temp;
		}
	
	}

}