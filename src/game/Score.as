package game 
{
	/**
	 * ...
	 * @author Daniel
	 */
	public class Score 
	{
		private static var _score:int;
		
		public static function set score(amount:int):void
		{
			_score += amount;
		}
		
		public static function get score():int
		{
			return _score;
		}
		
		public function Score() 
		{
			
		}
		
	}
}