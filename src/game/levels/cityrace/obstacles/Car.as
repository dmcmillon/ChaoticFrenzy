package game.levels.cityrace.obstacles 
{
	import engine.collision.AABB;
	import engine.objectpool.IPoolable;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author Daniel
	 */
	public class Car extends Sprite implements IPoolable
	{
		public static const UP_DIRECTION:int = -1;
		public static const DOWN_DIRECTION:int = 1;
		
		public var isChangingLanes:Boolean = false;
		
		private var _direction:int = UP_DIRECTION;
		private var _lane:int;
		
		private var _image:Image;
		
		private var _free:Boolean = true;
		
		private var _aabb:AABB;
		private var _collisionOffset:int = 5;
		
		public function get aabb():AABB
		{
			_aabb.min = new Point(x + _collisionOffset, y + _collisionOffset);
			_aabb.max = new Point(x + width - _collisionOffset, y + height - _collisionOffset);
			
			return _aabb;
		}
		
		public function get lane():int
		{
			return _lane;
		}
		
		public function set lane(carLane:int):void
		{
			_lane = carLane;
		}
		
		public function get direction():int
		{
			return _direction;
		}
		
		public function set direction(facingDirection:int):void
		{
			if ( facingDirection != UP_DIRECTION && facingDirection != DOWN_DIRECTION )
			{
				throw new Error("Facing direction must be 1 or -1!");
			}
			
			_direction = facingDirection;
			rotation = (_direction == DOWN_DIRECTION) ? deg2rad(90) : deg2rad( -90);
		}
		
		public function Car(texture:Texture, scale:Point) 
		{
			_image = new Image(texture);
			addChild(_image);
			
			alignPivot();
			
			scaleX = scale.x;
			scaleY = scale.y;
			
			_aabb = new AABB();
		}
		
		public function isFree():Boolean
		{
			return _free;
		}
		
		public function release():void
		{
			_free = true;
			removeFromParent();
		}
		
		public function take():void
		{
			_free = false;
		}
		
	}

}