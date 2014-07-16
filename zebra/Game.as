package zebra 
{
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import zebra.content.GameContent;
	import zebra.core.GameTimeUpdate;
	import zebra.data.GameDataService;
	import zebra.directEvent.DirectEventManager;
	import zebra.directEvent.IDirectEventManager;
	import zebra.graphics.GraphicsDeviceManager;
	import zebra.input.KeyInput;
	import zebra.input.MouseInput;
	import zebra.system.GameHack;
	import zebra.system.net.GameSocketThread;
	
	
	public class Game 
	{
		static private var _initialized:Boolean;
		static private var _gameContent:GameContent;
		static private var _graphicsDeviceManager:GraphicsDeviceManager;
		static private var _mouseInput:MouseInput;
		static private var _gamehack:GameHack;
		static private var _gametimeUpdate:GameTimeUpdate;
		static private var _gameDirectEventManager:IDirectEventManager;
		static private var _keyInput:KeyInput;
		static private var _gameDataService:GameDataService;
		static private var _IsDebugMode:Boolean;
		static private var _socketThread:GameSocketThread; 
		
		public function Game(stage:Stage) 
		{
			if (_initialized) throw new Error(" Game FrameWork is Initialized ");
			_gamehack = new GameHack();
			_gamehack.keepframe();
			_graphicsDeviceManager = new GraphicsDeviceManager(stage);

			
			_gametimeUpdate = new GameTimeUpdate();
			_gameContent = new GameContent()

			_mouseInput = new MouseInput();
			_gameDirectEventManager = new DirectEventManager();
			
			_keyInput = new KeyInput();			
			_gameDataService = new GameDataService();
			
			_socketThread = new GameSocketThread();
			
			_IsDebugMode = true;
			_initialized = true;
		}
		
		
		
		static public function get INITIALIZED():Boolean { return _initialized; }		
		static public function get Content():GameContent { return _gameContent; }
		
		static public function get currentApplicationDomain():ApplicationDomain {
			  return  _graphicsDeviceManager.stage.loaderInfo.applicationDomain;
			}	
		
			
		static public function get graphicsDeviceManager():GraphicsDeviceManager { return _graphicsDeviceManager; }
		
		static public function get DataService():GameDataService { return _gameDataService;}

		static public function get Hack():GameHack { return _gamehack; }
		static public function get DirectEvent():IDirectEventManager { return _gameDirectEventManager; }
		
		static public function get TimeUpdate():GameTimeUpdate { return  _gametimeUpdate; }
		static public function get mouseInput():MouseInput { return _mouseInput; }		
		static public function get keyInput():KeyInput { return _keyInput; }
		static public function get SocketThread():GameSocketThread{ return _socketThread; }
		
		
		static public function get IsDebugMode():Boolean 
		{
			return false;
			return  Capabilities.isDebugger;
		}
		 
		   
	/*	public function initialize():void {}*/
	}
}
