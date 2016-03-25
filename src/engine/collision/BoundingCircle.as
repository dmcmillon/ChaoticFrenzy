package engine.collision 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel
	 */
	public class BoundingCircle 
	{
		private var _center:Point;
		private var _radius:Number;
		
		public function BoundingCircle(center:Point, radius:Number) 
		{
			_center = center;
			_radius = radius;
		}
		
	}

}