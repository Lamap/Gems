package miner.views 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import miner.models.ConfigModel;
	import miner.models.GemVO;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Gem extends Sprite 
	{
		public var gemType:GemVO;
		public var point:int;
		private var _rowIndex:int;
		private var _collIndex:int;
		private var _selected:Boolean;	
		private var image:Bitmap;
		
		public function Gem(p_gemType:GemVO) 
		{
			gemType = p_gemType;		
			init();
		}
		
		public function init():void {
			var w:int = ConfigModel.gridWidth;
			var h:int = ConfigModel.gridHeight;
			
			if (gemType.type == ConfigModel.gemTypeBlue.type)
			{
				image = new Bitmap(new BlueGem(w,h));
			}
			
			else if (gemType.type == ConfigModel.gemTypePurple.type)
			{
				image = new Bitmap(new PurpleGem(w,h));
			}
			else if (gemType.type == ConfigModel.gemTypeYellow.type)
			{
				image = new Bitmap(new YellowGem(w,h));
			}
			else if (gemType.type == ConfigModel.gemTypeGreen.type)
			{
				image = new Bitmap(new GreenGem(w,h));
			}
			else if (gemType.type == ConfigModel.gemTypeRed.type)
			{
				image = new Bitmap(new RedGem(w,h));
			}
			point = gemType.value;
			
			addChild(image);
			
			}
			
		public function focusError():void {
			var errSign:Sprite = new Sprite();
			errSign.graphics.beginFill(0x000000);
			errSign.graphics.drawCircle(ConfigModel.gridWidth / 2, ConfigModel.gridWidth / 2, 8)
			errSign.graphics.endFill();
			addChild(errSign);
			}	
		
		
		public function get rowIndex():int 
		{
			return _rowIndex;
		}
		
		public function set rowIndex(value:int):void 
		{			
			y = value * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			_rowIndex = value;
		}
		
		public function get collIndex():int 
		{
			return _collIndex;
		}
		
		public function set collIndex(value:int):void 
		{
			x = value * (ConfigModel.gridWidth + ConfigModel.gridHorizontalGap);
			_collIndex = value;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			if (value)
				{
					var glowFilter:GlowFilter = new GlowFilter(0xFFFF66,1,12,12);
					filters = [glowFilter];
				}
			else 
				filters = null;
			_selected = value;
		}
		
		public function destroy():void {
			visible = false;
		}
		
	}

}