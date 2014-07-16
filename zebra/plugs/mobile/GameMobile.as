package zebra.plugs.mobile
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.InterfaceAddress;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	import flash.system.Capabilities;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import zebra.Game;
	import zebra.plugs.mobile.display.MobileRoot;
	import zebra.plugs.mobile.model.AppConfig;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;
	
	public class GameMobile extends Sprite
	{
		private var _initbackground:Bitmap;
		protected var mStarling:Starling;
		protected var scaleFactor:int;
		
		protected var resourceClass:Class;
		
		public var appDir:File = File.applicationDirectory;
 
		public var assets:AssetManager;
		public var commonRoot:Sprite = new Sprite();
		
		public var config:AppConfig = new AppConfig();
		
		
		public function GameMobile()
		{
			 stage.scaleMode = StageScaleMode.NO_SCALE;
			 stage.align = StageAlign.TOP_LEFT;
			 addChild(commonRoot);
			 
			 
			 var game:Game = new Game(stage);
			 
			 Starling.multitouchEnabled = true;  // useful on mobile devices
             Starling.handleLostContext =  !MobileConstants.IOS;  // not necessary on iOS. Saves a lot of memory!
            // Starling.handleLostContext = true;    //!MobileConstants.IOS;  // not necessary on iOS. Saves a lot of memory!
				
			 MobileConstants.deviceViewPort =	new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			 updateNetWork();
			 
             //assets = new AssetManager();   
             //assets.verbose = Capabilities.isDebugger;
             //assets.enqueue(
                //appDir.resolvePath("assets/audio"),
                //appDir.resolvePath(formatString("assets/fonts", scaleFactor)),
                //appDir.resolvePath(formatString("assets/textures", scaleFactor))
            //);
			
 
			Game.Content.addView(this);		
		}
		
		
		public function  showCommonRoot(target:DisplayObject):void {
			removeCommonRoot();
			commonRoot.addChild(target);
		}	
		
		public function removeCommonRoot():void {
			commonRoot.removeChildren();
		}
		
		/**
		 * 启动位图,入口文件,资源类,设计尺寸
		 * @param	bm
		 * @param	root
		 * @param	res
		 * @param	design
		 */
		public function startApp(startupImg:Bitmap, root:Class,res:Class,designRect:Rectangle):void
		{
			resourceClass = res;
			MobileConstants.designViewPort = designRect;
			setBackground(startupImg);
			launchStarling(root);
			
			this.scaleX = MobileConstants.deviceViewPort.width / MobileConstants.designViewPort.width;
			this.scaleY = MobileConstants.deviceViewPort.height / MobileConstants.designViewPort.height;
		}
		
		public function exitApp():void {
			NativeApplication.nativeApplication.exit();
		}
		
		
		protected function setBackground(startupImg:Bitmap):void
		{
			_initbackground = startupImg;
			_initbackground.x = MobileConstants.designViewPort.x;
			_initbackground.y = MobileConstants.designViewPort.y;
			_initbackground.width = MobileConstants.designViewPort.width;
			_initbackground.height = MobileConstants.designViewPort.height;
			_initbackground.smoothing = true;
			addChild(_initbackground);
		}
		
		/**设备丢失后的重建*/
		//private function onContextCreated(event:Event):void
		//{
			// 设备丢失后，我们必须创建新的缓冲区和着色器
			//createBuffers();
			//registerPrograms();
		//}
		//
		
		protected function launchStarling(root:Class):void
		{
			mStarling = new Starling(root, stage, MobileConstants.deviceViewPort);
			//mStarling = new Starling(root, stage, new Rectangle(0,0,MobileConstants.viewPort.width*0.7,MobileConstants.viewPort.height*0.7));
			mStarling.simulateMultitouch = false;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			//mStarling.showStats = true;//Capabilities.isDebugger;
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreateHandler);
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, function(e:*):void
				{
					mStarling.start();
				});
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, function(e:*):void
				{
					mStarling.stop();
				});
		
		}
		
		private function rootCreateHandler(event:Object, app:MobileRoot):void
		{
			mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreateHandler);			
			new resourceClass();
			if (_initbackground)
				removeChild(_initbackground);
			var bgTexture:Texture = Texture.fromBitmap(_initbackground, false, false);
			//app.initialize(bgTexture, assets);
			app.initialize(bgTexture);
			mStarling.start();
			initialize();
		}
		
		
		protected function initialize():void {
			
			
		}
		
		
		
		
		//更新网络信息
		public function updateNetWork():void {
			
				var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
				var interfaces:Vector.<NetworkInterface> = networkInfo.findInterfaces();
				if( interfaces != null )
				{
					//trace( "Interface count: " + interfaces.length );
					for each ( var interfaceObj:NetworkInterface in interfaces )
					{
						if (interfaceObj.name == "WIFI") {
							  MobileConstants.WIFIActive =  interfaceObj.active;
							  MobileConstants.MacAdress = interfaceObj.hardwareAddress;
							}
						/*trace( "\nname: "             + interfaceObj.name );
						trace( "display name: "     + interfaceObj.displayName );
						trace( "mtu: "                 + interfaceObj.mtu );
						trace( "active?: "             + interfaceObj.active );
						trace( "parent interface: " + interfaceObj.parent );
						trace( "hardware address: " + interfaceObj.hardwareAddress );
						if( interfaceObj.subInterfaces != null )
						{
							trace( "# subinterfaces: " + interfaceObj.subInterfaces.length );
						}
						trace("# addresses: "     + interfaceObj.addresses.length );
						for each ( var address:InterfaceAddress in interfaceObj.addresses )
						{
							trace( "  type: "           + address.ipVersion );
							trace( "  address: "         + address.address );
							trace( "  broadcast: "         + address.broadcast );
							trace( "  prefix length: "     + address.prefixLength );
						}*/
					}            
				}   
			
		}
		
		
	
	}

}