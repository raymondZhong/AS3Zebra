package zebraui.baseShape 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class ChessGrid extends Sprite
	{
		
		
		// Box colour 1
		private var even:uint = 0xFFFFFF;
		// Box colour 2
		private var odd:uint = 0xE3E3E3;

		// Box size
		private var _size:int = 10;

		// number of boxes horizontally
		private var nH:int;

		// number of boxes vertically
		private var nV:int;

		// vars to be used in the loops
		private var clr:uint;
		private var i:uint;
		private var j:uint;
		
		private var _stage:Stage;
		public function ChessGrid(width:Number,height:Number,size:int=10) 
		{
			_width = width;
			_height = height;
			_size = size;
			draw();
			//addEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);
		
		}
		
		private var _width:Number;
		private var _height:Number;
		
		private function _addToStageLogic(e:Event):void 
		{
				draw();
				return;
			removeEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);
			_stage = this.stage;			
			draw();
			_stage.addEventListener(Event.RESIZE, _stageReSizeLogic);
		}
		
		private function _stageReSizeLogic(e:Event):void 
		{
			draw();
		}
		
		
		private function draw():void {
	 
			    graphics.clear();
				nH = this._width/ _size;
			    nV = this._height / _size;	
				// loop vertical
				for (i=0;i<nV;++i)
				{
						// Flip values of Even and Odd colours using Bitwise operations
						even ^= odd;
						odd  ^= even;
						even ^= odd;
						
						// loop horizontal
						for (j=0;j<nH;++j)
						{
								//bitwise modulus
								//check if column is odd or even, then set colour
								clr = j & 1 ? even : odd;								
								// draw box with previously set colour
								graphics.beginFill(clr,1);
								graphics.drawRect(Number(j*_size),Number(i*_size),_size,_size);
								graphics.endFill();
						}
				}
			}
		
	}

}




