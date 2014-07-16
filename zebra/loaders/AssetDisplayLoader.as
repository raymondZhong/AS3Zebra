package zebra.loaders
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import zebra.content.GameAsset;
	
	public class AssetDisplayLoader extends AssetBaseLoader
	{
		private var _contentLoader:Loader;
		
		public function AssetDisplayLoader(loaderEntity:ILoader)
		{
			super(loaderEntity);
			_contentLoader = new Loader();
		}
		
		override public function load(request:URLRequest):void
		{
			super.load(request);
			_contentLoader.load(request, GameAsset.defaultContext);
		}
		
		override public function get content():*
		{
			return _contentLoader.content;
		}
		
		public function get contentLoaderInfo():LoaderInfo 
		{
			return _contentLoader.contentLoaderInfo;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_contentLoader.unloadAndStop();
		}
		
		override public function get type():String
		{
			return AssetType.DISPLAYOBJECT;
		}
	}

}