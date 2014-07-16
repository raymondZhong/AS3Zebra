package zebra.graphics.animation 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	
	public class MovieClipPlayer extends EventDispatcher 
	{
		
		static public  const onComplete:String = "onComplete";
		static public  const onProgress:String = "onProcess";
		static public  const onProcessFrameLable:String = "onProcessFrameLable";
		
		public function MovieClipPlayer(mc:MovieClip=null) 
		{
			target = mc;
		}
		
		public function  get  target():MovieClip { return _mc; }
		public function  set  target(value:MovieClip):void { 
			_mc = value;
			_totalFrams = _mc.totalFrames;
			_isPlay = false;
			_isPause = false;
			_currentFrame = 1;
			value.stop();
			}
		
		
		private var _mc:MovieClip;
		private var _currentFrame:int;
		private var _totalFrams:int;
		private var _isPause:Boolean;
		private var _isPlay:Boolean;
		private var _lables:Dictionary = new Dictionary();
		//private var _second:Number;
		private var _isReplay:Boolean;
		
		public function get currentFrameLable():String{return _mc.currentFrameLabel}
		public function get currentFrame():int { return _mc.currentFrame;}
		public function set currentFrame(value:int):void {_currentFrame=value;}
		public function get totalFrames():int { return _totalFrams; }
		
		public function get isReplay():Boolean { return _isReplay; }
		public function set isReplay(value:Boolean):void {_isReplay = value;}
		
		
		public function changeContext(mc:MovieClip):void{
			   target = mc;
			}
		
		/*public function  isArriveFrameLable(lable:String):Boolean {
			   return  _lables[lable] != null;
			}*/
		 
		public function play():void {
				_isPlay = true;
				_mc.removeEventListener(Event.ENTER_FRAME, _onframeLogic);
				_mc.addEventListener(Event.ENTER_FRAME, _onframeLogic);
				_mc.play();
			}
			
		public function pause():void { _isPause = !_isPause; }
		public function stop():void {
			    _mc.removeEventListener(Event.ENTER_FRAME, _onframeLogic);
				_mc.stop();
			}
		
		
		/**
		 * 虚拟进度  不再第1帧做为进度开始,自定义开始帧数到尾帧。
		 * @param	startFrame
		 * @return
		 */
		public  function virtualProgress(startFrame:int=82):Number {
			   var vEnd:int = _totalFrams -82;			   
			   return (_mc.currentFrame-startFrame) / vEnd;
			}
		
		private function _onframeLogic(e:Event):void 
		{
			if(!_isPlay) return;
		    if(!_isPause) _currentFrame++;
		   _mc.gotoAndStop(_currentFrame);
		   
		   if (_currentFrame == _totalFrams) {		
				   if (_mc.currentFrameLabel != null)
				   {
					   _lables[_mc.currentFrameLabel] = true;
					   dispatchEvent(new Event(onProcessFrameLable));
				   }
					  if(!_isReplay){
						_mc.removeEventListener(Event.ENTER_FRAME, _onframeLogic);		   
					   }else {
					   _currentFrame = 1;
					 }
				   dispatchEvent(new Event(onProgress)); 
				   dispatchEvent(new Event(onComplete));
			   }else {
			    if (_mc.currentFrameLabel != null)
			   {
				   _lables[_mc.currentFrameLabel] = true;
				   dispatchEvent(new Event(onProcessFrameLable));
			   }
			   dispatchEvent(new Event(onProgress));   
			}
		}
		
		
		
		
		
		
	}

}