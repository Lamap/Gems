package miner.models 
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class UserModel extends Actor 
	{
		private var _userPoint:int = 0;
		
		public function UserModel() 
		{
			
		}
		
		public function get userPoint():int 
		{
			return _userPoint;
		}
		
		public function set userPoint(value:int):void 
		{
			_userPoint = value;
		}
		
	}

}