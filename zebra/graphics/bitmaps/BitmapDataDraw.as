package zebra.graphics.bitmaps 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapDataDraw 
	{
		/**
		 * 绘制对象
		 * @param	$target  绘画目标
		 * @param	$full    全部绘制
		 */
		public function BitmapDataDraw($target:DisplayObject=null,$full:Boolean=false) 
		{
			_target = $target;
			_full = $full;
		}
		
		private var _target:DisplayObject=null;
		private var _zoom:Number = 1;
		private var _horizontal:Boolean;
		private var _vertical:Boolean;
		private var _x:Number=0;
		private var _y:Number=0;
		private var _width:Number=0;
		private var _height:Number = 0;
		private var _full:Boolean;
		
		/**
		 * 绘画显示对象的位图
		 * @return
		 */
		public function render():BitmapData {
			        if(_target==null){ throw new Error("没有显示对象")}
                    var _rect:Rectangle = _target.getBounds (_target.parent);
					var _w:Number = _width == 0?_target.width:_width;
					var _h:Number = _height == 0?_target.height:_height;

					_w = _w*_zoom
					_h = _h*_zoom

					
					var m:Matrix;
					var hm:int= _horizontal==true?-1:1;
					var vm:int= _vertical==true?-1:1;
					
					
					var hw:Number =  _horizontal==true?_w:0;
					var vh:Number =  _vertical==true?_h:0;
					
					var Data:BitmapData=new BitmapData(_w,_h,true,0x000000);
					if(_full){			
						m = new Matrix(1,0,0,1,_target.x-_rect.x,_target.y-_rect.y);
						m.scale(hm*_zoom,vm*_zoom);
						m.translate(hw,vh);
						Data.draw(_target,m);
					  }else {
						m = new Matrix(1,0,0,1,-_x,-_y);
						m.scale(hm*_zoom,vm*_zoom);
					
						Data.draw(_target,m);  
					
					  }
					
					return Data;
			}
		
		public function renderTarget($target:DisplayObject):BitmapData {
			 _target = $target;
			 return render();
			}
			
		 
			
		public function renderMobile(mobileRect:Rectangle):BitmapData {
			 if(_target==null){ throw new Error("没有显示对象")}
                    var _rect:Rectangle = _target.getBounds (_target.parent);
					var _w:Number = mobileRect.width;
					var _h:Number = mobileRect.height;

					_w = _w*_zoom
					_h = _h*_zoom

					
					var m:Matrix;
					var hm:int= _horizontal==true?-1:1;
					var vm:int= _vertical==true?-1:1;
					
					
					var hw:Number =  _horizontal==true?_w:0;
					var vh:Number =  _vertical==true?_h:0;
					
					var Data:BitmapData=new BitmapData(_w,_h,false,0xE3E34A);
					if(_full){			
						m = new Matrix(1,0,0,1,_target.x-_rect.x,_target.y-_rect.y);
						m.scale(hm*_zoom,vm*_zoom);
						m.translate(hw,vh);
						Data.draw(_target,m);
					  }else {
						m = new Matrix(1,0,0,1,-_x,-_y);
						m.scale(hm*_zoom,vm*_zoom);
					
						Data.draw(_target,m);  
					
					  }
					
					return Data;
			}	
			
		public function  renderMovieClip():Vector.<BitmapData>	{
			return BitmapDataTool.MovieClipToBitmapData(this);
			}
			
			
		/**
		 * 缩放
		 */
		public function get zoom():Number 
		{
			return _zoom;
		}
		/**
		 * 缩放
		 */
		public function set zoom(value:Number):void 
		{
			_zoom = value;
		}
		/**
		 * 是否水平翻转
		 */
		public function get horizontal():Boolean 
		{
			return _horizontal;
		}
		/**
		 * 是否水平翻转
		 */
		public function set horizontal(value:Boolean):void 
		{
			_horizontal = value;
		}
		/**
		 * 是否垂直翻转
		 */
		public function get vertical():Boolean 
		{
			return _vertical;
		}
		/**
		 * 是否垂直翻转
		 */
		public function set vertical(value:Boolean):void 
		{
			_vertical = value;
		}
		/**
		 * 位图绘画的开始坐标X
		 */
		public function get x():Number 
		{
			return _x;
		}
		/**
		 * 位图绘画的开始坐标X
		 */
		public function set x(value:Number):void 
		{
			_x = value;
		}
		/**
		 * 位图绘画的开始坐标Y
		 */
		public function get y():Number 
		{
			return _y;
		}
		/**
		 * 位图绘画的开始坐标Y
		 */
		public function set y(value:Number):void 
		{
			_y = value;
		}
		/**
		 * 宽
		 */
		public function get width():Number 
		{
			return _width;
		}
		/**
		 * 宽
		 */
		public function set width(value:Number):void 
		{
			_width = value;
		}
		/**
		 * 高
		 */
		public function get height():Number 
		{
			return _height;
		}
		/**
		 * 高
		 */
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		/**
		 * 全景，0,0坐标前面的也需要绘制
		 */
		public function get full():Boolean 
		{
			return _full;
		}
		/**
		 * 全景，0,0坐标前面的也需要绘制
		 */
		public function set full(value:Boolean):void 
		{
			_full = value;
		}
		
		/**
		 * 绘制的显示对象
		 */
		public function get target():DisplayObject 
		{
			return _target;
		}
		/**
		 * 绘制的显示对象
		 */
		public function set target(value:DisplayObject):void 
		{
			_target = value;
		}
		
	}

}