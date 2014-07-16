package zebraui.components.core
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import zebraui.components.UIComponent;
	
	//TODO: 单张9宫格图的背景。
	public class Background extends Sprite implements IBackground
	{
		
		private var _repeat:Boolean;
		private var _matrix:Matrix;
		private var _bmpd:BitmapData;
		private var _preferWidth:Number;
		private var _preferHeight:Number;
		
		public function Background()
		{
			_preferWidth = 0;
			_preferHeight = 0;
			_matrix = null;
			_begFillBitmap();

		}
		
		private function addoToStageLogic(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addoToStageLogic);
			_begFillBitmap();
		}
		
		

		
		override public function set width(value:Number):void
		{
			_preferWidth = value;
			_begFillBitmap();
		}
		//override public function get width():Number
		//{
			//return _preferWidth ;
		//}
		
		override public function set height(value:Number):void
		{
			_preferHeight = value;
			_begFillBitmap(); 
		}
		//override public function get height():Number
		//{
			//return _preferHeight ;
		//}
		//
		
		public function begFill(bmd:BitmapData):void {

			  _bmpd = bmd;
			  _begFillBitmap();
			}
		
		public function begFillColor(value:uint):void {
			if (this.parent && this.parent.width>0 && this.parent.height>0) {
				_bmpd = new BitmapData(this.parent.width, this.parent.height, false, value);
				_begFillBitmap();
				}
			}	
			
		private function _begFillBitmap():void
		{
				if (this.parent && this.parent.width > 0 && this.parent.height > 0) {
					_preferWidth =  this.parent.width;
					_preferHeight =  this.parent.height;
				}
				graphics.clear();
				if(_bmpd!=null){
					graphics.beginBitmapFill(_bmpd, _matrix, _repeat);
					graphics.moveTo(0, 0);
					graphics.lineTo(_preferWidth, 0);
					graphics.lineTo(_preferWidth, _preferHeight);
					graphics.lineTo(0, _preferHeight);
					graphics.lineTo(0, 0);
					graphics.endFill();
				}

		}
 
		
		public function get repeat():Boolean
		{
			return _repeat;
		}
		
		public function set repeat(value:Boolean):void
		{
			_repeat = value;
			if (this.parent)
				_begFillBitmap()
		}
		
		public function clearFill():void {
				graphics.clear();
				_preferWidth = 0;
				_preferHeight = 0;
			}
		
/*		public function get matrix():Matrix
		{
			return _matrix;
		}
		
		public function set matrix(value:Matrix):void
		{
			_matrix = value;
			if (IsRender)
				_begFillBitmap()
		}*/
	
	}

}