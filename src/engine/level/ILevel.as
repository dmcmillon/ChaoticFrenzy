package engine.level 
{
	import engine.miscellaneous.ITickable;
	
	/**
	 * ...
	 * @author Daniel
	 */
	public interface ILevel extends ITickable
	{
		function setup():void;
		function resume():void;
		function pause():void;
		function teardown():void;
	}
}