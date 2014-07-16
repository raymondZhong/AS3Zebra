package zebra.graphics.bitmaps
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import zebra.math.RectangleIncision;
	import zebra.math.RectangleIncisionNode;
	
	/**
	 * 切割Bitmapdata 分成很多小块
	 */
	public class BitmapDataIncision
	{
		private var _rectIncision:RectangleIncision;
		private var _sourceBitmapData:BitmapData;
		
		public function BitmapDataIncision(bitmap:BitmapData)
		{
			_sourceBitmapData = bitmap;
			_rectIncision = new RectangleIncision(new Rectangle(0, 0, bitmap.width, bitmap.height));
		}
		
		private var _splitBitmapData:Vector.<BitmapDataIncisionNode>;
		
		public function get splitBitmapdata():Vector.<BitmapDataIncisionNode>
		{
		    return _splitBitmapData;
		}
		
		/**
		 * 切割返回位图序列
		 * @param	widthParam
		 * @param	heightParam
		 * @param	offX
		 * @param	offY
		 * @return
		 */
		public function split(widthParam:int, heightParam:int, offX:Number = 0, offY:Number = 0):Vector.<BitmapDataIncisionNode>
		{
			var bitmapdatas:Vector.<BitmapDataIncisionNode> = new Vector.<BitmapDataIncisionNode>();
			var data:Vector.<RectangleIncisionNode> = _rectIncision.split(widthParam, heightParam);
			
			for each (var item:RectangleIncisionNode in data)
			{
				var createBitmap:Bitmap = new Bitmap(new BitmapData(item.rect.width, item.rect.height))
				createBitmap.x = item.rect.x + offX;
				createBitmap.y = item.rect.y + offY;
				//trace(createBitmap.x ,createBitmap.y)
				createBitmap.bitmapData.copyPixels(_sourceBitmapData, new Rectangle(item.rect.x, item.rect.y, item.rect.width, item.rect.height), new Point(0, 0));
				
				var bitmapDataIncisionNode:BitmapDataIncisionNode = new BitmapDataIncisionNode();
				bitmapDataIncisionNode.bitmap = createBitmap;
				bitmapDataIncisionNode.rect = item.rect;
				bitmapDataIncisionNode.rect.x += offX;
				bitmapDataIncisionNode.rect.y += offY;		
				bitmapDataIncisionNode.row = item.row;
				bitmapDataIncisionNode.column = item.column;
				bitmapdatas.push(bitmapDataIncisionNode);
			}
			_splitBitmapData = bitmapdatas;
			return bitmapdatas;
		}
		
		/**
		 * 切割的数据到数组
		 * @param	data
		 */
		public function appendToData(data:Vector.<BitmapData>):void
		{
			if (_splitBitmapData != null)
			{
				for each (var item:BitmapDataIncisionNode in _splitBitmapData)
				{
					 data.push(item.bitmap.bitmapData);
				}
			}else {
			  throw new Error("you need use method split")	
			}
		}
	
		public function appendToBitmap(data:Vector.<Bitmap>):void
		{
			if (_splitBitmapData != null)
			{
				for each (var item:BitmapDataIncisionNode in _splitBitmapData)
				{
					 data.push(item.bitmap);
				}
			}else {
			  throw new Error("you need use method split")	
			}
		}
	}

}