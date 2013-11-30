package miner.views 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import miner.models.ConfigModel;
	import miner.utils.GemGameEvent;
	import miner.utils.Tracer;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameScene extends MovieClip 
	{
		private var background:Background = new Background();
		private var startScene:GameStartScene = new GameStartScene();
		private var wick:WickView = new WickView();
		private var endScene:GameEndScene = new GameEndScene();
		
		public var gemGrid:GemGrid;
		public var startGameButton:SimpleButton;
		public var replayButton:SimpleButton;
		
		
		public function GameScene() 
		{
			addChild(background);
			addChild(startScene);
			startGameButton = startScene.startButton;
			
		}
		public function removeStartScene():void {
			if (startScene && startScene.stage)
				removeChild(startScene);
			}
		
		public function createGemGrid():void {
			gemGrid = new GemGrid();
			gemGrid.x = ConfigModel.gridPosition.x;
			gemGrid.y = ConfigModel.gridPosition.y;
			addChild(gemGrid);
			
			wick = new WickView();
			addChild(wick);
			}
			
		public function showEndScene(point:int):void {
			endScene.points.htmlText = point.toString();
			addChild(endScene);
			removeChild(gemGrid);
			removeChild(wick);
			
			replayButton = endScene.restartButton;
			replayButton.addEventListener(MouseEvent.CLICK, onReplayClicked);
			}
			
		private function onReplayClicked(e:MouseEvent):void {
			dispatchEvent(new GemGameEvent(GemGameEvent.REPLAY_GAME));	
			removeChild(endScene);
			}
	}

}