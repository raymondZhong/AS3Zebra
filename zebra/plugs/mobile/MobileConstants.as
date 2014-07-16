package zebra.plugs.mobile 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.core.Starling;
 
	public class MobileConstants 
	{
		
		public function MobileConstants() 
		{
			
		}
		
		  static public var designViewPort:Rectangle = new Rectangle();
		  static public var deviceViewPort:Rectangle = new Rectangle();
		  
		  static public var scaleX:Number = 1;
		  static public var scaleY:Number = 1;
		  
		  static public const IOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
		  static public const DPI:Number = Capabilities.screenDPI;
		  
		  static public var MacAdress:String = "";
		  static public var WIFIActive:Boolean = false;
		  
		  
		  static public function scalePoint(point:Point):Point {
			      return new Point( point.x * MobileConstants.scaleX,
									point.y * MobileConstants.scaleY
								);
			  }
			  
		  static public const IPHONE4_SD:Rectangle = new Rectangle(0, 0, 320, 480);
		  static public const IPHONE4_HD:Rectangle = new Rectangle(0, 0, 640, 960) ;
		  static public const IPHONE5_HD:Rectangle = new Rectangle(0, 0, 640, 1186);
		  
		  
		  static public const ANDROID_WVGA800:Rectangle = new Rectangle(0, 0, 480, 800);
		  static public const ANDROID_WVGA854:Rectangle = new Rectangle(0, 0, 480, 854);
		  static public const ANDROID_HVGA:Rectangle = new Rectangle(0, 0, 480, 640);
		  static public const ANDROID_QVGA:Rectangle = new Rectangle(0, 0, 240, 320);
		 
		  
	}

}