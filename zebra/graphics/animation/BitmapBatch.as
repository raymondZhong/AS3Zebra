package zebra.graphics.animation
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import zebra.events.BitmapBatchEvent;
	import zebra.Game;
	import zebra.graphics.bitmaps.BitmapDataTool;
	
	
	[Event(name = "dispose", type = "zebra.events.BitmapBatchEvent")]
	[Event(name="bitmapClick",type="zebra.events.BitmapBatchEvent")]
	[Event(name="bitmapDown",type="zebra.events.BitmapBatchEvent")]
	[Event(name="bitmapHover",type="zebra.events.BitmapBatchEvent")]
	[Event(name = "bitmapOut", type = "zebra.events.BitmapBatchEvent")]
	
	public class BitmapBatch extends Bitmap implements IAnimation
	{
		protected var _ClickBeforeHandler:Function;
		protected var _ClickHandler:Function;
		protected var _HoverHandler:Function;
		protected var _DownHandler:Function;
		protected var _OutHandler:Function;
		private var _lock:Boolean; 
		
		public function BitmapBatch(data:Vector.<BitmapData>=null,align:String="none")
		{ 
			if (data == null) {
				 data = new Vector.<BitmapData>();
					var bmd:BitmapData = new BitmapData(1, 1, true);
					data.push(bmd);
				}
			
			_bitmapdataSource = data;
			_loop = true;
			_disposed = false;
			_align = align;
			_offX = 0;
			_offY = 0;
			//_fps = Game.graphicsDeviceManager.fps;
			_fps = 24;
			this.bitmapData == _bitmapdataSource[0];	
			addEventListener(Event.ADDED_TO_STAGE,addToStageLogic)
			addEventListener(Event.REMOVED_FROM_STAGE,removeStageLogic)
		}
		
		private function removeStageLogic(e:Event):void 
		{
			Game.graphicsDeviceManager.bitmapBatchManger.remove(this);
		}
		
		private function addToStageLogic(e:Event):void 
		{
			Game.graphicsDeviceManager.bitmapBatchManger.add(this);
		}
		
		private var _disposed:Boolean;
		private var _pause:Boolean;
		private var _isStrat:Boolean;
		private var _bitmapBatchTaskAction:BitmapBatchTaskAction;
		private var _currentFrame:int = 0;
		private var _bitmapdataSource:Vector.<BitmapData>;
		private var _fps:int;
		private var _loop:Boolean;
		private var _align:String;
		private var _offX:Number;
		private var _offY:Number;
		
		
		public function get IsHitMouse():Boolean {
			 if (_lock) return false;
			 return BitmapDataTool.IsTransparentByMousePoint(this);
			}
		
		/**
		 * 返回全局坐标
		 * @param	target
		 * @return
		 */
		public function toStagePoint(target:DisplayObject):Point
		{
			 return this.parent.localToGlobal(new Point(this.x, this.y));
		}
		
		override public function set bitmapData(value:flash.display.BitmapData):void 
		{
			super.bitmapData = value;
			setBitmapAlign();
		}
		
		public function get totalframes():int
		{
			return _bitmapdataSource.length;
		}
		
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		public function set currentFrame(value:int):void
		{
		    if (value < 0){_currentFrame = 0;}
			if (value >= totalframes) {_currentFrame = totalframes - 1;}
		 	this.bitmapData = _bitmapdataSource[_currentFrame];
		}
		
		public function get IsStart():Boolean
		{
			return _isStrat;
		}
		
		public function get loop():Boolean { return _loop; }
		public function set loop(value:Boolean):void { _loop = value; }
		
		public function frameRenderLogic():void
		{
			if (!_pause && !_disposed )
			{				
				// IF 效率高于 Switch 大量判断switch会降帧
				if (_loop) {
						this.bitmapData = _bitmapdataSource[_currentFrame];
						_currentFrame++;
						_currentFrame = _currentFrame == totalframes?0:_currentFrame;	
					}else {

					if (_currentFrame != totalframes-1) {
							this.bitmapData = _bitmapdataSource[_currentFrame];
							_currentFrame++;
							}
				}
				
			    //INFO:如果不包含在Stage中,自动隐藏。
				/*var rect:Rectangle = new Rectangle(0, 0,
				                                   Game.graphicsDeviceManager.stage.stageWidth,
				                                   Game.graphicsDeviceManager.stage.stageHeight);
				var point:Point =  Game.graphicsDeviceManager.toDevicePoint(this);
				var thisViewRect:Rectangle = new Rectangle(point.x, point.y, this.width, this.height);
				
				this.visible = rect.intersects(thisViewRect);*/
				
			}
		}
		
		public function play(name:String=""):void
		{
			this.bitmapData = _bitmapdataSource[_currentFrame];
			_isStrat = true;
			_disposed = false;
			_pause = false;
			fps = _fps;
		}
		
		public function pause():void
		{
			_pause = !_pause;
		}
		
		public function stop():void
		{
		  _pause = true;
		}
		
		
		
		public function get Disposed():Boolean
		{
			return _disposed;
		}
		
		public function get fps():int 
		{
			return _fps;
		}
		
		public function set fps(value:int):void 
		{
			_fps = value;
			if(totalframes>1){
				if(_bitmapBatchTaskAction!=null){
					 Game.TimeUpdate.removeTaskAction(_bitmapBatchTaskAction);
				}
				_bitmapBatchTaskAction = new BitmapBatchTaskAction(this);
				Game.TimeUpdate.addTaskAction(_bitmapBatchTaskAction, 1000 / _fps);
			}
		}
		
		public function get BitmapDataSource():Vector.<BitmapData> 
		{
			return _bitmapdataSource;
		}
		
		public function set BitmapDataSource(value:Vector.<BitmapData>):void 
		{
			_bitmapdataSource = value;
			currentFrame = 0;
		}
		
		public function get align():String 
		{
			return _align;
		}
		
		public function set align(value:String):void 
		{
			_align = value;
			setBitmapAlign();
		}
		
		public function get offX():Number 
		{
			return _offX;
		}
		
		public function set offX(value:Number):void 
		{
			_offX = value;
		}
		
		public function get offY():Number 
		{
			return _offY;
		}
		
		public function set offY(value:Number):void 
		{
			_offY = value;
		}
		
		public function get ClickHandler():Function 
		{
			return _ClickHandler;
		}
		
		public function set ClickHandler(value:Function):void 
		{
			_ClickHandler = value;
		}
		
		public function get HoverHandler():Function 
		{
			return _HoverHandler;
		}
		
		public function set HoverHandler(value:Function):void 
		{
			_HoverHandler = value;
		}
		
		public function get OutHandler():Function 
		{
			return _OutHandler;
		}
		
		public function set OutHandler(value:Function):void 
		{
			_OutHandler = value;
		}
		
		public function get lock():Boolean 
		{
			return _lock;
		}
		
		public function set lock(value:Boolean):void 
		{
			_lock = value;
		}
		
		public function get DownHandler():Function 
		{
			return _DownHandler;
		}
		
		public function set DownHandler(value:Function):void 
		{
			_DownHandler = value;
		}
		
		public function get ClickBeforeHandler():Function 
		{
			return _ClickBeforeHandler;
		}
		
		public function set ClickBeforeHandler(value:Function):void 
		{
			_ClickBeforeHandler = value;
		}
		
		
		private function  setBitmapAlign():void {
			if (this.bitmapData == null) return;
			switch (_align.toLocaleUpperCase()) 
			{
				case "NONE":
					break;
				case "LT":
					this.x = 0;
					this.y=0
					break;
				
				case "CT": 
					this.x = this.bitmapData.width/2*-1;
					this.y=0
					break;
				
				case "RT": 
					this.x = this.bitmapData.width*-1;
					this.y=0
					break;
				
				case "TL": 
					this.x = 0;
					this.y=0;
					break;
				
				case "TC": 
					this.x = this.bitmapData.width/2*-1;
					this.y=0
					break;
				
				case "TR": 
					this.x = this.bitmapData.width*-1;
					this.y=0
					break;

				case "CL": 
					this.x = 0;;
					this.y=this.bitmapData.height/2*-1;
					break;				
				
				case "LC": 
					this.x = 0;;
					this.y=this.bitmapData.height/2*-1;
					break;	
				
				case "CC": 
					this.x = this.bitmapData.width/2*-1;
					this.y=this.bitmapData.height/2*-1;
					break;
				
				case "CR": 
					this.x = this.bitmapData.width*-1;;
					this.y=this.bitmapData.height/2*-1;
					break;
				
				case "RC": 
					this.x = this.bitmapData.width*-1;;
					this.y=this.bitmapData.height/2*-1;
					break;
				
				
				
				case "BL": 
					this.x = 0 ;
					this.y = this.bitmapData.height*-1;
					break;
				
				case "LB": 
					this.x = 0 ;
					this.y = this.bitmapData.height*-1;
					break;
				
				case "BC": 
					this.x = this.bitmapData.width/2*-1;
					this.y = this.bitmapData.height*-1;
					break;
				
				case "CB": 
					this.x = this.bitmapData.width/2*-1;
					this.y = this.bitmapData.height*-1;
					break;
				
				case "BR": 
					this.x = this.bitmapData.width*-1;
					this.y = this.bitmapData.height*-1;					
					break;
				
				case "RB": 
					this.x = this.bitmapData.width*-1;
					this.y = this.bitmapData.height*-1;					
					break;
			}
	          this.x = this.x+_offX;
			  this.y = this.y+_offY;
		}
		
		
		public function clone():BitmapBatch {
			 return  new BitmapBatch(_bitmapdataSource,_align);
			}
		
		public function dispose():void
		{
			if (!_disposed)
			{
				_disposed = true;
				var event:BitmapBatchEvent = new BitmapBatchEvent(BitmapBatchEvent.DISPOSE);
				    dispatchEvent(event);
				this.bitmapData = null
				if (_bitmapBatchTaskAction != null)
				Game.TimeUpdate.removeTaskAction(_bitmapBatchTaskAction);
			}
		}
	
	}
}



import zebra.graphics.animation.BitmapBatch;
import zebra.thread.task.TaskAction;

internal class BitmapBatchTaskAction extends TaskAction
{
	
	private var _bitmapBatch:BitmapBatch
	
	public function BitmapBatchTaskAction(bitmapBatch:BitmapBatch)
	{
		_bitmapBatch = bitmapBatch;
	}
	
	override public function execute():void
	{
		super.execute();
		if (_bitmapBatch != null && _bitmapBatch.IsStart)
		{
			_bitmapBatch.frameRenderLogic();
		}
	}

}
