package zebra.plugs.mobile.layout 
{
	public class LayoutMargin 
	{
		
		/**
		 * 内框宽
		 * @param	top
		 * @param	left
		 * @param	right
		 * @param	bottom
		 */
		public function LayoutMargin( left:int=0,top:int=0,right:int=0,bottom:int=0) {
			     this.top = top;
				 this.left = left;
				 this.right = right;
				 this.bottom = bottom;
			}
		static public const Empty:LayoutMargin = new LayoutMargin(0, 0, 0, 0);
		public var top:int;
		public var left:int;
		public var right:int;
		public var bottom:int;
	}

}