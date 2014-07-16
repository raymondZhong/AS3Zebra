package zebraui.components.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import zebraui.components.InteractiveUIComponent;
 
	/**
	 * 占位符
	 */		
	public class BaseSpacer extends InteractiveUIComponent
	{
		
		private var bmd:BitmapData;
		private	var bm:Bitmap;
		private var _empty:Boolean;

		/**
		 * 占位符 {empty:True By MouseEvent}
		 * @param	empty
		 */ 
		public function BaseSpacer(empty:Boolean=true,preferWidth:Number=100, preferHeight:Number=20)  
		{
			_empty = empty;
			super(preferWidth, preferHeight);
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			bm.width = value;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			bm.height = value;
		}
		
		override public function get width():Number 
		{
			return bm.width;
		}
		
		override public function get height():Number 
		{
			return bm.height;
		}
		
		override protected function initialize():void 
		{
			 bmd = new BitmapData (15, 15, true, 0xFFFFFF);
			 bm = new Bitmap (bmd); 
			 bm.width = _preferWidth;
			 bm.height = _preferHeight;
			 bm.visible = _empty;
			 addChild(bm)
			super.initialize();
		}
		
		
	}
}