package zebra.events 
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import zebra.loaders.IAssetLoader;
	
	/**
	 * ...
	 * @author raymond
	 */
	public class AssetLoaderEvent extends Event 
	{
		static public const PROGRESS:String = "progress";
		static public const COMPLETE:String = "complete";
		static public const Errors:String = "error";		
		static public const CHILDCOMPLETE:String = "childcomplete";
		
		public function AssetLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/**
		 *  每个加载后的加载数据信息
		 */
		public var assetloader:IAssetLoader;
		
		public override function clone():Event 
		{ 
			return new AssetLoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AssetLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}