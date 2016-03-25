package engine.objectpool 
{
	
	/**
	 * ...
	 * @author Daniel
	 */
	public interface IPoolable 
	{
		function isFree():Boolean;
		function release():void;
		function take():void;
	}
	
}