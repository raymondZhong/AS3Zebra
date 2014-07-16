package zebra.graphics.bitmaps
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class BitmapDataTool
	{
		
		static public function MovieClipToBitmapData(bitmapDataDraw:BitmapDataDraw):Vector.<BitmapData>
		{
			var data:Vector.<BitmapData> = new Vector.<BitmapData>();
			var target:MovieClip = MovieClip(bitmapDataDraw.target)
			for (var i:int = 1; i <= target.totalFrames; i++)
			{
				target.gotoAndStop(i);
				data.push(bitmapDataDraw.renderTarget(target));
			}
			return data;
		}
		
		/**
		 * 替换位图指定颜色值;
		 * @param bitmapData 位图;
		 * @param color 需要替换的颜色(ARBG);
		 * @param repColor 替换的颜色(ARBG);
		 * @param mask 用于隔离颜色成分的遮罩(ARBG 0x00FF0000);
		 */
		static public function replaceColor(bitmapData:BitmapData, color:uint, repColor:uint, mask:uint = 0x00FFFFFF):void
		{
			if (bitmapData == null || bitmapData.width < 1)
			{
				return;
			}
			bitmapData.threshold(bitmapData, bitmapData.rect, new Point(), "==", color, repColor, mask, true);
		}
		
		/**
		 * 获取图片真实大小（去除透明部分）
		 * @param bitmapData 位图;
		 * @return Rectangle
		 */
		static public function getRealImageRect(bitmapData:BitmapData):Rectangle
		{
			if (bitmapData == null || bitmapData.width < 1)
			{
				return new Rectangle();
			}
			return bitmapData.getColorBoundsRect(0xFF000000, 0, false);
		}
		
		/**
		 * 获得图片真实大小Bitmapdata
		 * @param	source
		 * @return
		 */
		static public function getRealBitmapData(source:BitmapData):BitmapData
		{
			var rect:Rectangle = getRealImageRect(source)
			var bmd:BitmapData = new BitmapData(rect.width, rect.height, true, 0xFFFFFF);
			bmd.copyPixels(source, rect, new Point(0, 0));			
			return bmd;
		}
		
		
		
		/**
		 * 是否空图片(去除透明部分)
		 * @param bitmapData 位图;
		 * @return
		 */
		static public function isEmptyImage(bitmapData:BitmapData):Boolean
		{
			if (bitmapData == null || bitmapData.width < 1)
			{
				return false;
			}
			return getRealImageRect(bitmapData).equals(new Rectangle());
		}
		
		/**
		 * 鼠标点击位图的坐标点是否透明
		 * @param	bm
		 * @return
		 */
		static public function IsTransparentByMousePoint(bm:Bitmap):Boolean
		{
			if (bm.stage == null)
				return true;
			var bd:BitmapData = bm.bitmapData;
			var displayPoint:Point = toStagePoint(bm);
			var stagepoint:Point = new Point(bm.stage.mouseX, bm.stage.mouseY);
			return (bd.getPixel32(bm.stage.mouseX - displayPoint.x, bm.stage.mouseY - displayPoint.y) >> 24 & 0xFF) != 0
			//trace(bd.getPixel32(bm.stage.mouseX - displayPoint.x, bm.stage.mouseY - displayPoint.y),bd.getPixel32(bm.stage.mouseX - displayPoint.x, bm.stage.mouseY - displayPoint.y).toString(16),"=========================")
			//return bd.getPixel32(bm.stage.mouseX - displayPoint.x, bm.stage.mouseY - displayPoint.y).toString(16) != "0";
		}
		
		static private function toStagePoint(target:DisplayObject):Point
		{
			return target.parent.localToGlobal(new Point(target.x, target.y));
			//var result:Point = new Point();
			//while (target != null)
			//{
				//result.x += target.x;
				//result.y += target.y;
				//target = target.parent;
			//}
			//return result;
		}
	}
}