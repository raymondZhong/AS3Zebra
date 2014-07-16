package zebra.system.media
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.net.URLStream;
	import flash.net.NetConnection;
	import flash.utils.setTimeout;
	
	public class QuickVideoPlayer extends Sprite
	{
		
		
	    private var  _volume:Number = 1;
		private var connection:NetConnection;
        private var stream:NetStream;
		public  var videoURL:String="" // "http://192.168.0.90/zebramediasystem/public/uploads/2014-06-20/53a3ced873f2c.flv";

		public  var video:Video;		
		public var realVideoWidth:Number = 0;
		public var realVideoHeight:Number = 0;
		public var duration:Number = 0;
		public var framerate:Number = 0;
		
		private var _isPlaying:Boolean = true;
		
		public var onReadyHandler:Function;
		public var onCompleteHandler:Function;
		public var onDisposeHandler:Function;
		
		public function QuickVideoPlayer()
		{
			connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.connect(null);
			
			
			stream = new NetStream(connection);
			stream.client =  new CustomClient(this);
			stream.soundTransform  =  new SoundTransform(_volume);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			
			video = new Video(500, 400);
			video.attachNetStream(stream);
			video.smoothing = true;
			addChild(video);
			_isPlaying = true;
			 
		}
		
		
		
		
		private function asyncErrorHandler(e:AsyncErrorEvent):void 
		{
			
		}
		
 
		private function netStatusHandler(event:NetStatusEvent):void {
			trace(event.info.code)
			switch (event.info.code) {
				case "NetConnection.Connect.Failed":
				   // dispatchEvent(new Event(Event_Error_Connect));
					break;					
                case "NetConnection.Connect.Success":
                   // connectStream();
					//addEventListener(Event.ENTER_FRAME, ENTERFRAME);
                    break;
                case "NetStream.Play.StreamNotFound":
                   // dispatchEvent(new Event(Event_Error)); 
				    break;
				case "NetStream.Buffer.Empty":
				//	dispatchEvent(new Event(Event_Buffer_Empty));
				 
				    break;
				case "NetStream.Buffer.Full":
					//dispatchEvent(new Event(Event_Buffer_Full));
			 
					break;
				case "NetStream.Play.Start":
			 	
				//dispatchEvent( new Event(Event_Play_Start));
				    break;
				case "NetStream.Play.Stop":
				//	dispatchEvent(new Event(Event_Play_End));
					break;		
				case "NetStream.Play.Complete":
					break;		
            }
        }
		
		public function setMetaData(info:Object):void {
			  this.duration = info.duration;
			  this.realVideoWidth = info.width;
			  this.realVideoHeight = info.height;
			  this.framerate = info.framerate;
			  video.width = info.width;
			  video.height = info.height;
			  onReady();
		}
		
		
		
		public function setSize(w:Number,h:Number):void {			
			  video.width = w;
			  video.height = h;
		}
		
		public function play(url:String):void {
				videoURL = url;
				stream.play(videoURL);
				_isPlaying = true;
			}
		
		public function onReady():void {			
			    if(onReadyHandler) onReadyHandler()
			}
			
		public function onComplete():void {				
				if (onCompleteHandler) onCompleteHandler();
			}
		
			
		public function pause():void {
			   if(_isPlaying){
				stream.pause();
				_isPlaying = false;
			   }
			}
			
		public function resume():void {
			   if(!_isPlaying){
				   stream.resume()
				  _isPlaying = true;
			   }
			}
			
		public function replay():void {
				  stream.play(videoURL);
				  _isPlaying = true;
			}
			
		public function seek(value:Number):void {
				stream.seek(value);
			}
			
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function set volume(value:Number):void 
		{
			_volume = value;
			stream.soundTransform.volume = value;
		}
		
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		public function set isPlaying(value:Boolean):void 
		{
			_isPlaying = value;
		}
	
 
		public function dispose():void {
			stream.soundTransform.volume = 0;
			stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.dispose();
			video.clear();
			removeChild(video);
			onReadyHandler = null;
			onCompleteHandler = null;
			if (onDisposeHandler) onDisposeHandler();
		}
	
	}

}

import zebra.debug.Debug;
import  zebra.system.media.QuickVideoPlayer;
//onCuePoint()、onImageData()、onMetaData()、onPlayStatus()、onSeekPoint()、onTextData() 和 onXMPData()
internal class CustomClient {
	
	private var _player:QuickVideoPlayer;
	public function CustomClient(player:QuickVideoPlayer) {
				_player = player;
		}
	
    public function onCuePoint(info:Object):void {
       // trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
    }	
	
	public function onImageData(info:Object):void {
		    Debug.dump(info);
		}
		
    public function onMetaData(info:Object):void {
        //trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		_player.setMetaData(info);
    }
	
	public function onPlayStatus(info:Object):void {
		   // Debug.dump(info);
			_player.onComplete();
		}
		
	public function onSeekPoint(info:Object):void {
		    //Debug.dump(info);
		}
		
	public function onTextData(info:Object):void {
		    //Debug.dump(info);
		}
	
    public function onXMPData(info:Object):void {
           //Debug.dump(info);
    }
}
