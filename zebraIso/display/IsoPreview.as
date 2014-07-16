package zebraIso.display 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoConfig;
	import zebraIso.data.xmlmapper.Tile;

	public class IsoPreview extends Sprite implements IIsoPreview
	{
		private var _isogrid:IsoGrid;
		private var _target:DisplayObject;
		private var _IsCenter:Boolean;
		private var _IsRender:Boolean;
		private var _param:*;
		private var _tile:Tile;
		private var _IsBuild:Boolean;
		private var _bound:IsoBound;
		
		public function IsoPreview(widthX:uint = 1, lengthZ:uint = 1):void {
			_IsRender = false;
			_isogrid = new IsoGrid(widthX, lengthZ);
			visible = _IsRender;
			_isogrid.visibleText = false;
			addChild(_isogrid);
			setPosition();
		}
		
		/**
		 * 是否有Tile数据
		 * @return
		 */
		public function hasTile():Boolean {
			   return _tile != null;
			}
		
		/**
		 * 设置Tile数据
		 * @param	tile
		 */	
		public function setTile(tile:Tile):void {
			  _tile = tile;
			  clearTarget();
			}	
		
		public function getTile():Tile {
			 return _tile;
			}
			
		public function clearTile():void {
			    _tile = null;
				_target = null;
				this.x = -1000;
				this.y = -1000;
				_IsBuild = false;
			}	
		
		public function setTarget(target:DisplayObject,tile:Tile=null):void {
			if (_target && this.contains(_target)) removeChild(_target);
			_tile = tile;
			_IsRender = true;
			_target = target;
			addChild(_target);
			visible = true;
			setPosition();
		}
			
		public function clearTarget():void {
			if (_target && this.contains(_target)) removeChild(_target);
			_IsRender = false;
			visible = false;
			clearTile();
		}
		 
		/**
		 * 设置网格大小
		 * @param	widthX
		 * @param	lengthZ
		 */
		public function setGridSize(widthX:uint, lengthZ:uint):void {
			_isogrid.setGridSize(widthX, lengthZ);			
			setPosition();
			}
		/**
		 * 设置网格颜色
		 * @param	color
		 */
		public function setGridColor(color:uint):void {
			 _isogrid.setGridColor(color, 1);
			 
		}
		
		private function setPosition():void {
			  if(_IsCenter){
			    _isogrid.x =_isogrid.outsideWidth-_isogrid.width/2;
			    _isogrid.y =_isogrid.outsideHeight-_isogrid.height / 2;				
				if (_target) {
					_target.x = _isogrid.x;
					_target.y = _isogrid.y - IsoConfig.IsoGridSize / 2;
				}
			  }else {
				    _isogrid.x =0;
					_isogrid.y = IsoConfig.IsoGridSize*.5;
					if(_target){
					_target.x = _isogrid.x;
					_target.y = _isogrid.y-IsoConfig.IsoGridSize/2
					}				  
				}
			}			
		
		public function get isogrid():IsoGrid 
		{
			return _isogrid;
		}
		
		public function get IsCenter():Boolean 
		{
			return _IsCenter;
		}
		
		public function set IsCenter(value:Boolean):void 
		{
			_IsCenter = value;
			setPosition();
		}
		
		public function get IsRender():Boolean 
		{
			return _IsRender;
		}
		
		public function get param():* 
		{
			return _param;
		}
		
		public function set param(value:*):void 
		{
			_param = value;
		}
		
		/**
		 * 允许放下建筑
		 */
		public function get IsBuild():Boolean 
		{
			return _IsBuild;
		}
		
		/**
		 * 允许放下建筑
		 */
		public function set IsBuild(value:Boolean):void
		{
			_IsBuild = value;
		}
		
	 
		/**
		 * 预览元素在layout上的范围
		 */
		public function get bound():IsoBound 
		{
			return _bound;
		}
		
		public function set bound(value:IsoBound):void 
		{
			_bound = value;
		}
		
		/**
		 * 全局坐标
		 * @return
		 */
		public function toStagePoint():Point
		{
			return this.parent.localToGlobal(new Point(this.x, this.y));
			//var result:Point = new Point();
			//var target:DisplayObject = this;
			//while (target != null)
			//{
				//result.x += target.x;
				//result.y += target.y;
				//target = target.parent;
			//}
			//return result;
		}
		 
	}

}