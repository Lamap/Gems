package miner.models 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class WinGemLine extends EventDispatcher 
	{
		private var _winValue:int;
		private var _gemNodes:Array;
		private var _lineLength:int = 0;
		private var _startNode:Point;
		private var _endNode:Point;
		private var _winPerNode:int;
		
		private var gemType:String;
		private var gemVO:GemVO;
	
		public function WinGemLine(p_gemVO:GemVO,p_startNode:Point) 
		{
				gemVO = p_gemVO;
				gemType = p_gemVO.type;
				_startNode = p_startNode;
				_gemNodes = new Array(p_startNode);
				_lineLength = 1;
				_winPerNode = gemVO.value;
		}
		
		
		public function addWinNode(node:Point):void {
				_endNode = node;
				
				_gemNodes.push(node);
				_lineLength = _gemNodes.length;
				_winValue = _lineLength * gemVO.value;
			}
		
		public function get winValue():int 
		{
			return _winValue;
		}
		
		public function get gemNodes():Array 
		{
			return _gemNodes;
		}
		
		public function get lineLength():int 
		{
			return _lineLength;
		}
		
		public function get startNode():Point 
		{
			return _startNode;
		}
		
		public function get endNode():Point 
		{
			return _endNode;
		}
		
		public function get winPerNode():int 
		{
			return _winPerNode;
		}
		
	}

}