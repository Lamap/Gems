package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import miner.MainContext;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Main extends Sprite 
	{
		private var mainContext:MainContext;
		
		public function Main():void 
		{
			mainContext = new MainContext(this);
						
			if (stage) init();		
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);		
		}
		
	}
	
}