package miner.mediators
{
	import miner.models.GameModel;
	import miner.models.UserModel;
	import miner.utils.GemGameEvent;
	import miner.views.WickView;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class WickViewMediator extends Mediator
	{
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var wick:WickView;
		
		public function WickViewMediator()
		{
		
		}
		
		override public function onRegister():void
		{
			
			wick.init(userModel.userPoint);
			addContextListener(GemGameEvent.GAME_TIME_STEPPED, updateTime);
			addContextListener(GemGameEvent.GAME_POINT_CHANGED, updatePoint);
			addContextListener(GemGameEvent.GAME_TIME_OVER, timeIsOver);
		}
		
		private function timeIsOver(e:GemGameEvent):void 
		{
			wick.timeIsOver();
		}
		
		private function updatePoint(e:GemGameEvent):void 
		{
			wick.updateScore(gameModel.gamePoint);
		}
		
		private function updateTime(e:GemGameEvent):void
		{
			wick.update(gameModel.gameTime);
		}
	
	}

}