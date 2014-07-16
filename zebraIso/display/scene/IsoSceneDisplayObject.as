package zebraIso.display.scene
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoElementList;
	import zebraIso.display.IsoGrid;
	import zebraIso.display.IsoContainer;
	import zebraIso.display.IsoPreview;
	import zebraIso.display.primitive.IsoRectangles; 
	import zebraIso.display.IsoCoordinate;
	
	internal class IsoSceneDisplayObject extends IsoLayout
	{
		protected var _globalStagePoint:Point;
		protected var _isoGrid:IsoGrid;	 
		/**
		 * 显示坐标轴
		 */
		private var _showCoordinate:Boolean;
		protected var _isoCoordinate:IsoCoordinate;
		private var _IsoRectangleContianer:IsoRectangleContianer;
		protected var _editBound:IsoBound;
		
		public function IsoSceneDisplayObject(world:IsoWorldDisplayObject)
		{ 
			_world = world; 
			_isoCoordinate = new IsoCoordinate();
			_isoCoordinate.visible = false;
			addChild(_isoCoordinate);
			
			_isoGrid = world.isoGrid;
			addChild(_isoGrid);
			
			_IsoRectangleContianer = new IsoRectangleContianer();
			addChild(_IsoRectangleContianer);			
			
			setEditBound(new IsoBound(new Vector3D(), new Vector3D(_world.isoGrid.gridX - 1, 0, _world.isoGrid.gridZ - 1)));
			
			addEventListener(Event.ADDED_TO_STAGE, sceneAddToStageLogic)
			addEventListener(Event.REMOVED_FROM_STAGE, sceneRemoveFromStageLogic);
		}
		
		 protected function sceneAddToStageLogic(e:Event):void{} 
		
		 protected function sceneRemoveFromStageLogic(e:Event):void{} 
		
			 
		/**
		 * 编辑模式的可编辑区域
		 * @param	value
		 */
		public function setEditBound(value:IsoBound):void {
			     _editBound = value;
			}
			
		/**
		 * 设置等角世界地面格子
		 * @param	isoGrid
		 */
		public function setIsoGrid(isoGrid:IsoGrid):void {
			   _isoGrid = isoGrid;
			}
		
		/**
		 * 获得地面范围
		 * @return
		 */			
		public function getIsoBound():IsoBound {
				return new IsoBound(new Vector3D(), new Vector3D(_isoGrid.gridX-1,0,_isoGrid.gridZ-1));
		}	
			
		 
		/**
		 * 显示坐标轴
		 */
		public function get showCoordinate():Boolean 
		{
			return _showCoordinate;
		}
		
		/**
		 * 显示坐标轴
		 */
		public function set showCoordinate(value:Boolean):void 
		{
			_showCoordinate = value;
			_isoCoordinate.visible = value;
		}
			
		public function get isoGrid():IsoGrid 
		{
			return _isoGrid;
		}
		
		public function get rectangleContianer():IsoRectangleContianer 
		{
			return _IsoRectangleContianer;
		}
		
	 
 
		
		/**
		 * 全局坐标
		 * @return
		 */
		public function toStagePoint():Point
		{
			return this.parent.localToGlobal(new Point(this.x, this.y));
			// var result:Point = new Point();
			//s2.parent.localToGlobal(new Point(s2.x,s2.y)); 
			//return this.parent.localToGlobal(new Point(this.x, this.y));
			//var target:DisplayObject = this;
			//while (target != null)
			//{
				//result.x += target.x;
				//result.y += target.y;
				//target = target.parent;
			//}
			//return result;
		}
		
		public function dispose():void { }
		
		override public function append(element:IsoContainer,bound:IsoBound=null):void {}
		override public function remove(element:IsoContainer):void {}
		override public function clear():void {}
		override public function sortElements(element:IsoContainer):void {}		
	}

}