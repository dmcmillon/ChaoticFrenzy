package game.levels.patternmatch.animation 
{
	import engine.animation.Animation;
	import starling.events.EventDispatcher;
	import engine.animation.AnimationPlayer;
	
	import game.levels.patternmatch.PatternPiece;
	/**
	 * ...
	 * @author Daniel
	 */
	public class HighlightPatternAnimation extends EventDispatcher implements Animation
	{
		private var _patternPieces:Vector.<PatternPiece>;
		private var _pattern:Vector.<int>;
		private var highlightTime:Number = 1;
		private var waitTime:Number = 0.5;
		private var timeBeforePatternShown:Number = 1.5;
		private var timer:Number;
		
		private var index:int = 0;
		
		private var wait:Boolean = true;
		
		public function HighlightPatternAnimation(patternPieces:Vector.<PatternPiece>, pattern:Vector.<int>)
		{
			_patternPieces = patternPieces;
			_pattern = pattern;
		}
		
		public function setup():void
		{
			timer = timeBeforePatternShown;
			//_patternPieces[_pattern[index]].highlight();
		}
		
		public function tick(deltaTime:Number):void
		{
			timer -= deltaTime;
			
			if ( timer <= 0 )
			{
				if ( wait )
				{
					timer = highlightTime;
					wait = false;
					_patternPieces[_pattern[index]].highlight();
				}
				else
				{
					_patternPieces[_pattern[index]].cancelHighlight();
					index++;
					timer = waitTime;
					wait = true;
					
					if ( index >= _pattern.length )
					{
						dispatchEventWith(AnimationPlayer.ANIMATION_COMPLETE);
					}
				}
			}
		}
		
		public function teardown():void
		{
			
		}
	}
}