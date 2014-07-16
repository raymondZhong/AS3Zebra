package zebraIso.display 
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoConfig;
	import zebraIso.display.IsoContainer;
	import zebraIso.util.IsoUtil;
	public class IsoSprite  extends IsoContainer
	{
		
		public function IsoSprite(width:Number = 0,  height:Number = 0,length:Number = 0)
		{			
			super(width, height, length);
			
		}
		
		override protected function updateSceenPosition():void
		{
			var position:Vector3D = _position.clone();
			position.x += -IsoConfig.IsoGridSize >> 1;
			position.z += -IsoConfig.IsoGridSize >> 1;
			
			var screenPos:Point = IsoUtil.isoToScreen(position);
			super.x = screenPos.x + _offX;
			super.y = screenPos.y + _offY;
		}
		
	}

}