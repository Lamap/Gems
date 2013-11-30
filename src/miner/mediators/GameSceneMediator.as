package miner.mediators 
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import miner.models.ConfigModel;
	import miner.models.GameModel;
	import miner.utils.GemGameEvent;
	import miner.utils.Tracer;
	import miner.views.GameScene;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameSceneMediator extends Mediator 
	{
		[Inject]
		public var view:GameScene;
		
		[Inject]
		public var configModel:ConfigModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function GameSceneMediator() 
		{
			super();
		}
		override public function onRegister():void
		{
			view.startGameButton.addEventListener(MouseEvent.CLICK, onStartGameClick);
			view.addEventListener(GemGameEvent.REPLAY_GAME, replayClicked);
			addContextListener(GemGameEvent.GEM_GRID_CREATED, goAndPlay);
			addContextListener(GemGameEvent.GAME_TIME_OVER, goToEndScene);
		}
		
		private function replayClicked(e:GemGameEvent):void 
		{
			dispatch(e);
		}
		
		private function goToEndScene(e:GemGameEvent):void 
		{
			var setTimeOut:Timer = new Timer(1000, 1);
			setTimeOut.addEventListener(TimerEvent.TIMER_COMPLETE, showEnd, false, 0, true)
			setTimeOut.start();
		}
		
		private function showEnd(e:TimerEvent):void 
		{
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, showEnd);
			view.showEndScene(gameModel.gamePoint);
		}
				
		
		private function onStartGameClick(e:MouseEvent):void 
		{
		
			dispatch(new GemGameEvent(GemGameEvent.BUILD_GEM_GRID));
		}
		private function goAndPlay(e:GemGameEvent):void 
		{
			view.removeStartScene();
			view.createGemGrid();
		}
		
	}

}