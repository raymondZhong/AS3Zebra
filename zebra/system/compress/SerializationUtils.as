package zebra.system.compress
{
	import flash.utils.ByteArray;
	
	public class SerializationUtils
	{
		public static function serializeToString(value:Object):String
		{
			if (value == null)
			{
				throw new Error("null isn't a legal serialization candidate");
			}
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(value);
			bytes.position = 0;
			var be:Base64Encoder = new Base64Encoder();
			be.encode(bytes.readUTFBytes(bytes.length));
			return be.drain();
		}
		
		public static function readObjectFromStringBytes(value:String):ByteArray
		{
			var dec:Base64Decoder = new Base64Decoder();
			dec.decode(value);
			var result:ByteArray = dec.drain();
			result.position = 0;
			return result;
		}
	}
}