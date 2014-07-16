package zebraui.components.message
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class Alert
	{
		static internal var IsOpen:Boolean = false;
		
		static public function show(container:DisplayObjectContainer, title:String, text:String, isdialog:Boolean = false, type:String = "Yes", yesLabel:String = "Yes", noLabel:String = "No", cancelLabel:String = "Cancel", yesHandler:Function = null, noHandler:Function = null, cancelHandler:Function = null):void
		{
			if (!IsOpen)
			{
				var alert:AlertDesigner = new AlertDesigner(type);
				alert.Isdialog = isdialog;
				alert.type = type;
				alert.title = title;
				alert.messageText.text = text;
				alert.yesButton.text = yesLabel;
				alert.noButton.text = noLabel;
				alert.cancelButton.text = cancelLabel;
				alert.yesHandler = yesHandler;
				alert.noHandler = noHandler;
				alert.cancelHandler = cancelHandler;
				container.addChild(alert);
				IsOpen = true;
			}
		
		}
	}

}