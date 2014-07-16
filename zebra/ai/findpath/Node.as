package zebra.ai.findpath
{
	public class Node
	{
		
		public var x:int;
		public var y:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var walkable:Boolean = true;
		public var parent:Node;
		//public var costMultiplier:Number = 1.0;
		public var version:int = 1;
		public var links:Array;
		public var direction:int;
		
		//public var index:int;
		public function Node(x:int, y:int)
		{
			this.x = x;
			this.y = y;
		}
	
	}

}