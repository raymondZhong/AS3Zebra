package zebra.debug 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import zebra.Game;
	/**
	 * ...
	 * @author raymond
	 */
	public class DebugConsoleGUI extends Sprite
	{
		private var _bg:Shape;
		private var _textInput:TextField;
		private var _commandSprite:Sprite;
		private var _shorcut:Boolean;
		public function DebugConsoleGUI(shortcut:Boolean=true) 
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			_commandSprite = new Sprite();
			addChild(_commandSprite);
			_shorcut = shortcut;
			this.visible = false;
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			var label:TextField = new TextField();
			label.text = " Command >"
			label.background = true;
			label.backgroundColor = 0x000000;
			label.height = 22;
			label.width -=5
			_commandSprite.addChild(label);
			
			var labelTformat:TextFormat = new TextFormat("Arial",14,0x55CB2E);
			label.setTextFormat(labelTformat);
			
			
			
			_textInput = new TextField();
			_textInput.x = label.width;
			_textInput.width = stage.stageWidth-_textInput.x;
			_textInput.height = 22;
			_textInput.type = TextFieldType.INPUT;
			_textInput.background = true;
			_textInput.backgroundColor = 0x000000;
			_textInput.addEventListener(KeyboardEvent.KEY_UP,commandKeyUpHandler)
			_commandSprite.addChild(_textInput);
			
			
			var tformat:TextFormat = new TextFormat("Arial",14,0xFFFFFF);
			_textInput.defaultTextFormat =tformat;
			
		 	addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
			
			
			stage.addEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler);
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			
		}
		
		private function stageResizeHandler(e:Event):void 
		{
			_textInput.width = stage.stageWidth-_textInput.x;
		}
		
		private function stageKeyUpHandler(e:KeyboardEvent):void 
		{
			//trace(e.keyCode,"???????????????")
			if (_shorcut) {
				  if (e.ctrlKey  && e.keyCode == 68) {
					    this.visible = !this.visible;
						stage.addChild(this);
					  }
				}
		}
		
		private function removeFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);			
			stage.removeEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler);
			_textInput.removeEventListener(KeyboardEvent.KEY_UP, commandKeyUpHandler);
			stage.removeEventListener(Event.RESIZE, stageResizeHandler);
		}
		
		private function commandKeyUpHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == 13) {
				  Game.DirectEvent.send(_textInput.text, null, DebugCommand.DebugCommandChannel);
				  _textInput.text = "";
				}
				
		}
 
		
	}

}