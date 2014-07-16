package zebraIso.display 
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoConfig;
	import zebraIso.display.primitive.IsoTileGrid;
	public class IsoGrid extends Sprite
	{
		
		private var _cellSize:Number;
		
		/**
		 *  视图Top角度
		 *  看到的轴线
		 *   x轴 和 z 轴， 
		 *   x轴是 宽度
		 *   z轴是 长度
		 *   Y轴是 高度
		 */   
		
		private var _gridWidth:uint = 0;
		private var _gridHeight:uint = 0;
		private var _gridLength:uint = 0;
		private var _visibleText:Boolean; 
		private var _grids:Vector.<IsoTileGrid>; 
		private var _isobounds:IsoBound;
		
		public function IsoGrid(widthX:uint=9, lengthZ:uint=9,visible:Boolean=true) 
		{
			this.visible = visible;
			_visibleText = false;
			_cellSize = IsoConfig.IsoGridSize;
			_grids = new Vector.<IsoTileGrid>();
			_isobounds = new IsoBound(new Vector3D(0, 0, 0), new Vector3D(Math.max(widthX-1,0), 0, Math.max(lengthZ-1,0)));
			setGridSize(widthX, lengthZ);
		}
		
		public function get tileGrids():Vector.<IsoTileGrid> { return _grids; }
		
		
		public function normal():void {
				 setGridColor(0xFFFFFF);
			}
		 
		public function setGridColor(value:uint,_alpha:int=0):void {
			for each (var item:IsoTileGrid in _grids) 
				 {
					 item.setColor(value,_alpha);
				 }
			}	
		 
		public function setGridSize(widthX:uint, lengthZ:uint):void {
			var heightY:uint = _gridHeight;
			_gridWidth = widthX;
			_gridLength = lengthZ;
			for (var i:int = numChildren - 1; i >= 0; i--)
			{
				removeChildAt(i);
			}
		    for (var j:int = 0; j <widthX ; j++) 
			{
				for (var k:int = 0; k <lengthZ; k++) 
				{
					 var  grid:IsoTileGrid = new IsoTileGrid();
						  grid.setPosition(new Vector3D(j * _cellSize, heightY, k * _cellSize));
						  grid.setText(j + "-" + k);
						  grid.setCell(j, 0, k);
						  grid.textObject.visible = _visibleText;
					      addChild(grid);
						 _grids.push(grid);

				}
			}
		}
		
		/**
		 * 根据范围获得地面格子
		 * @param	bound
		 * @return
		 */
		public function getGridByBound(bound:IsoBound):Vector.<IsoTileGrid> {
			var grids:Vector.<IsoTileGrid> = new Vector.<IsoTileGrid>();
				for (var i:int = int(bound.topCell.x); i <= int(bound.bottomCell.x); i++) 
				{
					for (var j:int = int(bound.topCell.z); j <= int(bound.bottomCell.z); j++) 
					{
						 grids.push(getTileGridCell(new Vector3D(i,0,j)));
					}
				}
				return grids;
			}
		
		
	/**
	 * 获得地面制定格子
	 * @param	x
	 * @param	z
	 * @return
	 */
		public function getTileGridCell(value:Vector3D):IsoTileGrid {
				 for each (var item:IsoTileGrid in _grids) 
				 {
					 if(item.cellX == value.x && item.cellZ == value.z)
						 return item;
				 }
				 return null;
			}
		
		/**
		 * 地面X轴格子数
		 */
		public function get gridX():uint {
			return _gridWidth;
			}
			
		/**
		 * 地面Z轴格子数
		 */
		public function get gridZ():uint {
			return _gridLength;
			}
		
		/**
		 * 
		 */	
		public function get cellSize():Number 
		{
			return _cellSize;
		}
		
		override public function get width():Number 
		{
			return _cellSize * (gridX + gridZ);
		}
		
		override public function get height():Number 
		{
			return (_cellSize>>1) * (gridX + gridZ);
		}
		
		
		
		public function get outsideWidth():Number {
			  return _cellSize *  gridZ;
			}
		
		
		public function get insideWidth():Number {
			  return _cellSize *  gridX;
			}	
			
		public function get outsideHeight():Number {
			return _cellSize >> 1;
			}	
			
		public function get insideHeight():Number {
			return (_cellSize>>1) * (gridX + gridZ)- outsideHeight;
			}	
		
			
		//public function set cellSize(value:Number):void 
		//{
			//if (value < 2) throw new Error("格子大小不能2");
			//_cellSize = value;
		//}
		
		public function get visibleText():Boolean 
		{
			return _visibleText;
		}
		
		public function set visibleText(value:Boolean):void 
		{
			if(value!= _visibleText){
				_visibleText = value;
				for each (var grid:IsoTileGrid in _grids) 
				{
					grid.textObject.visible = value;
				}
			}
		}
		
		public function getIsoBound():IsoBound 
		{
			return _isobounds;
		}
		 
		 
		public function dispose():void {
			for ( var i:int = this.numChildren - 1; i >= 0; i--)
			{
				this.removeChildAt(i);
			}
		} 
		 
		 
	}

}