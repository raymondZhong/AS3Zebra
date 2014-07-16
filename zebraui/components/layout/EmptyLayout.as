package zebraui.components.layout 
{
	import flash.display.DisplayObject;
	public final class EmptyLayout  extends LayoutManager
	{
		
		/**
		 * 自由布局无约束
		 */
		public function EmptyLayout() 
		{
			 super();
			_margin = LayoutMargin.Empty;
		}
		
		override public function append(cmp:DisplayObject):void 
		{
			super.append(cmp);
			changeSize();
		}
		
		override public function remove(cmp:DisplayObject):void 
		{
			super.remove(cmp);
			changeSize();
		}
		
		override public function updateAlign(valign:String = null, halign:String = null):void 
		{
			super.updateAlign(valign, halign);
			changeSize();
		}
		
		internal function changeSize():void {			
			   for each ( var  element:DisplayObject  in __elements) {
				      if (_preferWidth < element.width+element.x) {
						  _preferWidth = element.width+element.x
						  }
				    if (_preferHeight < element.height+element.y) {
						  _preferHeight = element.height+element.y
						  }
				   }
			}
		
		 
		
		
	}

}