package zebraui.components.panel
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import zebraui.components.UIComponent;
	import zebraui.event.ColorPickerEvent;
	
	[Event(name="CompleteColorSelection",type="zebraui.event.ColorPickerEvent")]
	
	public class ColorPickerBox extends UIComponent
	{
		private var _color:uint;
		private var _colorMixing:ColorPicker;
		private var _gridBgSp:Sprite;
		private var _topgridBgSp:Sprite;
		private var isShowFace:Boolean = false;
		private var _ColorSelectionHands:Function;
		private var _isClickClosed:Boolean = true;
		private var _isClickThis:Boolean = true;
		private var _faceWidth:Number = 240;
		private var _faceHeight:Number = 300;
		private var _isRim:Boolean = true;
		
		public function ColorPickerBox(preferWidth:Number = 20, preferHeight:Number = 20, color:uint = 0xFFFFFF, isRim:Boolean = true)
		{
			super(preferWidth, preferHeight);
			_color = color;
			_isRim = isRim;
			_gridBgSp = new Sprite();
			_topgridBgSp = new Sprite();
			addChild(_gridBgSp);
			if (isRim)
			{
				addChild(_topgridBgSp);
				_topgridBgSp.graphics.lineStyle(1);
				_topgridBgSp.graphics.moveTo(0, 0);
				_topgridBgSp.graphics.lineTo(_preferWidth, 0);
				_topgridBgSp.graphics.lineTo(_preferWidth, _preferHeight);
				_topgridBgSp.graphics.lineTo(0, _preferHeight);
				_topgridBgSp.graphics.lineTo(0, 0);
				_topgridBgSp.graphics.endFill();
			}
			drawBgSp();
			this.addEventListener(MouseEvent.CLICK, thisClickHands);
		
		}
		
		private function drawBgSp():void
		{
			_gridBgSp.graphics.clear();
			_gridBgSp.graphics.beginFill(_color);
			_gridBgSp.graphics.drawRect(0, 0, _preferWidth, _preferHeight);
			_gridBgSp.graphics.endFill();
		}
		
		private function thisClickHands(e:MouseEvent):void
		{
			if (isShowFace)
			{
				if (_isClickThis)
					clearColorMixing();
				return;
			}
			isShowFace = true;
			_colorMixing = new ColorPicker(_faceWidth, _faceHeight, _color);
			this.stage.addChild(_colorMixing);
			_colorMixing.setCoordinate(this.toGlobalPoint().x, this.toGlobalPoint().y, _preferWidth);
			_colorMixing.addEventListener(ColorPickerEvent.CompleteColorSelection, CompleteColorSelection);
			if (_isClickClosed)
				this.stage.addEventListener(MouseEvent.CLICK, stageClickHands);
		}
		
		private function stageClickHands(e:MouseEvent):void
		{
			if (!_colorMixing)
				return;
			if (this.hitTestPoint(this.stage.mouseX, this.stage.mouseY) || _colorMixing.hitTestPoint(this.stage.mouseX, this.stage.mouseY))
				return;
			clearColorMixing();
		}
		
		private function CompleteColorSelection(e:Event):void
		{
			isShowFace = false;
			if (!_colorMixing)
				return;
			_color = _colorMixing.color;
			drawBgSp();
			clearColorMixing();
			if (ColorSelectionHands != null)
				ColorSelectionHands(this);
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(MouseEvent.CLICK, thisClickHands);
			clearColorMixing();
			_gridBgSp.graphics.clear();
			_topgridBgSp.graphics.clear();
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		private function clearColorMixing():void
		{
			if (!_colorMixing)
				return;
			_colorMixing.dispose();
			if (this.stage.contains(_colorMixing))
				this.stage.removeChild(_colorMixing);
			_colorMixing.removeEventListener(ColorPickerEvent.CompleteColorSelection, CompleteColorSelection);
			_colorMixing = null;
			isShowFace = false;
			if (_isClickClosed && this.stage.hasEventListener(MouseEvent.CLICK))
				this.stage.removeEventListener(MouseEvent.CLICK, stageClickHands);
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			drawBgSp();
		
		}
		
		public function get ColorSelectionHands():Function
		{
			return _ColorSelectionHands;
		}
		
		public function set ColorSelectionHands(value:Function):void
		{
			_ColorSelectionHands = value;
		}
		
		/** 调色板宽度 */
		public function set faceWidth(value:Number):void
		{
			_faceWidth = value;
		}
		
		/** 调色板高度 */
		public function set faceHeight(value:Number):void
		{
			_faceHeight = value;
		}
		
		/** 点击窗口其他地方，是否关闭调色板 */
		public function set isClickClosed(value:Boolean):void
		{
			_isClickClosed = value;
		}
		
		/** 再次点击按钮是否关闭调色板 */
		public function set isClickThis(value:Boolean):void
		{
			_isClickThis = value;
		}
	
	}

}