package engine.animation 
{
	import engine.event.IEventDispatcher;
	/**
	 * Interface for animations.
	 * @author Daniel
	 */
	public interface Animation extends IEventDispatcher
	{
		/** Used to initialize any variables before the animation starts. Method is called once before the animation starts to play */
		function setup():void;
		/** Used to update and play the animation. Method is called once every frame.
		 * @param	deltaTime: The time that has passed since the last call to the method.
		 */
		function tick(deltaTime:Number):void;
		/** Used to clean up animation. Called once after animation has completed. */
		function teardown():void;
	}
}