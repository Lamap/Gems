package miner.commands 
{
	import miner.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class AllGemAnimEndedCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function AllGemAnimEndedCommand() 
		{
			
		}
		override public function execute():void {
			gameModel.forbidGemChange = false;
			}
	}

}