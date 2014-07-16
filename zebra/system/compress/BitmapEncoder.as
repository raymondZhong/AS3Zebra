package zebra.system.compress 
{
	import flash.display.BitmapData;  
    import flash.geom.Rectangle;  
    import flash.utils.ByteArray;     
      
    public class BitmapEncoder {  
          
        public static function encodeByteArray(data:BitmapData):ByteArray{  
            if(data == null){  
                throw new Error("data parameter can not be empty!");  
            }  
            var bytes:ByteArray = data.getPixels(data.rect);  
            bytes.writeShort(data.width);  
            bytes.writeShort(data.height);  
            bytes.writeBoolean(data.transparent);  
            bytes.compress();  
            return bytes;  
        }  
        public static function encodeBase64(data:BitmapData):String{  
            return BitmapBase64.encode(encodeByteArray(data));  
        }  
          
        public static function decodeByteArray(bytes:ByteArray):BitmapData{  
            if(bytes == null){  
                throw new Error("bytes parameter can not be empty!");  
            }  
            bytes.uncompress();  
            if(bytes.length <  6){  
                throw new Error("bytes parameter is a invalid value");  
            }             
            bytes.position = bytes.length - 1;  
            var transparent:Boolean = bytes.readBoolean();  
            bytes.position = bytes.length - 3;  
            var height:int = bytes.readShort();  
            bytes.position = bytes.length - 5;  
            var width:int = bytes.readShort();  
            bytes.position = 0;  
            var datas:ByteArray = new ByteArray();            
            bytes.readBytes(datas,0,bytes.length - 5);  
            var bmp:BitmapData = new BitmapData(width,height,transparent,0);  
            bmp.setPixels(new Rectangle(0,0,width,height),datas);  
            return bmp;  
        }  
          
        public static function decodeBase64(data:String):BitmapData{              
            return decodeByteArray(BitmapBase64.decode(data));  
        }         
          
        public function BitmapEncoder() {  
            throw new Error("BitmapEncoder  is a static class!");  
        }  
          
    }  
      
}   

