package miner.views 
{
	import flash.display.MovieClip;
	import miner.models.ConfigModel;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class WickView extends MovieClip 
	{
		private var wick:Wick;
		
		private var wickStep:int; 
		
		public function WickView() 
		{
			
		}
		
		public function init(userScore:int):void{
			wick = new Wick();
			wick.stop();
			
			wickStep = int(ConfigModel.timePrecision * ConfigModel.gameDurationInSecond / wick.totalFrames); 
			wick.points.htmlText = 'Scores: <font color="#D20000">0</font>';
			wick.pointsTogether.htmlText = 'User\'s scores: <font color="#D20000">' + userScore.toString() + '</font>';
			addChild(wick);
			}
		
		public function update(time:int):void {
			var timeStr:String = (time %10 == 0) ? (time/ConfigModel.timePrecision).toString() + ".0" : (time/ConfigModel.timePrecision).toString();
			wick.timeLeft.htmlText = '<font color="#D20000">' + timeStr + ' </font> secs left';
			
			if(time % wickStep == 0)
				wick.nextFrame();
			}
	
		public function updateScore(score:int):void {
				wick.points.htmlText = 'Scores: <font color="#D20000">' + score.toString() + '</font>';
			}
			
		public function timeIsOver():void {
			wick.timeLeft.htmlText = '<font color="#D20000">Time is over!</font>';
			}
	}
	
}