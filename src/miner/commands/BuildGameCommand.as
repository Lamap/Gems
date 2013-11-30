package miner.commands 
{
	import miner.models.GameModel;
	import miner.utils.Tracer;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class BuildGameCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function BuildGameCommand() 
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