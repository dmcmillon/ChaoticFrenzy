package engine.collision 
{
	/**
	 * ...
	 * @author Daniel
	 */
	public class CollisionTester
	{		
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