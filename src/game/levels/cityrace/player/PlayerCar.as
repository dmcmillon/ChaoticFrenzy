package game.levels.cityrace.player 
{
	import engine.collision.AABB;
	import engine.maths.Vector2D;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.Event;
	/**
	 * ...
	 * @author Daniel
	 */
	//TODO: convert to image
	public class PlayerCar extends Sprite
	{
		public static const STRAFE:String = "strafe";
		
		public static const RIGHT:int = 1;
		public static const LEFT:int = -1;
		
		public var speed:int = 500;
		
		private var _strafeSpeed:int = 445;
		
		private const MAX_SPEED:int = 800;
		
		private var image:Image;
		
		private var _aabb:AABB;
		private var _collisionOffset:int = 5;
		
		public function get strafeSpeed():int
		{
			return _strafeSpeed;
		}
		
		public function get aabb():AABB
		{
			_aabb.min = new Point(x + _collisionOffset, y + _collisionOffset);
			_aabb.max = new Point(x + width - _collisionOffset, y + height - _collisionOffset);
			
			return _aabb;
		}
		
		public function get MaxSpeed():int
		{
			return MAX_SPEED;
		}
		
		public function PlayerCar(texture:Texture, position:Vector2D, scale:Point, rotation:Number) 
		{
			image = new Image(texture);
			addChild(image);
			
			alignPivot();
			
			x = position.X;
			y = position.Y;
			
			scaleX = scale.x;
			scaleY = scale.y;
			
			this.rotation = rotation;
			
			_aabb = new AABB();
		}
		
		//TODO: possibly change direction to int
		public function strafe(direction:Number):void
		{
			dispatchEventWith(STRAFE, false, direction);
		}
	}
}