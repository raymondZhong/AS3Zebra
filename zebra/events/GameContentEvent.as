package zebra.events
{
	import flash.events.Event;
	
	public class GameContentEvent extends Event
	{
		
		/**
		 * 每件资源载入发出
		 */
		static public const EVERYTHING:String = "everything";
		
		/**
		 * ONLOAD TAETET 载入完成后的事件
		 */
		static public const ONLOADSWF:String = "onloadswf";
		static public const ONLOADIMAGE:String = "onloadImage";
		static public const ONLOADSOUND:String = "onloadsound";
		static public const ONLOADXML:String = "onloadxml";
		
		/**
		 * BITMAPDATA  一组序列位图加入完成抛出
		 */
		static public const ADDBITMAPDATA:String = "addBitmapData";
		
 
		static public const ADDVIEW:String = "addView";		
		static public const ADDMODEL:String = "addModel";
		static public const ADDCONTROLLER:String = "addController";
		static public const ADDXMLDATA:String = "addxmldata";
		static public const ADDGAMETEXTURE:String = "addGameTexture";
		
		/**
		 * ObjectContent
		 */
		static public const ADDOBJECTCONTENT:String = "addObjectContent";
		
		public function GameContentEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var content:*;
		public var key:*;
		public var vars:Object;
	
	}

}