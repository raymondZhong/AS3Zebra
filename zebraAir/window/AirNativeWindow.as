package zebraAir.window
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class AirNativeWindow extends NativeWindow
	{
		public var options:NativeWindowInitOptions;
		
		public function AirNativeWindow()
		{
			
			options = new NativeWindowInitOptions();
			options.systemChrome = NativeWindowSystemChrome.STANDARD;
			options.resizable = false;
			//options.minimizable = false;
			options.maximizable = false;
			initOptions();
			super(options);
			stage.scaleMode =   StageScaleMode.NO_SCALE;
			stage.align =  StageAlign.TOP_LEFT;
			initialize();
		}
		
		protected function initOptions():void
		{
		
		}
		
		protected function initialize():void
		{
		
		}
	}
}