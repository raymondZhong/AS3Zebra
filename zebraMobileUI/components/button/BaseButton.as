package zebraMobileUI.components.button 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import zebra.mobile.MobileFont;
	import zebraMobileUI.components.core.BaseSpacer;
	import zebraMobileUI.components.MobileComponent;
	import zebraMobileUI.components.text.Label;
	import zebraMobileUI.event.ButtonEvent;
	import zebraMobileUI.MobileUIFramework;
	import zebraMobileUI.skinSetting.ButtonNode;
	import zebraMobileUI.util.Scale9GridBitmap;
	
	
	
	[Event(name="trigger",type="zebraMobileUI.event.ButtonEvent")]
	
	public class BaseButton extends MobileComponent
	{
		
		private var _buttonBM:Scale9GridBitmap;
		private var _text:String;
		private var _buttonNode:ButtonNode;
		private var _lable:Label;
		private var _spacer:BaseSpacer;		
		private var _padding:Number = 20;
		
		public function BaseButton() 
		{
			 super();
			 _buttonNode = MobileUIFramework.resource.buttonSetting.getButtonNodeByTheme(this._theme);
			 _buttonBM = new Scale9GridBitmap(_buttonNode.getNormalBmd(), _buttonNode.getRectBound());
			 addChild(_buttonBM);
			 

			_lable = new Label();
			_lable.text = ""
			_lable.textColor = 0xFFFFFF;
			_lable.bold = true;
		 	_lable.setFont(MobileFont.XHT);
			addChild(_lable)
			
 
			_spacer = new BaseSpacer(true,0xFF00FF);
			addChild(_spacer);
			
			_lable.mask = _spacer;
			
			this.width = 80;
			this.height = 44;
			resizeMask();
			
			aglinText();
		}
		
		protected function resizeMask():void {
				_spacer.width = _buttonBM.width - _padding;
				_spacer.height = _buttonBM.height - _padding;
				_spacer.x = _padding / 2;
				_spacer.y = _padding / 2;
			}
		
		protected function aglinText():void {
			   if(_lable.width<=_buttonBM.width){
				_lable.x =  ( _buttonBM.width-_lable.width) / 2
			   }else {
				_lable.x = _spacer.x;
				  }
				_lable.y=  (_buttonBM.height-_lable.height)/2-1
			}
		
		override protected function eventHandler():void 
		{
			addEventListener(MouseEvent.CLICK, _clickHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _mouseOutHandler);
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler)
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUpHandler);
		}
		
		private function _mouseUpHandler(e:MouseEvent):void 
		{
			_buttonBM.updateState(_buttonNode.getNormalBmd());
		}
		
		private function _mouseOutHandler(e:MouseEvent):void 
		{
			_buttonBM.updateState(_buttonNode.getNormalBmd());
		}
		
		private function _mouseDownHandler(e:MouseEvent):void 
		{
			_buttonBM.updateState(_buttonNode.getTriggerBmd());
		}
		
		private function _clickHandler(e:MouseEvent):void 
		{
			_buttonBM.updateState(_buttonNode.getNormalBmd());
			var event:ButtonEvent = new ButtonEvent(ButtonEvent.TRIGGER);
			dispatchEvent(event);
		}
		
		
		override public function dispose():void 
		{
			super.dispose();			
			removeEventListener(MouseEvent.CLICK, _clickHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _mouseOutHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUpHandler);
		}
		
		
		override public function get width():Number 
		{
			return _buttonBM.width;
		}
		
		override public function set width(value:Number):void 
		{
			_buttonBM.width = value;
			resizeMask();
			aglinText();
		}
		
		override public function get height():Number 
		{
			return _buttonBM.height;
		}
		
		override public function set height(value:Number):void 
		{
			_buttonBM.height = value;
			resizeMask();
			aglinText();
		}
		
		public function get text():String 
		{
			return _lable.text;
		}
		
		public function set text(value:String):void 
		{
			_lable.text = value;
			aglinText();
			resizeMask();
		}		
		public function get htmlText():String 
		{
			return _lable.htmlText;
		}
		
		public function set htmlText(value:String):void 
		{
			_lable.htmlText = value;
			aglinText();
			resizeMask();
		}
		
		public function autoSize():void {
			_buttonBM.width = _lable.width + _padding;
			_buttonBM.height = _lable.height + _padding;
			resizeMask();
			aglinText();
		}
		
		
	}

}