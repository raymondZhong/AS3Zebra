package zebra.system.collections
{
	import flash.utils.ByteArray;
	
	public class FlashBytesReader extends ByteArrayReader
	{
		protected var _packlength:uint;
		protected var _mainId:int;
		protected var _childId:int;
		
		public function FlashBytesReader(bytes:ByteArray, position:uint = 0, iscopy:Boolean = false)
		{
			super(bytes, position, iscopy);
			_packlength = this.readUInt32();
			_mainId = this.readUInt8();
			_childId = this.readUInt8();
		}
		
		public function get packlength():uint
		{
			return _packlength;
		}
		
		public function get mainId():int
		{
			return _mainId;
		}
		
		public function get childId():int
		{
			return _childId;
		}
	
		override public function clone():* 
		{
			_bytes.position = 0;
			var bytes:ByteArray  = new ByteArray();
				bytes.writeBytes(_bytes);
			return new FlashBytesReader(bytes, 0, _iscopy);
		}
		
	}

}