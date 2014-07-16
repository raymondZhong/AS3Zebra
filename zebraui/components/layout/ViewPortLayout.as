package zebraui.components.layout 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	public class ViewPortLayout  
	{
		
		private var _northRect:Rectangle;
		private var _southRect:Rectangle;
		private var _westRect:Rectangle;
		private var _eastRect:Rectangle;
		private var _centerRect:Rectangle;
		
		private var _northHeight:Number;
		private var _southHeight:Number;
		private var _westWidth:Number;
		private var _eastWidth:Number;
		
		/**
		 * 全界面布局范围
		 */
		private var _rectViewPort:Rectangle;
		
		private var _minRect:Rectangle;
		
		public function ViewPortLayout(rect:Rectangle) 
		{	
			  _rectViewPort = rect;
			  _minRect = new Rectangle(0, 0, 800, 600);
			  if (_rectViewPort.width < _minRect.width) _rectViewPort.width = _minRect.width;
			  if (_rectViewPort.height < _minRect.height) _rectViewPort.height = _minRect.height;
			  			  
			  _northHeight = 100;
			  _southHeight = 100;
			  _westWidth = 200;
			  _eastWidth = 200;
			  
			  _northRect = new Rectangle;
			  _southRect = new Rectangle;
			  _westRect = new Rectangle;
			  _eastRect = new Rectangle;
			  _centerRect = new Rectangle;
			  
			  updateRect ();
		}
		 
		/**
		 * 更新布局
		 * @param	rect
		 */
		public function updateRect(rect:Rectangle = null):void {
			 if (rect) {
				  _rectViewPort = rect;
				  if (_rectViewPort.width < _minRect.width) _rectViewPort.width = _minRect.width;
				  if (_rectViewPort.height < _minRect.height) _rectViewPort.height = _minRect.height;
			 }
				 _northRect.width = _rectViewPort.width;
			  _northRect.height =  _northHeight;			  
			  _northRect.x = _rectViewPort.x;
			  _northRect.y = _rectViewPort.y;
			 
			  
			  _southRect.width = _rectViewPort.width;
			  _southRect.height = _southHeight;
			  _southRect.x = _rectViewPort.x;
			  _southRect.y = _rectViewPort.height -_southRect.height + _rectViewPort.y;
			  
			  
			  _westRect.width =  _westWidth;
			  _westRect.height =  _rectViewPort.height - _northRect.height - _southRect.height;
			  _westRect.x = _rectViewPort.x;
			  _westRect.y = _rectViewPort.y + _northRect.height + _northRect.y;
			  
			  			  
			  _eastRect.width = _eastWidth;
			  _eastRect.height = _rectViewPort.height - _northRect.height - _southRect.height;
			  _eastRect.y = _westRect.y;
			  
 
			  _centerRect.width = _rectViewPort.width - _westRect.width - _eastRect.width;
			  _centerRect.height = _rectViewPort.height - _northRect.height - _southRect.height;
			  _centerRect.x = _westRect.x + _westRect.width;
			  _centerRect.y = _westRect.y;			  
			  _eastRect.x = _centerRect.x + _centerRect.width;
			 
		}
		 

		
		public function get northRect():Rectangle 
		{
			return _northRect;
		}
		
		public function get southRect():Rectangle 
		{
			return _southRect;
		}
		
		public function get westRect():Rectangle 
		{
			return _westRect;
		}
		
		public function get eastRect():Rectangle 
		{
			return _eastRect;
		}
		
		public function get centerRect():Rectangle 
		{
			return _centerRect;
		}
		
		/**
		 * 北高度
		 */
		public function get northHeight():Number 
		{
			return _northHeight;
		}
		
		/**
		 * 北高度
		 */
		public function set northHeight(value:Number):void 
		{
			_northHeight = value;
		}
		
		/**
		 * 南高度
		 */
		public function get southHeight():Number 
		{
			return _southHeight;
		}
		
		/**
		 * 南高度
		 */
		public function set southHeight(value:Number):void 
		{
			_southHeight = value;
		}
		
		/**
		 * 东宽度
		 */
		public function get westWidth():Number 
		{
			return _westWidth;
		}
		/**
		 * 东宽度
		 */
		public function set westWidth(value:Number):void 
		{
			_westWidth = value;
		}
		/**
		 * 西宽度
		 */
		public function get eastWidth():Number 
		{
			return _eastWidth;
		}
		/**
		 * 西宽度
		 */
		public function set eastWidth(value:Number):void 
		{
			_eastWidth = value;
		}
		/**
		 * 最小范围
		 */
		public function get minRect():Rectangle 
		{
			return _minRect;
		}
		
		/**
		 * 最小范围
		 */
		public function set minRect(rect:Rectangle):void 
		{
			  _minRect = rect;
		}
			

		}
	}

