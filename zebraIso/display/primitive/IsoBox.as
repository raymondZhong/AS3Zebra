package zebraIso.display.primitive
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import zebraIso.data.IsoConfig;
	import zebraIso.display.IsoContainer;
	import zebraIso.graphics.SolidColorFill;
	import zebraIso.util.IsoSkew;
	import zebraIso.util.IsoUtil;
	
	
	public class IsoBox extends IsoContainer
	{
		/**
		 * FacePoint
		 * ◇  点的顺序  top right bottom left
		 */
		private var bottomFacePoint:Vector.<Point>;
		private var frontFacePoint:Vector.<Point>;
		private var topFacePoint:Vector.<Point>;
		private var backFacePoint:Vector.<Point>;
		private var leftFacePoint:Vector.<Point>;
		private var rightFacePoint:Vector.<Point>;
		
		//sin
		private var _degreesTop_Right:Number = 0.4472135954999579;
		private var _degreesTop_Left:Number = 0.4472135954999579;
		
		private var _container:Sprite;
		protected var _colorfill:Vector.<SolidColorFill>;
		private var _facesPoint:Dictionary;
		protected var _bitmapfill:Vector.<BitmapData>;
		private var _faceCreateOrder:Vector.<String>;
		
		
		static private var NameIndex:int = 0;
		
		public function IsoBox(width:Number = 0,  height:Number = 0,length:Number = 0)
		{			
			super(width, height, length);
			_faceCreateOrder = Vector.<String>(["bottom", "left", "back", "front", "right", "top"]);
			_colorfill = Vector.<SolidColorFill>([new SolidColorFill(), new SolidColorFill(), new SolidColorFill(), new SolidColorFill(), new SolidColorFill(), new SolidColorFill()]);
			_bitmapfill = new Vector.<BitmapData>(6);
			_container = new Sprite();
			createFacePoint();
			this.name = String(NameIndex);
			NameIndex++;
			for (var i:int = 0; i < _faceCreateOrder.length; i++)
			{
				var container:Sprite = new Sprite();
					container.name = String(_faceCreateOrder[i]);
					addChild(container);
				if (i == 2)	addChild(_container);
			}
			
			
		}
		
		override protected function updateSceenPosition():void
		{
			var position:Vector3D = _position.clone();
			position.x += -IsoConfig.IsoGridSize >> 1;
			position.z += -IsoConfig.IsoGridSize >> 1;
			
			var screenPos:Point = IsoUtil.isoToScreen(position);
			super.x = screenPos.x + _offX;
			super.y = screenPos.y + _offY;
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			createFacePoint();
			drawControl();
			updateScreenPositionControl();
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			createFacePoint();
			drawControl();
			updateScreenPositionControl();
		}
		
		
		override public function get length():Number 
		{
			return super.length;
		}
		
		override public function set length(value:Number):void 
		{
			super.length = value;
			createFacePoint();
			drawControl();
			updateScreenPositionControl();
		}
		
		
		override protected function draw():void
		{
			var i:int = 0
			for (i = numChildren - 1; i >= 0; i--)
			{
				removeChildAt(i);
			}
			for (i = 0; i < _faceCreateOrder.length; i++)
			{
				var container:Sprite = new Sprite();
					container.name = String(_faceCreateOrder[i]);
					addChild(container);
				if (i == 2)	addChild(_container);
			}			
			colorfill = _colorfill;
			bitmapfill = _bitmapfill;
		}
		
		/**
		 *  Face: ["top","front","right","left", "back","bottom"]
		 */
		public function get colorfill():Vector.<SolidColorFill>
		{
			return _colorfill;
		}
		
		/**
		 *  Face: ["top","front","right","left", "back","bottom"]
		 */
		public function set colorfill(value:Vector.<SolidColorFill>):void
		{
			var i:int = 0;
			if (this.parent)
			{
				for (i = 0; i < _faceCreateOrder.length; i++)
				{
					if (Sprite(getChildByName(_faceCreateOrder[i])))
					    Sprite(getChildByName(_faceCreateOrder[i])).graphics.clear();
				}
			}
			
			if (value == null)value =Vector.<SolidColorFill>([null,null,null,null,null,null]);
			for (i = 0; i < value.length; i++)
			{
				_colorfill[i] = value[i];
			}
			
		
			var faceName:Vector.<String> = Vector.<String>(["top", "front", "right", "left", "back", "bottom"]);
			for ( i = 0; i < faceName.length; i++)
			{
				_createFace(faceName[i], _facesPoint[faceName[i]], _colorfill[i]);
			}
		}
		
		/**
		 *  Face: ["top","front","right","left", "back","bottom"]
		 */
		public function get bitmapfill():Vector.<BitmapData>
		{
			return _bitmapfill;
		}
		
		/**
		 *  Face: ["top","front","right","left", "back","bottom"]
		 */
		public function set bitmapfill(value:Vector.<BitmapData>):void
		{
			var i:int = 0;
			if (value == null)
				value = new Vector.<BitmapData>(6);
			for (i = 0; i < value.length; i++)
			{
				_bitmapfill[i] = value[i];
			}
			
			if (this.parent == null)
				return;
			
			for (var j:int = 0; j < _faceCreateOrder.length; j++)
			{
				for (i = Sprite(getChildByName(_faceCreateOrder[j])).numChildren - 1; i >= 0; i--)
				{
					Sprite(getChildByName(_faceCreateOrder[j])).removeChildAt(i);
				}
			}
			
			var faceName:Vector.<String> = Vector.<String>(["top", "front", "right", "left", "back", "bottom"]);
			var isoskew:IsoSkew;
			for (i = 0; i < faceName.length; i++)
			{
				if (_bitmapfill[i])
				{
					isoskew = new IsoSkew(_bitmapfill[i]);
					isoskew.setTransformPoints(_facesPoint[faceName[i]][0], _facesPoint[faceName[i]][1], _facesPoint[faceName[i]][2], _facesPoint[faceName[i]][3])
					isoskew.name = "isoBitmapFill"
					Sprite(getChildByName(faceName[i])).addChild(isoskew);
				}
			}
		
		}
		
		public function get container():Sprite 
		{
			return _container;
		}
		
		private function createFacePoint():void
		{
			bottomFacePoint = new Vector.<Point>();
			topFacePoint = new Vector.<Point>();
			frontFacePoint = new Vector.<Point>();
			backFacePoint = new Vector.<Point>();
			leftFacePoint = new Vector.<Point>();
			rightFacePoint = new Vector.<Point>();
			createBottomFace();
			createLeftFace();
			createBackFace();
			createRightFace();
			createFrontFace();
			createTopFace();
			_facesPoint = new Dictionary();
			_facesPoint["bottom"] = bottomFacePoint;
			_facesPoint["left"] = leftFacePoint;
			_facesPoint["back"] = backFacePoint;
			_facesPoint["front"] = frontFacePoint;
			_facesPoint["right"] = rightFacePoint;
			_facesPoint["top"] = topFacePoint;
		}
		
		private function createBottomFace():void
		{
			var topPoint:Point = new Point(0, 0);
			var rightHeight:Number = _degreesTop_Right * _width;		 
			var rightWidth:Number = Math.sqrt(_width * _width - rightHeight * rightHeight);			
			var rightPoint:Point = new Point(rightWidth, rightHeight);
			var leftHeight:Number = _degreesTop_Left * _length;
			var leftWidth:Number = -Math.sqrt(_length * _length - leftHeight * leftHeight);
			var leftPoint:Point = new Point(leftWidth, leftHeight);
			var bottomPoint:Point = new Point(leftWidth + rightWidth, leftHeight + rightHeight);
			
			bottomFacePoint.push(topPoint); //Top    Point
			bottomFacePoint.push(rightPoint); //Right  Point
			bottomFacePoint.push(bottomPoint); //Bottom Point
			bottomFacePoint.push(leftPoint); //Left   Point
			
		}
		
		private function createLeftFace():void
		{
			leftFacePoint.push(new Point(bottomFacePoint[3].x, bottomFacePoint[3].y - _height));
			leftFacePoint.push(new Point(bottomFacePoint[0].x, bottomFacePoint[0].y - _height));
			leftFacePoint.push(new Point(bottomFacePoint[0].x, bottomFacePoint[0].y));
			leftFacePoint.push(new Point(bottomFacePoint[3].x, bottomFacePoint[3].y));
		
		}
		
		private function createBackFace():void
		{
			backFacePoint.push(new Point(bottomFacePoint[0].x, bottomFacePoint[0].y - _height));
			backFacePoint.push(new Point(bottomFacePoint[1].x, bottomFacePoint[1].y - _height));
			backFacePoint.push(new Point(bottomFacePoint[1].x, bottomFacePoint[1].y));
			backFacePoint.push(new Point(bottomFacePoint[0].x, bottomFacePoint[0].y));
		
		}
		
		private function createFrontFace():void
		{
			frontFacePoint.push(new Point(bottomFacePoint[3].x, bottomFacePoint[3].y - _height)); //Top Left
			frontFacePoint.push(new Point(bottomFacePoint[2].x, bottomFacePoint[2].y - _height)); //Top Right
			frontFacePoint.push(new Point(bottomFacePoint[2].x, bottomFacePoint[2].y)); //Bottom Right
			frontFacePoint.push(new Point(bottomFacePoint[3].x, bottomFacePoint[3].y)); //Bottom Left
		
		}
		
		private function createRightFace():void
		{
			rightFacePoint.push(new Point(bottomFacePoint[2].x, bottomFacePoint[2].y - _height));
			rightFacePoint.push(new Point(bottomFacePoint[1].x, bottomFacePoint[1].y - _height));
			rightFacePoint.push(new Point(bottomFacePoint[1].x, bottomFacePoint[1].y));
			rightFacePoint.push(new Point(bottomFacePoint[2].x, bottomFacePoint[2].y));
		
		}
		
		private function createTopFace():void
		{
			topFacePoint.push(new Point(bottomFacePoint[0].x, bottomFacePoint[0].y - _height));
			topFacePoint.push(new Point(bottomFacePoint[1].x, bottomFacePoint[1].y - _height));
			topFacePoint.push(new Point(bottomFacePoint[2].x, bottomFacePoint[2].y - _height));
			topFacePoint.push(new Point(bottomFacePoint[3].x, bottomFacePoint[3].y - _height));
		}
		
		private function _createFace(faceName:String, points:Vector.<Point>, solid:SolidColorFill):void
		{
			/*	switch (faceName)
			   {
			   case "bottom":
			   graphics.beginFill(0xFF8000, 1);
			   break;
			   case "left":
			   graphics.beginFill(0xC0C0C0, 1);
			   break;
			   case "back":
			   graphics.beginFill(0x0080FF, 1);
			   break;
			   case "front":
			   graphics.beginFill(0x000000, 1);
			   break;
			   case "right":
			   graphics.beginFill(0x00FFFF, 1);
			   break;
			   case "top":
			   graphics.beginFill(0x8000FF, 1);
			   break;
			 }*/
			if(solid){
				var container:Sprite = getChildByName(faceName) as Sprite;
				container.graphics.clear();
				container.graphics.beginFill(solid.fillColor, solid.fillAlpha);
				container.graphics.lineStyle(solid.thickness, solid.lineColor, solid.lineAlpha);
				container.graphics.moveTo(points[0].x, points[0].y); //Top    Point
				container.graphics.lineTo(points[1].x, points[1].y); //Right  Point
				container.graphics.lineTo(points[2].x, points[2].y); //Bottom Point
				container.graphics.lineTo(points[3].x, points[3].y); //Left   Point
				container.graphics.lineTo(points[0].x, points[0].y); //Top    Point
				container.graphics.endFill();
			}
		}
	
	}

}