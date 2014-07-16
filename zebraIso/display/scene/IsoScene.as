package zebraIso.display.scene
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoElementList;
	import zebraIso.display.IsoGrid;
	import zebraIso.display.IsoContainer;
	import zebraIso.display.primitive.IsoRectangles;
	import zebraIso.emnu.IsoSceneMode; 
	
	public class IsoScene extends IsoSceneInterActive implements IIsoScene
	{
		private var _state:String;
		
		public function IsoScene(world:IsoWorldDisplayObject)
		{
			super(world);
			_state = IsoSceneMode.NORMAL;
		}
		
		
		public function setState(value:String):void {
			     switch(value) {
						 case IsoSceneMode.NORMAL:
						 break;	 
					 }
			}
			
			
	}
}
