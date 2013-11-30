package miner.commands 
{
	import miner.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class CheckGemWinLinesCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function CheckGemWinLinesCommand() 
		{
			
		}
		override public function execute():void 
		{
			super.execute();
			gameModel.checkWinningLines();
			
		}
	}

}