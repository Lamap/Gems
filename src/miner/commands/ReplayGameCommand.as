package miner.commands 
{
	import miner.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class ReplayGameCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function ReplayGameCommand() 
		{
			
		}
		override public function execute():void 
		{
			super.execute();
			
			gameModel.createGemMatrixData();
			gameModel.startTimer();
		}
	}

}