package zebra.system.net 
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	import zebra.system.collections.FlashBytesReader;
	
	[Event(name="connectSuccess",type="zebra.events.GameSocketEvent")]
	[Event(name="close",type="zebra.events.GameSocketEvent")]
	[Event(name="ioerror",type="zebra.events.GameSocketEvent")]
	[Event(name = "securityerror", type = "zebra.events.GameSocketEvent")]
	
	public interface IGameSocket extends IEventDispatcher
	{
		function connect(ip:String, port:int):void;
		function get bufferList():Vector.<FlashBytesReader>;
		function send(byteArray:ByteArray):void;
	}
	
}