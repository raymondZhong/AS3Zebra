/**
 * @author joris timmerman
 * @version 1.1
 * for use with Flex and Flash in Adobe AIR
 * 
 * ScreenManager
 * Make your application go multi-screen
 * Move or open windows on different screens
 */
package zebraAir.util
{
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	
	public class ScreenManager
	{
		
		public static const TOP_LEFT_CORNER:String="topLeft"
		public static const TOP_RIGHT_CORNER:String="topRight"
		public static const BOTTOM_LEFT_CORNER:String="bottomLeft"
		public static const BOTTOM_RIGHT_CORNER:String="bottomRight"
		
		/**
		 * Open an instance of NativeWindow on a screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to add your window on, main screen=1, second screen = 2, ...
		 * @param x (optional) x value of the new window on the screen
		 * @param y (optional) y value of the new window on the screen
		 */
		public static function openWindowOnScreen( window : NativeWindow,oneBasedScreenIndex : int,x : int = 0,y : int = 0) : void {
			var screen : Screen = Screen.screens[oneBasedScreenIndex - 1] as Screen; 
			
			if( ((screen.bounds.left) + x) < screen.bounds.right) {
				window.x = (screen.bounds.left) + x;
			}
			
			if( ((screen.bounds.top) + y) < screen.bounds.bottom) {
				window.y = (screen.bounds.top) + y;
			}
			
			
			window.activate();
		}

		/**
		 * Open an instance of NativeWindow centered on a screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to add your window on, main screen=1, second screen = 2, ...
		 */
		public static function openWindowCenteredOnScreen(window : NativeWindow,oneBasedScreenIndex : int) : void {
			var screen : Screen = Screen.screens[oneBasedScreenIndex - 1] as Screen; 
			var centerX : int = screen.bounds.right - screen.bounds.width + (screen.bounds.width / 2);
			var centerY : int = screen.bounds.bottom - screen.bounds.height + (screen.bounds.height / 2);
			window.x = centerX - (window.width) / 2
			window.y = centerY - (window.height) / 2; 
			window.activate();               
		}
		
		
		/**
		 * Open an instance of NativeWindow on a screen to the corner of a screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 * @param corner Corner to move the window to (public statics of this class)
		 */
		public static function openWindowInCorner(window : NativeWindow,oneBasedScreenIndex : int,corner:String):void{
			moveWindowToCorner(window,oneBasedScreenIndex,corner)			
			window.activate()
		}
		
		

		/**
		 * Move an instance of NativeWindow on a screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 * @param x (optional) x value of the new window on the screen
		 * @param y (optional) y value of the new window on the screen
		 */
		public static function moveWindow(window : NativeWindow,oneBasedScreenIndex : int,x : Number = 0,y : Number = 0) : void {
			var screen : Screen = Screen.screens[oneBasedScreenIndex - 1] as Screen; 
			if( ((screen.bounds.left) + x) < screen.bounds.right) {
				window.x = (screen.bounds.left) + x;
			}
			
			if( ((screen.bounds.top) + y) < screen.bounds.bottom) {
				window.y = (screen.bounds.top) + y;
			}
		}
		
		/**
		 * Move an instance of NativeWindow on a screen to the corner of a screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 * @param corner Corner to move the window to (public statics of this class)
		 */
		public static function moveWindowToCorner(window : NativeWindow,oneBasedScreenIndex : int,corner:String):void{
			var screen : Screen = Screen.screens[oneBasedScreenIndex - 1] as Screen; 
			switch(corner){
				case TOP_RIGHT_CORNER:
					window.x=screen.bounds.width-window.width
					window.y=0
				break;
				case BOTTOM_LEFT_CORNER:
					window.x=0
					window.y=screen.bounds.height-window.height
				break;
				case BOTTOM_RIGHT_CORNER:
					window.x=screen.bounds.width-window.width
					window.y=screen.bounds.height-window.height
				break;
				default:
					window.x=0
					window.y=0
				break;
			}
			
			window.x += screen.bounds.x
			window.y += screen.bounds.y
		}

		/**
		 * Move an instance of NativeWindow to the center of a screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 */
		public static function centerWindowOnScreen(window : NativeWindow,oneBasedScreenIndex : int) : void {
			var screen : Screen = Screen.screens[oneBasedScreenIndex - 1] as Screen; 
			var centerX : int = screen.bounds.right - screen.bounds.width + (screen.bounds.width / 2);
			var centerY : int = screen.bounds.bottom - screen.bounds.height + (screen.bounds.height / 2);
			window.x = centerX - (window.width) / 2
			window.y = centerY - (window.height) / 2; 
		}

		/**
		 * Stretches an instance of NativeWindow to fill the screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 */
		public static function stretchWindowOnScreen(window : NativeWindow,oneBasedScreenIndex : int) {
			moveWindow(window , oneBasedScreenIndex , 0 , 0);
			window.width = getVisibleScreenBounds(oneBasedScreenIndex).width
			window.height = getVisibleScreenBounds(oneBasedScreenIndex).height
		}

		/**
		 * Stretches an instance of NativeWindow to fill all screens
		 * @param window Instance of a NativeWindow
		 */
		public static function stretchWindowToAllScreens(window : NativeWindow) {
			window.x = 0;
			window.y = 0
			window.width = maximumAvailableResolution.width
			window.height = maximumAvailableResolution.height
		}
		
		/**
		 * OPen window  fullscreen on certain screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 * @param displayState displayState of the window, can be all strings in the static class StageDisplayState
		 * @param fullScreenSourceRect FullScreen Source Rectangle, defines what part of the application goes fullscreen, null is default
		 */
		 public static function openWindowFullScreenOn(window:NativeWindow,oneBasedScreenIndex:int=1,displayState:String=StageDisplayState.FULL_SCREEN_INTERACTIVE,fullScreenSourceRect:Rectangle=null):void{
		 	moveWindow(window,oneBasedScreenIndex);
		 	window.activate();
		 	
		 	if(fullScreenSourceRect!=null){
		 		window.stage.fullScreenSourceRect=fullScreenSourceRect;
		 	}
		 	
		 	window.stage.displayState=displayState;
		 }
		 
		 /**
		 * Make existing window go fullscreen on certain screen
		 * @param window Instance of a NativeWindow
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 * @param displayState displayState of the window, can be all strings in the static class StageDisplayState
		 * @param fullScreenSourceRect FullScreen Source Rectangle, defines what part of the application goes fullscreen, null is default
		 */
		 public static function setWindowFullScreenOn(window:NativeWindow,oneBasedScreenIndex:int=1,displayState:String=StageDisplayState.FULL_SCREEN_INTERACTIVE,fullScreenSourceRect:Rectangle=null):void{
		 	moveWindow(window,oneBasedScreenIndex);
		 	if(fullScreenSourceRect!=null){
		 		window.stage.fullScreenSourceRect=fullScreenSourceRect;
		 	}
		 	window.stage.displayState=displayState;
		 }

		/**
		 * Get the bounds (rectangle) of a screen
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 */		 
		public static function getActualScreenBounds(oneBasedScreenIndex : int) : Rectangle {
			return Screen(Screen.screens[oneBasedScreenIndex - 1]).bounds;
		}

		/**
		 * Get the visible bounds (rectangle) of a screen
		 * Excludes taskbar/dock and menubar
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 */		 
		public static function getVisibleScreenBounds(oneBasedScreenIndex : int) : Rectangle {
			return Screen(Screen.screens[oneBasedScreenIndex - 1]).visibleBounds;
		}

		/**
		 * Get the colordepth (int) of a screen, f.e 32bit, 64bit
		 * @param oneBasedScreenIndex index of the screen you want to move your window in, main screen=1, second screen = 2, ...
		 */		 
		public static function getScreenColorDepth(oneBasedScreenIndex : int) : int {
			return Screen(Screen.screens[oneBasedScreenIndex - 1]).colorDepth;
		}

		

		//- EVENT HANDLERS ----------------------------------------------------------------------------------------
	
		
	
		//- GETTERS & SETTERS -------------------------------------------------------------------------------------
		/**
		 * Get the index of the main screen
		 */
		public static function get mainScreenIndex() : int {
			return 1;
		}

		/**
		 * Get the number of screens available
		 */
		public static function get numScreens() : int {
			return Screen.screens.length
		}
		
		/**
		 * Get the maximum available resolution, the resolution of all screens combined
		 */
		public static function get maximumAvailableResolution() : Rectangle {
			var virtualBounds : Rectangle = new Rectangle()
			for each(var screen:Screen in Screen.screens) {
				if(virtualBounds.left > screen.bounds.left) {
					virtualBounds.left = screen.bounds.left;
				}
				if(virtualBounds.right < screen.bounds.right) {
					virtualBounds.right = screen.bounds.right;
				}
				if(virtualBounds.top > screen.bounds.top) {
					virtualBounds.top = screen.bounds.top;
				}
				if(virtualBounds.bottom < screen.bounds.bottom) {
					virtualBounds.bottom = screen.bounds.bottom;
				}                
			}
			return virtualBounds
		}

	}
}