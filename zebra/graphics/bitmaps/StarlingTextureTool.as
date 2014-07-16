package zebra.graphics.bitmaps 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import zebra.plugs.mobile.MobileConstants;
	/**
	 * ...
	 * @author ...
	 */
	public class StarlingTextureTool 
	{
		
		public function StarlingTextureTool() 
		{
			
		}
		
		
		static public function getTexture(bm:*):Texture {
				var bmd:BitmapData;
				var texture:Texture;
				if (bm is Bitmap){
					 texture = Texture.fromBitmap(bm);
					 Bitmap(bm).bitmapData.dispose();
				}
				if (bm is BitmapData) {
					 texture = Texture.fromBitmapData(bm);
					 BitmapData(bm).dispose();
				}
				 return texture;
			}
			
		
		static public function screenShot(displayObject:DisplayObject,  bound:Rectangle=null,transparentBackground:Boolean = true, backgroundColor:uint = 0x757575):BitmapData
		{
			if (displayObject == null || isNaN(displayObject.width) || isNaN(displayObject.height))
				return null;
				var resultRect:Rectangle = bound;
		//	    displayObject.getBounds(displayObject, resultRect);
				
				var result:BitmapData = new BitmapData(resultRect.width, resultRect.height, transparentBackground, backgroundColor);
				var context:Context3D = Starling.context;
				var support:RenderSupport = new RenderSupport();
				RenderSupport.clear();
				support.setOrthographicProjection(0, 0, Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
				//support.setOrthographicProjection(0, 0, Starling.current.stage.stageWidth*.5, Starling.current.stage.stageHeight*.5);
				support.applyBlendMode(true);
				support.translateMatrix(-resultRect.x, -resultRect.y);
				support.pushMatrix();
				support.blendMode = displayObject.blendMode;
				displayObject.render(support, 1.0);
				support.popMatrix();
				support.finishQuadBatch();
				context.drawToBitmapData(result);
			return result;
		}
		
		
		static public function screenFullShot(bound:Rectangle=null):BitmapData
		{
			 	var r:RenderSupport=new RenderSupport();
					  RenderSupport.clear();
					  r.setOrthographicProjection(0, 0, Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
					  Starling.current.stage.render(r,1);
					  r.finishQuadBatch();
					  var result:BitmapData=new BitmapData(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight,true);
					  Starling.current.context.drawToBitmapData(result);
				 
			    var tempBm:Bitmap = new Bitmap(result); 
				var matrix:Matrix = new Matrix();
					matrix.scale(MobileConstants.designViewPort.width / MobileConstants.deviceViewPort.width,
								 MobileConstants.designViewPort.height / MobileConstants.deviceViewPort.height);
				var bmd:BitmapData =  new BitmapData(MobileConstants.designViewPort.width, MobileConstants.designViewPort.height)
					bmd.draw(tempBm, matrix);
			       if (bound)
				   {
					   tempBm.bitmapData = bmd;
					   var newbmd:BitmapData = new BitmapData(bound.width,bound.height);
					   newbmd.copyPixels(bmd, bound, new Point(0, 0));   
					   result.dispose();
					   bmd.dispose();
					   return newbmd;
				   }  
				 result.dispose();
				return bmd;
		}
/*		public static function copyAsBitmapData(sprite:starling.display.DisplayObject):BitmapData {
			  if (sprite == null) return null;
			 
			  var resultRect:Rectangle = new Rectangle();
			  sprite.getBounds(sprite, resultRect);
			 
			  var context:Context3D = Starling.context;
			  var scale:Number = Starling.contentScaleFactor;
			  var nativeWidth:Number = getNextPowerOfTwo(Starling.current.stage.stageWidth  * scale);
			  var nativeHeight:Number = getNextPowerOfTwo(Starling.current.stage.stageHeight * scale);
			 
			  var support:RenderSupport = new RenderSupport();
			  RenderSupport.clear();
			  support.setOrthographicProjection(nativeWidth/scale, nativeHeight/scale);
			  support.applyBlendMode(true);
			  support.transformMatrix(sprite.root);
			  support.translateMatrix( -resultRect.x, -resultRect.y);
			 
			  var result:BitmapData = new BitmapData(resultRect.width * scale, resultRect.height * scale, true, 0x00000000);
			 
			  support.pushMatrix();
			  support.pushBlendMode();
			 
			  support.blendMode = sprite.blendMode;
			  support.transformMatrix(sprite);
			  sprite.render(support, 1.0);
			  support.popMatrix();
			  support.popBlendMode();
			 
			  support.finishQuadBatch();
			 
			  context.drawToBitmapData(result);	
			 
			  return result;
			}*/
		
	}

}