package zebra.ai.navigation 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.setTimeout;
	import zebra.ai.steer.SteeredVehicle;
	import zebra.ai.ZebraVehicle;
	import zebra.content.GameAsset;
	import zebra.loaders.IAssetLoader; 
	import zebraui.baseShape.Rect;
	/**
	 * ...
	 * @author raymondzhong
	 */
	public class MapNavigactionContainer extends Sprite
	{
		/**
		 * 线框
		 */
		public var rectLine:Rect;
		private var mapImage:Bitmap;
		
		//地图容器
		private var _magImageContainer:Sprite;
		private var _maskRect:Rect;
		
		public var imageWidth:Number
		public var imageHeight:Number
		
		private var _paths:Array;
		
		private var shapeLineContainer:Shape = new Shape();
		
		/**
		 * 初始化完毕 已经加载好资源
		 * @param	paths
		 * @param	$w
		 * @param	$h
		 */
		public var loadResourceHandler:Function;
		
		
		
		/**
		 *  
		 */
		public var containerChild:Sprite = new Sprite();
		
		

		public function MapNavigactionContainer($w:int=300,$h:int=300) 
		{
			mapImage = new Bitmap();
			_magImageContainer = new Sprite()
			_magImageContainer.addChild(mapImage);
			_magImageContainer.addChild(shapeLineContainer)
			addChild(_magImageContainer)
			
			
			
			
			
			
			rectLine = new Rect($w, $h)
			rectLine.bgAlhpa = 0;
			rectLine.render();
			rectLine.visible = false;
			addChild(rectLine);
		}
		
		/**
		 * 加载地图资源
		 * @param	url
		 */
		public function loadMapResource(url:String):void {
			GameAsset.receive(url,loadCompleteHandler);
			GameAsset.load(url);
		}
	 	
		
		public function setViewPort(targetX:Number,targetY:Number):void {
			  rectLine.x = targetX - rectLine.width / 2;
			  rectLine.y = targetY - rectLine.height / 2; 
			  if (rectLine.x < 0)rectLine.x = 0;
			  if (rectLine.y < 0)rectLine.y = 0;
			  if (rectLine.x >= imageWidth - rectLine.width)rectLine.x = imageWidth - rectLine.width;
			  if (rectLine.y >= imageHeight - rectLine.height)rectLine.y = imageHeight - rectLine.height;
			
			}
		/**
		 * 移动视窗,根据移动对象
		 * @param	v
		 */
		public function moveViewPort(v:ZebraVehicle):void {
			   rectLine.x = v.x - rectLine.width / 2;
			   rectLine.y = v.y - rectLine.height / 2;
			   if (v.x >= rectLine.width / 2) {
					rectLine.x += v.moveX;
				  } 
			  if (v.y >= rectLine.height / 2) {
				   rectLine.y += v.moveY;
				  } 
			  if (rectLine.x < 0)rectLine.x = 0;
			  if (rectLine.y < 0)rectLine.y = 0;
			  if (rectLine.x >= imageWidth - rectLine.width)rectLine.x = imageWidth - rectLine.width;
			  if (rectLine.y >= imageHeight - rectLine.height)rectLine.y = imageHeight - rectLine.height; 
		}
		
		
		/**
		 * 资源加载完成
		 * @param	e
		 */
		private function loadCompleteHandler(e:IAssetLoader):void 
		{
			GameAsset.destroy(e.key,loadCompleteHandler);
			mapImage.bitmapData = e.content.bitmapData;
			imageWidth = _magImageContainer.width;
			imageHeight = _magImageContainer.height;
			if (loadResourceHandler) loadResourceHandler(this);
		}
		
		public function setPaths(paths:Array):void {
				_paths = paths;
				drawLineShape(_paths);
			}
		
		private function drawLineShape(_points:Array):void {			
					var g:Graphics = shapeLineContainer.graphics;
					g.clear();
					g.lineStyle(5, 0xE87400);				 
					for (var j:int = 0; j < _points.length; j++) 
					{
							if (j == 0) {
							  g.moveTo(_points[j].x,  _points[j].y);
							 }else {
							  g.lineTo(_points[j].x,  _points[j].y);
							 }
					}
			}
			
		/**
		 * 获得视窗口的位图数据
		 * @return
		 */
		public function getViewPortData():BitmapData {
			 var bmd:BitmapData = new BitmapData(rectLine.width, rectLine.height,false,0x000000);
			 var m:Matrix = new Matrix();
				 m.tx = rectLine.x*-1;
				 m.ty = rectLine.y*-1;
				 bmd.draw(this, m);
				return bmd;
			}
		
	}

}