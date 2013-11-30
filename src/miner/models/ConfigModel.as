package miner.models 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class ConfigModel extends Actor 
	{
		public var background:MovieClip; // if we use external swf, not swc 
		public var debugMode:Boolean = true;
		
		public static var rowCount:int = 8;
		public static var collCount:int = 8;
		public static var gridWidth:int = 30;
		public static var gridHeight:int = 30;
		public static var gridHorizontalGap:int = 2;
		public static var gridVerticalGap:int = 2;
		public static var gridPosition:Point = new Point(232, 68);
		
		
		public static var gemChangeDuration:Number = 0.8;
		
		public static var gemTypeBlue:GemVO = new GemVO("BlueGem",1);
		public static var gemTypePurple:GemVO =  new GemVO("PurpleGem",2);
		public static var gemTypeYellow:GemVO =  new GemVO("YellowGem",3);
		public static var gemTypeGreen:GemVO =  new GemVO("GreenGem",4);
		public static var gemTypeRed:GemVO =  new GemVO("RedGem", 5);
		
		public static var gameDurationInSecond:int = 60;
		public static var timePrecision:int = 10;
		
		public static var gemCollection:Array = new Array(
			ConfigModel.gemTypeBlue,
			ConfigModel.gemTypePurple,
			ConfigModel.gemTypeYellow,
			ConfigModel.gemTypeGreen,
			ConfigModel.gemTypeRed
		)
		public static function getRandomGemType():GemVO {
			var index:int = Math.floor(Math.random() * 5);
			return (ConfigModel.gemCollection[index] as GemVO);
			}
		public static function getRandomGemTypeOutOf(type1:int = 0,type2:int = 0):GemVO {
			var index:int = Math.floor(Math.random() * 5);
			
			index = getValueFrom1to5outOf(type1, type2) - 1;
			
			return (ConfigModel.gemCollection[index] as GemVO);
			}
		public static function getValueFrom1to5outOf(p1:int = 0,p2:int = 0):int {
			var ret:Array =  new Array(1, 2, 3, 4, 5);
			if(p1 != 0){
				for (var i:String in ret) {
					if (ret[i] == p1)
						ret.splice(i, 1);
					}
				}
			if (p2 != 0) {
				for (var j:String in ret) {
					if (ret[j] == p2)
						ret.splice(j, 1);
					}	
				}
			var retIndex:int = Math.floor(Math.random() * ret.length);
			return ret[retIndex];
			}
		public function ConfigModel() 
		{
			
		}
		
	}

}