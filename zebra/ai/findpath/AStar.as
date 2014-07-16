package zebra.ai.findpath
{
	public class AStar
	{
		private var _open:BinaryHeap;
		private var _map:AStarMap;
		private var _endNode:Node;
		private var _startNode:Node;
		private var _path:Array;
		public var heuristic:Function;
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		private var nowversion:int = 1;
		
		public function AStar(map:AStarMap)
		{
			this._map = map;
			//heuristic = euclidian2;
			heuristic = diagonal;
		}
		
		private function justMin(x:Object, y:Object):Boolean
		{
			return x.f < y.f;
		}
		
		public function findPath():Boolean
		{
			_endNode = _map.endNode;
			nowversion++;
			_startNode = _map.startNode;
			//_open = [];
			_open = new BinaryHeap(justMin);
			_startNode.g = 0;
			return search();
		}
		
		public function search():Boolean
		{
			var node:Node = _startNode;
			node.version = nowversion;
			while (node != _endNode)
			{
				var len:int = node.links.length;
				for (var i:int = 0; i < len; i++)
				{
					var test:Node = node.links[i].node;
					var cost:Number = node.links[i].cost;
					var g:Number = node.g + cost;
					var h:Number = heuristic(test);
					var f:Number = g + h;
					if (test.version == nowversion)
					{
						if (test.f > f)
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
						}
					}
					else
					{
						test.f = f;
						test.g = g;
						test.h = h;
						test.parent = node;
						_open.insert(test);
						test.version = nowversion;
					}
					
				}
				if (_open.a.length == 1)
				{
					return false;
				}
				node = _open.pop() as Node;
			}
			buildPath();
			return true;
		}
		
		private function buildPath():void
		{
			_path = [];
			var node:Node = _endNode;
			_path.push(node);
			while (node != _startNode)
			{
				node = node.parent;
				_path.unshift(node);
			}
			
			if (_path.length > 1) {
				//90°设置方位 可以去掉这块,在具体的role类处理人物方位
				for (var i:int = 0; i < _path.length; i++) 
				{
					var curnode:Node = _path[i];
					if (i == 0) {
						 curnode.direction = 8;
						}else {
						 curnode.direction = nodePostion(curnode);
						}
			    }
			}else {
			 _path.shift();	
			}
			
		}
		
		public function get path():Array
		{
			return _path;
		}
		
		public function get map():AStarMap 
		{
			return _map;
		}
		
		//曼哈顿估价法(Manhattan heuristic),它忽略所有的对角移动，只添加起点节点和终点节点之间的行、列数目.
		public function manhattan(node:Node):Number
		{
			return Math.abs(node.x - _endNode.x) + Math.abs(node.y - _endNode.y);
		}
		
		public function manhattan2(node:Node):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			return dx + dy + Math.abs(dx - dy) / 1000;
		}
		
		//几何估价法（Euclidian heuristic）它计算出两点之间的直线距离，本质公式为勾股定理A2+B2=C2。
		public function euclidian(node:Node):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		private var TwoOneTwoZero:Number = 2 * Math.cos(Math.PI / 3);
		
		public function chineseCheckersEuclidian2(node:Node):Number
		{
			var y:int = node.y / TwoOneTwoZero;
			var x:int = node.x + node.y / 2;
			var dx:Number = x - _endNode.x - _endNode.y / 2;
			var dy:Number = y - _endNode.y / TwoOneTwoZero;
			return sqrt(dx * dx + dy * dy);
		}
		
		private function sqrt(x:Number):Number
		{
			return Math.sqrt(x);
		}
		
		public function euclidian2(node:Node):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return dx * dx + dy * dy;
		}
		
		//对角线估价法（Diagonal heuristic）
		public function diagonal(node:Node):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		//90°获得角度
		private function  nodePostion(node:Node):int {
				if (node.parent.x-1 == node.x && node.parent.y - 1 == node.y) return 1;
				if (node.parent.x == node.x && node.parent.y - 1 == node.y) return 2;
				if (node.parent.x + 1 == node.x && node.parent.y - 1 == node.y) return 3;
				
				if (node.parent.x-1 == node.x && node.parent.y  == node.y) return 4;
				if (node.parent.x + 1 == node.x && node.parent.y  == node.y) return 6;
				
				if (node.parent.x-1 == node.x && node.parent.y+1  == node.y) return 7;
				if (node.parent.x == node.x && node.parent.y+1  == node.y) return 8;
				if (node.parent.x+1 == node.x && node.parent.y+1  == node.y) return 9;
				return 8;
			}
	}

}