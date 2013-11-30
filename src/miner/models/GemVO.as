package miner.models
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import miner.views.Gem;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GemVO extends EventDispatcher
	{
		private var _value:int;
		private var _type:String;
		private var _toDestroy:Boolean = false;
		private var _typeIndex:int;
		
		//private var _instance:Gem;
		
		public function GemVO(p_type:String, p_typeIndex:int)
		{
			
			_typeIndex = p_typeIndex;
			_type = p_type;
			_value = _typeIndex * 10;
		}
		
		public function get value():int
		{
			return _value;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get toDestroy():Boolean
		{
			return _toDestroy;
		}
		
		public function set toDestroy(value:Boolean):void
		{
			_toDestroy = value;
		}
		
		public function get typeIndex():int 
		{
			return _typeIndex;
		}
		
		public function set typeIndex(value:int):void 
		{
			_typeIndex = value;
		}
		/*
		public function get instance():Gem
		{
			return _instance;
		}
		
		public function set instance(value:Gem):void
		{
			_instance = value;
		}
		*/
	}

}