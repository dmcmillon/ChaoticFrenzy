package game.levels.flow 
{
	import game.levels.AbstractLevel;
	
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Daniel
	 */
	public class Flow extends AbstractLevel 
	{
		private var peopleEscape:PeopleEscape;
		
		public function Flow() 
		{
			peopleEscape = new PeopleEscape(8, 8);
		}
		
		/* INTERFACE engine.levels.ILevel */
		
		override public function setup():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override public function resume():void 
		{
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function pause():void 
		{
			removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function tick(deltaTime:Number):void
		{
			
		}
		
		override public function teardown():void 
		{
			
		}
		//--------------------------------//
		
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addChild(peopleEscape);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(peopleEscape, TouchPhase.BEGAN);
			
			if ( touch )
			{
				peopleEscape.onTouch(touch);
			}
		}
	}
}