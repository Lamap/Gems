package miner 
{
	import flash.display.DisplayObjectContainer;
	import miner.commands.AllGemAnimEndedCommand;
	import miner.commands.BuildGameCommand;
	import miner.commands.CheckGemWinLinesCommand;
	import miner.commands.ReplayGameCommand;
	import miner.mediators.GameSceneMediator;
	import miner.mediators.GemGridMediator;
	import miner.mediators.GemMediator;
	import miner.mediators.WickViewMediator;
	import miner.models.ConfigModel;
	import miner.models.GameModel;
	import miner.models.UserModel;
	import miner.services.AssetService;
	import miner.services.IAssetService;
	import miner.utils.GemGameEvent;
	import miner.views.GameScene;
	import miner.views.Gem;
	import miner.views.GemGrid;
	import miner.views.WickView;
	import org.robotlegs.mvcs.Context;
	import miner.utils.Tracer;
	
	/**
	 * ...
	 * @author Ákos
	 * 
	 * 	// TODO: 
		 1. dragging 
		 2. set the 2nd selected gem to active is wrong selection
		 3. maximize the same kinda gems in a row and col whe creating
		 4. change the win checking from the change point to the global matrix.
		 5. check after fall
	 * 
	 * 
	 */
	

	 
	public class MainContext extends Context 
	{
		
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
			
			// reg models
			injector.mapSingleton(ConfigModel);
			injector.mapSingleton(GameModel);
			injector.mapSingleton(UserModel);
			
			// reg commands
			commandMap.mapEvent(GemGameEvent.BUILD_GEM_GRID, BuildGameCommand, GemGameEvent, false);
			commandMap.mapEvent(GemGameEvent.CHECK_GEM_WIN_LINES, CheckGemWinLinesCommand, GemGameEvent, false);
			commandMap.mapEvent(GemGameEvent.REPLAY_GAME, ReplayGameCommand, GemGameEvent, false);
			commandMap.mapEvent(GemGameEvent.All_GEM_ANIM_FINISHED, AllGemAnimEndedCommand, GemGameEvent, false);
			
			// reg mediators
			mediatorMap.mapView(GameScene, GameSceneMediator);
			mediatorMap.mapView(GemGrid, GemGridMediator);
			mediatorMap.mapView(Gem, GemMediator);
			mediatorMap.mapView(WickView, WickViewMediator);
			
			// reg services
			//injector.mapSingletonOf(IAssetService, AssetService);
			
			super.startup();
			Tracer.log("mainContextInitialized");	
			
			contextView.addChild(new GameScene());			
		}
		
	}

}