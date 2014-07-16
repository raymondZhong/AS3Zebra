package zebraui.effect 
{
 
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	public class Effect 
	{
		
		public function Effect() 
		{
			
		}
		
		/**
		 * 灰色矩阵
		 * @param	display
		 */
		static public function gray(display:DisplayObject):void {
			 var data:Array =[0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
             var colorData:ColorMatrixFilter = new ColorMatrixFilter(data);
			 display.filters = [colorData];
			}
		
		/**
		 * 复位矩阵
		 * @param	display
		 */
		static public function reset(display:DisplayObject):void {
			 var data:Array = [
								1, 0, 0, 0, 0,			 
								0, 1, 0, 0, 0,
								0, 0, 1, 0, 0,
								0, 0, 0, 1, 0
			                  ];
             var colorData:ColorMatrixFilter = new ColorMatrixFilter(data);
			 display.filters = [colorData];
			}
				
	}

}