package miner.commands 
{
	import miner.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class ToggleGemsCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function ToggleGemsCommand() 
		{
			
		}
		override public function execute():void 
		{
			super.execute();
			
			
		}
	}

}