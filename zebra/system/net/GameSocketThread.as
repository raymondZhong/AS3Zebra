package zebra.system.net
{
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	import zebra.directEvent.DirectEventParameter;
	import zebra.Game;
	
	public class GameSocketThread
	{
		static public const channel:String = "GameSocketThread_channel";
		
		public const ConnectSuccess:String = "GameSocketThreadConnect_Success";
		public const Close:String = "GameSocketThread_Close";
		public const IOerror:String = "GameSocketThread_ioerror";
		public const Securityerror:String = "GameSocketThread_securityerror";
		public const CommandReader:String = "GameSocketThread_commandreader";
		
		static public var serverType:uint;
		
		private var _socketManager:GameSocketManager;
		public var firstConnectHandler:Function;
		
		private var _autoConnectionTime:uint = 3000;
		private var _isAutoConnection:Boolean;
		
		public function GameSocketThread()
		{
			_socketManager = new GameSocketManager();
			_socketManager.connectHandler = _connectHandler;
			_socketManager.ioErrorHandler = _ioErrorHandler;
			_socketManager.securityErrorHandler = _securityErrorHandler;
			_socketManager.closeHandler = _closeHandler;
		}
		
		public function setSendBytesByConnect(sendBytesByConnect:Function):void
		{
			_socketManager.sendBytesByConnect = sendBytesByConnect;
		}
		
		/**
		 * 接受buffer缓冲的数据
		 * @param	command
		 * @param	action
		 */
		public function receive(command:String, action:*):void
		{
			Game.DirectEvent.receive(command, action, channel);
		}
		
		/**
		 * 销毁
		 * @param	command
		 * @param	action
		 */
		public function destroy(command:String, action:*):void
		{
			Game.DirectEvent.destroy(command, action, channel);
		}
		
		/**
		 * 向服务器端发送协议数据
		 * @param	command
		 * @param	data
		 */
		public function send(command:String, data:ByteArray):void
		{
			_socketManager.sendCommand(command, data);
		}
		
		private function _closeHandler():void
		{
			Game.DirectEvent.send(Close, new DirectEventParameter(), channel);
			if(_isAutoConnection){
				setTimeout(function():void{
							Game.SocketThread.connect(_socketManager.ip, _socketManager.port, serverType)
						}, 
						_autoConnectionTime);
			}
		}
		
		private function _ioErrorHandler():void
		{
			Game.DirectEvent.send(IOerror, new DirectEventParameter(), channel);
			if(_isAutoConnection){
				setTimeout(function():void{
							Game.SocketThread.connect(_socketManager.ip, _socketManager.port, serverType)
						}, 
						_autoConnectionTime);
			}
		}
		
		private function _securityErrorHandler():void
		{
			Game.DirectEvent.send(Securityerror, new DirectEventParameter(), channel);
		}
		
		private function _connectHandler():void
		{
			Game.DirectEvent.send(ConnectSuccess, new DirectEventParameter(), channel);
		}
		
		public function connect(ip:String, port:int, serverType:uint = 0):void
		{
			_socketManager.connect(ip, port);
			serverType = serverType;
		}
		
		/**
		 * 设置自动联机
		 */
		public function setAutoConnect(value:uint = 3000):void {
			_autoConnectionTime = value;
			_isAutoConnection = true;
		}
		
		//取消设置的自动联机
		public function unsetAutoConnect():void {
			_isAutoConnection = false;
		}
		
		
		public function close():void
		{
			_socketManager.close();
		}
	
	}

}