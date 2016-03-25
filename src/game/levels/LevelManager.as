package game.levels 
{
	import engine.miscellaneous.ITickable;
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	import starling.events.Event;
	/**
	 * ...
	 * @author Daniel
	 */
	public class LevelManager extends Sprite implements ITickable
	{
		public static const LEVEL_COMPLETED:String = "levelCompleted";
		public static const SWITCH_LEVEL:String = "switchLevel";
		
		private var levels:Vector.<AbstractLevel>;
		private var currentLevelIndex:int;
		
		private var totalScore:int;
		
		public function LevelManager() 
		{
			levels = new Vector.<AbstractLevel>();
		}
		
		public function addLevel(level:AbstractLevel):void
		{
			level.setup();
			
			level.addEventListener(LEVEL_COMPLETED, onLevelCompleted);
			level.addEventListener(SWITCH_LEVEL, onLevelSwitch);
			
			levels.push(level);
		}
		
		public function tick(deltaTime:Number):void
		{
			if ( currentLevelIndex < levels.length )
			{
				levels[currentLevelIndex].tick(deltaTime);
			}
		}
			
		public function startGame():void
		{
			nextLevel();
		}
		
		private function pauseCurrentLevel():void
		{
			levels[currentLevelIndex].pause();
			removeChild(levels[currentLevelIndex]);
		}
		
		private function removeCurrentLevel():void
		{
			levels[currentLevelIndex].teardown();
			levels.splice(currentLevelIndex, 1);
		}
		
		private function nextLevel():void
		{
			chooseLevel();
			levels[currentLevelIndex].resume();
			addChild(levels[currentLevelIndex]);
		}
		
		private function chooseLevel():void 
		{
			currentLevelIndex = Math.floor(Math.random() * levels.length);
		}
		
		private function onLevelCompleted(event:Event):void
		{
			var level:AbstractLevel = event.target as AbstractLevel;
			totalScore += level.score;
			
			pauseCurrentLevel();
			removeCurrentLevel();
			
			if ( levels.length > 0 )
			{
				nextLevel();
			}
		}
		
		private function onLevelSwitch(event:Event):void
		{
			pauseCurrentLevel();
			nextLevel();
		}
		
		private function onLevelResumed(event:Event):void
		{
			
		}
		
		private function onLevelPaused():void
		{
			
		}
	}
}