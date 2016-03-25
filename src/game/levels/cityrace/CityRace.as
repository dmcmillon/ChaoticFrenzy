package game.levels.cityrace 
{
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	
	import starling.display.Button;
	import starling.events.Touch;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.KeyboardEvent;		//delete
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import engine.level.ILevel;
	import engine.maths.Vector2D;
	import engine.miscellaneous.ITickable;
	import engine.objectpool.IPoolable;
	import engine.collision.CollisionTester;
	
	import game.levels.AbstractLevel;
	import game.levels.cityrace.player.PlayerCar;
	import game.levels.cityrace.player.PlayerController;
	import game.levels.cityrace.obstacles.Car;
	import game.levels.cityrace.scene.Road;
	import game.levels.LevelManager;
	/**
	 * ...
	 * @author Daniel
	 */
	public class CityRace extends AbstractLevel
	{
		[Embed(source = "../../../../icons/android/cars/BlueCar.png")]
		private static const PlayerCarImage:Class;
		
		[Embed(source = "../../../../icons/android/cars/YellowCar.png")]
		private static const CarImage:Class;
		
		[Embed(source = "../../../../icons/android/road/road.png")]
		private static const RoadImage:Class;
		
		private var _playerCar:PlayerCar;
		private var _playerController:PlayerController;
		
		private var _road:Road;
		
		private var _tickables:Vector.<ITickable>;
		
		private var _accelerometer:Accelerometer;
		
		private var _cars:Vector.<Car>;
		
		//private var _obstacles:Vector.<IPoolable>;
		
		public function CityRace() 
		{
			
		}
		
		/* INTERFACE engine.levels.ILevel */
		
		override public function setup():void 
		{
			super.setup();
			
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			_accelerometer = new Accelerometer();
			
			var _carScale:Point = new Point(0.15, 0.15);
			
			_cars = new Vector.<Car>(4);
			
			//TODO: Add an event listener to listen for when car is no longer on screen and then free up that car.
			_cars[0] = new Car(Texture.fromEmbeddedAsset(CarImage), _carScale);
			_cars[1] = new Car(Texture.fromEmbeddedAsset(CarImage), _carScale);
			_cars[2] = new Car(Texture.fromEmbeddedAsset(CarImage), _carScale);
			_cars[3] = new Car(Texture.fromEmbeddedAsset(CarImage), _carScale);
			
			for ( var carsIndex:int = 0; carsIndex < _cars.length; carsIndex++ )
			{
				_cars[carsIndex].addEventListener(Road.REMOVED_FROM_SCENE, onRemovedFromScreen);
			}
		}
		
		override public function resume():void 
		{
			super.resume();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_accelerometer.addEventListener(AccelerometerEvent.UPDATE, onAccelerometerChanged);
		}
		
		override public function pause():void 
		{
			super.pause();
			//TODO: delete
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_accelerometer.removeEventListener(AccelerometerEvent.UPDATE, onAccelerometerChanged);
		}
		
		private var addCarTimer:Number = 5.0;
		private var addPotholeTimer:Number = 3.0;
		
		override public function tick(deltaTime:Number):void
		{
			_road.y += _playerCar.speed * deltaTime;
			
			addCarTimer += deltaTime;
			addPotholeTimer += deltaTime;
			
			if ( Math.random() < .25 && addCarTimer > 1 )
			{
				addCarTimer = 0.0;
				
				var _car:Car = null;
				
				for ( var _carsIndex:int = 0; _carsIndex < _cars.length; _carsIndex++ )
				{
					if ( _cars[_carsIndex].isFree() )
					{
						_car = _cars[_carsIndex];
						_car.take();
						
						break;
					}
				}
				
				if ( _car != null )
				{
					_road.addObstacle(_car);
				}
			}
			
			for ( var checkCollisionIndex:int = 0; checkCollisionIndex < _cars.length; checkCollisionIndex++ )
			{
				if ( _cars[checkCollisionIndex].isFree() )
				{
					continue;
				}
				
				if ( CollisionTester.AABBvsAABBCollisionCheck(_playerCar.aabb, _cars[checkCollisionIndex].aabb) )
				{
					//Level Ends
					dispatchEventWith(LevelManager.LEVEL_COMPLETED);
					
					_tickables.splice(0, _tickables.length);
					_playerCar.speed = 0;
				}
			}
			
			for ( var x:int = 0; x < _tickables.length; x++ )
			{
				_tickables[x].tick(deltaTime);
			}
			
			super.tick(deltaTime);
		}
		
		override public function teardown():void 
		{
			super.teardown();
			trace(teardown);
		}
		//--------------------------------//
		
		private function onInit():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			var playerScale:Point = new Point(0.15, 0.15);
			var rotation:Number = deg2rad(-90);
			var position:Vector2D = new Vector2D(0, -(stage.stageHeight / 5));
			
			_playerCar = new PlayerCar(Texture.fromEmbeddedAsset(PlayerCarImage), position, playerScale, rotation);
			
			_road = new Road(Texture.fromEmbeddedAsset(RoadImage), 2);
			_road.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			_road.x = stage.stageWidth >> 1;
			_road.y = stage.stageHeight;
			addChild(_road);
			
			_road.addChild(_playerCar);
			
			_playerController = new PlayerController(_playerCar);
			
			_tickables = new Vector.<ITickable>();
			_tickables.push(_playerController);
			_tickables.push(_road);
		}
		
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//TODO: delete
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onAccelerometerChanged(event:AccelerometerEvent):void
		{
			_playerCar.strafe(-event.accelerationX);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if ( event.keyCode == 37 )
			{
				_playerCar.strafe(-0.5);
			}
			else if ( event.keyCode == 39 )
			{
				_playerCar.strafe(0.5);
			}
		}
		
		private function onRemovedFromScreen(event:Event):void
		{
			(IPoolable)(event.target).release();
		}
	}
}