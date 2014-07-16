package zebra.loaders 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	public class AssetTextLoader extends AssetBaseLoader
	{
		
		private var _contentLoader:URLLoader;
		public function AssetTextLoader(loaderEntity:ILoader)
		{
			super(loaderEntity);
			_contentLoader = new URLLoader();
		}
		
		override public function load(request:URLRequest):void 
		{
			super.load(request);			
			_contentLoader.load(request);
		}
		
		
		override public function get type():String
		{
			return AssetType.TEXT;
		}
		
		override public function dispose():void 
		{
			super.dispose();
			try
			{
				_contentLoader.close();
			}
			catch (error:*)
			{
			}
		}
 
		public function get contentLoader():URLLoader
		{
			return _contentLoader;
		}
		 
		override public function get content():* 
		{
			return _contentLoader.data;
		}
	}

}