package game 
{
	import game.levels.addition.AdditionGame;
	import game.levels.flow.Flow;
	import game.levels.LevelManager;
	import game.levels.cityrace.CityRace;
	import game.levels.patternmatch.PatternMatch;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * The Game class.
	 * @author Daniel
	 */
	public class ChaoticFrenzy extends Sprite
	{
		private var levelManager:LevelManager;
		
		public function ChaoticFrenzy() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			levelManager = new LevelManager();
			levelManager.addLevel(new CityRace());
			levelManager.addLevel(new AdditionGame());
			//levelManager.addLevel(new Flow());
			levelManager.addLevel(new PatternMatch());
			
			levelManager.startGame();
			addChild(levelManager);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Called once per frame to update the game.
		 * @param	event			
		 * @param	passedTime
		 */
		private function onEnterFrame(event:Event, passedTime:Number):void
		{
			levelManager.tick(passedTime);
		}	
	}
}