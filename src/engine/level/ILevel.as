package engine.level 
{
	import engine.miscellaneous.ITickable;
	
	/**
	 * Interface for levels.
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