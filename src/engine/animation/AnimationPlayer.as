package engine.animation 
{
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Daniel
	 */
	public class AnimationPlayer extends EventDispatcher
	{
		public static const ANIMATION_COMPLETE:String = "animationComplete";
		
		private var _currentAnimation:Animation;
		
		private var _animations:Vector.<Animation>;
		
		private var _idleAnimation:Animation;
		
		public function AnimationPlayer() 
		{		
			_animations = new Vector.<Animation>();
		}
		
		public function tick(deltaTime:Number):void
		{
			if ( _currentAnimation != null )
			{
				_currentAnimation.tick(deltaTime);
			}
		}
		
		public function isPlayingAnimation():Boolean
		{
			return (_currentAnimation != null)
		}
		
		public function playAnimation(animation:Animation):void
		{
			_currentAnimation = animation;
			_currentAnimation.addEventListener(ANIMATION_COMPLETE, onAnimationComplete);
			_currentAnimation.setup();
		}
		
		public function addAnimation(animation:Animation):void
		{
			_animations.push(animation);
		}
		
		private function onAnimationComplete():void
		{
			_currentAnimation.teardown();
			_currentAnimation = null;
			
			if ( _idleAnimation != null )
			{
				playAnimation(_idleAnimation);
			}
			
			dispatchEventWith(ANIMATION_COMPLETE);
		}
	}
}