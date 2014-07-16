package zebraui.components.panel
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import zebraui.components.container.Box;
	import zebraui.components.silder.AbstractSilder;
	import zebraui.components.silder.HSilderBar;
	import zebraui.components.silder.SilderPolicy;
	import zebraui.components.silder.VSilderBar;
	import zebraui.components.silder.VSilderLite;
	import zebraui.components.UIComponent;
	import zebraui.event.ScrollPanelEvent;
	import zebraui.event.SilderEvent;
	import zebraui.components.UIComponent;
	
	internal class ScrollPanelDesinger extends UIComponent
	{
		
		protected var _body:Box;
		//protected var _VSilder:VSilderBar;
		//protected var _HSilder:HSilderBar;
		
		protected var _VSilder:AbstractSilder;
		protected var _HSilder:AbstractSilder;
		public function ScrollPanelDesinger(preferWidth:Number = 200, preferHeight:Number = 200)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			_body = new Box(_preferWidth, _preferHeight);
			addChild(_body)
			_VSilder = new VSilderBar();
			_HSilder = new HSilderBar();
			addChild(_VSilder)
			addChild(_HSilder)
			super.initialize();
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_preferWidth = value;
			_body.width = _preferWidth - _VSilder.width;
			_VSilder.x = _body.width;
			_HSilder.width = _body.width;
		}
		
		override public function get width():Number
		{
			return _preferWidth;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_preferHeight = value;
			_body.height = _preferHeight - _HSilder.height;
			_HSilder.y = _body.height;
			_VSilder.height = _body.height;
		}
		override public function get height():Number
		{
			return _preferHeight;
		}
		
		public function get body():Box 
		{
			return _body;
		}
	
	}

}