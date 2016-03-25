package engine.animation 
{
	/**
	 * ...
	 * @author Daniel
	 */
	public interface Transition 
	{
		function setup():void;
		function tick(deltaTime:Number):void;
		function teardown():void;
	}
}