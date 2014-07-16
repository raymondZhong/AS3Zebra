package zebra.system.net 
{
	import zebra.system.collections.FlashBytesReader;
		
	public interface SocketCommandRecordImp
	{
		function parse(data:FlashBytesReader):void
	}
	
}