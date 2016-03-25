package game.levels.cityrace.player 
{
	import engine.miscellaneous.ITickable;
	
	import starling.events.Event;
	/**
	 * ...
	 * @author Daniel
	 */
	public class PlayerController implements ITickable
	{
		private const INCREASE_ACCELERATION_TIME:Number = 1;
		
		private var player:PlayerCar;
		
		private var acceleration:int = 5;
		
		//TODO: possibly change to int
		private var strafe:Number = 0;
		
		private var roadWidth:Number;
		
		private var timer:Number = 0.0;
		
		public function PlayerController(actor:PlayerCar) 
		{
			player = actor;
			
			player.addEventListener(PlayerCar.STRAFE, onPlayerStrafe);
			
			if ( player.parent == null )
			{
				player.addEventListener(Event.ADDED, onPlayerAdded);
			}
			else
			{
				roadWidth = player.parent.width;				
			}
		}
		
		public function tick(deltaTime:Number):void
		{
			var speed:int = player.speed;
			
			timer += deltaTime;
			
			if ( timer >= INCREASE_ACCELERATION_TIME )
			{
				timer = 0.0;
				
				speed += acceleration;
				speed = (speed < player.MaxSpeed) ? speed : player.MaxSpeed;
				player.speed = speed;
			}
			
			player.x += strafe * deltaTime;
			player.y -= speed * deltaTime;
			
			//strafe = 0;
			
			var playerRightBoundary:Number = (roadWidth / 2) - (player.width / 2);
			
			if ( player.x > playerRightBoundary )
			{
				player.x = playerRightBoundary;
			}
			
			var playerLeftBoundary:Number = ( -roadWidth / 2) + (player.width / 2);
			
			if ( player.x < playerLeftBoundary ) 
			{
				player.x = playerLeftBoundary;
			}
		}
		
		private function onPlayerStrafe(event:Event, direction:Number):void
		{
			strafe = player.strafeSpeed * direction;
		}
		
		private function onPlayerAdded():void
		{
			roadWidth = player.parent.width;
		}
	}
}