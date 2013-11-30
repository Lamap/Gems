package miner.models 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class FallVO extends EventDispatcher 
	{
		private var _collIndex:int;
		private var _reserveGems:Array = new Array();
		private var _replacedNodes:Array = new Array();
		private var _length:int = 0;
		
		public function FallVO() 
		{
			
		}
		public function addReserveGem(p_gem:GemVO):void {
			_reserveGems.push(p_gem);
			_length = _reserveGems.length;
			}
		public function addReplacedNode(row:int):void {
			_replacedNodes.push(row);
				}
		public function get collIndex():int 
		{
			return _collIndex;
		}
		
		public function set collIndex(value:int):void 
		{
			_collIndex = value;
		}
		
		public function get reserveGems():Array 
		{
			return _reserveGems;
		}
		
		public function set reserveGems(value:Array):void 
		{
			_reserveGems = value;
		}
		
		public function get length():int 
		{
			return _length;
		}
		
		public function get replacedNodes():Array 
		{
			return _replacedNodes;
		}
		
		public function set replacedNodes(value:Array):void 
		{
			_replacedNodes = value;
		}
		
	}

}