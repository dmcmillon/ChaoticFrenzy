package engine.collision 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniel
	 */
	public class AABB 
	{
		public var min:Point;
		public var max:Point;
		
		public function AABB(min:Point = null, max:Point = null) 
		{
			this.min = ( min != null ) ? min : new Point();
			this.max = ( max != null ) ? max : new Point();
		}
	}
}