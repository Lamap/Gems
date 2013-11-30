package miner.models 
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import miner.utils.GemGameEvent;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameModel extends Actor 
	{
		public var gemMatrix:Array = new Array();
		
		public var firstSelectedGem:Point = null;
		public var secondSelectedGem:Point = null;
		
		public var actWinningLines:Array;
		public var fallObjects:Array;
		
		public var forbidGemChange:Boolean = false;
		
		private var gameTimer:Timer;
		private var _gameTime:int = 0;
		
		private var _gamePoint:int  = 0;
		
		[Inject]
		public var userModel:UserModel;
		
		public function GameModel() 
		{
			
		}
		
		public function startTimer():void {
			_gameTime = ConfigModel.gameDurationInSecond * ConfigModel.timePrecision;
			gameTimer = new Timer(1000 / ConfigModel.timePrecision, ConfigModel.gameDurationInSecond * ConfigModel.timePrecision);
			gameTimer.addEventListener(TimerEvent.TIMER, onTimeUpdate);
			gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeComplete);
			gameTimer.start();
			}			
		private function onTimeUpdate(e:TimerEvent):void {
			_gameTime = ConfigModel.gameDurationInSecond * ConfigModel.timePrecision - gameTimer.currentCount;
			dispatch(new GemGameEvent(GemGameEvent.GAME_TIME_STEPPED));
			}
		private function onTimeComplete(e:TimerEvent):void {
			
			dispatch(new GemGameEvent(GemGameEvent.GAME_TIME_OVER));	
			userModel.userPoint += _gamePoint;
			
			}	
		
			
		public function createGemMatrixData():void {
			
			_gamePoint = 0;
			firstSelectedGem = null;
			secondSelectedGem = null;
			actWinningLines = null;
			fallObjects = null;
			var leftNeighbourType:int = 0;
			var upNeighbourType:int = 0;
			for (var c:int = 0; c < ConfigModel.collCount; c++ ) {
				gemMatrix[c] = new Array();
				
				for (var r:int = 0; r < ConfigModel.rowCount; r++) { 
					upNeighbourType = (r > 0)? (gemMatrix[c][r - 1] as GemVO).typeIndex : 0; 
					leftNeighbourType =  (c > 0) ? (gemMatrix[c - 1][r] as GemVO).typeIndex : 0;
						
					var gemElemOnColl:GemVO = ConfigModel.getRandomGemTypeOutOf(leftNeighbourType,upNeighbourType);
					gemMatrix[c][r] = gemElemOnColl; 		
					trace(gemElemOnColl.value)
					}
				}
			
			dispatch(new GemGameEvent(GemGameEvent.GEM_GRID_CREATED));
		};
		
		public function areNeighbours(point1:Point,point2:Point):Boolean {
				var neighbours:Boolean = false;
				
				if (point1.x == point2.x && Math.abs(point1.y - point2.y) == 1) {
					neighbours = true;
					}
				else if (point1.y == point2.y && Math.abs(point1.x - point2.x) == 1) {
					neighbours = true;
					}
								
				return neighbours;
		}
		
		public function areSameColored():Boolean {
			var p1:Point = firstSelectedGem;
			var p2:Point = secondSelectedGem;
			var same:Boolean = false;
			same = ((gemMatrix[p1.x][p1.y] as GemVO).type == (gemMatrix[p2.x][p2.y] as GemVO).type);
			return same;
			}
		
		public function checkWinningLines():void {
			
			actWinningLines = null;
			fallObjects = null;
			resetGemDatas();
			
			var winGemLinesArray:Array = new Array();
			
			
			// create changed matrix
			var changedMatrix:Array = new Array();
			changedMatrix = cloneMatrix(gemMatrix);
			changedMatrix[secondSelectedGem.x][secondSelectedGem.y] = gemMatrix[firstSelectedGem.x][firstSelectedGem.y];
			changedMatrix[firstSelectedGem.x][firstSelectedGem.y] = gemMatrix[secondSelectedGem.x][secondSelectedGem.y];
			
			//A
				//winGemLinesArray = checkGem(changedMatrix, firstSelectedGem);
			//B
				//winGemLinesArray = winGemLinesArray.concat(checkGem(changedMatrix, secondSelectedGem));
				
			winGemLinesArray = checkGem2(changedMatrix);
			
			// there is win
			if(winGemLinesArray.length > 0){
				gemMatrix = cloneMatrix(changedMatrix);
				addWinPoints(winGemLinesArray);
				actWinningLines = winGemLinesArray;
				createFallObjects();
				
				dispatch(new GemGameEvent(GemGameEvent.CONFIRM_GEM_CHANGE));
			}
			// there s no win
			else
				dispatch(new GemGameEvent(GemGameEvent.UNDO_GEM_CHANGE));
		}
		
		public function checkWinningLinesAfterAnim():void {
			var winGemLinesArray:Array = new Array();
			winGemLinesArray = checkGem2(gemMatrix);
			if (winGemLinesArray.length > 0) {
				addWinPoints(winGemLinesArray);
				actWinningLines = winGemLinesArray;
				createFallObjects();
				dispatch(new GemGameEvent(GemGameEvent.AFTER_WIN));
				}
			
			}
		
		private function checkGem(matrix:Array, positon:Point):Array { 
			var from:int;
			var till:int;
			var runner:int;
			var typeToCompare:String = (matrix[positon.x][positon.y] as GemVO).type;
			var tempType:String;
			var winLines:Array = new Array();
			var resultCount:int = 0;
			
			
			
		// vertical check			
			from = positon.y;
			var vertWinLine:WinGemLine = new WinGemLine((matrix[positon.x][positon.y] as GemVO), positon);
			//up
			till = 0;
			for (runner = positon.y - 1; runner >= till; runner--) {
				tempType = (matrix[positon.x][runner] as GemVO).type;
				if (tempType == typeToCompare) 
					{
						vertWinLine.addWinNode(new Point(positon.x, runner));
						//(matrix[positon.x][runner] as GemVO).toDestroy = true;
					}
				else
					break;	
			}
			//down
			till = ConfigModel.rowCount;
			for (runner = positon.y + 1; runner < till; runner++) {
				tempType = (matrix[positon.x][runner] as GemVO).type;
				if (tempType == typeToCompare) 
					{
						vertWinLine.addWinNode(new Point(positon.x, runner));							
						//(matrix[positon.x][runner] as GemVO).toDestroy = true;
					}
				else
					break;			
			}	
			if (vertWinLine.lineLength > 2)
				winLines.push(vertWinLine);
				
		// horizontal check
			from = positon.x;
			var horWinLine:WinGemLine = new WinGemLine((matrix[positon.x][positon.y] as GemVO), positon);
			// left
			till = 0;
			var tempWinLineLeft:WinGemLine = new WinGemLine((matrix[positon.x][positon.y] as GemVO), positon);
			for (runner = positon.x - 1; runner >= till; runner--) {
				tempType = (matrix[runner][positon.y] as GemVO).type;
				if (tempType == typeToCompare) 
					{
						horWinLine.addWinNode(new Point(runner, positon.y));							
						//(matrix[runner][positon.y] as GemVO).toDestroy = true;
					}
				else
					break;	
			}
			//right
			till = ConfigModel.collCount;
			for (runner = positon.x + 1; runner < till; runner++) {
				tempType = (matrix[runner][positon.y]  as GemVO).type; 
				if (tempType == typeToCompare) 
					{
						horWinLine.addWinNode(new Point(runner, positon.y));							
						//(matrix[runner][positon.y] as GemVO).toDestroy = true;
					}
					
					
				else
					break;	
			}
			if (horWinLine.lineLength > 2)
				winLines.push(horWinLine);
		
			return winLines;
		}
		
		private function checkGem2(matrix:Array):Array {
			var winLines:Array = new Array();			
			
			// check verticaly
			var c:int = 0;
			var r:int = 0;
			var tempLine:Array = new Array();
			var tempWinLine:WinGemLine;
			for (c = 0; c < ConfigModel.collCount; c++ ) {
				tempLine = new Array();
				for (r = 1; r < ConfigModel.rowCount; r++) { 
					if ((matrix[c][r] as GemVO).typeIndex == (matrix[c][r - 1] as GemVO).typeIndex)
						{	
							if (tempLine.length == 0)
								{
									tempLine.push(matrix[c][r - 1]);
									tempWinLine = new WinGemLine(matrix[c][r - 1], new Point(c, r - 1));
								}

							tempLine.push(matrix[c][r]);
							tempWinLine.addWinNode(new Point(c, r));
							
							if (r == ConfigModel.rowCount - 1 && tempLine.length > 2)
								{
									
									winLines.push(tempWinLine);								
								}
						}	
					else {
						if (tempLine.length > 2)
							{
								winLines.push(tempWinLine);
								
							}
						tempLine = new Array();
						if(r < ConfigModel.rowCount - 1)
							tempWinLine = new WinGemLine(matrix[c][r + 1], new Point(c, r + 1));
						}
					}
					
				}
			
			/// checkHorizontaly
			for (r = 0; r < ConfigModel.rowCount; r++ ) {
				tempLine = new Array();
				for (c = 1; c < ConfigModel.collCount; c++) { 
					if ((matrix[c][r] as GemVO).typeIndex == (matrix[c - 1][r] as GemVO).typeIndex)
						{
							if (tempLine.length == 0)
								{
									tempLine.push(matrix[c - 1][r]);
									tempWinLine = new WinGemLine(matrix[c - 1][r], new Point(c - 1, r));
								}
							tempLine.push(matrix[c][r]);
							tempWinLine.addWinNode(new Point(c, r));
							
							if (c == ConfigModel.collCount - 1 && tempLine.length > 2)
								{
									winLines.push(tempWinLine);
								
								}
						}
					else {
						if (tempLine.length > 2)
							{
								winLines.push(tempWinLine);
							
							}
						tempLine = new Array();
						if(c < ConfigModel.collCount - 1)
							tempWinLine = new WinGemLine(matrix[c + 1][r], new Point(c + 1, r));
						}				
					}
					
				}
				
			return winLines;
			}
			
		private function convertGemVoArrayToWinLine(gemVOs:Array,startPoint:Point):WinGemLine {
			var winLine:WinGemLine;
			winLine = new WinGemLine(gemVOs[0] as GemVO, startPoint);
			for (var i:int = 1; i < gemVOs.length; i++ ) {
				//winLine.addWinNode(new Point(
				}
			return winLine;
			}
		
		private function addWinPoints(winLines:Array):void {
			var p:int = gamePoint;
			for (var i:String in winLines) {
				p += (winLines[i] as WinGemLine).winValue;
				}
			gamePoint = p;
			}
		
		private function createFallObjects():void {
			var tempFallObjects:Array = new Array();
			
			for (var i :String in actWinningLines) {
				for (var j:String in (actWinningLines[i] as WinGemLine).gemNodes) {
					var x:int = ((actWinningLines[i] as WinGemLine).gemNodes[j] as Point).x;
					var y:int = ((actWinningLines[i] as WinGemLine).gemNodes[j] as Point).y;
					gemMatrix[x][y].toDestroy = true;
					}
				}
		
			for (var c:int = 0;  c < gemMatrix.length; c++ ) {
				var tempFallVO:FallVO = new FallVO();
				tempFallVO.collIndex = c;
				for (var r:int = 0; r < gemMatrix[c].length; r++ ) {		
					if ((gemMatrix[c][r] as GemVO).toDestroy)
						{				                                                        
							var tempGemVO:GemVO = ConfigModel.getRandomGemType();
							tempFallVO.addReplacedNode(r);
							tempFallVO.addReserveGem(tempGemVO);
						}
					}
				if (tempFallVO.length > 0)
					tempFallObjects.push(tempFallVO)
				}
						
			if (tempFallObjects.length > 0){
				
				fallObjects = tempFallObjects;
			
				}
				
			// reindex matrix nodes with reservers
			for (var k:int = 0; k < fallObjects.length; k++) {
				var coll:int = (fallObjects[k] as FallVO).collIndex;
				var distance:int = (fallObjects[k] as FallVO).replacedNodes.length;
				var from:int = (fallObjects[k] as FallVO).replacedNodes[distance - 1];
				var till:int = distance;
				for (var m:int = from; m >= till; m--) {
					var origin:GemVO = gemMatrix[coll][m - distance];
					var clone:GemVO = new GemVO(origin.type, origin.value/10);
					clone.toDestroy = (gemMatrix[coll][m - distance] as GemVO).toDestroy;
					gemMatrix[coll][m] = clone;
				}	
				for (var n:int = 0; n < distance; n++ ) {
					//var tempType:GemVO = ((fallObjects[k] as FallVO).reserveGems[n] as GemVO).type
					//var cloneRes:GemVO = new GemVO(tempType,tempType.value);
					gemMatrix[coll][n] = ((fallObjects[k] as FallVO).reserveGems[n] as GemVO)
					}
				}
			}	
			
		private function cloneMatrix(matrix:Array):Array {
			var returnMatrix:Array = new Array();
			for (var c:int = 0;  c < matrix.length; c++ ) {
				returnMatrix[c] = new Array();
				for (var r:int = 0; r < matrix[c].length; r++ ) {
					(matrix[c][r] as GemVO).type 
					var newGem:GemVO = new GemVO((matrix[c][r] as GemVO).type, (matrix[c][r] as GemVO).value / 10);
					newGem.toDestroy = (matrix[c][r] as GemVO).toDestroy;
					//newGem.instance = (matrix[c][r] as GemVO).instance;
					returnMatrix[c][r] = newGem;
					}
				}
			return returnMatrix;
			}
			
		private function resetGemDatas():void {
			for (var c:int = 0;  c < gemMatrix.length; c++ ) {
				for (var r:int = 0; r < gemMatrix[c].length; r++ ) {
					
					(gemMatrix[c][r] as GemVO).toDestroy = false;
					}
				}
			
			}
			
		public function get gamePoint():int 
			{
				return _gamePoint;
			}
			
		public function set gamePoint(value:int):void 
			{
				_gamePoint = value;
				dispatch(new GemGameEvent(GemGameEvent.GAME_POINT_CHANGED));
			}
			
		public function get gameTime():int 
			{
				return _gameTime;
			}
	}

}