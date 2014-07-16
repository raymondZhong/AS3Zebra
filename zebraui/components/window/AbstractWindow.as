package zebraui.components.window 
{
import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.DropShadowFilter;
	import zebraui.components.mask.MaskComponent;
	import zebraui.components.UIComponent;
	import zebraui.event.WindowEvent;
	
	public class AbstractWindow extends UIComponent
	{
		private var _dialog:Boolean;
		private var _dialogVisible:Boolean;
		protected var _maskCmp:MaskComponent;
		protected var _minWidth:Number;
		protected var _minHeight:Number;
		private var _shadow:Boolean;
		protected var _dragObject:DisplayObject;
		protected var _isOpen:Boolean;
		protected var _isClose:Boolean;
		
		public function AbstractWindow()
		{
		    _minWidth = 0;
			_minHeight = 0;
			super(_preferWidth,_preferHeight);
		}
		
		public function seMinSize(width:Number=0,height:Number=0):void {
			  _minWidth = width;
			  _minHeight = height;
		}
		
		public function min():void{}
		public function common():void{}
		public function max():void{}
		
		public function open():void
		{
			_isClose = false;
			_isOpen = true;
			if (_maskCmp)
				_maskCmp.visible = true;
			this.visible = true;
			
			dispatchEvent(new WindowEvent(WindowEvent.OPEN));
		}
		
		public function close():void
		{
			_isClose = true;
			_isOpen = false;
			if (_maskCmp)
				_maskCmp.visible = false;
			this.visible = false;
			dispatchEvent(new WindowEvent(WindowEvent.CLOSE));
		}
		
		override public function render(container:DisplayObjectContainer = null):void
		{
			if (_dialog)
			{
				_maskCmp.render(container);
			}
			super.render(container);
		}
		
		override public function dispose():void
		{
			_isClose = true;
				if (_maskCmp)_maskCmp.dispose();
				this.visible = false;
				super.dispose();
		}
		
		public function get dialog():Boolean
		{
			return _dialog;
		}
		
		public function set dialog(value:Boolean):void
		{
			_dialog = value;
			if (value)
			{
				_maskCmp = new MaskComponent();
			}
		}
		
		public function get maskCmp():MaskComponent
		{
			return _maskCmp;
		}
		
		/**
		 * 模态同时隐藏遮罩
		 */
		public function get dialogVisible():Boolean
		{
			return _dialogVisible;
		}
		
		/**
		 * 模态同时隐藏遮罩
		 */
		public function set dialogVisible(value:Boolean):void
		{
			if (_dialog)
			{
				_dialogVisible = value;
				if (value)
				{
					_maskCmp.alpha = 1;
				}
				else
				{
					_maskCmp.alpha = 0.05;
				}
				
			}
		}
		
		public function get shadow():Boolean
		{
			return _shadow;
		}
		
		public function set shadow(value:Boolean):void
		{
			_shadow = value;
			if (value)
			{
				this.filters = [new DropShadowFilter(6, 45, 0x000000, 0.3, 5, 5, 0.5, 1)];
			}
			else
			{
				this.filters = null;
			}
		}
		
		public function get maskComponent():DisplayObject 
		{
			return _maskCmp;
		}
		
		public function get dragObject():DisplayObject 
		{
			return _dragObject;
		}
		
		public function set dragObject(value:DisplayObject):void 
		{
			_dragObject = value;
		}
		
		public function get IsOpen():Boolean 
		{
			return _isOpen;
		}
		
		public function get IsClose():Boolean 
		{
			return _isClose;
		}
		
		
 
		

	}

}