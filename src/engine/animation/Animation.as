package engine.animation 
{
	import engine.event.IEventDispatcher;
	/**
	 * ...
	 * @author Daniel
	 */
	public interface Animation extends IEventDispatcher
	{
		function setup():void;
		function tick(deltaTime:Number):void;
		function teardown():void;
	}
}