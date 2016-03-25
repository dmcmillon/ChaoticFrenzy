package game.levels.addition 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	import game.levels.AbstractLevel;
	import game.levels.LevelManager;
	import starling.events.Touch;
	import starling.text.TextField;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Daniel
	 */
	
	//Randomly place the NumberSprites in the scene
	public class AdditionGame extends AbstractLevel
	{
		private var texture:Texture;
		
		private const HIGHEST_NUMBER:int = 10;
		
		private const MAX_TIME:Number = 10.0;
		private const INCREASE_TIMER:Number = 3.0;
		
		private var _sum:int;
		private var _runningSum:int;
		
		private var _gameTimer:Number;
		
		private var _sumTextfield:TextField;
		private var _timerTextfield:TextField;
		
		private var _availableNumbers:Vector.<NumberSprite>;
		private var _activeNumbers:Vector.<NumberSprite>;
		
		public function AdditionGame()
		{
			_gameTimer = MAX_TIME;
			
			_availableNumbers = new Vector.<NumberSprite>();
			_activeNumbers = new Vector.<NumberSprite>();
			
			var square:Shape = new Shape();
			square.graphics.beginFill(0xffffff);
			square.graphics.drawRect(0, 0, 60, 60);
			square.graphics.endFill();
			
			var bitmapData:BitmapData = new BitmapData(60, 60);
			bitmapData.draw(square);
			
			texture = Texture.fromBitmapData(bitmapData);
		}
		
		/* INTERFACE engine.levels.ILevel */
		
		override public function setup():void 
		{
			super.setup();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			for ( var y:int = 0; y < 8; y++ )
			{
				for ( var x:int = 0; x < 4; x++ )
				{
					var numberSprite:NumberSprite = new NumberSprite(texture, 1 + Math.round(Math.random() * (HIGHEST_NUMBER - 1)));
					numberSprite.x += x * numberSprite.width + (x + 1) * 40;
					numberSprite.y += y * numberSprite.height + (y + 1) * 30;
					addChild(numberSprite);
					
					_availableNumbers.push(numberSprite);
				}
			}
		}
		
		override public function resume():void 
		{
			super.resume();
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function pause():void 
		{
			super.pause();
			removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function tick(deltaTime:Number):void
		{
			_gameTimer -= deltaTime;
			
			_timerTextfield.text = Math.max(Math.ceil(_gameTimer), 0).toString();
			
			if ( _gameTimer <= 0 )
			{
				dispatchEventWith(LevelManager.LEVEL_COMPLETED);
			}
			
			super.tick(deltaTime);
		}
		
		override public function teardown():void 
		{
			super.teardown();
		}
		//--------------------------------//
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_timerTextfield = new TextField(100, 50, _gameTimer.toString(), "Verdana", 16);
			_timerTextfield.x = stage.stageWidth - _timerTextfield.width - 20;
			_timerTextfield.y = stage.stageHeight - _timerTextfield.height - 10;
			addChild(_timerTextfield);
			
			_sumTextfield = new TextField(100, 50, "", "Verdana", 16);
			_sumTextfield.x = (stage.stageWidth >> 1) - (_sumTextfield.width >> 1);
			_sumTextfield.y = stage.stageHeight - _sumTextfield.height - 10;
			addChild(_sumTextfield);
			
			chooseNextSum();
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			
			if ( !touch )
			{
				return;
			}
			
			var touchLocation:Point = touch.getLocation(this);
			
			var numberSprite:NumberSprite;
			var availableNumbersIndex:int;
			
			//Search for the NumberSprite that was touched.
			for ( availableNumbersIndex = 0; availableNumbersIndex < _availableNumbers.length; availableNumbersIndex++ )
			{
				var possibleNumberSprite:NumberSprite = _availableNumbers[availableNumbersIndex];
				
				if ( touchLocation.x > possibleNumberSprite.x && touchLocation.x < possibleNumberSprite.x + possibleNumberSprite.width && 
					 touchLocation.y > possibleNumberSprite.y && touchLocation.y < possibleNumberSprite.y + possibleNumberSprite.height )
				{
					numberSprite = possibleNumberSprite;
				}
			}
			
			
			if ( !numberSprite )
			{
				return;
			}
			
			//If the NumberSprite is not active, activate it, add its value to the running sum and add NumberSprite to _activeNumbers.
			if ( ! numberSprite.isActive() )
			{
				numberSprite.activate();
				_runningSum += numberSprite.value;
				_activeNumbers.push(numberSprite);
			}
			//If it is active, deactivate it, substract its number from the running sum, and remove it from _activeNumbers.
			else
			{
				numberSprite.deactivate();
				_runningSum -= numberSprite.value;
				
				for (var x:int = 0; x < _activeNumbers.length; x++)
				{
					if ( _activeNumbers[x] == numberSprite )
					{
						_activeNumbers.splice(x, 1);
					}
				}
			}
			
			//Check if running sum equals sum.
			//If it does remove all NumberSprites in _activeNumbers from the stage and from _availableNumbers.
			if ( _runningSum == _sum )
			{
				_runningSum = 0;
				_gameTimer = Math.min(_gameTimer + INCREASE_TIMER, MAX_TIME);
				
				for ( var activeNumbersIndex:int = 0; activeNumbersIndex < _activeNumbers.length; activeNumbersIndex++ )
				{
					for ( availableNumbersIndex = 0; availableNumbersIndex < _availableNumbers.length; availableNumbersIndex++ )
					{
						if ( _availableNumbers[availableNumbersIndex] == _activeNumbers[activeNumbersIndex] )
						{
							_availableNumbers.splice(availableNumbersIndex, 1);
							break;
						}
					}
					
					_activeNumbers[activeNumbersIndex].removeFromParent(true);
				}
				
				_activeNumbers.splice(0, _activeNumbers.length);
				
				//Check if _availableNumbers is empty.
				//If it is dispatch a LevelManager.LEVEL_COMPLETE event.
				if ( _availableNumbers.length == 0 )
				{
					dispatchEventWith(LevelManager.LEVEL_COMPLETED);
				}
				//If it is not call chooseNextSum.
				else
				{
					chooseNextSum();
				}
			}
		}
		
		private function chooseNextSum():void
		{
			_sum = 0;
			
			
			if ( _availableNumbers.length < 4 )
			{
				for ( var x:int = 0; x < _availableNumbers.length; x++ )
				{
					_sum += _availableNumbers[x].value;
				}
			}
			else 
			{
				var _index1:int = Math.floor(Math.random() * _availableNumbers.length);
				var _index2:int = Math.floor(Math.random() * _availableNumbers.length);
				
				while ( _index2 == _index1 ) 
				{
					_index2 = Math.floor(Math.random() * _availableNumbers.length);
				}
				
				_sum = _availableNumbers[_index1].value + _availableNumbers[_index2].value;
			}
			
			_sumTextfield.text = _sum.toString();
		}
	}
}