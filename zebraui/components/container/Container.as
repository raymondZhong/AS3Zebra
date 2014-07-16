package zebraui.components.container
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import zebraui.components.layout.EmptyLayout;
	import zebraui.components.layout.FlowLayout;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.UIComponent;
	
	public class Container extends UIComponent implements IContainer
	{
		
		private var _layout:ILayoutManager;
		
		/**
		 *  没有自动遮罩的容器
		 */
		public function Container(preferWidth:Number = 0, preferHeight:Number = 0)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			_layout = new EmptyLayout();
			_layout.container = this;
			super.initialize();
		}
		
		override public function set width(value:Number):void
		{
			_preferWidth = value;
			_layout.setPreferWidth(_preferWidth);
			if (IsRender) {
			_layout.updateAlign();
			}
			
			super.width = value;
		}
		
		override public function get width():Number
		{
			return _layout.width;
		}
		
		override public function set height(value:Number):void
		{
			_preferHeight = value;
			_layout.setPreferHeight(_preferHeight);
			if (IsRender)
			{
				_layout.updateAlign();
			}
			super.height = value;
		}
		
		override public function get height():Number
		{
			return _layout.height;
		}
		
		public function sourceUpdate():void
		{
			if (_layout)
			{
				_layout.updateAlign();
			}
		}
		
		public function get container():DisplayObjectContainer
		{
			return this;
		}
		
		public function get elements():Vector.<DisplayObject>
		{
			return _layout.elements;
		}
		
		public function setLayout(layout:ILayoutManager):void
		{
			_layout = layout;
			layout.container = this;
		}
		
		public function getLayout():ILayoutManager
		{
			return _layout;
		}
		
		/**
		 * 添加显示元素
		 * @param	target
		 */
		public function append(target:DisplayObject):void
		{
			if (_layout)
				_layout.append(target);
		}
		
		/**
		 * 移除显示元素
		 * @param	target
		 */
		public function remove(target:DisplayObject):void
		{
			if (_layout)
				_layout.remove(target);
		}
		
		public function clear():void
		{
			if (_layout)
			{
				_layout.clear();
				if (_layout is FlowLayout)
					this.height = _layout.height;
				sourceUpdate();
			}
		}
		
		override protected function addToStageControl():void
		{
			super.addToStageControl();
			sourceUpdate();
		}
	
	}

}