package miner.utils 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Tracer extends EventDispatcher 
	{
		static public var traces:Array = new Array();
		
		public function Tracer() 
		{
			
		}
	static public function log(messageObject:String = null):void {
		
		if(messageObject)
			{
				trace(messageObject);
				traces.push(messageObject);
				
			}
		
		}
		
	}

}