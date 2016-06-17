package engine.miscellaneous 
{
	
	/**
	 * Interface for updateable objects.
	 * @author Daniel
	 */
	public interface ITickable 
	{
		/**
		 * Called every frame.
		 * @param	deltaTime - The time that has passed since the last call to the tick method.
		 */
		function tick(deltaTime:Number):void;
	}
	
}