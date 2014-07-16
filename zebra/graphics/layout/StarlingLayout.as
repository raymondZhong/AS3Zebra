package zebra.graphics.layout 
{
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;

	public class StarlingLayout 
	{
		private var _viewport:Rectangle;
		private var _container:DisplayObjectContainer;
		private var _elementChilds:Vector.<StarlingLayoutModel>;
		private var _elements:Vector.<DisplayObject>;
		private var _delay:Number = 0;
		public function StarlingLayout(container:DisplayObjectContainer,viewport:Rectangle=null,delay:Number=0)
		{
			_container = container;
			_delay = delay;
			_elementChilds = new Vector.<StarlingLayoutModel>();
			_elements = new Vector.<DisplayObject>();
			if (viewport==null) {
				 _viewport = new Rectangle(0, 0, Starling.current.nativeStage.fullScreenWidth, Starling.current.nativeStage.fullScreenHeight);
				}else{
				_viewport = viewport;
				}
		}
		
		public function append(child:DisplayObject,aglin:String="LT",offsetx:int = 0,offsety:int = 0):void {
			 var  model:StarlingLayoutModel = new StarlingLayoutModel();
				  model.offsetX = offsetx;
				  model.offsetY = offsety;
				  model.aglin = aglin;
				  model.child = child;
				  _container.addChild(child);
				  _elementChilds.push(model);
				  _elements.push(child);
			     update();
		}
		
		
	 
		public function remove(child:DisplayObject):void {
				var index:int = -1;
				for (var i:int = 0; i <_elementChilds.length ; i++) 
				{
					if (_elementChilds[i].child == child) {
						index = i;
						break;
					}
				}
				_elementChilds.splice(index, 1);
				_elements.splice(index, 1);
				_container.removeChild(child);
			}			
			
		public function clear():void {
				 for (var i:int = _elements.length-1; i >=0 ; i--) 
				 {
					 remove(_elements[i]);
				 }
			}	
			
		public function update():void {
			setTimeout(function():void{
			 for (var i:int = 0; i < _elementChilds.length; i++) 
			 {
				 setChildAlign(_elementChilds[i].child, _elementChilds[i].aglin, _elementChilds[i].offsetX, _elementChilds[i].offsetY);
			 }
			},_delay);
		}
		
		
		
		
		private function  setChildAlign(child:DisplayObject, align:String, offX:int, offY:int):void {
			
			switch (align.toLocaleUpperCase())
			{
				case "NONE":
					break;
				case "LT":
					child.x = 0;
					child.y = 0;
					break;
				
				case "CT": 
					child.x = (_viewport.width - child.width) * .5;
					child.y = 0;
					break;
				
				case "RT": 
					child.x = _viewport.width - child.width;
					child.y = 0;
					break;
				
				case "TL": 
					child.x = 0;
					child.y=0;
					break;
				
				case "TC": 
					child.x = (_viewport.width - child.width) * .5;
					child.y = 0;
					break;
				
				case "TR": 
					child.x = _viewport.width - child.width;
					child.y = 0;
					break;

				case "CL": 
					child.x = 0;;
					child.y= (_viewport.height - child.height) * .5;
					break;				
				
				case "LC": 
					child.x = 0;;
					child.y= (_viewport.height - child.height) * .5;
					break;	
				
				case "CC": 
					child.x = (_viewport.width - child.width) * .5;
					child.y=(_viewport.height - child.height) * .5;
					break;
				
				case "CR": 
					child.x = _viewport.width - child.width;
					child.y=(_viewport.height - child.height) * .5;
					break;
				
				case "RC": 
					child.x = _viewport.width - child.width;
					child.y=(_viewport.height - child.height) * .5;
					break;
				
				
				
				case "BL": 
					child.x = 0 ;
					child.y = _viewport.height - child.height;
					break;
				
				case "LB": 
					child.x = 0 ;
					child.y = _viewport.height - child.height;
					break;
				
				case "BC": 
					child.x =  (_viewport.width - child.width) * .5;
					child.y = _viewport.height - child.height;
					break;
				
				case "CB": 
					child.x =  (_viewport.width - child.width) * .5;
					child.y = _viewport.height - child.height;
					break;
				
				case "BR": 
					child.x = _viewport.width - child.width;
					child.y = _viewport.height - child.height;					
					break;
				
				case "RB": 
					child.x =_viewport.width - child.width;
					child.y = _viewport.height - child.height;	
					break;
			}
	          child.x = int(child.x+offX);
			  child.y = int(child.y+offY);
		}
		
		public function get elements():Vector.<DisplayObject> 
		{
			return _elements;
		}
		
		
	}

}

import starling.display.DisplayObject;
internal class  StarlingLayoutModel {
	    public function StarlingLayoutModel(){}
		public var offsetX:int=0;
		public var offsetY:int = 0;
		public var child:DisplayObject;
		public var aglin:String="LT";
		//public var parent:DisplayObject;
	}