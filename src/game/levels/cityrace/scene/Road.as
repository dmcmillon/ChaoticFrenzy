package game.levels.cityrace.scene 
{
	import engine.miscellaneous.ITickable;
	
	import game.levels.cityrace.obstacles.Car;
	import game.levels.cityrace.obstacles.CarController;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Daniel
	 */
	public class Road extends Sprite implements ITickable
	{
		public static const REMOVED_FROM_SCENE:String = "removedFromScene";
		
		private var texture:Texture;
		
		private var numberOfLanes:int;
		
		private var laneWidth:Number;
		
		private var xLocation:Number
		private var yLocation:Number;
		private var xScale:Number;
		private var yScale:Number;
		
		private var images:Vector.<Image>;
		
		private var bottomRoadIndex:int = 0;
		
		//TODO: Move car controller to CityRace class.
		private var _carController:CarController;
		
		private var _obstacles:Vector.<DisplayObject>;
		
		private var _previousLane:int;
		private var _lanePercentage:Number = 0.5;
		
		public function Road(texture:Texture, numberOfLanes:int) 
		{
			this.texture = texture;
			
			images = new Vector.<Image>();
			
			this.numberOfLanes = numberOfLanes;
			
			_carController = new CarController(numberOfLanes, laneWidth);
			
			_obstacles = new Vector.<DisplayObject>();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function tick(deltaTime:Number):void
		{
			if ( y + images[bottomRoadIndex].y - images[bottomRoadIndex].height > stage.stageHeight)
			{
				images[bottomRoadIndex].y -= images.length * images[bottomRoadIndex].height;
				bottomRoadIndex = (bottomRoadIndex + 1) % images.length;
			}
			
			for ( var obstaclesIndex:int = 0; obstaclesIndex < _obstacles.length; obstaclesIndex++ )
			{
				if ( _obstacles[obstaclesIndex].y > -y + stage.stageHeight + _obstacles[obstaclesIndex].height ) 
				{
					var obstacle:Car = _obstacles[obstaclesIndex] as Car;
					
					_obstacles.splice(obstaclesIndex, 1);
					obstacle.dispatchEventWith(Road.REMOVED_FROM_SCENE);
					removeChild(obstacle);
					_carController.removeCar(obstacle);
				}
			}
			
			_carController.tick(deltaTime);
		}
	
		//TODO: Scale car inside its class or pass scale values to its constructor when the object is created.
		public function addObstacle(obstacle:DisplayObject):void
		{
			var lane:int = chooseLane();
			
			obstacle.x = getXPosition(lane);
			obstacle.y = -y - obstacle.height;
			
			if ( obstacle is Car )
			{
				var car:Car = obstacle as Car;
				car.lane = lane;
				car.direction = Car.UP_DIRECTION;
				//car.direction = ( lane <= (numberOfLanes >> 1) ) ? Car.DOWN_DIRECTION : Car.UP_DIRECTION;
				_carController.addCar(car);
			}
			
			_obstacles.push(obstacle);
			addChild(obstacle);
			
			_previousLane = lane;
		}
		
		private function getXPosition(lane:int):Number
		{
			return (lane - (numberOfLanes >> 1)) * laneWidth - (laneWidth >> 1);
		}
		
		//TODO: Determine lanes of several previous cars and adjust percentage of being in that lane.
		private function chooseLane():int
		{
			if ( _previousLane == 1 )
			{
				_lanePercentage -= 0.15;
				_lanePercentage = Math.max(_lanePercentage, 0);
			}
			else
			{
				_lanePercentage += 0.15;
				_lanePercentage = Math.min(_lanePercentage, 1);
			}
			
			return  Math.random() < _lanePercentage ? 1 : 2;
		}
		
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			yLocation = stage.stageHeight;
			xScale = 1.5;
			yScale = 1.5;
			
			build();
			
			laneWidth = width / numberOfLanes;
		}
		
		private function build():void
		{
			
			//TODO: Create one image and pass to addImageToRoad().
			while ( yLocation > 0 )
			{
				addImageToRoad();
			}
			
			addImageToRoad();
		}
		
		private function addImageToRoad():void
		{
			var image:Image = new Image(texture);
			image.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			image.y = yLocation;
			image.scaleX = xScale;
			image.scaleY = yScale;
			
			addChild(image);
			
			images.push(image);
			
			yLocation -= image.height;
		}
	}
}