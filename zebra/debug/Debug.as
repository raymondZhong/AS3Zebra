package zebra.debug
{
	import flash.utils.getQualifiedClassName;
	import zebra.system.reflection.Reflection;
	
	public class Debug
	{
		
		static public function output(str:String, tabindex:int = 0, textcolor:String = "0x000000", textBgColor:String = "0xFFFFFF"):void
		{
			var ot:String = "[Tab:" + tabindex + "],{" + str + "},{" + textcolor + "},{" + textBgColor + "}";
			trace(ot);
		}
		
		static public function dumpClass(cls:*, tabindex:int = 0, textcolor:String = "0x0000FF", textBgColor:String = "0xFFFFFF"):void
		{
			output(cls.toString(), tabindex, textcolor, textBgColor);
			output("{", tabindex, textcolor, textBgColor);
			var data:Reflection = new Reflection(cls);
			for each (var item:String in data.variable.names)
			{
				output("  " + item + ":" + data.variable.get(item), tabindex, textcolor, textBgColor);
			}
			for each (var access:String in data.accessor.names)
			{
				output("  " + access + ":" + data.accessor.get(access), tabindex, textcolor, textBgColor);
			}
			output("}", tabindex, textcolor, textBgColor);
		}
		
		static public function dump(_obj:*):void
		{
			if (!_obj)
				return;
				
			trace("********************************");
			trace("["+getQualifiedClassName(_obj)+"]=>");
			for (var i:*in _obj)
			{
				trace("         "+i + "  :  " + _obj[i]);
			}
		}
	
	}

}