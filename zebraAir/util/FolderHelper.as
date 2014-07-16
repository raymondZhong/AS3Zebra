package zebraAir.util 
{
	import flash.filesystem.File;
	public class FolderHelper 
	{
		
		public function FolderHelper() 
		{
			
		}
		
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
		  
		  
		static public function  createFolder(file:File):void {
			     if (!file.exists) {
					 file.createDirectory();
					 }			  
			  } 
			  
		/**
		 * 打开一个文件夹
		 * @param	fileORpath
		 */
		static public function  openFolder(fileORpath:*):void {
			    var file:File;
				if (fileORpath is File) 
				{
					file = fileORpath;
				}else {
					file = new File(fileORpath)
				}
				file.openWithDefaultApplication();
			  }
			  
		
		  /**
		   * 把目标文件夹拷贝到本地指定文件夹, 本地不存在先创建
		   * @param	targetFile
		   * @param	localFile
		   */
		static public function copyFolder(targetFile:File, localFile:File):void {
			   var source:File = targetFile;
			   var local:File = localFile;
			   if (!local.exists) local.createDirectory();   
			   source.copyTo(local, true);
				
			  /*var source:File = File.applicationDirectory.resolvePath("www");//copy entire folder (with css)
			  var destination:File = File.applicationStorageDirectory;
			  var website:File = new File(destination.nativePath + "/www");
			  if (!website.exists) website.createDirectory();   
			  source.copyTo(website, true);*/
			 }
    }
}