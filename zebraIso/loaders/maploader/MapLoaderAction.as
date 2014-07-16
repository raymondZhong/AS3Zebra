package zebraIso.loaders.maploader
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.map.IsoMapElement;
	import zebraIso.IsoGame;
	import zebra.thread.task.TaskAction;
	import zebraIso.data.xmlmapper.Skin;
	import zebraIso.data.xmlmapper.Tile;
	import zebraIso.display.IsoSprite;
	import zebraIso.display.scene.IIsoLayout;
	import zebraIso.display.scene.IsoWorld;
	import zebraIso.event.IsoLoaderEvent;
	import zebraIso.loaders.TileLoader;
	import zebra.graphics.animation.SpriteSheet;
	
	internal class MapLoaderAction extends TaskAction
	{
		private var _mapElement:IsoMapElement;
		private var _tile:Tile;
		private var _container:IsoSprite;
		private var _element:Vector.<DisplayObject>;
		private var _layout:IIsoLayout;
		
		public function MapLoaderAction(layout:IIsoLayout,element:IsoMapElement)
		{
			_element = new Vector.<DisplayObject>();
			_layout = layout;
			_mapElement = element;
			_tile = IsoGame.resource.libary.tiles.getTileById(element.tid);
			_container = new IsoSprite();
			_container.tile = _tile;
			
			var topV:Vector3D = new Vector3D(element.topX, 0, element.topZ);
			var bottomV:Vector3D = new Vector3D(element.bottomX, 0, element.bottomZ);
			
			var bound:IsoBound = new IsoBound(topV, bottomV);
			_layout.append(_container, bound);

			
		}
		
		override public function execute():void
		{
			super.execute();
			var tileLoader:TileLoader = new TileLoader();
			tileLoader.addEventListener(IsoLoaderEvent.COMPLETE, addToSceneLogic)
			tileLoader.load(_tile);
		
		}
		
		private function addToSceneLogic(e:IsoLoaderEvent):void
		{
			for (var i:int = 0; i < _tile.tilechild.length; i++)
			{
				var skin:Skin = _tile.tilechild[i].getSkin();
				var spriteSheet:SpriteSheet = new SpriteSheet(skin.getTexture().gametexture);
					//spriteSheet.ClickHandler = function():void {
						 //_element.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					//}
					spriteSheet.x = skin.offsetX;
					spriteSheet.y = skin.offsetY;
					spriteSheet.play(skin.action);
					_container.addChild(spriteSheet);
					_element.push(spriteSheet);
			}
			this.finish();
		}
		
		public function get container():IsoSprite 
		{
			return _container;
		}
		
		
		public function get tile():Tile 
		{
			return _tile;
		}
		
		public function get element():Vector.<DisplayObject> 
		{
			return _element;
		}
	
	}

}