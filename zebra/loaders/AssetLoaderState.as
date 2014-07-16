package zebra.loaders 
{
	public class AssetLoaderState 
	{
		
		/** The loader is ready to load and has not completed yet. **/
		public static const READY:int 		= 0;
		/** The loader is actively in the process of loading. **/
		public static const LOADING:int 	= 1;
		/** The loader has completed. **/
		public static const COMPLETED:int 	= 2;
		/** The loader is paused. **/
		//public static const PAUSED:int 		= 3;
		/** The loader failed and did not load properly. **/
		//public static const FAILED:int 		= 4;
		/** The loader has been disposed. **/
		public static const DISPOSED:int	= 5;
		
	}

}