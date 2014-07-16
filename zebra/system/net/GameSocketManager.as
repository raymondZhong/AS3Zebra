/**
 * 协议:
 *	 整包= 4+ 包头(2字节 主ID +子ID) + 包体
 */

package zebra.system.net
{
	import flash.events.*;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import zebra.events.GameSocketEvent;
	import zebra.Game;
	import zebra.system.collections.ByteArrayCollection;
	import zebra.system.collections.ByteArrayReader;
	import zebra.system.collections.FlashBytesReader;
	import zebra.system.collections.Int64;
	import zebra.system.util.SocketPackUtil;
	import zebra.thread.task.Task;
	
	[Event(name="connectSuccess",type="zebra.events.GameSocketEvent")]
	[Event(name="close",type="zebra.events.GameSocketEvent")]
	[Event(name="ioerror",type="zebra.events.GameSocketEvent")]
	[Event(name="securityerror",type="zebra.events.GameSocketEvent")]
	[Event(name="commandreader",type="zebra.events.GameSocketEvent")]
	
	internal class GameSocketManager extends EventDispatcher implements IGameSocket
	{
		
		private var _socket:Socket;
		private var _buffer:ByteArray;
		private var _ip:String;
		private var _port:int;
		private var _settingPackLength:uint = 4;
		private var _socketBufferAction:SocketBufferAction;
		private var _bufferList:Vector.<FlashBytesReader>
		
		public var ioErrorHandler:Function;
		public var securityErrorHandler:Function;
		public var connectHandler:Function;
		public var closeHandler:Function;
		
		public var sendBytesByConnect:Function;
		
		public function GameSocketManager()
		{
			_bufferList = new Vector.<FlashBytesReader>();
			_socket = new Socket();
			_buffer = new ByteArray();
			_socketBufferAction = new SocketBufferAction(_bufferList);
			Game.TimeUpdate.addTaskAction(_socketBufferAction);
		}
		
		public function connect(ip:String, port:int):void
		{
			_ip = ip;
			_port = port;
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, getSocketData);
			_socket.addEventListener(Event.CLOSE, onClose);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.connect(ip, port);
		}
		
		public function close():void {
			_socket.close();
			}
		
		private function onIOError(e:IOErrorEvent):void
		{
			trace("socket发送通信异常:" + e.text);
			if (ioErrorHandler != null) ioErrorHandler();
			dispatchEvent(new GameSocketEvent(GameSocketEvent.IOERROR));
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			trace("socket发送沙箱异常:" + e.text);
			if (securityErrorHandler != null) securityErrorHandler();
			dispatchEvent(new GameSocketEvent(GameSocketEvent.SECURITYERROR));
		}
		
		private function onConnect(e:Event):void
		{
			
			trace("连接成功>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			sendFlashPlayerHeader();
			 if (sendBytesByConnect != null) sendBytesByConnect();
			if (connectHandler != null) connectHandler();
			dispatchEvent(new GameSocketEvent(GameSocketEvent.CONNECTSUCCESS));
		}
		
		/**
		 * 发送穿透的策略文件 843端口的socket用的数据
		 */
		private function sendFlashPlayerHeader():void {
					_socket.writeMultiByte("<swf-connect-request/>\n","utf-8");
					_socket.flush();
			}
		
		private function onClose(e:Event):void
		{
			if (closeHandler != null) closeHandler();
			dispatchEvent(new GameSocketEvent(GameSocketEvent.CLOSE));
		}
		
		/**
		 * 解析网络数据流
		 */
		protected function parseNetStream():void
		{
			if (_buffer.length >= 4)
			{
				_buffer.position = 0;
				var packLen:uint = _buffer.readUnsignedInt();
				if (_buffer.length >= packLen)
				{
					var bytesReader:ByteArray = new ByteArray();
						bytesReader.writeBytes(_buffer, 0, packLen);
					
			 
					//服务器数据放入bufferList
					var reader:FlashBytesReader = new FlashBytesReader(bytesReader);
					_bufferList.push(reader);
					//_bufferList.push(reader.clone());
					trace("接收到:" + reader.mainId + "--" + reader.childId);
					//var event:GameSocketEvent = new GameSocketEvent(GameSocketEvent.COMMANDREADER);
					//event.bytesReader = reader;
					//dispatchEvent(event);
					 
					
					//剩余包数据处理
					var surplusBytes:ByteArray = new ByteArray();
						surplusBytes.writeBytes(_buffer, packLen);
					_buffer.clear();
					_buffer = surplusBytes;
					parseNetStream();
				}
			}
		}
		
		protected function getSocketData(e:ProgressEvent):void
		{
			if (_socket.bytesAvailable > 0)
			{
				_buffer.position = _buffer.length;
				var currentData:ByteArray = new ByteArray();
				_socket.readBytes(currentData);
				_buffer.writeBytes(currentData);
				parseNetStream();
			}
		}
		
		public function send(byteArray:ByteArray):void
		{
			if (_socket.connected)
			{
				_socket.writeBytes(byteArray);
				_socket.flush();
			}
		}
		
		/**
		 * 0-1  byteArray
		 * @param	commandName
		 * @param	bytes
		 */
		public function sendCommand(commandName:String, bytes:ByteArray):void {
			 send(SocketPackUtil.setPackHeader(commandName, bytes))
			//var v:ByteArrayCollection = new ByteArrayCollection()
			//v.toStr("insomnia中国馆");
			//v.toInt32(5000);
			//v.toStr("insomnia中国馆2");
			//send(SocketPackUtil.setPackHeader("9-9", v));
			//
		}
		
		
		public function get bufferList():Vector.<FlashBytesReader>
		{
			return _bufferList;
		}
		
		public function get ip():String 
		{
			return _ip;
		}
		
		public function get port():int 
		{
			return _port;
		}
	}

}