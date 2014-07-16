package zebra.system.collections 
{
	public class Array2D 
	{
		private var _column:int;
		private var _row:int;
		public function Array2D(col,row) 
		{
			for (var i:int = 0; i < col; i++) 
			{
				for (var j:int = 0; j < row; j++) 
				{
				
				}
			}
			
			
		}
		
		public function get column():int 
		{
			return _column;
		}
		
		public function set column(value:int):void 
		{
			_column = value;
		}
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		
	}

}