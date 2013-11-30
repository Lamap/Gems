package miner.mediators 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import miner.models.ConfigModel;
	import miner.models.GameModel;
	import miner.models.GemVO;
	import miner.utils.GemGameEvent;
	import miner.views.Gem;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GemMediator extends Mediator 
	{
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var gem:Gem;
		
		[Inject]
		public var configModel:ConfigModel;
		
		public function GemMediator() 
		{
			
		}
		
		override public function onRegister():void {		
			gem.addEventListener(MouseEvent.CLICK, onGemClicked);
			addContextListener(GemGameEvent.CLEAR_ALL_GEM_FOCUS, clearFocus);
			
			// alert on difference between model and view
			var typeInModel:String = (gameModel.gemMatrix[gem.collIndex][gem.rowIndex] as GemVO).type;
			var typeInGem:String = gem.gemType.type;
			if (typeInGem != typeInModel && configModel.debugMode)
				gem.focusError();
				
				
			// dragging
			gem.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			
		private function mouseDown(e:MouseEvent):void 
			{
				trace("down");
			}
			
		
			
		private function onGemClicked(e:MouseEvent):void 
			{
				trace("click");
				if (gameModel.forbidGemChange)
					return;
				
				
					
				var c:int = gem.collIndex;
				var r:int = gem.rowIndex;
				trace(c, r, (gameModel.gemMatrix[c][r] as GemVO).type, gem.x, gem.y);
				trace("-------------");
				
				//if have 2 selected, then clear
				if (gameModel.secondSelectedGem)
				{
					clearAllGemsFocus();
				}
				
				//if 0 or 1 selected
				if (!gameModel.firstSelectedGem)
					{
						gameModel.firstSelectedGem = new Point();
						gameModel.firstSelectedGem.x = gem.collIndex;
						gameModel.firstSelectedGem.y = gem.rowIndex;
						
						gem.selected = true;
					}
				else {
					var tempGemPoint:Point = new Point(gem.collIndex,gem.rowIndex);
					var neighbours:Boolean = gameModel.areNeighbours(gameModel.firstSelectedGem, tempGemPoint);
					
					// if not neighbours
					if (!neighbours)
						{
							clearAllGemsFocus();
							return;
						}
					
					gameModel.secondSelectedGem = new Point();
					gameModel.secondSelectedGem.x = gem.collIndex;
					gameModel.secondSelectedGem.y = gem.rowIndex;
					
					// if same Color 	
					if (gameModel.areSameColored()) {
						clearAllGemsFocus();
						return;
						}
						
					
					gem.selected = true;
					
					dispatch(new GemGameEvent(GemGameEvent.SHOW_GEM_CHANGE));
					gameModel.forbidGemChange = true;
					}

			}
		private function clearAllGemsFocus():void {
			gameModel.firstSelectedGem = null;
			gameModel.secondSelectedGem = null;				
			dispatch(new GemGameEvent(GemGameEvent.CLEAR_ALL_GEM_FOCUS));
			}	
			
		private function clearFocus(e:GemGameEvent):void 
			{
				gem.selected = false;
			}	
	}

}