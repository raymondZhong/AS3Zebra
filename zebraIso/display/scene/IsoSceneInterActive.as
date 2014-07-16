package zebraIso.display.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoConfig;
	import zebraIso.emnu.IsoSceneMode;
	import zebraIso.display.IsoGrid;
	import zebraIso.display.primitive.IsoTileGrid;
	import zebraIso.event.IsoSceneEvent;
	import zebraIso.util.IsoStyle;
	import zebraIso.util.IsoUtil;

	
	[Event(name="pick",type="zebraIso.event.IsoSceneEvent")]
	[Event(name="selectActive",type="zebraIso.event.IsoSceneEvent")]
	[Event(name="SelectExecute",type="zebraIso.event.IsoSceneEvent")]
	[Event(name="SelectRelease",type="zebraIso.event.IsoSceneEvent")]
	
	internal class IsoSceneInterActive extends IsoSceneDisplayObject
	{
		private var _sceneMouseDownBySelect:Point;
		private var _sceneMouseMoveBySelect:Point;
		private var _sceneMouseUpBySelect:Point;
		private var _IsSceneSelectActive:Boolean;
		private var _sceneMode:String;		
		
		public function IsoSceneInterActive(world:IsoWorldDisplayObject)
		{
			_sceneMode = IsoSceneMode.NORMAL;
			super(world);
		}
		 
		/**
		 * IsoSceneMode 
		 * @param	mode
		 */
		public function setMode(mode:String):void {
				_sceneMode = mode;
			}
		 
		override protected function sceneAddToStageLogic(e:Event):void 
		{
			super.sceneAddToStageLogic(e);
			stage.addEventListener(MouseEvent.CLICK, pickIsoSceneLogic);
			addEventListener(MouseEvent.MOUSE_DOWN, regionSelectDownLogic);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, regionSelectMoveLogic);
			stage.addEventListener(MouseEvent.MOUSE_UP, regionSelectReleaseLogic);			
		}
		
		override protected function sceneRemoveFromStageLogic(e:Event):void 
		{
			super.sceneRemoveFromStageLogic(e);	
			stage.removeEventListener(MouseEvent.CLICK, pickIsoSceneLogic);
			removeEventListener(MouseEvent.MOUSE_DOWN, regionSelectDownLogic);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, regionSelectMoveLogic);
			stage.removeEventListener(MouseEvent.MOUSE_UP, regionSelectReleaseLogic);			
		}
		
		 
		private function regionSelectDownLogic(e:MouseEvent):void 
		{
			if(_sceneMode == IsoSceneMode.SELECT){
				_globalStagePoint = toStagePoint();
				_sceneMouseDownBySelect = new Point(e.stageX - _globalStagePoint.x, e.stageY - _globalStagePoint.y);
				_IsSceneSelectActive = true;
				var activePoint:Point = IsoUtil.screenToIsoGrid(_sceneMouseDownBySelect);
				var event:IsoSceneEvent = new IsoSceneEvent(IsoSceneEvent.SelectActive);
					event.selectIsoBound = selectIsoBoundFix(activePoint, activePoint);
					dispatchEvent(event);
			}
		}
		
		//范围选择移动逻辑
		private function regionSelectMoveLogic(e:MouseEvent):void 
		{
			//预览元素的操作
			if (_sceneMode == IsoSceneMode.NORMAL && _world.previewSprite!=null && _world.previewSprite.IsRender) {
				_globalStagePoint = toStagePoint();
				_sceneMouseMoveBySelect = new Point(e.stageX - _globalStagePoint.x, e.stageY - _globalStagePoint.y);   
				var bound:IsoBound = extendGrid(IsoUtil.screenToIsoGrid(_sceneMouseMoveBySelect),
												_world.previewSprite.isogrid.gridX,
												_world.previewSprite.isogrid.gridZ);
				//在检测是否在world的编辑范围内								
				var isContainer:Boolean = _editBound.container(bound);
				if (isContainer) {
						_world.previewSprite.IsBuild = _world.previewSprite.hasTile();
						_world.previewSprite.IsCenter = false;
						_world.previewSprite.bound = bound;
						var tile:IsoTileGrid =  _world.isoGrid.getTileGridCell(bound.topCell);
						    _world.previewSprite.x = tile.isoSceneRectangle.x+tile.isoSceneRectangle.width / 2 ;
						    _world.previewSprite.y = tile.isoSceneRectangle.y ;
						//检测是否有存在范围重叠
						if (_world.layouts[2].hasOverlapBound(_world.previewSprite.bound)) {
							_world.previewSprite.IsBuild = false;
							_world.previewSprite.filters = [IsoStyle.BuilderError];							
							_world.previewSprite.isogrid.setGridColor(0xFF0080, 1);
							}else {							
							_world.previewSprite.filters = null;							
							_world.previewSprite.isogrid.setGridColor(0x00FF00, 1);
							}							
					}else {
						_world.previewSprite.bound = null;
						_world.previewSprite.IsBuild = false;
						_world.previewSprite.IsCenter = true;
					    _world.previewSprite.isogrid.setGridColor(0xFF0080, 1);
					    _world.previewSprite.x = _world.mouseX ;
					    _world.previewSprite.y = _world.mouseY ;
						_world.previewSprite.filters = [IsoStyle.BuilderError];
					}
			}
			
			//范围选择模式状态
			if(_sceneMode == IsoSceneMode.SELECT && _IsSceneSelectActive){
				_globalStagePoint = toStagePoint();
				_sceneMouseMoveBySelect = new Point(e.stageX - _globalStagePoint.x, e.stageY - _globalStagePoint.y);
				var event:IsoSceneEvent = new IsoSceneEvent(IsoSceneEvent.SelectExecute);
					event.selectIsoBound = selectIsoBoundFix(IsoUtil.screenToIsoGrid(_sceneMouseDownBySelect),IsoUtil.screenToIsoGrid(_sceneMouseMoveBySelect))
					dispatchEvent(event);	
			}
		}
 
		 
		
		/**
		 * 范围选择释放逻辑
		 * @param	e
		 */
		private function regionSelectReleaseLogic(e:MouseEvent):void 
		{
			if(_sceneMode == IsoSceneMode.SELECT &&_IsSceneSelectActive){
				_globalStagePoint = toStagePoint();
				_IsSceneSelectActive = false;
				_sceneMouseUpBySelect = new Point(e.stageX - _globalStagePoint.x, e.stageY - _globalStagePoint.y);
				var event:IsoSceneEvent = new IsoSceneEvent(IsoSceneEvent.SelectRelease);
					event.selectIsoBound = selectIsoBoundFix(IsoUtil.screenToIsoGrid(_sceneMouseDownBySelect),IsoUtil.screenToIsoGrid(_sceneMouseUpBySelect))
					dispatchEvent(event);	
			}
		}
		
		private function selectIsoBoundFix(toppoint:Point,bottompoint:Point):IsoBound {
			    var bound:IsoBound = new IsoBound(new Vector3D(toppoint.x, 0, toppoint.y), new Vector3D(bottompoint.x, 0, bottompoint.y));
				if (bound.topCell.x < 0) bound.topCell.x = 0;
				if (bound.topCell.z < 0) bound.topCell.z = 0;
				if (bound.bottomCell.x >(this._isoGrid.gridX-1)) bound.bottomCell.x = this._isoGrid.gridX-1;
				if (bound.bottomCell.z >(this._isoGrid.gridZ-1)) bound.bottomCell.z = this._isoGrid.gridZ-1;
				return bound;
			}
		
		/**
		 * 挑选单元格事件
		 * @param	e
		 */
		protected function pickIsoSceneLogic(e:MouseEvent):void 
		{
			_globalStagePoint = toStagePoint();
			var point:Point = new Point(e.stageX - _globalStagePoint.x, e.stageY - _globalStagePoint.y);
			var v:Vector3D;
			//如果有设置预览元素的情况下,用左上角格子
			if (_world.previewSprite.IsBuild && _world.previewSprite.bound!=null) {
				 v =  _world.previewSprite.bound.topCell;
				}else {
				//默认的Pick
				 v = IsoUtil.screenToIso(point);
				}
			
			var event:IsoSceneEvent = new IsoSceneEvent(IsoSceneEvent.Pick);
				event.pickPosition = v;
				event.pickCell = new Vector3D(Math.round(v.x / IsoConfig.IsoGridSize),
											  0,
											  Math.round(v.z / IsoConfig.IsoGridSize));
				dispatchEvent(event);
		}
				
		
	    private function  extendGrid(v:Point,row:uint,column:uint):IsoBound {
			 var _topGrid:Vector3D = new Vector3D();
			 var _bottomGrid:Vector3D = new Vector3D();
				 _topGrid.x = v.x - Math.floor(row / 2);
				 _topGrid.z = v.y - Math.floor(column / 2);
				 _bottomGrid.x = v.x + (row - (Math.floor(row / 2)+1));
				 _bottomGrid.z = v.y + (column -  (Math.floor(column / 2) + 1));
			return new IsoBound(_topGrid, _bottomGrid);
		 }	
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	
		
	}

}