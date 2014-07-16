package zebra.system.util
{
	
	public class StringHelper
	{
		
		static public function fixed(char:*):String {
			   if (char) return String(char);
			   return "";
			}
		
		static public function isWhitespace(char:String):Boolean
		{
			if (char == null) return true;
			if (char.length == 0) return true;
			switch (trim(char))
			{

				case " ": 
					return true;
				break; 
				case "\t": 
					return true;
				break; 
				case "\r": 
					return true;
				break;
				case "\n": 
					return true;
				break; 
				case "\f": 
					return true;
				break;
				default: 
					return false;
			}
		}
		
		/**
		 * 截取
		 * @param	source
		 * @param	startpoint
		 * @param	length
		 * @return
		 */
		static public function cut(source:String,startpoint:int=0, length:int=1):String {
			   return source.substr(startpoint, length);	
			}
		
		
		public static function trim(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/^\s+|\s+$/g, '');
		}


		public static function trimLeft(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/^\s+/, '');
		}


		public static function trimRight(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/\s+$/, '');
		}
	
		
		/**
		 * 翻转字符串
		 * @param	p_string
		 * @return
		 */
		public static function reverse(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.split('').reverse().join('');
		}
		
		public static function padLeft(p_string:String, p_padChar:String, p_length:uint):String {
			var s:String = p_string;
			while (s.length < p_length) { s = p_padChar + s; }
			return s;
		}
		
				public static function padRight(p_string:String, p_padChar:String, p_length:uint):String {
			var s:String = p_string;
			while (s.length < p_length) { s += p_padChar; }
			return s;
		}
		
		
			/**
		 * 将秒转换为 00 m 00 s 
		 * 
		 */
		public static function format_MediaTime(_n:uint):String{
			return ("0"+uint(_n/60)).substr(-2)+":"+("0"+_n%60).substr(-2);
		}
		
		
		public static function format(str:String, ...args):String{  
			for(var i:int = 0; i<args.length; i++){  
				str = str.replace(new RegExp("\\{" + i + "\\}", "gm"), args[i]);  
			}  
			return str;  
		} 
		
		/**
		 * 字符串替换
		 * @param	reSource
		 * @param	p
		 * @param	reple
		 * @return
		 */
		public static function replace(reSource:String,p:*,reple:*):String{  
			var reg:RegExp = new RegExp(p, "ig");
			
			return reSource.replace(reg,reple);//替换ABC  为A-B-C
		}
		
		
		public static function formatHTML(html:String):String {
				html = StringHelper.replace(html, "<", "&lt&");
				html = StringHelper.replace(html, ">", "&gt&");
				html = StringHelper.replace(html, '"', "&st&");
				html = StringHelper.replace(html, "'", "&dt&");
				return  html;
			}
		
		
		public static function unformatHTML(html:String):String {
				html = StringHelper.replace(html, "&lt&", "<");
				html = StringHelper.replace(html, "&gt&", ">");
				html = StringHelper.replace(html, "&st&", '"');
				html = StringHelper.replace(html, "&dt&", "'");
				return  html;
			}
		
	}

}