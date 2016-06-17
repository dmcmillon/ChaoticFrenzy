package engine.collision 
{
	/**
	 * Class test for collision between different bounding objects.
	 * @author Daniel
	 */
	public class CollisionTester
	{
		/**
		 * Tests for collision between two Axis-Aligned Bounding Boxes.
		 * @param	aabb1 - Axis-Aligned Bounding Box used in the test.
		 * @param	aabb2 - Axis-Aligned Bounding Box used in the test.
		 * @return  Returns true if there was a collision and false if there was not.
		 */
		public static function AABBvsAABBCollisionCheck(aabb1:AABB, aabb2:AABB):Boolean
		{
			var collision:Boolean = false;
			
			if ( aabb1.min.x < aabb2.max.x && aabb1.max.x > aabb2.min.x && aabb1.min.y < aabb2.max.y && aabb1.max.y > aabb2.min.y )
			{
				collision = true;
			}
		 
			return collision;
		}		
	}
}