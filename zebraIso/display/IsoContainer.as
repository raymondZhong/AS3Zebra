package zebraIso.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoConfig;
	import zebraIso.data.xmlmapper.Tile;
	import zebraIso.display.primitive.IsoTileGrid;
	import zebraIso.display.scene.IIsoLayout;
	import zebraIso.display.scene.IsoWorld;
	import zebraIso.util.IsoUtil;
	import zebra.debug.Debug;
	
	public class IsoContainer extends Sprite
	{
		protected var _position:Vector3D;
		protected var _size:Number;
		protected var _walkable:Boolean;
		//protected var _vx:Number = 0;
		//protected var _vy:Number = 0;
		//protected var _vz:Number = 0;
		protected var _IsoBound:IsoBound;
		protected var _lock:Boolean;
		public var layout:IIsoLayout;
		
		/**
		 * Y轴
		 */
		protected var _height:Number;
		/**
		 * Z轴
		 */
		protected var _length:Number;
		/**
		 * X轴
		 */
		protected var _width:Number;
		
		protected var _IsoX:int;
		protected var _IsoY:int;
		protected var _IsoZ:int;
		
		protected var _offX:Number;
		protected var _offY:Number;
		
		private  var _tile:Tile;
		private var _sceneRectangle:Rectangle;
		
		/**
		 * 2个字段用来排序
		 */
		public var sortX:Number;
		public var sortY:Number;	
		// a more accurate version of 1.2247...
		//public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

		public function IsoContainer(width:Number = 0,height:Number = 0 , length:Number = 0)
		{
			_IsoX = 0;
			_IsoY = 0;
			_IsoZ = 0;
			_offX = 0;
			_offY = 0;
			_height = height;
			_width = width;
			_length = length;
			sortX = 0;
			sortY = 0;
			_size = IsoConfig.IsoGridSize;
			_position = new Vector3D();
			_IsoBound = new IsoBound();
			updateScreenPositionControl();
			addEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);
		}
		
		private function _addToStageLogic(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);
			drawControl();
			updateScreenPositionControl(false);
		}
		
		public function setIsoBound(value:IsoBound):void {
			  _IsoBound = value;
			  _sceneRectangle = new Rectangle( int(value.topCell.x * IsoConfig.edge),
											 int(value.topCell.z * IsoConfig.edge),
											 int(value.column*IsoConfig.edge),
											 int(value.row * IsoConfig.edge));
			    sortX = value.bottomCell.x;
			    sortY = value.bottomCell.z;
			}
		

			
		public function getIsoBound():IsoBound {
			return _IsoBound;
			//var pos:Vector3D = getIsoCoord();
				//pos.y = 0;
			//var topgrid:Vector3D = pos;
			//var bottomgrid:Vector3D = new Vector3D(topgrid.x+Math.round(_width / IsoConfig.edge)-1,0,topgrid.z+Math.round(_length / IsoConfig.edge)-1)
			//return new IsoBound(topgrid,bottomgrid);
			}
		
		
 
		protected function updateScreenPositionControl(checkRender:Boolean = true):void
		{
			if (checkRender)
			{
				if (this.parent == null)
					return;
			}
			 updateSceenPosition();
		}
		
		protected function  updateSceenPosition():void {
			     var screenPos:Point = IsoUtil.isoToScreen(_position);
			
					 super.x = screenPos.x + _offX;
					 super.y = screenPos.y + _offY;	
			 //_position = IsoUtil.screenToIso(new Point(screenPos.x + _offX,screenPos.y + _offY));
			}
		 
		
		public function get depth():Number
		{
			//return this.x + this.y;
			return   (_position.x + _position.z)* .866  - _position.y * .707;;
			//return (_position.x + _position.z) * .866 - _position.y * .707;
		}	
		
		//public function get depthY():Number {
			   //return  -1 * y;	
			 //}
			
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set width(value:Number):void 
		{
			_width = value;
		}	
		
			
		override public function get height():Number 
		{
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			_height = value;
		}	
			
		 
		public function set length(value:Number):void { _length = value; }
		public function get length():Number { return _length; }
		
		public function get offX():Number 
		{
			return _offX;
		}
		
		public function set offX(value:Number):void 
		{
			_offX = value;
			updateScreenPositionControl();
		}
		
		public function get offY():Number 
		{
			return _offY;
		}
		
		public function set offY(value:Number):void 
		{
			_offY = value;
			updateScreenPositionControl();
		}
		 
		public function setIsoX(value:Number):void
		{
			_position.x = value;
			updateScreenPositionControl();
		}
		
		public function setIsoY(value:Number):void
		{
			_position.y = value;
			updateScreenPositionControl();
		}
		
		public function setIsoZ(value:Number):void
		{
			_position.z = value;
			updateScreenPositionControl();
		}
		 
		
	  
		/**
		 * 精确到x,y,z 3轴格子索引
		 * @param	x
		 * @param	y
		 * @param	z
		 */
		public function setIsoCoord(x:uint,y:uint,z:uint):void
		{
			_position.x = x * IsoConfig.IsoGridSize;
			_position.y = y * IsoConfig.IsoGridSize;
			_position.z = z * IsoConfig.IsoGridSize;
			updateScreenPositionControl();
		}
		
		
		public function getIsoCoord():Vector3D {
			   return new Vector3D(Math.round(_position.x/IsoConfig.IsoGridSize),_height,Math.round(_position.z/IsoConfig.IsoGridSize))
			}
		
		
		override public function toString():String
		{
			return "[IsoContainer (x:" + _position.x + ", y:" + _position.y + ", z:" + _position.z + ")]";
		}
		
		/**
		 * 精确到x,y,z 3轴像素
		 * @param	value
		 */	
		public function setPosition(value:Vector3D):void
		{
			_position = value;
			updateScreenPositionControl();
		}
		
		public function get inAir():Boolean {
			  return  _position.y < 0;
			}
			
		public function get lock():Boolean 
		{
			return _lock;
		}
		
		public function set lock(value:Boolean):void 
		{
			_lock = value;
			 this.mouseChildren = !value;
			 this.mouseEnabled = !value;
		}
		
		
		/**
		 * 获得的单元格数据
		 */
		public function get tile():Tile 
		{
			return _tile;
		}
		
		/**
		 * 设置的单元格数据
		 */
		public function set tile(value:Tile):void 
		{
			_tile = value;
		}
		
	 
		 
	
			
		public function getPosition():Vector3D
		{
			return _position;
		}
		
		/**
		 * 移除所有子元素 FlashPlayer 9-11 
		 */
		public function removeAllChild():void {
			var i:int=0
			for ( i = this.numChildren - 1; i >= 0; i--)
			{
				this.removeChildAt(i);
			}
		} 
			
		protected function drawControl(checkRender:Boolean = true):void
		{
			if (checkRender)
			{
				if (this.parent == null)
					return;
			}
			draw();
		}
			
		protected function draw():void { }
		
		/**
		 * 全局坐标
		 * @return
		 */
		public function toStagePoint():Point
		{
			return this.parent.localToGlobal(new Point(this.x, this.y));
		}
		
		/**
		 * 平面世界的正矩阵
		 */
		public function get sceneRectangle():Rectangle 
		{
			return _sceneRectangle;
		}
		
		public function get IsoX():int 
		{
			_IsoX = IsoUtil.screenToIsoGrid(new Point(this.x, this.y)).x;
			return _IsoX;
		}
		
		public function get IsoY():int 
		{
			_IsoY = 0;
			return _IsoY;
		}
		
		public function get IsoZ():int 
		{
			_IsoZ = IsoUtil.screenToIsoGrid(new Point(this.x, this.y)).y;
			return _IsoZ;
		}
		
		public function get walkable():Boolean 
		{
			return _walkable;
		}
		
		public function set walkable(value:Boolean):void 
		{
			_walkable = value;
		}
		
		public function moveTo():void {
			
			
			}
			
		 
	}

}