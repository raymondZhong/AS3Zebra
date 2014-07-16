package zebra.ai.findpath
{
	
	/**
	 * 二叉数据堆
	 */
	internal final class BinaryHeap
	{
		
		public var a:Array = [];
		public var justMinFun:Function = function(x:Object, y:Object):Boolean
		{
			return x < y;
		};
		
		public function BinaryHeap(justMinFun:Function = null)
		{
			a.push(-1);
			if (justMinFun != null)
				this.justMinFun = justMinFun;
		}
		
		/**
		 * 插入一个数据
		 * @param	value
		 */
		public function insert(value:Object):void
		{
			var p:int = a.length;
			a[p] = value;
			var pp:int = p >> 1;
			while (p > 1 && justMinFun(a[p], a[pp]))
			{
				var temp:Object = a[p];
				a[p] = a[pp];
				a[pp] = temp;
				p = pp;
				pp = p >> 1;
			}
		}
		
		public function pop():Object
		{
			var min:Object = a[1];
			a[1] = a[a.length - 1];
			a.pop();
			var p:int = 1;
			var l:int = a.length;
			var sp1:int = p << 1;
			var sp2:int = sp1 + 1;
			while (sp1 < l)
			{
				if (sp2 < l)
				{
					var minp:int = justMinFun(a[sp2], a[sp1]) ? sp2 : sp1;
				}
				else
				{
					minp = sp1;
				}
				if (justMinFun(a[minp], a[p]))
				{
					var temp:Object = a[p];
					a[p] = a[minp];
					a[minp] = temp;
					p = minp;
					sp1 = p << 1;
					sp2 = sp1 + 1;
				}
				else
				{
					break;
				}
			}
			return min;
		}
	
	}

}