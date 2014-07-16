package zebraui.components.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import zebraui.components.UIComponent; 
	
	public class Border extends Sprite implements IBorder
	{
		
		private var _thickness:Number = 1;
		private var _topLine:Bitmap
		private var _bottomLine:Bitmap
		private var _leftLine:Bitmap
		private var _rightLine:Bitmap
		
 
		private var dotColor:uint = 0x000000; //0x99BBE8;
 
		
		private var _topColor:uint;
		private var _bottomColor:uint;
		private var _leftColor:uint;
		private var _rightColor:uint;
		
		private var _topVisible:Boolean;
		private var _bottomVisible:Boolean;
		private var _leftVisible:Boolean;
		private var _rightVisible:Boolean;
		private var _preferWidth:Number;
		private var _preferHeight:Number;
		
		public function Border()
		{
			_preferWidth = 0;
			_preferHeight = 0;
			_topColor = _bottomColor = _leftColor = _rightColor = dotColor;
			_topVisible = _rightVisible = _bottomVisible = _leftVisible = true;
		 	mouseChildren = false;
			mouseEnabled = false;
			tabChildren = false;
			tabEnabled = false;
		}
		
		
		protected function drawLine():void {
			    this.graphics.clear(); 
				if (_thickness <= 0) return;
				if(_topVisible){
				 this.graphics.lineStyle(_thickness, _topColor);
				 this.graphics.moveTo(0, 0);
				 this.graphics.lineTo(this.width-_thickness*0.5, 0);				  
				 this.graphics.endFill();
				 }
				 
				if(_rightVisible){
				this.graphics.lineStyle(_thickness, _rightColor);
				this.graphics.moveTo(this.width-_thickness*0.5, 0);
				this.graphics.lineTo(this.width-_thickness*0.5, this.height-_thickness*0.5);
				this.graphics.endFill();
				}
				
				if(_bottomVisible){
				this.graphics.lineStyle(_thickness, _bottomColor);
				this.graphics.moveTo(this.width-_thickness*0.5, this.height-_thickness*0.5);
				this.graphics.lineTo(0, this.height-_thickness*0.5);
				this.graphics.endFill();
				}
				
				if(_leftVisible){
				this.graphics.lineStyle(_thickness, _leftColor);
				this.graphics.moveTo(0, this.height-_thickness*0.5);
				this.graphics.lineTo(0, 0);
				this.graphics.endFill();
				}
				
			}
		
		
		override public function set width(value:Number):void
		{
	        _preferWidth = value;
			if(true)drawLine()
		}
		
		override public function set height(value:Number):void
		{
			_preferHeight = value;
			if(true)drawLine()
		}		
		override public function get width():Number
		{
	        return _preferWidth;
		}
		
		override public function get height():Number
		{
			return _preferHeight;
		}
		public function get topColor():uint
		{
			return _topColor;
		}
		
		public function set topColor(value:uint):void
		{
			if(_thickness<=0)_thickness = 1
			_topColor = value;
			if (true) drawLine();
		}
		
		public function get bottomColor():uint
		{
			return _bottomColor;
		}
		
		public function set bottomColor(value:uint):void
		{
			if(_thickness<=0)_thickness = 1
			_bottomColor = value;
			if (true) drawLine();
		}
		
		public function get leftColor():uint
		{
			return _leftColor;
		}
		
		public function set leftColor(value:uint):void
		{
			if(_thickness<=0)_thickness = 1
			_leftColor = value;
			if (true) drawLine();
		}
		
		public function get rightColor():uint
		{
			return _rightColor;
		}
		
		public function set rightColor(value:uint):void
		{
			if(_thickness<=0)_thickness = 1
			_rightColor = value;
			if (true) drawLine();
		}
		
		public function get topVisible():Boolean
		{
			return _topVisible;
		}
		
		public function set topVisible(value:Boolean):void
		{
			_topVisible = value;
			if (true) drawLine();
			 
		}
		
		public function get bottomVisible():Boolean
		{
			return _bottomVisible;
		}
		
		public function set bottomVisible(value:Boolean):void
		{
			_bottomVisible = value;
			if (true) drawLine();
		 
		}
		
		public function get leftVisible():Boolean
		{
			return _leftVisible;
		}
		
		public function set leftVisible(value:Boolean):void
		{
			_leftVisible = value; 
			if (true) drawLine();
		}
		
		public function get rightVisible():Boolean
		{
			return _rightVisible;
		}
		
		public function set rightVisible(value:Boolean):void
		{
			_rightVisible = value; 
			if (true) drawLine();
		}
		
		
		
		/**
		 * 设置四边颜色
		 */
		public function set color(value:uint):void {
			if(_thickness<=0)_thickness = 1
			topColor = bottomColor = leftColor = rightColor = value;
			if (true) drawLine();
		}
		
		/**
		 * 厚度
		 */
		public function get thickness():Number
		{
			return _thickness;
		}
		
		/**
		 * 厚度
		 */
		public function set thickness(value:Number):void
		{
			_thickness = value;
			if (true) drawLine();
		}	
		
		static public function  get DEFAULT():Border {
			     return new Border();
			}
		
	}

}