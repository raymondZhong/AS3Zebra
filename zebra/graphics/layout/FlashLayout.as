package zebra.graphics.layout 
{
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	
	public class FlashLayout 
	{
		private var _viewport:Rectangle;
		private var _container:DisplayObjectContainer;
		private var _elementChilds:Vector.<FlashLayoutModel>;
		private var _elements:Vector.<DisplayObject>;
		
		public function FlashLayout(container:DisplayObjectContainer,viewport:Rectangle=null)
		{
			_container = container;
			_elementChilds = new Vector.<FlashLayoutModel>();
			_elements = new Vector.<DisplayObject>();
			if (viewport==null) {
				 _viewport = new Rectangle(0, 0, Starling.current.nativeStage.fullScreenWidth, Starling.current.nativeStage.fullScreenHeight);
				}else{
				_viewport = viewport;
				}
		}
		
		public function append(child:DisplayObject,aglin:String="LT",offsetx:int = 0,offsety:int = 0):void {
			 var  model:FlashLayoutModel = new FlashLayoutModel();
				  model.offsetX = offsetx;
				  model.offsetY = offsety;
				  model.aglin = aglin;
				  model.child = child;
				  _container.addChild(child);
				  _elements.push(child);
				  _elementChilds.push(model);
			     update();
		}
		
		
 
		 
		public function remove(child:DisplayObject):void {
				var index:int = _container.getChildIndex(child);				
				_elementChilds.splice(index, 1);
				_elements.splice(index, 1);
				if (index >= 0) _container.removeChildAt(index);
			}			
			
		public function update():void{
			 for (var i:int = 0; i < _elementChilds.length; i++) 
			 {
				 setChildAlign(_elementChilds[i].child, _elementChilds[i].aglin, _elementChilds[i].offsetX, _elementChilds[i].offsetY);
			 }
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
		
		public function clear():void {
			 for (var i:int = _elements.length-1; i >=0 ; i--) 
			 {
				 remove(_elements[i]);
			 }
		}	
		
		
	public function get elements():Vector.<DisplayObject> 
		{
			return _elements;
		}
		
	}

}

import flash.display.DisplayObject;
internal class  FlashLayoutModel {
		public var offsetX:int=0;
		public var offsetY:int = 0;
		public var child:DisplayObject;
		public var aglin:String="LT";
		//public var parent:DisplayObject;
	}