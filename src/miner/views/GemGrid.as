package miner.views
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Circ;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import miner.models.ConfigModel;
	import miner.models.FallVO;
	import miner.models.GemVO;
	import miner.models.WinGemLine;
	import miner.utils.GemGameEvent;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GemGrid extends MovieClip
	{
		private var colls:Array;
		private var gemItems:Array;
		private var matrix:Array;
		private var maskArea:Sprite;
		
		public function GemGrid()
		{
			
		}
		
		// init only when added to stage
		public function init(p_matrix:Array):void
		{
			matrix = p_matrix;
			colls = new Array();
			gemItems = new Array();
			
			for (var c:int = 0; c < p_matrix.length; c++)
			{
				gemItems[c] = new Array()
				for (var r:int = 0; r < p_matrix[c].length; r++)
				{
					var tempGem:Gem = new Gem(p_matrix[c][r] as GemVO);
					tempGem.x = c * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
					tempGem.y = r * (ConfigModel.gridHeight + ConfigModel.gridVerticalGap);
					tempGem.rowIndex = r;
					tempGem.collIndex = c;
					gemItems[c][r] = tempGem;
					addChild(tempGem);
				}
			}
			
			addMask();
		}
		
		// masking gems
		private function addMask():void {
			var mWidth:int = ConfigModel.collCount * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap)
			var mHeight:int = ConfigModel.rowCount * (ConfigModel.gridHeight + ConfigModel.gridVerticalGap);
			
			maskArea = new Sprite();
			maskArea.graphics.beginFill(0xFF0000);			
			maskArea.graphics.drawRect(0, 0, mWidth , mHeight );
			maskArea.graphics.endFill();
			
			addChild(maskArea);
			this.mask = maskArea;		
			}
			
		// changing gems
		public function changeGems(gem1:Point, gem2:Point):void
		{
			var gemItem1:Gem = gemItems[gem1.x][gem1.y]
			var gemItem2:Gem = gemItems[gem2.x][gem2.y]
			
			var gem1_Xto:int = gem2.x * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			var gem1_Yto:int = gem2.y * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			TweenLite.to(gemItem1, ConfigModel.gemChangeDuration, {x: gem1_Xto, y: gem1_Yto, ease: Back.easeInOut, onComplete: onChangeGemsCompleted})
			
			var gem2_Xto:int = gem1.x * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			var gem2_Yto:int = gem1.y * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			TweenLite.to(gemItem2, ConfigModel.gemChangeDuration, {x: gem2_Xto, y: gem2_Yto, ease: Back.easeInOut})
			
		}
		
		// send out event when the change-in animation is ready
		public function onChangeGemsCompleted():void {
			dispatchEvent(new GemGameEvent(GemGameEvent.CHANGE_ANIMATION_COMPLETED));
			}
			
		// change back if no win	
		public function changeGemsBack(gem1:Point, gem2:Point):void
		{
			var gemItem1:Gem = gemItems[gem1.x][gem1.y]
			var gemItem2:Gem = gemItems[gem2.x][gem2.y]
			var gem1_Xto:int = gem1.x * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			var gem1_Yto:int = gem1.y * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			TweenLite.to(gemItem1, ConfigModel.gemChangeDuration, {x: gem1_Xto, y: gem1_Yto, ease: Circ.easeInOut})
			
			var gem2_Xto:int = gem2.x * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			var gem2_Yto:int = gem2.y * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			TweenLite.to(gemItem2, ConfigModel.gemChangeDuration, {x: gem2_Xto, y: gem2_Yto, ease: Circ.easeInOut})
		}
		
		// change coll and row index if change is confirmed	
		public function changeGemsIndex(firstNode:Point,secondNode:Point, p_matrix:Array):void {
			matrix = p_matrix;
			var firstGem:Gem = new Gem(matrix[firstNode.x][firstNode.y]) // gemItems[firstNode.x][firstNode.y];
			var secondGem:Gem = new Gem(matrix[secondNode.x][secondNode.y]);// gemItems[secondNode.x][secondNode.y]
			
			// horizontal change
			if (firstNode.y == secondNode.y) {
				trace("h");
				
				}
			// vertical change
			else {
				trace("v");
				}
			
			removeChild(gemItems[firstNode.x][firstNode.y]);	
			removeChild(gemItems[secondNode.x][secondNode.y])	
			gemItems[firstNode.x][firstNode.y] = null;
			gemItems[secondNode.x][secondNode.y] = null;
			
			gemItems[firstNode.x][firstNode.y] = firstGem;//secondGem;
			(gemItems[firstNode.x][firstNode.y] as Gem).collIndex = firstNode.x;
			(gemItems[firstNode.x][firstNode.y] as Gem).rowIndex = firstNode.y;
			
			gemItems[secondNode.x][secondNode.y] = secondGem;//firstGem;
			(gemItems[secondNode.x][secondNode.y] as Gem).collIndex = secondNode.x;
			(gemItems[secondNode.x][secondNode.y] as Gem).rowIndex = secondNode.y;
			
			addChild(gemItems[firstNode.x][firstNode.y]);
			addChild(gemItems[secondNode.x][secondNode.y]);
			
			
			
			}
			
		// make all updated gems fall	
		public function fallColls(fallObjects:Array, updatedGemMatrix:Array):void {
			matrix = updatedGemMatrix;
			var delay:Number = 0;
			for (var i:String in fallObjects) {
				var c:int = (fallObjects[i] as FallVO).collIndex;
				var till:int = (fallObjects[i] as FallVO).replacedNodes.pop();
				var drop:int = (fallObjects[i] as FallVO).length * (ConfigModel.gridHeight + ConfigModel.gridVerticalGap);
				var additionalDelay:Number = 0;
				for (var r:int = 0;r <= till ; r++) {
					removeChild(gemItems[c][r]);
					gemItems[c][r] = null;
					
					var tempGem:Gem = new Gem(matrix[c][r]);
					tempGem.collIndex = c;
					tempGem.rowIndex = r;
					
					tempGem.x = c * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
					tempGem.y = (r - (fallObjects[i] as FallVO).length)  * (ConfigModel.gridHeight + ConfigModel.gridVerticalGap);
					gemItems[c][r] = tempGem;
					addChild(tempGem);
					
					TweenLite.to(tempGem, 0.5, {y: String(drop), onComplete: on1stFallCompleted, onCompleteParams: [c,r], ease: Bounce.easeOut, delay:delay + additionalDelay})
					additionalDelay += 0.01
					}
					delay += 0.06
				}
			
			}
			
		private function on1stFallCompleted(c:int,r:int):void 
			{
				dispatchEvent(new GemGameEvent(GemGameEvent.All_GEM_ANIM_FINISHED));
			}
			
		// win animation for winlines	
		public function addWinAnim(winningLines:Array):void 
			{
				
				for (var i:String in winningLines) {
					var winValue:int = (winningLines[i] as WinGemLine).winPerNode;
					for (var j:String in (winningLines[i] as WinGemLine).gemNodes) {
						var c:int = (winningLines[i] as WinGemLine).gemNodes[j].x;
						var r:int = (winningLines[i] as WinGemLine).gemNodes[j].y;
						var tempWinText:WinText = new WinText();
						tempWinText.winValue.text = winValue.toString();
						tempWinText.x = c * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap) + ConfigModel.gridWidth / 2;
						tempWinText.y = r * (ConfigModel.gridHeight + ConfigModel.gridVerticalGap) + ConfigModel.gridHeight / 2;
						addChild(tempWinText);
						
						TweenLite.to(tempWinText, 2, { alpha:0, scaleX:3, scaleY:3, onComplete:onWinAnimCompleted, onCompleteParams:[tempWinText] } );
						}
					}				
			}
			
		private function onWinAnimCompleted(target:WinText):void 
			{
				removeChild(target);
				target = null;
			}
	}

}