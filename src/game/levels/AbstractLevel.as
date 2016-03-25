package game.levels 
{
	import engine.level.ILevel;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Daniel
	 */
	//TODO: Add a win and lose animation. Win animation will say success, and lose animation will be a flashing transparent red overlay.
	public class AbstractLevel extends Sprite implements ILevel
	{
		protected const MAX_LEVEL_PLAY_TIME:Number = 4.0;
		
		protected var switchLeveltimer:Number;
		protected var currentLevelPlayTime:Number;
		protected var timerVariable:Number = 2;
		
		protected var _score:int;
		
		public function get score():int
		{
			return _score;
		}
		
		public function AbstractLevel() 
		{
			switchLeveltimer = 0.0;
			currentLevelPlayTime = MAX_LEVEL_PLAY_TIME - (rand() * timerVariable);
		}
		
		/* INTERFACE engine.levels.ILevel */
		
		//TODO: Throw some exceptions if this class is instantiated.
		public function setup():void 
		{
			
		}
		
		public function resume():void 
		{
			currentLevelPlayTime = MAX_LEVEL_PLAY_TIME - (rand() * timerVariable);
		}
		
		public function pause():void 
		{
			
		}
		
		public function tick(deltaTime:Number):void
		{
			switchLeveltimer += deltaTime;
			
			if ( switchLeveltimer > currentLevelPlayTime )
			{
				dispatchEventWith(LevelManager.SWITCH_LEVEL);
				
				switchLeveltimer = 0.0;
				currentLevelPlayTime = MAX_LEVEL_PLAY_TIME - (rand() * timerVariable);
			}
		}
		
		public function teardown():void 
		{
			
		}
		//--------------------------------//
		
		private function rand():Number
		{
			return Math.random() - Math.random();
		}
	}

}