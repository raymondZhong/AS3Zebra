package zebraui.components.container
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.layout.LayoutMargin;
	import zebraui.components.UIComponent;
	import zebraui.event.ContainerEvent;
	import zebraui.event.ScrollPanelEvent;
	import zebraui.UIFramework;
	
	[Event(name="updateSource",type="zebraui.event.PanelEvent")]
	
	/**
	 * 有自动遮罩的容器
	 */
	public class Box extends UIComponent implements IBox
	{
		/**
		 * 内容容器
		 */
		protected var _container:Container;
		
		private var _scrollDrag:Boolean;
		/**
		 * 内部按下了允许拖动
		 */
		private var _IsDrag:Boolean;
		
		/**
		 * 允许拖动范围
		 */
		private var _dragBound:Rectangle;
		
		/**
		 * 位图遮罩
		 */
		protected var _maskBM:Bitmap;
		protected var _processHeight:Number = 0;
		protected var _processWidth:Number = 0;
		
		public function Box(preferWidth:Number = 100, preferHeight:Number = 100)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			_dragBound = new Rectangle();
			_maskBM = new Bitmap(new BitmapData(_preferWidth, _preferHeight, false, 0x000000));
			_container = new Container(_preferWidth, _preferHeight);
			_container.getLayout().margin = LayoutMargin.Empty;
			addChild(_container);
			addChild(_maskBM)
			_container.mask = _maskBM;
			_container.addEventListener(MouseEvent.MOUSE_DOWN, _startDragLogic);
			super.initialize();
		}
		
		public function set processWidth(value:Number):void
		{
			_processWidth = value;
			_container.x = _dragBound.x * value;
		
		}
		
		public function set processHeight(value:Number):void
		{
			_processHeight = value;
			_container.y = _dragBound.y * value;
		}
		
		public function get processWidth():Number
		{
			return Math.abs(_container.x / _dragBound.width)
		}
		
		public function get processHeight():Number
		{
			return Math.abs(_container.y / _dragBound.height)
		}
		
		protected function setDragBoundLogic():Rectangle
		{
			
			var useFulWidth:Number = _container.width;
			var useFulHeight:Number = _container.height;
			var bound:Rectangle = new Rectangle(_maskBM.width - useFulWidth, _maskBM.height - useFulHeight, Math.abs(_maskBM.width - useFulWidth), Math.abs(_maskBM.height - useFulHeight));
			if (useFulWidth <= _maskBM.width)
			{
				bound.x = 0;
				bound.width = 0;
			}
			if (useFulHeight <= _maskBM.height)
			{
				bound.y = 0;
				bound.height = 0;
			}
			_dragBound = bound;
			
			_container.x = 0;
			_container.y = 0;
			
			return bound;
		}
		
		/**
		 * 改变Source大小
		 */
		public function sourceUpdate():void
		{
			setDragBoundLogic();
			getLayout().updateAlign();
			this.dispatchEvent(new ContainerEvent(ContainerEvent.SOURCEUPDATE));
		}
		
		override protected function addToStageControl():void
		{
			super.addToStageControl();
			
			//_container.x = _dragBound.x * _processWidth;
			//_container.y = _dragBound.y * _processHeight;
			
			sourceUpdate();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _draggingLogic);
			stage.addEventListener(MouseEvent.MOUSE_UP, _removedragLogic);
		
		}
		
		override protected function removeStageControl():void
		{
			super.removeStageControl();
			_container.removeEventListener(MouseEvent.MOUSE_DOWN, _startDragLogic);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _draggingLogic);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _removedragLogic);
		}
		
		private function _removedragLogic(e:MouseEvent):void
		{
			if (_IsDrag)
			{
				_IsDrag = false;
				_container.stopDrag();
			}
		}
		
		private function _draggingLogic(e:MouseEvent):void
		{
			if (_IsDrag && _dragBound != null)
			{
				_container.startDrag(false, _dragBound);
				var event:ScrollPanelEvent = new ScrollPanelEvent(ScrollPanelEvent.DRAGING);
				event.processWidth = this.processWidth;
				event.processHeight = this.processHeight;
				this.dispatchEvent(event);
			}
		}
		
		private function _startDragLogic(e:MouseEvent):void
		{
			if(_scrollDrag){
			_IsDrag = true;
			}
		}
		
		public function setLayout(layout:ILayoutManager):void
		{
			_container.setLayout(layout)
		}
		
		public function getLayout():ILayoutManager
		{
			return _container.getLayout();
		}
		
		/* ====================================================================================
		 * Get Set
		 * ====================================================================================
		 */
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_container.width = value;
			_maskBM.width = value;
			sourceUpdate();
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_container.height = value;
			_maskBM.height = value;
			sourceUpdate();
		}
		
		override public function get width():Number
		{
			return _maskBM.width;
		}
		
		override public function get height():Number
		{
			return _maskBM.height;
		}
		
		/**
		 * 允许内容拖动
		 */
		public function get scrollDrag():Boolean
		{
			return _scrollDrag;
		}
		
		/**
		 * 允许内容拖动
		 */
		public function set scrollDrag(value:Boolean):void
		{
			if (_scrollDrag != value)
				_scrollDrag = value;
		}
		
		public function get container():DisplayObjectContainer
		{
			return _container;
		}
		
		public function append(target:DisplayObject):void
		{
			_container.getLayout().append(target);
			sourceUpdate();
		}
		
		public function get elements():Vector.<DisplayObject>
		{
			return _container.elements;
		}
		
		public function remove(target:DisplayObject):void
		{
			_container.getLayout().remove(target);
			sourceUpdate();
		}
		
		public function clear():void
		{
			_container.getLayout().clear();
			sourceUpdate();
		}
	
 
	}

}

