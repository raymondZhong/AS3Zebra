package zebra.ai.navigation 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	import zebra.ai.ZebraVehicle;
	/**
	 * ...
	 * @author raymondzhong
	 */
	public class MapNavigation extends Sprite
	{
		/**
		 * 导航的移动工具
		 */
		private var   vehicle:ZebraVehicle;
		
		/**
		 * 导航地图容器
		 */
		private var  _mapPreview:MapNavigactionContainer;
		
		private var index:int;
		private var viewportElement:Bitmap;
		private var paths:Array;
		
		public var readyHandler:Function;
		
	    public var completeHandler:Function;
		
		public var symbolInfoSprite:Sprite;		
		 
		/**
		 * 路径 视窗
		 * @param	$paths
		 * @param	viewportWidth
		 * @param	viewportHeight
		 */
		public function MapNavigation(viewportWidth:Number=300,viewportHeight:Number=300,$paths:Array=null) 
		{
			vehicle = new ZebraVehicle();
			 paths = $paths; 
			 index = 0;
			 _mapPreview = new MapNavigactionContainer(viewportWidth, viewportHeight);
			 if (paths) {
				     _mapPreview.setPaths(paths);
				 }
			 
			 symbolInfoSprite = new Sprite();

			 
		}
		
		public function setInfoSprite(target:DisplayObject):void {
			     symbolInfoSprite.removeChildren();			
			     symbolInfoSprite.addChild(target);
			}
		
		/**
		 * 设置移动箭头
		 * @param	target
		 */
		public function setMoveArrows(target:DisplayObject):void {
			vehicle.graphics.clear();
			vehicle.removeChildren();
			vehicle.addChild(target);
		}
		
		
		/**
		 * 背景资源 和 路径数据组
		 * @param	imageUrl
		 * @param	$paths
		 */
		public function initialize(imageUrl:String = "", $paths:Array = null):void {
			 if ($paths) {
				index = 0;
				 paths = $paths; 
				 _mapPreview.setPaths(paths);
			 }
			 _mapPreview.loadMapResource(imageUrl);
			 _mapPreview.loadResourceHandler = LoadResourceHandler;
			
		}
		
		private function LoadResourceHandler(e:*):void 
		{
				 vehicle.moveHandler = moveHandler
				 vehicle.completeHandler = comHandler;
				 _mapPreview.addChild(vehicle);
			     _mapPreview.addChild(symbolInfoSprite);
				 
				 viewportElement = new Bitmap();
				 addChild(viewportElement);		
				 
				  if(paths){
					 vehicle.x = paths[index].x
					 vehicle.y = paths[index].y
					 _mapPreview.setViewPort(vehicle.x, vehicle.y);
				      vehicle.fixRotation(paths[index+1].x, paths[index+1].y);		//修正角度				 
					 viewportElement.bitmapData = _mapPreview.getViewPortData();
				 }
			 
				if (readyHandler) readyHandler(this);
		}
		
		/**
		 * 到达目标
		 */
		public function arrive($paths:Array = null):void {
			//设置了新地址
			if ($paths) {
				index = 0;
				paths = $paths;
			    _mapPreview.setPaths(paths);
			    vehicle.x = paths[index].x
			    vehicle.y = paths[index].y
			    _mapPreview.setViewPort(vehicle.x, vehicle.y);				
			    vehicle.fixRotation(paths[index+1].x, paths[index+1].y);	//修正角度
			    viewportElement.bitmapData = _mapPreview.getViewPortData();
			}
			if(paths){
				 setTimeout(function():void {					 
							vehicle.arrive(paths[index].x, paths[index].y);
							},2000);
			}
		}
		
		
		
		/**
		 * 正在移动
		 * @param	v
		 */
		private function moveHandler(v:ZebraVehicle):void 
		{
			    _mapPreview.moveViewPort(v);				
			    viewportElement.bitmapData = _mapPreview.getViewPortData();
		}
		 
		 /**
		  * 一组路径移动完毕
		  * @param	v
		  */
		private function comHandler(v:ZebraVehicle):void 
		{
			index++
			if (index == paths.length) {
					trace("map navigation over")
					if (completeHandler) completeHandler(this);
				}else {
					v.arrive(paths[index].x, paths[index].y);
				}
		}
		
		public function stop():void {
				vehicle.stop();
			
		}
		
		public function get speed():int 
		{
			return vehicle.speed;
		}
		
		public function set speed(value:int):void 
		{
			vehicle.speed = value;
		}
 
		
	}

}