package zebra.system.util 
{
	import flash.utils.getDefinitionByName;
	public class VectorHelper
	{
		
		public function VectorHelper($node:String=null) 
		{
			if ($node != null) {
				_node = $node;
				}
		}
		
		private var _node:String;
		
		/**
		 * 
		 * @param	x
		 * @param	y
		 * @return
		 */
		public  function sortSingleNode(x:*,y:*):Number
		{
			if (_node == null) {
				throw new Error("没有设置节点名")
				}
			 var lastNameSort:Number = sortObject(x[_node], y[_node]);
             return lastNameSort;
		}
		 
		 /**
		  * 排序数字或者字符串
		  * @param	x
		  * @param	y
		  * @return
		  */
		public function sortObject(x:*, y:*):Number
		{
			if (x < y)
			{
				return -1;
			}
			else if (x > y)
			{
				return 1;
			}
			else
			{
				return 0;
			}
			return 0;
		}
		
		
		
		
		public function get node():String 
		{
			return _node;
		}
		
		public function set node(value:String):void 
		{
			_node = value;
		}
		
	}

}