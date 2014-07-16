package zebra.math 
{
	import flash.geom.Rectangle;
	
	
	/**
	 * 切割矩形 分成很多小块
	 */
	public class RectangleIncision 
	{
		
		private var _bounds:Rectangle;
		private var _splicWidthParam:int;
		private var _splicHeightParam:int;
		
		public function RectangleIncision(Bounds:Rectangle) 
		{
			_bounds = Bounds;
		}
		
		
		public function get width():int { return _splicWidthParam; }
		public function get height():int { return _splicHeightParam; }
		
		public function get Bound():Rectangle { return _bounds; }
		
		
		/**
		 * 分开  等比例的分块
		 * @param	row
		 * @param	column
		 * @return
		 */
		 public function slice(row:int,column:int):Vector.<RectangleIncisionNode> {
			   return split(_bounds.width / column,_bounds.height / row);
			 }
		
		/**
		 * 分开   可以是不等比例的
		 * @param	WidthParam
		 * @param	HeightParam
		 * @return
		 */
	    public  function split(WidthParam:int,HeightParam:int):Vector.<RectangleIncisionNode>{
			_splicWidthParam = WidthParam;
			_splicHeightParam = HeightParam;
			_splicWidthParam = _splicWidthParam > _bounds.width?_bounds.width:_splicWidthParam;
	        _splicHeightParam = _splicHeightParam > _bounds.height?_bounds.height:_splicHeightParam;
		    var index:int=0
			//trace("row",Math.ceil(_bounds.height/_splicHeightParam),"column",Math.ceil(_bounds.width/_splicWidthParam))
			var node:Vector.<RectangleIncisionNode> = new Vector.<RectangleIncisionNode>();
			for ( var row:int = 0; row <Math.ceil(_bounds.height/_splicHeightParam) ; row++) 
			//for ( var row:int = 0; row <1; row++) 
			{
			   for (var column:int = 0; column <Math.ceil(_bounds.width/_splicWidthParam) ; column++) 
				{
				     var rect:Rectangle = new Rectangle(column*_splicWidthParam, row*_splicHeightParam,  _splicWidthParam, _splicHeightParam);
					 
					 if (rect.x + rect.width > _bounds.width) {
						   rect.width = _bounds.width - rect.x;
						 }
					 if (rect.y + rect.height > _bounds.height) {
						   rect.height = _bounds.height - rect.y;
						 }
				 
					var item:RectangleIncisionNode = new RectangleIncisionNode();
					    item.row = row;
						item.column = column;
						item.rect = rect;
						item.index = index;
						node.push(item) 
						index++;
			    } 
			}
			return node;
		 }
		
		
		 
	}

}