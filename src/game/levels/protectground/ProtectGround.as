package game.levels.protectground 
{
	import starling.events.Event;
	import game.levels.AbstractLevel
	/**
	 * ...
	 * @author Daniel
	 */
	public class ProtectGround extends AbstractLevel 
	{
		
		public function ProtectGround() 
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