package zebraAir.util 
{
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.Capabilities;
	import flash.utils.ByteArray; 

	public class FileHelper 
	{
		
		public function FileHelper() 
		{
			
		}
          
		 
		
		static public function fixPath(path:String):String {
			return path.replace('\\','/');
			}

		static  public function open(file:File,encoding:String="UTF-8"):String {
			var  txt:String;
		    var  fs:FileStream  = new FileStream();
			fs.open(file, FileMode.READ);
			txt = fs.readMultiByte(fs.bytesAvailable, encoding);
			fs.close();
			return txt;
		}
		
		
		static public function resolvePath(path:String):String {
			  if (Capabilities.os.indexOf("Window") >= 0) return  File.applicationDirectory.nativePath + "/" + path;
			  return  path;
			//return File.applicationDirectory.resolvePath(path);
			}
			
		/**
		 * 自动判断平台的相对路径文件
		 * @param	path
		 * @return
		 */
		static public function getResolveFile(path:String):File {
			  if (Capabilities.os.indexOf("Window") >= 0) return   new File(File.applicationDirectory.resolvePath(path).nativePath);
			  if (Capabilities.os.indexOf("Linux") >= 0) return    File.userDirectory.resolvePath(path).clone();
			  return null;
			}	
		
		
		static  public function write(file:File,data:String,async:Boolean=false,encoding:String="UTF-8"):void {
		    var  fs:FileStream  = new FileStream();
			if (async) {
				fs.openAsync(file, FileMode.WRITE);
				}else {
				fs.open(file, FileMode.WRITE);
				}
				fs.writeMultiByte(data, encoding);
				fs.close();
		}
		
		
		static  public function saveFile(file:File,data:ByteArray):void {
		    var  fs:FileStream  = new FileStream();
				//fs.openAsync(file, FileMode.WRITE);
				fs.open(file, FileMode.WRITE);
				fs.writeBytes(data);
				fs.close();
		}
		
		static public function IsFile(file:File,expandFile:String):Boolean {
			   return file.name.indexOf(expandFile) != -1
			}
		
		
		/**
		 * 获得文件夹列表
		 * @param	file
		 * @return
		 */
		static public function getFolderList(file:File):Vector.<File> {
			 var folders:Vector.<File> = new Vector.<File>();
			 var arr:Array = file.getDirectoryListing();
			     for each( var item:File in arr) {
				    if (item.isDirectory) {
						folders.push(item);
						}
			     }			 
			 return folders;
	      }
		
		 /**
		  * 获得所有文件包括文件夹和文件
		  * @param	file
		  * @param	filter
		  * @return
		  */
		 static public function getFileChilds(file:File,filter:String="*"):Vector.<File>  {
			  var source:Vector.<File> = new Vector.<File>();
              var extendName:String;
			  var arr:Array = file.getDirectoryListing();
			  var filterFiles:Array;
			  if (filter != "*") filterFiles =  filter.split(",");
			  for each( var item:File in arr) {
				    if (item.isDirectory) {
						 getFiles(item, filter);
						  source.push(item)
						}else {
							
						  if (filter == "*") {
							 source.push(item)
							 }
						 	 if (filter != "*") {	
								 extendName = item.name.substr(item.name.length - 4, 4).toLocaleUpperCase();
								 for each (var f:String in filterFiles) 
								 {
									 if ( extendName ==  f) {
										   source.push(item);
										 }
								 }
							 }    
					    }
				 } 
				return source;
			}
		
        /**
         * 获得文件对象 不包括文件夹
         * @param	file
         * @param	filter
         * @return
         */
		static public function getFiles(file:File,filter:String="*"):Vector.<File>  {
			  var source:Vector.<File> = new Vector.<File>();
              var extendName:String;
			  var arr:Array = file.getDirectoryListing();
			  var filterFiles:Array;
			  if (filter != "*") filterFiles =  filter.split(",");
			  
			  for each( var item:File in arr) {
				    if (item.isDirectory) {
						// getFiles(item,filter);
						}else {
							
						  if (filter == "*") {
							 source.push(item)
							 }
						 if (filter != "*") {	
							 extendName = item.name.substr(item.name.length - 4, 4).toLocaleUpperCase();
							 for each (var f:String in filterFiles) 
							 {
								 if ( extendName ==  f.toLocaleUpperCase()) {
									   source.push(item);
									 }
							 }   
							 
							 /*if (extendName == "." + filter.toLocaleUpperCase()) {
									source.push(item);
									}*/
							 } 
					    }
				 } 
				return source;
			}
			
			
			
			static public function getMimeType(file:File):String {
				
			        var imageExtensions:Array = ["jpg","jpeg","png","gif"];
					var audioExtensions:Array = ["wav","mp3","m4a"];
					var videoExtensions:Array = ["wmv","mp4","avi","flv","f4v"];

					//this next chunck of ugly code figures out what the mime type of the file is so that android launches the approprate share list.
					var ext:String = file.extension;
					var str:String

					//if the extension doesn't match any from our arrays it will remain the defauld application/* and be shared as a file.
					var mimeType:String = "application/*";

					for each (str in imageExtensions){
						if(ext==str){
							mimeType = "image/*";
							break;
						}
					}
					for each (str in videoExtensions){
						if(ext==str){
							mimeType = "video/*";
							break;
						}
					}
					for each (str in audioExtensions){
						if(ext==str){
							mimeType = "audio/*";
							break;
						}
					}
					
					return mimeType;
				
				}
				
				
			static public function copyFile(targetFile:File, localFile:File):void {
			   var source:File = targetFile;
			   var local:File = localFile;
			   if (!local.exists) local.createDirectory();   
			   source.copyTo(local, true);
			 }
			 
			 /**
			  * 重新打开自己exe程序
			  */
			 static public function reSetupSelf():void
			{
				 NativeApplication.nativeApplication.autoExit = true;
				 try{
					  var file:File = FileHelper.getResolveFile(NativeApplication.nativeApplication.applicationID+".exe");
					  var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();  
					  nativeProcessStartupInfo.executable=file;
					  var process:NativeProcess=new NativeProcess();
					  process.start(nativeProcessStartupInfo);
				 }catch (e) {
				
				 }
			}
	}

}