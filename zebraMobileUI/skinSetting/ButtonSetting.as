package zebraMobileUI.skinSetting 
{
	public class ButtonSetting 
	{
		
		public function ButtonSetting() 
		{
			
		}
		
		public var buttonNode:Vector.<ButtonNode>;
		
		public function getButtonNodeByTheme(theme:String):ButtonNode {
				for each (var node:ButtonNode in buttonNode) 
				{ 
					if (node.theme == theme) return node;
				}
				throw new Error(theme + ": 不存在.");
				return null;
			}
		
	}

}