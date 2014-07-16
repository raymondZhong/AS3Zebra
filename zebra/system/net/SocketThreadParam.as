package zebra.system.net 
{
	import flash.utils.ByteArray;
	import zebra.directEvent.DirectEventParameter;
	import zebra.system.collections.ByteArrayReader;
	import zebra.system.collections.FlashBytesReader;

	public class SocketThreadParam extends DirectEventParameter
	{
		public var bytesReader:FlashBytesReader;
		public function SocketThreadParam(reader:FlashBytesReader) 
		{
			this.bytesReader = reader;
		}
		
	}

}