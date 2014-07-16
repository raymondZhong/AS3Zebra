package zebra.graphics.animation
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import zebra.data.GameTexture;
	import zebra.data.IGameTexture;
	import zebra.events.BitmapBatchEvent;
	import zebra.events.SpriteSheetEvent;
	import zebra.system.util.StringHelper;
	
	[Event(name="dispose",type="zebra.events.SpriteSheetEvent")]
	[Event(name="bitmapClick",type="zebra.events.SpriteSheetEvent")]
	[Event(name="bitmapHover",type="zebra.events.SpriteSheetEvent")]
	[Event(name="bitmapOut",type="zebra.events.SpriteSheetEvent")]
	[Event(name="bitmapDown",type="zebra.events.SpriteSheetEvent")]
	
	public class SpriteSheet extends Sprite implements IAnimation
	{
		private var _maps:XML;
		private var _currentGameTexture:IGameTexture;
		private var _bitmapBatch:BitmapBatch;
		
		protected var _ClickBeforeHandler:Function;
		protected var _ClickHandler:Function;
		protected var _DownHandler:Function;
		protected var _HoverHandler:Function;
		protected var _OutHandler:Function;
		protected var _actionName:String;
		
		private var _gameTextureList:Vector.<IGameTexture>
		
		public function SpriteSheet(gametexture:IGameTexture)
		{
			_gameTextureList = new Vector.<IGameTexture>();
			pushTexture(gametexture);
			this._currentGameTexture = gametexture;		
			mouseChildren = false;
			mouseEnabled = false;
			tabChildren = false;
			tabEnabled = false;	
			_bitmapBatch = new BitmapBatch();
			addChild(_bitmapBatch);
			addEventListener(Event.ADDED_TO_STAGE, addToStageLogic);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStageLogic)
		}
		
		/**
		 * 添加多个GameTexture
		 * @param	gametexture
		 */
		public function pushTexture(gametexture:IGameTexture):void {
			  var index:int = _gameTextureList.indexOf(gametexture);
			  if (index == -1) {
				  _gameTextureList.push(gametexture);
				  }
			}
		
		private function addToStageLogic(e:Event):void
		{
			_bitmapBatch.addEventListener(BitmapBatchEvent.BITMAPCLICK, batchClickHandler);
			_bitmapBatch.addEventListener(BitmapBatchEvent.BITMAPHOVER, batchHoverHandler);
			_bitmapBatch.addEventListener(BitmapBatchEvent.BITMAPOUT, batchOutHandler);
			_bitmapBatch.addEventListener(BitmapBatchEvent.BITMAPDOWN, batchDownHandler);
		}
		
		private function batchDownHandler(e:BitmapBatchEvent):void
		{
			var event:SpriteSheetEvent = new SpriteSheetEvent(SpriteSheetEvent.BITMAPDOWN);
			dispatchEvent(event);
			if (_DownHandler != null)
				_DownHandler(this);
		}
		
		private function batchClickHandler(e:BitmapBatchEvent):void
		{
			var event:SpriteSheetEvent = new SpriteSheetEvent(SpriteSheetEvent.BITMAPCLICK);
			dispatchEvent(event);
			if (_ClickBeforeHandler != null)
				_ClickBeforeHandler(this);
			if (_ClickHandler != null)
				_ClickHandler(this);
		}
		
		private function batchHoverHandler(e:BitmapBatchEvent):void
		{
			var event:SpriteSheetEvent = new SpriteSheetEvent(SpriteSheetEvent.BITMAPHOVER);
			dispatchEvent(event);
			if (_HoverHandler != null)
				_HoverHandler(this);
		}
		
		private function batchOutHandler(e:BitmapBatchEvent):void
		{
			var event:SpriteSheetEvent = new SpriteSheetEvent(SpriteSheetEvent.BITMAPOUT);
			dispatchEvent(event);
			if (_OutHandler != null)
				_OutHandler(this);
		}
		
		private function removeStageLogic(e:Event):void
		{
			_bitmapBatch.removeEventListener(BitmapBatchEvent.BITMAPCLICK, batchClickHandler);
			_bitmapBatch.removeEventListener(BitmapBatchEvent.BITMAPHOVER, batchHoverHandler);
			_bitmapBatch.removeEventListener(BitmapBatchEvent.BITMAPOUT, batchOutHandler);
			_bitmapBatch.removeEventListener(BitmapBatchEvent.BITMAPDOWN, batchDownHandler);
		}
		
		public function get actionName():String
		{
			return _actionName;
		}
		
		public function get gameTexture():IGameTexture
		{
			return _currentGameTexture;
		}
		
		public function dispose():void
		{
			_bitmapBatch.dispose();
		}
		
		public function clone():IAnimation
		{
			return new SpriteSheet(_currentGameTexture);
		}
		
		public function play(actionName:String = ""):void
		{
			if(_actionName!=actionName){
				_actionName = actionName;
				var currentTexture:Vector.<BitmapData>
				for (var i:int = 0; i < _gameTextureList.length; i++) 
				{
					currentTexture = _gameTextureList[i].getBitmapsByActionName(actionName);
					if (currentTexture!=null) {
							_bitmapBatch.BitmapDataSource = currentTexture;
							_bitmapBatch.play();
							return;
						}
				}
			}
			
		
		}
		
		public function pause():void
		{
			_bitmapBatch.pause();
		}
		;
		
		public function stop():void
		{
			_bitmapBatch.stop();
		}
		;
		
		public function set fps(value:int):void
		{
			_bitmapBatch.fps = value;
		}
		
		public function get fps():int
		{
			return _bitmapBatch.fps;
		}
		
		public function get align():String
		{
			return _bitmapBatch.align;
		}
		
		public function set align(value:String):void
		{
			_bitmapBatch.align = value;
		}
		
		public function get BitmapDataSource():Vector.<BitmapData>
		{
			return _bitmapBatch.BitmapDataSource;
		}
		
		public function set BitmapDataSource(value:Vector.<BitmapData>):void
		{
		}
		
		public function get totalframes():int
		{
			return _bitmapBatch.totalframes;
		}
		
		public function get currentFrame():int
		{
			return _bitmapBatch.currentFrame;
		}
		
		public function set currentFrame(value:int):void
		{
			_bitmapBatch.currentFrame = value;
		}
		
		
		
		public function get offX():Number 
		{
			return _bitmapBatch.offX;
		}
		
		public function set offX(value:Number):void 
		{
			_bitmapBatch.offX = value;
		}
		
		public function get offY():Number 
		{
			return _bitmapBatch.offY;
		}
		
		public function set offY(value:Number):void 
		{
			_bitmapBatch.offY = value;
		}
		
		
		public function get IsHitMouse():Boolean
		{
			return _bitmapBatch.IsHitMouse;
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
	}
}

