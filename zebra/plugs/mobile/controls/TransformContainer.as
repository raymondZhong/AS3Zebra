package zebra.plugs.mobile.controls
{
	import acheGesture.data.TapGesture;
	import feathers.controls.Label;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import org.gestouch.events.GestureEvent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import zebra.Game;
	import zebra.plugs.mobile.MobileConstants;
	import zebra.system.util.MathHelper;
	
	//public class TransformContainer extends Sprite
	public class TransformContainer extends Sprite
	{
		
		private var _target:DisplayObject;
		private var _toolSprite:Sprite;
		private var _rectline:Shape;
		
		private	var _isTouchToolBegan:Boolean;
		private var _isTouchToolMoveing:Boolean;
		private var _isTouchTargetMoveing:Boolean;
		private var _isTouchTargetBegan:Boolean;
		 
		private var _isActiveTransform:Boolean;
		private var _manager:TransformManager;
		private var scaleRotationQuad:Quad;
		private var closeQuad:Quad;	
		
		
		public function TransformContainer(manager:TransformManager,target:DisplayObject)
		{
			_manager = manager;
			_target = target;	

			_target.visible = false;
			addChild(_target); 	
			if (_target is Label) {				
				setTimeout(init, 0);
				}else {
				init()
				}
			 
		
		}
		
		
		private	var ball:Shape = new Shape()
		private function init():void { 
				_rectline = new Shape();
				_rectline.touchable = false;
				_rectline.graphics.lineStyle(1, 0x000000);
				_rectline.graphics.drawRect(0, 0, _target.width, _target.height+10);
				_rectline.graphics.endFill(); 
				addChild(_rectline);
				
				swapChildren(_rectline, _target);
				
				_target.visible = true;
				trace(_target.width, _target.height);
				closeQuad = new Quad(40, 40, 0xFF0080);
				closeQuad.pivotX = closeQuad.width / 2;
				closeQuad.pivotY = closeQuad.height / 2;
				addChild(closeQuad);
				
				
				scaleRotationQuad = new Quad(40, 40, 0x591FD1);
				scaleRotationQuad.x = _target.width;
				scaleRotationQuad.y = _target.height;
				scaleRotationQuad.pivotX = scaleRotationQuad.width / 2;
				scaleRotationQuad.pivotY = scaleRotationQuad.height / 2;
				addChild(scaleRotationQuad);
				
				this.pivotX = _target.width / 2;
				this.pivotY = _target.height / 2;
				
				 
				ball.graphics.beginFill(0x80FF00);
				ball.graphics.drawCircle(0, 0, 10)
				ball.graphics.endFill();
				ball.x = this.pivotX
				ball.y = this.pivotY
				ball.visible = false;
				addChild(ball)
				
				
				eventHandler();
			}
		
			
		public function refreshToolView():void {
			    removeChild(_rectline);
				closeQuad.visible = false;
				scaleRotationQuad.visible = false;
				setTimeout(refreshToolHander,10)				
			}	
			
		private function refreshToolHander():void 
		{
				_rectline = new Shape();
				_rectline.touchable = false;
				_rectline.graphics.lineStyle(1, 0x000000);
				_rectline.graphics.drawRect(0, 0, _target.width, _target.height+10);
				_rectline.graphics.endFill();
				scaleRotationQuad.x = _target.width;
				scaleRotationQuad.y = _target.height;
				addChildAt(_rectline, 0);
				closeQuad.visible = true;
				scaleRotationQuad.visible = true;
				
				
				this.pivotX = _target.width / 2;
				this.pivotY = _target.height / 2;
				ball.x = this.pivotX
				ball.y = this.pivotY
				
		}
			
					
		public function showTool():void { 
			if(_rectline)_rectline.visible = true; 
			if(closeQuad)closeQuad.visible = true; 
			if(scaleRotationQuad)scaleRotationQuad.visible = true;
			}
		public function hideTool():void {
			if(_rectline)_rectline.visible = false; 
			if(closeQuad)closeQuad.visible = false; 
			if(scaleRotationQuad)scaleRotationQuad.visible = false;
			}
		
		private function eventHandler():void 
		{
			scaleRotationQuad.addEventListener(TouchEvent.TOUCH, rotationScaleTouchHandler);
			closeQuad.addEventListener(TouchEvent.TOUCH, closeHandler);
			_target.addEventListener(TouchEvent.TOUCH, targetDrag); 
			addEventListener(Event.REMOVED_FROM_STAGE, removeToStageHandler);
			 
			//var tap:TapGesture = new TapGesture(_target);
			//tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTap, false, 0, true);
			 
			 
		}
		
		private function closeHandler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch && touch.phase == TouchPhase.ENDED) {
			    this.visible = false;
				_manager.removeElement(this);
				//this.parent.removeChild(this);
			}
		}
		
		private function removeToStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeToStageHandler);
			closeQuad.removeEventListener(TouchEvent.TOUCH, closeHandler);
			_target.removeEventListener(TouchEvent.TOUCH, targetDrag);
			scaleRotationQuad.removeEventListener(TouchEvent.TOUCH, rotationScaleTouchHandler); 
			removeEventListener(Event.REMOVED_FROM_STAGE, removeToStageHandler);
		}
		
		private var _touchoffx:Number=0;
		private var _touchoffy:Number = 0;
	    private var _longTouchTime:Number = 500;
		private var _touchTimer:Timer;
		
		//拖动
		private function targetDrag(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				_isTouchTargetBegan = true;
				 var point:Point = this.parent.localToGlobal(new Point(this.x, this.y));
					 point = MobileConstants.scalePoint(point);
					 
				 var _mousePoint:Point = new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);	
				 _mousePoint =  MobileConstants.scalePoint(_mousePoint);
					 
				 _touchoffx =  _mousePoint.x - point.x;
				 _touchoffy =  _mousePoint.y - point.y;
				 
				 _manager.setActive(this); 
				 _touchTimer = new Timer(1500);
				 _touchTimer.addEventListener(TimerEvent.TIMER, longTouchHander)
				 _touchTimer.start();
			}
			
 			if (_isTouchTargetBegan && touch.phase == TouchPhase.MOVED)
			{
				_isTouchTargetMoveing = true;
				moveHandler();
				_touchTimer.stop();
			}
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				_isTouchTargetBegan = false;
				_isTouchTargetMoveing = false;	
				_touchTimer.stop();
				_touchTimer.removeEventListener(TimerEvent.TIMER,longTouchHander)
			} 
		}
		
		
		//长按
		private function longTouchHander(e:TimerEvent):void 
		{
			trace(_isTouchTargetBegan, _isTouchTargetMoveing);
			_touchTimer.stop();
			_touchTimer.removeEventListener(TimerEvent.TIMER, longTouchHander);			
			if(longTouchFn)longTouchFn(this);
		}
		
		
		public var longTouchFn:Function;
		
		
		private var _dist:Number = 0;
		private var _prevScaleX:Number = 1;
		private var _prevScaleY:Number = 1;
		
		//选择缩放
		private function rotationScaleTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
		    var _isTouchBegan:Boolean;
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				_isTouchToolBegan = true;			 
 
				_manager.setActive(this); 
				
				
				 var selfpoint:Point = this.parent.localToGlobal(new Point(this.x, this.y));
				     selfpoint = MobileConstants.scalePoint(selfpoint);
				 
				   var linepoint:Point = _rectline.parent.localToGlobal(new Point(_rectline.x+_rectline.width, _rectline.y+_rectline.height));
					   linepoint = MobileConstants.scalePoint(linepoint);
				 
				  
				_dist =   Point.distance(selfpoint, linepoint);
				  
			}
			if (_isTouchToolBegan && touch.phase == TouchPhase.MOVED)
			{
				_isTouchToolMoveing = true;
				scaleHandler();
				rotationHandler();
			}
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				_isTouchToolBegan = false;
				_isTouchToolMoveing = false;
				_prevScaleX = this.scaleX;
				_prevScaleY = this.scaleY;
			}
		}
		
 
		//缩放
		private function scaleHandler():void {
				var currentMousePoint:Point = new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);
					currentMousePoint = MobileConstants.scalePoint(currentMousePoint);
					
				 var selfpoint:Point = this.parent.localToGlobal(new Point(this.x, this.y));
				     selfpoint = MobileConstants.scalePoint(selfpoint);
					 
				var  dist:Number = Point.distance(currentMousePoint, selfpoint);
		 
				/* OLD  
				if(dist/_dist*_prevScaleX*MobileConstants.scaleX>0.5){
					this.scaleX  = dist/_dist*_prevScaleX*MobileConstants.scaleX;
					this.scaleY  = dist/_dist*_prevScaleY*MobileConstants.scaleY;
				}*/
				
				
				if(dist/_dist*_prevScaleX*MobileConstants.scaleX>0.5){
					this.scaleX  = dist/_dist*_prevScaleX*MobileConstants.scaleX;
					this.scaleY  = dist / _dist * _prevScaleX * MobileConstants.scaleX;    //修正 竖屏以scaleX作为标准比例
					
				 
				}
				 
			}
			
		//旋转
		private function rotationHandler():void {			
			var  currentMousePoint:Point = new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);
				 currentMousePoint = MobileConstants.scalePoint(currentMousePoint);
					
			 var selfpoint:Point = this.parent.localToGlobal(new Point(this.x, this.y));
				 selfpoint = MobileConstants.scalePoint(selfpoint);
				
				var dx:Number = currentMousePoint.x - selfpoint.x;
				var dy:Number = currentMousePoint.y - selfpoint.y;
				var rr:Number =  45
				if (_target is Label) rr = 5;
				var radians:Number = Math.atan2(dy, dx) - MathHelper.deg2rad(rr);
				this.rotation = radians;
		}
		
		private function moveHandler():void {							
				var currentMousePoint:Point =  new Point(Starling.current.nativeStage.mouseX, Starling.current.nativeStage.mouseY);	
					currentMousePoint =  MobileConstants.scalePoint(currentMousePoint);
					this.x = currentMousePoint.x -_touchoffx ;
					this.y = currentMousePoint.y -_touchoffy ;
			}
			
			public function get target():DisplayObject 
			{
				return _target;
			}
			
			
		
	
	}

}