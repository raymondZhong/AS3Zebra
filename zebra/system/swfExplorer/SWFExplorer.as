package zebra.system.swfExplorer
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import  zebra.system.swfExplorer.events.SWFExplorerErrorEvent;
	import  zebra.system.swfExplorer.events.SWFExplorerEvent;

	/**
	 * Dispatched when all the classes definitions names have been extracted
	 *
	 * @eventType org.bytearray.explorer.events.SWFExplorerEvent.COMPLETE
	 *
	 * * @example
	 * This example shows how to listen for such an event :
	 * <div class="listing">
	 * <pre>
	 *
	 * myLoader.addEventListener ( SWFExplorerEvent.COMPLETE, definitionsReady );
	 * </pre>
	 * </div>
 	 */
	[Event(name='parseComplete', type='zebra.system.swfExplorer.events.SWFExplorerEvent')]
	
	/**
	 * Dispatched when no classes definitions names could be found
	 *
	 * @eventType org.bytearray.explorer.events.SWFExplorerErrorEvent.NO_DEFINITIONS
	 *
	 * * @example
	 * This example shows how to listen for such an event :
	 * <div class="listing">
	 * <pre>
	 *
	 * myLoader.addEventListener ( SWFExplorerErrorEvent.NO_DEFINITIONS, noDefinitions );
	 * </pre>
	 * </div>
 	 */
	[Event(name='noDefinitions', type='zebra.system.swfExplorer.events.SWFExplorerErrorEvent')]
	
	/**
	 * The SWFExplorer class allows you to : 
	 * 1. Browse all the exported classes definitions contained in an SWF. The getDefinitions() method returns an array of class definition names
	 * 2. Discover, if any GPU acceleration has been set in a Flash Player 10 or above SWF. The acceleration property tell you which GPU acceleration has been set
	 * @version 0.7.1
	 * @author Thibault Imbert
	 * @url www.bytearray.org
	 * 
	 */	
	public final class SWFExplorer extends URLLoader
	{	
		private var stream:ByteArray;
		private var compressed:int;
		private var nBits:int;
		private var version:int;
		private var length:int;
		private var swf:ByteArray;
		private var frameRate:int;
		private var frameCount:int;
		private var dictionary:Array;
		private var arrayClasses:Array;
		private var accelerationType:int;
		private var criteria:int;
		private var currentByte:int;
		private var bitPosition:int;
		
		private static const NOT_COMPRESSED:int = 0x46;
		private static const COMPRESSED:int = 0x43;
		private static const FULL:int = 0x3F;
		private static const SYMBOLCLASS:int = 0x4C;
		private static const FILEATTRIBUTES:int = 0x45;
		
		public static const CLASSES:String = "classes";
		public static const ACCELERATION:String = "acceleration";
		
		public static const NONE:int = 0;
		public static const DIRECT:int = 0x1;
		public static const GPU:int = 0x2;
		
		private var buffer:uint = 0;
		private var pointer:uint = 0;
		private var source:uint;
		
		public function SWFExplorer()
		{
			arrayClasses = new Array();
			
			dataFormat = URLLoaderDataFormat.BINARY;
			
			addEventListener (Event.COMPLETE, complete);
		}
		
		private function complete ( e:Event ):void
		{	
			parse ( data );	
		}
		
		public function parse ( bytes:ByteArray, type:String="classes" ):Array
		{
			stream = bytes;
			
			arrayClasses = new Array();
				
			stream.position = 0;
			
			compressed = stream.readUnsignedByte();
			
			stream.position += 2;
			
			version = stream.readUnsignedByte();
			
			stream.endian = Endian.LITTLE_ENDIAN;

			length = stream.readUnsignedInt();
			
			stream.endian = Endian.BIG_ENDIAN;
			
			swf = new ByteArray();
			
			stream.readBytes ( swf, 0 );
			
			if ( compressed == SWFExplorer.COMPRESSED )
				swf.uncompress();
			
			var firstBRect:uint = swf.readUnsignedByte();
			
			var size:uint = firstBRect >> 3; 
			var offset:uint = (size-3);
			
			var threeBits:uint = firstBRect & 0x7;
			
			source = swf.readUnsignedByte();
			
			var xMin:uint = readBits(offset) | (threeBits << offset) / 20;
			var yMin:uint = readBits(size) / 20;
			var wMin:uint = readBits(size) / 20;
			var hMin:uint = readBits(size) / 20;
			
			var frameRate:uint = swf.readShort() & 0xFF;
			
			var numFrames:uint = swf.readShort();
			
			var frameCount:uint = (numFrames >> 8) & 0xFF | ((numFrames & 0xFF) << 8);
						
			swf.endian = Endian.LITTLE_ENDIAN;
			
			dictionary = browseTables();
			
			if ( type == SWFExplorer.CLASSES )
			{
				criteria = SWFExplorer.SYMBOLCLASS;
				
				var symbolClasses:Array = dictionary.filter( filter );
				
				var i:int;
				var count:int;
				var char:int;
				var name:String;
				
				if ( symbolClasses.length > 0 )
				{
					swf.position = symbolClasses[0].offset;
					
					count = swf.readUnsignedShort();
					
					for (i = 0; i< count; i++)
					{
						swf.readUnsignedShort();
					
						char = swf.readByte();
						name = new String();
						
			            while (char != 0)
			            {
			                name += String.fromCharCode(char);
			                char = swf.readByte();
			            }
						arrayClasses.push ( name );
					}
					
				} else dispatchEvent( new SWFExplorerErrorEvent ( SWFExplorerErrorEvent.NO_DEFINITIONS ) );
				
				dispatchEvent( new SWFExplorerEvent ( SWFExplorerEvent.COMPLETE, arrayClasses ) );
				
			} else if ( type == SWFExplorer.ACCELERATION )
			{
				criteria = SWFExplorer.FILEATTRIBUTES;
				
				symbolClasses = dictionary.filter( filter );
				
				if ( symbolClasses.length > 0 )
				{	
					swf.position = symbolClasses[0].offset;
				 	accelerationType = (swf.readByte() & 0xE0) >> 5;	
				}	
			}
			return arrayClasses;
			
		}
		
		private function readBits(numBits:uint):uint
		{
			buffer = 0;
			var currentMask:uint;
			var bitState:uint;
			for ( var i:uint = 0; i<numBits; i++)
			{
				currentMask = (1 << 7) >> pointer++;
				bitState = uint((source & currentMask) != 0);
				buffer |= bitState << ((numBits - 1) - i);
				if ( pointer == 8 )
				{
					source = swf.readUnsignedByte();
					pointer = 0;
				}
			}
			return buffer;
		}
		
		private function filter (element:TagInfos, index:int, array:Array):Boolean
		{
			return element.tag == criteria;	
		}
		
		private function browseTables():Array
		{
			var currentTag:int;
			var step:int;
			var dictionary:Array = new Array();
			var infos:TagInfos;
			
			while ( currentTag = ((swf.readShort() >> 6) & 0x3FF) )
			{
				infos = new TagInfos();
			
				infos.tag = currentTag; 
				infos.offset = swf.position;
				swf.position -= 2;
				step = swf.readShort() & 0x3F;
				
				if ( step < SWFExplorer.FULL )
					swf.position += step;
				else 
				{
					step = swf.readUnsignedInt();
					infos.offset = swf.position;
					swf.position += step;
				}
				infos.endOffset = swf.position;		
				dictionary.push ( infos );	
			}
			return dictionary;
		}
		
		/**
		 * Returns an array of class definitions names
		 * @return Array
		 * 
		 */		
		public function getDefinitions():Array
		{
			return arrayClasses;	
		}
		
		/**
		 * Returns the number of definitions in the current SWF
		 * @return uint
		 * 
		 */	
		public function getTotalDefinitions():uint
		{	
			return arrayClasses.length;	
		}
		
		/**
		 * Returns the type of acceleration wich has been set in the SWF
		 * @return int
		 * 
		 */	
		public function get acceleration():int
		{	
			return accelerationType;	
		}

	}
}

final class TagInfos
{
	public var offset:int;
	public var endOffset:int;
	public var tag:int;	
}