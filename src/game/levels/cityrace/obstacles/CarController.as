package game.levels.cityrace.obstacles 
{
	/**
	 * ...
	 * @author Daniel
	 */
	public class CarController 
	{
		private var _speed:Number = 150;
		private var _cars:Vector.<Car>;
		
		private var _numberOfLanes:int;
		private var _laneWidth:Number;
		
		public function CarController(numberOfLanes:int, laneWidth:Number)
		{
			_cars = new Vector.<Car>();
			_numberOfLanes = numberOfLanes;
			_laneWidth = laneWidth;
		}
		
		public function tick(deltaTime:Number):void
		{
			for ( var x:int = 0; x < _cars.length; x++ )
			{
				_cars[x].y += _speed * _cars[x].direction * deltaTime;
				
				if ( Math.random() < 0.05 )
				{
					_cars[x].isChangingLanes = true;
					
					//TODO: Add strafe to cars
					//if ( 
				}
			}
		}
		
		public function addCar(car:Car):void
		{
			_cars.push(car);
		}
		
		public function removeCar(car:Car):void
		{
			for ( var x:int = 0; x < _cars.length; x++ )
			{
				if ( car == _cars[x] )
				{
					_cars.splice(x, 1);
					break;
				}
			}
		}
	}
}