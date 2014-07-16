package zebraIso.display.scene
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoConfig;
	import zebraIso.data.map.IsoMap;
	import zebraIso.display.IIsoPreview;
	import zebraIso.display.IsoGrid;
	import zebraIso.display.IsoPreview;
	import zebraIso.display.primitive.IsoTileGrid;
	import zebraIso.util.IsoMath;
	import zebraIso.util.IsoUtil;
	

	public class IsoWorldDisplayObject extends Sprite
	{
		private var _scene:IsoScene;
		private var _isogrid:IsoGrid;
		private var _layouts:Vector.<IIsoLayout>;
		private var _layoutContainer:Sprite;
		protected var _previewSprite:IsoPreview;
		private var _map:IsoMap;
		private var _currentLayout:IIsoLayout;
		private var _backgroundContainer:Sprite;
		private var _worldx:Number;	
		private var _worldy:Number;
		
		private var _viewport:IsoViewPort
		
		public function IsoWorldDisplayObject(grid:IsoGrid)
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			_worldx = 0;
			_worldy = 0;
			
			_backgroundContainer = new Sprite();
			addChild(_backgroundContainer);
			
			_layouts = new Vector.<IIsoLayout>();
			_isogrid = grid;			
			
			_layoutContainer = new Sprite();
			addChild(_layoutContainer)
		
			_previewSprite = new IsoPreview();
			addChild(_previewSprite);
			_previewSprite.setGridSize(3, 2);
			_previewSprite.setGridColor(0x00CE34);
			
			_scene = new IsoScene(this);
			initialize(); 
			
		
		}
		
		
		public function lookAt(pos:Vector3D):void {	
			return;
					 var point:Point = IsoUtil.isoToScreen(pos);
					 if (_viewport)_viewport.dispose();
					 _viewport = new IsoViewPort();
					 _viewport.x  = point.x+_backgroundOffX-_viewport.width/2;
					 _viewport.y  = point.y + _backgroundOffY-_viewport.height/2;	
					// this.mask = _viewport;
					// trace("lookat:",point.x,_backgroundOffY)
					// trace("lookat:",_backgroundOffX,_backgroundOffY)
			}
		 
		public function moveViewPort(vx:Number = 0, vz:Number = 0):void {
					//trace((_backgroundContainer.x*-1), _backgroundContainer.width - _backgroundContainer.stage.stageWidth, ">>>>>>>>>>>")
					trace((_backgroundContainer.y), ">>>>>>>>>>>")
					 _layoutContainer.x += vx;
					 _layoutContainer.y += vz;
					 _backgroundContainer.x += vx;
					 _backgroundContainer.y += vz;
					
					// trace(_layoutContainer.x,_layoutContainer.y,_backgroundContainer.x,_backgroundContainer.y)
					  _viewport.x += vx;
					  _viewport.y += vz;
					if (-_backgroundContainer.x > _backgroundContainer.width - _backgroundContainer.stage.stageWidth) {
						 _layoutContainer.x += -_backgroundContainer.x-(_backgroundContainer.width - _backgroundContainer.stage.stageWidth);
						 _backgroundContainer.x = (_backgroundContainer.width - _backgroundContainer.stage.stageWidth) * -1;
					}
					if (-_backgroundContainer.x < 0) {
						_layoutContainer.x += -_backgroundContainer.x;
						_backgroundContainer.x = 0;
					}
					if (-_backgroundContainer.y > _backgroundContainer.height - _backgroundContainer.stage.stageHeight) {
						 _layoutContainer.y += -_backgroundContainer.y-(_backgroundContainer.height - _backgroundContainer.stage.stageHeight);
						 _backgroundContainer.y = (_backgroundContainer.height - _backgroundContainer.stage.stageHeight) * -1;
					}
					
					if (-_backgroundContainer.y < 0) {
						_layoutContainer.y += -_backgroundContainer.y;
						_backgroundContainer.y = 0;
					}
			}
		 
		 
		private function initialize():void
		{			
			_pushLayout(new IsoLayout());
			_pushLayout(_scene);
			_pushLayout(new IsoLayout());
				
			_currentLayout = _layouts[2];
			 
			var gridWidth:Number = IsoConfig.IsoGridSize * 2;
			var gridHeight:Number = IsoConfig.IsoGridSize;
			var outsideWidth:Number = _isogrid.outsideWidth;
			var outsideHeight:Number = _isogrid.outsideHeight;
		     
			 
			for each (var item:IsoTileGrid in _isogrid.tileGrids) 
			{
				var pos:Point = IsoUtil.isoToScreen(item.getPosition());
					item.isoSceneRectangle = new Rectangle(  pos.x + outsideWidth-IsoConfig.IsoGridSize, 
															 pos.y + outsideHeight - IsoConfig.IsoGridSize * .5, 
															 gridWidth, 
															 gridHeight);
					//item.cell= IsoUtil.screenToIsoGrid(new Point(item.getPosition().x, item.getPosition().z));					
					//IsoUtil.screenToIsoGrid(new Point(item.getPosition().x,item.getPosition().z))
			}
			
			_viewport = new IsoViewPort();		
			//this.mask = _viewport;
		}
		
		
		
		private function _pushLayout(target:IsoLayout):void
		{
			target._world = this;
			var gridWidth:Number = IsoConfig.IsoGridSize * 2;
			var gridHeight:Number = IsoConfig.IsoGridSize;
			var outsideWidth:Number = _isogrid.outsideWidth;
			var outsideHeight:Number = _isogrid.outsideHeight;
			target.x = outsideWidth;
			target.y = outsideHeight;
			_layoutContainer.addChild(target);
			_layouts.push(target);
			
		}
		
		public function get scene():IIsoScene
		{
			return _scene;
		}
		
		override public function get width():Number
		{
			return _isogrid.width;
		}
		
		override public function get height():Number
		{
			return _isogrid.height;
		}
		
		public function get layouts():Vector.<IIsoLayout> 
		{
			return _layouts;
		}
		
		public function get isoGrid():IsoGrid 
		{
			return _isogrid;
		}
		
		/**
		 * 交互操作预览层
		 */
		public function get previewSprite():IIsoPreview 
		{
			return _previewSprite;
		}
		
		public function get map():IsoMap 
		{
			return _map;
		}
		
		public function set map(value:IsoMap):void 
		{
			_map = value;
		}
		
		public function get currentLayout():IIsoLayout 
		{
			return _currentLayout;
		}
		
		private var _backgroundOffX:Number=0;
		private var _backgroundOffY:Number=0;
		public function setBackground(value:DisplayObject, offx:Number = 0, offy:Number = 0):void {
			   if (_backgroundContainer.numChildren > 0)_backgroundContainer.removeChildAt(0);
			   _backgroundOffX = offx;
			   _backgroundOffY = offy;
			   _backgroundContainer.addChild(value);
			   value.x = isoGrid.outsideWidth-offx;
			   value.y = -offy;
			   super.x = offx-isoGrid.outsideWidth+_worldx;			   
			   super.y = offy + _worldy;
			 // trace(this.x, this.y, _backgroundContainer.x, _backgroundContainer.y)
			 //  _backgroundContainer.x = _backgroundContainer.y=50
			//   trace(this.x, this.y, _backgroundContainer.x, _backgroundContainer.y)
			
			trace(_backgroundContainer.x,_backgroundContainer.width,">>>>>>>>>>>")
			}
			
		public function removeBackground():void { 
			if (_backgroundContainer.numChildren > 0)
			     _backgroundContainer.removeChildAt(0);
			     _backgroundOffX = _backgroundOffY = 0;
				 _worldx = 0;
				 _worldy = 0;
				 super.x = 0;			   
			     super.y = 0;
			}
			
		override public function get x():Number 
		{
			return _worldx;
		}
		
		override public function set x(value:Number):void 
		{
			_worldx = value;
			super.x = value+_backgroundOffX-isoGrid.outsideWidth;;
		}
		
		override public function get y():Number 
		{
			return _worldy;
		}
		
		override public function set y(value:Number):void 
		{
			_worldy = value;
			super.y = value+_backgroundOffY;;
		}
		
		/**
		 * 测试释放world,不在使用这个world，重新在实例化。
		 */
		public function  dispose():void {
			 _isogrid.dispose();
			 _map = null;
			 removeBackground();
			 _previewSprite.clearTarget();
			 for ( var i:int = this.numChildren - 1; i >= 0; i--)
			 {
				this.removeChildAt(i);
			 }
			 _layouts.length = 0;
			 
		}
	}

}