package zebraui.components.panel
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.silder.SilderPolicy;
	import zebraui.event.ScrollPanelEvent;
	import zebraui.event.SilderEvent;
	
	[Event(name="draging",type="zebraui.event.ScrollPanelEvent")]
	
	internal class AbstractScrollPanel extends ScrollPanelDesinger
	{
		
		protected var _scrollDrag:Boolean;
		protected var _VSilderPolicy:String;
		protected var _HSilderPolicy:String;
		protected var _wheelBet:Number = 1.5;
		
		public function AbstractScrollPanel(preferWidth:Number = 200, preferHeight:Number = 200,vSilderPolicy:String="auto",hSilderPolicy:String="auto")
		{
			_VSilderPolicy = vSilderPolicy;
			_HSilderPolicy = hSilderPolicy;
			super(preferWidth, preferHeight);
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			SilderPolicyLogic();
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			SilderPolicyLogic();
		}
		

		override protected function addToStageControl():void
		{
			super.addToStageControl();			
			_VSilder.addEventListener(SilderEvent.DRAGING, _VSilderDragLogic);
			_VSilder.addEventListener(SilderEvent.PROGRESS, _VSilderDragLogic);
			_HSilder.addEventListener(SilderEvent.DRAGING, _HSilderDragLogic);
			_HSilder.addEventListener(SilderEvent.PROGRESS, _HSilderDragLogic);
			_body.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheelLogic);
			_body.addEventListener(ScrollPanelEvent.DRAGING, _panelDragLogic);
			SilderPolicyLogic();
		}
		
		override protected function removeStageControl():void
		{
			super.removeStageControl();
			_VSilder.removeEventListener(SilderEvent.DRAGING, _VSilderDragLogic);
			_VSilder.removeEventListener(SilderEvent.PROGRESS, _VSilderDragLogic);
			_HSilder.removeEventListener(SilderEvent.DRAGING, _HSilderDragLogic);
			_HSilder.removeEventListener(SilderEvent.PROGRESS, _HSilderDragLogic);
			_body.removeEventListener(ScrollPanelEvent.DRAGING, _panelDragLogic);
			_body.removeEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheelLogic);		
		}

		/**
		 * Silder Visible 逻辑
		 */
		protected function SilderPolicyLogic():void
		{
			if (_VSilderPolicy == SilderPolicy.AUTO) {  
				    _VSilder.visible = _body.getLayout().height>_body.height
				}
			if (_HSilderPolicy == SilderPolicy.AUTO) {
				    _HSilder.visible = _body.getLayout().width>_body.width
				}
			
			
			if (_VSilderPolicy == SilderPolicy.OFF)
			{
				_VSilder.visible = false;
			}
			if (_VSilderPolicy == SilderPolicy.ON)
			{
				_VSilder.visible = true;
			}
			
			if (_HSilderPolicy == SilderPolicy.OFF)
			{
				_HSilder.visible = false;
			}
			if (_HSilderPolicy == SilderPolicy.ON)
			{
				_HSilder.visible = true;
			}
			
			if (_VSilder.visible && _HSilder.visible) {
				_body.width = _preferWidth - _VSilder.width;
				_body.height = _preferHeight - _HSilder.height;
				_VSilder.x = _body.width;
				_VSilder.height = _body.height;
				_HSilder.y = _body.height;					
				_HSilder.width = _body.width;
				}
			if (_VSilder.visible && !_HSilder.visible) {
				_body.width = _preferWidth - _VSilder.width;
				_body.height = _preferHeight;
				_VSilder.x =_body.width;
				_VSilder.height = _body.height;
				_HSilder.y = _body.height-_HSilder.height;	
				}
			if (!_VSilder.visible && _HSilder.visible) {
				_body.width = _preferWidth
				_body.height = _preferHeight - _HSilder.height;
				_VSilder.x = _body.width;
				_HSilder.y = _body.height - _HSilder.height;	
				_HSilder.width = _body.width;
				}
		}
		
		private function _VSilderDragLogic(e:SilderEvent):void
		{
			_body.processHeight = e.process;
		}
		
		private function _HSilderDragLogic(e:SilderEvent):void
		{
			_body.processWidth = e.process;
		}
		
		private function _panelDragLogic(e:ScrollPanelEvent):void
		{
			_VSilder.progress = e.processHeight;
			_HSilder.progress = e.processWidth;
		}
		
		public function set processWidth(value:Number):void
		{
			_HSilder.progress = value;
			_body.processWidth = value;
		}
		
		public function get processWidth():Number
		{
			return _body.processWidth
		}
		
		public function set processHeight(value:Number):void
		{
			_VSilder.progress = value;
			_body.processHeight = value;
		}
		
		public function get processHeight():Number
		{
			return _body.processHeight
		}
		
		public function get scrollDrag():Boolean
		{
			return _scrollDrag;
		}
		
		public function set scrollDrag(value:Boolean):void
		{
			_scrollDrag = value;
			_body.scrollDrag = value;
		}
		
		public function get VSilderPolicy():String 
		{
			return _VSilderPolicy;
		}
		
		public function set VSilderPolicy(value:String):void 
		{
			_VSilderPolicy = value;
			SilderPolicyLogic();
		}
		
		public function get HSilderPolicy():String 
		{
			return _HSilderPolicy;
		}
		
		public function set HSilderPolicy(value:String):void 
		{
			_HSilderPolicy = value;
			SilderPolicyLogic();
		}
		
				
		public function append(target:DisplayObject):void
		{
			_body.append(target);
			_body.getLayout().updateAlign()
			SilderPolicyLogic();
			
		}
		
		public function remove(target:DisplayObject):void
		{
			_body.remove(target);
			SilderPolicyLogic()
			_body.getLayout().updateAlign()
		}
		
		public function clear():void
		{
			_body.clear();
			SilderPolicyLogic()
			//_body.getLayout().updateAlign()
		}
		
		public function setLayout(layout:ILayoutManager):void {
			_body.setLayout(layout);
		}
		
		public function getLayout():ILayoutManager {
			return _body.getLayout();
		}
		/**
		 * 滚轮事件
		 * @param	e
		 */
		private function _mouseWheelLogic(e:MouseEvent):void
		{
			if (_VSilder.visible)
			{
				_VSilder.progress += e.delta * 0.1 * -1 * _wheelBet;
				this.processHeight = _VSilder.progress;
			}
			
			if (_HSilder.visible && !_VSilder.visible)
			{
				_HSilder.progress += e.delta * 0.1 * -1 * _wheelBet;
				this.processWidth = _HSilder.progress;
			}
		}
	
	}

}