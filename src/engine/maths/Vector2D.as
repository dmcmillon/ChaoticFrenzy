package engine.maths 
{
	/**
	 * ...
	 * @author Daniel
	 */
	
	 //TODO: test class
	public class Vector2D 
	{
		private var x:Number;
		private var y:Number;
		
		public function Vector2D(x:Number = 0, y:Number = 0.0) 
		{
			this.x = x;
			this.y = y;
		}
			
		public function get X():Number
		{
			return x;
		}
		
		public function get Y():Number
		{
			return y;
		}
		
		public function add(vector:Vector2D):Vector2D
		{
			return new Vector2D(x + vector.x, y + vector.y);
		}
		
		public function subtract(vector:Vector2D):Vector2D
		{
			return new Vector2D(x - vector.x, y - vector.y);
		}
		
		public function mutliply(scalar:Number):Vector2D
		{
			return new Vector2D(x * scalar, y * scalar);
		}
		
		public function normalize():void
		{
			var mag:Number = magnitude();
			
			x /= mag;
			y /= mag;
		}
		
		public function magnitude():Number
		{
			return Math.sqrt(x * x + y * y);
		}
		
		public function magnitudeSquared():Number
		{
			return x * x + y * y;
		}
		
		public function toString():String
		{
			return "X: " + x.toString() + ", Y: " + y.toString();
		}
	}
}