package zebra.system.time 
{
	public class TimeFormat 
	{
		
		public function TimeFormat() 
		{
			
		}
		
		
		static public const DAYS:Array = ["周日","周一","周二","周三","周四","周五","周六"];
   
		static public function getDateString(date:Date):String
		{
			return "";
		/*	 var dYear:String = String(date.getFullYear());
			
			 var dMouth:String = String((date.getMonth() + 1 < 10) ? "0" : "") + (date.getMonth() + 1);
			
			 var dDate:String = String(date.getDate() < 10) ? "0" : "") + date.getDate();
			
			 var ret:String = "";
			
			 ret += dYear + "/" + dMouth + "/" + dDate + " ";
			
			 ret += DAYS[date.getDay()] + "";
			
			 ret += ((date.getHours() < 10) ? "0" : "") + date.getHours();
			
			 ret += ((date.getMinutes() < 10) ? "0" : "") + date.getMinutes();

			 // 想要获取秒的话，date.getSeconds() ，语句同小时、分
			
			 return ret;*/
		}
	}

}