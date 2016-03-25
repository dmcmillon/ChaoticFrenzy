package game.levels.collectcircles 
{
	import starling.events.Event;
	import game.levels.AbstractLevel;
	/**
	 * Object of game is to collect x number of green circles. The red circles turn green circles red when they collide. 
	 * @author Daniel
	 */
	public class CollectCircles extends AbstractLevel
	{
		private var numberOfRedCircles:int;
		private var numberOfGreenCircles:int;
		
		private var lives:int = 3;
		
		private var timeForNewCircle:Number;
		private var timer:Number;
		
		public function CollectCircles() 
		{
			
		}
		
		/* INTERFACE engine.levels.ILevel */
		
		override public function setup():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override public function resume():void 
		{
			
		}
		
		override public function pause():void 
		{
			
		}
		
		override public function tick(deltaTime:Number):void
		{
			
		}
		
		override public function teardown():void 
		{
			
		}
		//--------------------------------//
		
	}

}