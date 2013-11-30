package miner.utils 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GemGameEvent extends Event 
	{
		
		public static const BUILD_GEM_GRID:String = "BUILD_GREM_GRID";
		public static const GEM_GRID_CREATED:String = "GEM_GRID_CREATED";
		public static const CLEAR_ALL_GEM_FOCUS:String = "CLEAR_ALL_GEM_FOCUS";
		public static const SHOW_GEM_CHANGE:String = "SHOW_GEM_CHANGE";
		public static const CHANGE_ANIMATION_COMPLETED:String = "CHANGE_ANIMATION_COMPLETED";
		public static const CHECK_GEM_WIN_LINES:String = "CHECK_GEM_WIN_LINES";
		public static const UNDO_GEM_CHANGE:String = "UNDO_GEM_CHANGE";
		public static const CONFIRM_GEM_CHANGE:String = "CONFIRM_GEM_CHANGE";
		
		public static const GAME_POINT_CHANGED:String = "GAME_POINT_CHANGED";
		
		public static const GAME_TIME_STEPPED:String = "GAME_TIME_STEPPED";
		public static const GAME_TIME_OVER:String = "GAME_TIME_OVER";
		
		public static const REPLAY_GAME:String = "REPLAY_GAME";
		public static const All_GEM_ANIM_FINISHED:String = "All_GEM_ANIM_FINISHED";
		
		public static const AFTER_WIN:String = "AFTER_WIN";
		
		//public static const ASSETS_LOADED:String = "ASSETS_LOADED";
		
		public var paramObject:Object;
		
		public function GemGameEvent(p_type:String,p_paramObject:Object = null) 
		{
			paramObject = p_paramObject;
			super(p_type);
		}
		
		override public function clone():Event
		{
			return new GemGameEvent(type,paramObject);
		}
	}

}