package zebraui.components.message
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import zebraui.components.button.BaseButton;
	import zebraui.components.container.Box;
	import zebraui.components.layout.HBoxLayout;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.layout.LayoutAlign;
	import zebraui.components.layout.LayoutMargin;
	import zebraui.components.panel.Panel;
	import zebraui.components.panel.PanelDesigner;
	import zebraui.components.text.Label;
	import zebraui.components.text.TextWord;
	import zebraui.components.UIComponent;
	import zebraui.components.window.DialogWindow;
	import zebraui.UIFramework;
	
	internal class AlertDesigner extends DialogWindow
	{
		protected var panel:PanelDesigner;
		private var buttonBox:Box;
		private var messageBox:Box;
		public var yesButton:BaseButton;
		public var noButton:BaseButton;
		public var cancelButton:BaseButton;
		public var messageText:TextWord;
		
		public var yesHandler:Function;
		public var noHandler:Function;
		public var cancelHandler:Function;		
		protected var _type:String;
		
		public function AlertDesigner(type:String,preferWidth:Number = 360, preferHeight:Number = 160)
		{
			var layout:HBoxLayout = new HBoxLayout();
			layout.hAlign = LayoutAlign.HAlign_CENTER;
			layout.vAlign = LayoutAlign.VAlign_CENTER;
			_type = type;
			super(layout, preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			panel = new PanelDesigner(_preferWidth,_preferHeight);
			panel.dragEnable = true;
			box.append(panel);
			_Isdialog = false;
			_triggerResize = false;
			shadow = true;						
			messageText = new TextWord();
			var msgHBox:HBoxLayout = new HBoxLayout();
				msgHBox.margin = new LayoutMargin(5, 0, 5, 5);
				msgHBox.vAlign = LayoutAlign.VAlign_CENTER;
				msgHBox.hAlign = LayoutAlign.HAlign_CENTER;
			messageBox = new Box(panel.body.width, _preferHeight - panel.header.height-40);
			messageBox.setLayout(msgHBox);
			messageBox.append(messageText);
			panel.body.addChild(messageBox);
			 
			var butBoxLayout:HBoxLayout = new HBoxLayout();
				butBoxLayout.vAlign = LayoutAlign.VAlign_BOTTOM;
				butBoxLayout.hAlign = LayoutAlign.HAlign_CENTER;
				butBoxLayout.offY  = -10;
				
			buttonBox = new Box(panel.body.width,_preferHeight - panel.header.height);
			buttonBox.setLayout(butBoxLayout);
			panel.body.addChild(buttonBox);
			
			yesButton = new BaseButton(100);
			yesButton.ClickHandler = yesHandler;
			yesButton.ClickAfterHandler = closeAlert;
			noButton = new BaseButton(100);
			noButton.ClickHandler = noHandler;
			noButton.ClickAfterHandler = closeAlert;
			cancelButton = new BaseButton(100);
			cancelButton.ClickHandler = cancelHandler;
			cancelButton.ClickAfterHandler = closeAlert;			
			switch(_type) {
				case AlertType.YES:
					buttonBox.append(yesButton);
				break;
					case AlertType.YESNO:
					buttonBox.append(yesButton);
					buttonBox.append(noButton);
				break;
					case AlertType.YESNOCANCEL:
					buttonBox.append(yesButton);
					buttonBox.append(noButton);
					buttonBox.append(cancelButton);
				break;
			}
		}
		
		
		private function  closeAlert(e:*):void {
				 if (this.parent)
				 this.parent.removeChild(this);
				 Alert.IsOpen = false;
			}
		
		override protected function addToStageControl():void
		{
			var bmd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.HeaderRound");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Public", "PanelHeader");
			panel.header.backgroundSprite.updateState(bmd,rect);
			box.width = stage.stageWidth;
			box.height = stage.stageHeight;
			super.addToStageControl();
		}
		
		public function get title():String
		{
			return panel.header.title;
		}
		
		public function set title(value:String):void
		{
			panel.header.title = value;
		}
		
		public function get icon():BitmapData
		{
			return panel.header.icon;
		}
		
		public function set icon(value:BitmapData):void
		{
			panel.header.icon = value;
		}
		
		
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			panel.width = _preferWidth;
			buttonBox.width = _preferWidth;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			panel.height = _preferHeight;
			buttonBox.height = _preferHeight;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
	
	}

}