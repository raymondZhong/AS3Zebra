package zebra.ai.findpath
{
	public class Link
	{ 
		public var node:Node;
		public var cost:Number;
		
		public function Link(node:Node, cost:Number)
		{
			this.node = node;
			this.cost = cost;
		}
	
	}

}