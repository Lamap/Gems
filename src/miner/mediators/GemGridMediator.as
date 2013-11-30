package miner.mediators 
{
	import miner.models.GameModel;
	import miner.models.WinGemLine;
	import miner.utils.GemGameEvent;
	import miner.utils.Tracer;
	import miner.views.GemGrid;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GemGridMediator extends Mediator 
	{
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var grid:GemGrid;
		
		public function GemGridMediator() 
		{
			
		}
		override public function onRegister():void
		{			
			addContextListener(GemGameEvent.SHOW_GEM_CHANGE, gemChangeAnim);
			grid.addEventListener(GemGameEvent.CHANGE_ANIMATION_COMPLETED, onGemChangeCompleted);
			grid.addEventListener(GemGameEvent.All_GEM_ANIM_FINISHED, onGemFallCompleted);
			addContextListener(GemGameEvent.UNDO_GEM_CHANGE, undoGemChange);
			addContextListener(GemGameEvent.CONFIRM_GEM_CHANGE, applyGemChange);
			
			addContextListener(GemGameEvent.AFTER_WIN, afterWin);
			
			grid.init(gameModel.gemMatrix);
		}	
		
		
		private function onGemFallCompleted(e:GemGameEvent):void 
		{
			dispatch(new GemGameEvent(GemGameEvent.All_GEM_ANIM_FINISHED));
			gameModel.checkWinningLinesAfterAnim();
		}
		
		private function gemChangeAnim(e:GemGameEvent):void 
		{
			grid.changeGems(gameModel.firstSelectedGem, gameModel.secondSelectedGem);
		}	
		
		private function onGemChangeCompleted(e:GemGameEvent):void 
		{
			dispatch(new GemGameEvent(GemGameEvent.CLEAR_ALL_GEM_FOCUS));
			dispatch(new GemGameEvent(GemGameEvent.CHECK_GEM_WIN_LINES));
		}
		
		private function undoGemChange(e:GemGameEvent):void 
		{
				grid.changeGemsBack(gameModel.firstSelectedGem, gameModel.secondSelectedGem);	
				dispatch(new GemGameEvent(GemGameEvent.All_GEM_ANIM_FINISHED));
		}
		
		private function applyGemChange(e:GemGameEvent):void 
		{
			grid.changeGemsIndex(gameModel.firstSelectedGem, gameModel.secondSelectedGem, gameModel.gemMatrix);	
			grid.fallColls(gameModel.fallObjects,gameModel.gemMatrix);
			grid.addWinAnim(gameModel.actWinningLines);	
		}
		
		private function afterWin(e:GemGameEvent):void 
		{
			grid.fallColls(gameModel.fallObjects,gameModel.gemMatrix);
			grid.addWinAnim(gameModel.actWinningLines);	
		}
	}

}