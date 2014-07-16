package zebra.plugs.mobile.display
{
	import ASWC.controls.ConsoleAction;
	import ASWC.controls.MobileDebugConsole;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import flash.events.KeyboardEvent;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import zebra.Game;
	import zebra.plugs.mobile.MobileConstants;
	
	public class MobileRoot extends Sprite
	{
		private static var sAssets:AssetManager;
		public var  backgroundImage:Image;
		
		public var container:Sprite
		
		public function MobileRoot()
		{
			container = new Sprite();
			Game.Content.addView(this);
		}
		
		public function  showScreenContainer(target:DisplayObject):void {
			removeScreenContainer();
			container.addChild(target);
		}	
		
		public function removeScreenContainer():void {
			for (var i:int = 0; i < container.numChildren; i++) 
			{
				 container.getChildAt(i).dispose();
			}
			container.removeChildren();
		}
		
		
		public function removeBackgroundImage():void {
			removeChild(backgroundImage);
		}
		
 
		public function initialize(background:Texture):void
		{
			//sAssets = assets;
			backgroundImage = new Image(background);
			backgroundImage.width =  MobileConstants.deviceViewPort.width;
			backgroundImage.height =  MobileConstants.deviceViewPort.height;
			addChild(backgroundImage);
			addChild(container);
			 
			 
			this.scaleX = MobileConstants.deviceViewPort.width / MobileConstants.designViewPort.width;
			this.scaleY = MobileConstants.deviceViewPort.height / MobileConstants.designViewPort.height;
			
			MobileConstants.scaleX = MobileConstants.designViewPort.width/MobileConstants.deviceViewPort.width;
			MobileConstants.scaleY = MobileConstants.designViewPort.height/MobileConstants.deviceViewPort.height;
			 
			startGame();   
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler);
		}
		
		 
		private var _IsOpenConsole:Boolean;
		private function onKeyHandler(event:KeyboardEvent):void 
		{
			 switch(event.keyCode) {
				 case  Keyboard.BACK:
					 event.preventDefault();
					 activeBACK();
					 break;
				 case  Keyboard.MENU:
					 event.preventDefault();
					 activeMENU(); 
					 if (_IsOpenConsole) {
					      MobileDebugConsole.close();
						 }else {
						  MobileDebugConsole.openConsole();
						 }
						 _IsOpenConsole = !_IsOpenConsole;
					 break;
				 case  Keyboard.SEARCH:
					 //e.stopPropagation();
					 break;
				 }
		}
		
		protected function startGame():void
		{
			
		}
		
		
		protected function activeBACK():void {
			trace("back")
		}
		protected function activeMENU():void {
			trace("menu")			
		}
		protected function activeSEARCH():void {
			
		}
		
		public  function get assets():AssetManager
		{
			return sAssets;
		}
		
	}

}