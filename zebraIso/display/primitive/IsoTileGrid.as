package zebraIso.display.primitive
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import zebraIso.display.IsoContainer;
	
	/**
	 * 为了开发方便,把注册点设置在左上角.
	 * 正方形 转换成 菱形 ◇
	 * 100*100  =>  142*71
	   width *1.42
	   height * 0.71
	   return Math.round(height * 0.71);
	
	   h    1
	   -  = -
	   w    2
	 */
	
	public class IsoTileGrid extends IsoContainer
	{
		private var _color:Boolean;
		private var _textObject:TextField;
		private var _isoSceneRectangle:Rectangle; 
		
		public function IsoTileGrid(size:Number = 0, color:Boolean = false)
		{
			_isoSceneRectangle = new Rectangle();
			_color = color;
			super(size);
			_textObject = new TextField();
			_textObject.autoSize = TextFieldAutoSize.LEFT;
			_textObject.wordWrap = false;
			_textObject.y -= 10;
			_textObject.mouseEnabled = false;
			addChild(_textObject);
			setColor(0xFFFFFF);
		}
		

		public var cellX:int;
		public var cellY:int;
		public var cellZ:int;
		
		/**
		 * 等角世界设置格子索引
		 * @param	cx
		 * @param	cy
		 * @param	cz
		 */
		public function setCell(cx:int, cy:int, cz:int):void
		{
			cellX = cx;
			cellY = cy;
			cellZ = cz;
		}
		 
		public function get cell():Point { return new Point(cellX, cellZ); }
		
		public function setText(value:String):void
		{
			_textObject.text = value;
			_textObject.x -= _textObject.textWidth / 2
		}
		
		override public function get width():Number
		{
			return _size;
		}
		
		override public function get height():Number
		{
			return _size / 2;
		}
		
	 
		
		public function setColor(_color:uint, _alpha:int = 0):void
		{
			graphics.clear();
			graphics.beginFill(_color, _alpha);
			graphics.lineStyle(1, 0x000000, 1);
			graphics.moveTo(0, -_size >> 1); //Top    Point
			graphics.lineTo(_size, 0); //Right  Point
			graphics.lineTo(0, _size >> 1); //Bottom Point
			graphics.lineTo(-_size, 0); //Left   Point
			graphics.endFill();
		}
		
		public function get textObject():TextField
		{
			return _textObject;
		}
		
		public function set textObject(value:TextField):void
		{
			_textObject = value;
		}
		
		/**
		 * 等角世界的矩阵
		 */
		public function get isoSceneRectangle():Rectangle
		{
			return _isoSceneRectangle;
		}
		
		/**
		 * 等角世界的矩阵
		 */
		public function set isoSceneRectangle(value:Rectangle):void 
		{
			_isoSceneRectangle = value;
		}
		
		/**
		 * 平面世界的正矩阵
		 
		public function get sceneRectangle():Rectangle 
		{
			return _sceneRectangle;
		}*/
		
		/**
		 * 平面世界的正矩阵
		 
		public function set sceneRectangle(value:Rectangle):void 
		{
			_sceneRectangle = value;
		}*/
	
	}

}