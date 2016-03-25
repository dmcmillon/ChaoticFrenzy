package game.levels.patternmatch 
{
	import engine.animation.Animation;
	import engine.animation.AnimationPlayer;
	import flash.geom.Point;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import game.levels.patternmatch.animation.HighlightPatternAnimation;
	import game.levels.AbstractLevel;
	import game.levels.LevelManager;
	
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Daniel
	 */
	public class PatternMatch extends AbstractLevel
	{
		private const IMAGE_WIDTH:int = 200;
		private const IMAGE_HEIGHT:int = 200;
		
		private const RED:int = 0;
		private const BLUE:int = 1;
		private const GREEN:int = 2;
		private const YELLOW:int = 3;
		
		private const PATTERN_INCREASE:int = 1;
		
		private var redBitmapData:BitmapData;
		private var redGlowBitmapData:BitmapData;
		private var greenBitmapData:BitmapData;
		private var greenGlowBitmapData:BitmapData;
		private var blueBitmapData:BitmapData;
		private var blueGlowBitmapData:BitmapData;
		private var yellowBitmapData:BitmapData;
		private var yellowGlowBitmapData:BitmapData;
		
		private var redPiece:PatternPiece;
		private var greenPiece:PatternPiece;
		private var bluePiece:PatternPiece;
		private var yellowPiece:PatternPiece;
		
		private var currentPattern:Vector.<int>;
		private var patternTypes:Vector.<String> = new <String>["red", "blue", "green", "yellow"];
		
		private var patternPieces:Vector.<PatternPiece>;
		
		private var wasPatternDisplayedToPlayer:Boolean;
		//Index of the current pattern piece in currentPattern that the player is trying to remember.
		private var currentPatternIndex:int;
		private var turns:int = 7;
		private var patternSize:int = 3;
		
		private var indexOfDisplayedPiece:int;
		private var animationTimer:Number = 0;
		private var timeToDisplayEachPiece:Number = 2;
		
		private var animationPlayer:AnimationPlayer;
		
		public function PatternMatch() 
		{	
			var redSprite:Sprite = new Sprite();
			redSprite.graphics.beginFill(0xff0000);
			redSprite.graphics.drawRect(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
			redSprite.graphics.endFill();
			
			var redGlowSprite:Sprite = new Sprite();
			redGlowSprite.graphics.beginFill(0xff0000, 0.5);
			redGlowSprite.graphics.drawRect(0, 0, IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			redGlowSprite.graphics.endFill();
			
			var greenSprite:Sprite = new Sprite();
			greenSprite.graphics.beginFill(0x00ff00);
			greenSprite.graphics.drawRect(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
			greenSprite.graphics.endFill();
			
			var greenGlowSprite:Sprite = new Sprite();
			greenGlowSprite.graphics.beginFill(0x00ff00, 0.5);
			greenGlowSprite.graphics.drawRect(0, 0, IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			greenGlowSprite.graphics.endFill();
			
			var blueSprite:Sprite = new Sprite();
			blueSprite.graphics.beginFill(0x0000ff);
			blueSprite.graphics.drawRect(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
			blueSprite.graphics.endFill();
			
			var blueGlowSprite:Sprite = new Sprite();
			blueGlowSprite.graphics.beginFill(0x0000ff, 0.5);
			blueGlowSprite.graphics.drawRect(0, 0, IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			blueGlowSprite.graphics.endFill();
			
			var yellowSprite:Sprite = new Sprite();
			yellowSprite.graphics.beginFill(0xffff00);
			yellowSprite.graphics.drawRect(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
			yellowSprite.graphics.endFill();
			
			var yellowGlowSprite:Sprite = new Sprite();
			yellowGlowSprite.graphics.beginFill(0xffff00, 0.5);
			yellowGlowSprite.graphics.drawRect(0, 0, IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			yellowGlowSprite.graphics.endFill();
			
			redBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT);
			redBitmapData.draw(redSprite);
			redGlowBitmapData = new BitmapData(IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			redGlowBitmapData.draw(redGlowSprite);
			
			greenBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT);
			greenBitmapData.draw(greenSprite);
			greenGlowBitmapData = new BitmapData(IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			greenGlowBitmapData.draw(greenGlowSprite);
			
			blueBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT);
			blueBitmapData.draw(blueSprite);
			blueGlowBitmapData = new BitmapData(IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			blueGlowBitmapData.draw(blueGlowSprite);
			
			yellowBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT);
			yellowBitmapData.draw(yellowSprite);
			yellowGlowBitmapData = new BitmapData(IMAGE_WIDTH + 50, IMAGE_HEIGHT + 50);
			yellowGlowBitmapData.draw(yellowGlowSprite);
		}
		
		/* INTERFACE engine.levels.ILevel */
		
		override public function setup():void 
		{
			super.setup();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			currentPattern = new Vector.<int>();
			animationPlayer = new AnimationPlayer();
			
			choosePattern();
			
			indexOfDisplayedPiece = 0;
		}
		
		override public function resume():void 
		{
			super.resume();
			addEventListener(TouchEvent.TOUCH, onTouch);
			animationPlayer.addEventListener(AnimationPlayer.ANIMATION_COMPLETE, onAnimationComplete);
		}
		
		override public function pause():void 
		{
			super.pause();
			removeEventListener(TouchEvent.TOUCH, onTouch);
			animationPlayer.removeEventListener(AnimationPlayer.ANIMATION_COMPLETE, onAnimationComplete);
		}
		
		override public function tick(deltaTime:Number):void
		{
			if ( wasPatternDisplayedToPlayer )
			{
				super.tick(deltaTime);
			}
			else
			{
				if ( !animationPlayer.isPlayingAnimation() )
				{
					animationPlayer.playAnimation(new HighlightPatternAnimation(patternPieces, currentPattern));
				}
				
				animationPlayer.tick(deltaTime);
			}
		}
		
		override public function teardown():void 
		{
			super.teardown();
		}
		//--------------------------------//
		
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			redPiece = new PatternPiece(Texture.fromBitmapData(redBitmapData), patternTypes[RED]);
			redPiece.x = (stage.stageWidth >> 1) - redPiece.width;
			redPiece.y = (stage.stageHeight >> 1) - redPiece.height;
			addChild(redPiece);
			
			bluePiece = new PatternPiece(Texture.fromBitmapData(blueBitmapData), patternTypes[BLUE]);
			bluePiece.x = (stage.stageWidth >> 1);
			bluePiece.y = (stage.stageHeight >> 1) - bluePiece.height;
			addChild(bluePiece);
			
			greenPiece = new PatternPiece(Texture.fromBitmapData(greenBitmapData), patternTypes[GREEN]);
			greenPiece.x = (stage.stageWidth >> 1) - greenPiece.width;
			greenPiece.y = (stage.stageHeight >> 1);
			addChild(greenPiece);
			
			yellowPiece = new PatternPiece(Texture.fromBitmapData(yellowBitmapData), patternTypes[YELLOW]);
			yellowPiece.x = (stage.stageWidth >> 1);
			yellowPiece.y = (stage.stageHeight >> 1);
			addChild(yellowPiece);
			
			patternPieces = new Vector.<PatternPiece>();
			patternPieces.push(redPiece, bluePiece, greenPiece, yellowPiece);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			if ( !wasPatternDisplayedToPlayer )
			{
				return;
			}
			
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			
			if ( touch )
			{
				var touchLocation:Point = touch.getLocation(this);
				
				for ( var x:int = 0; x < patternPieces.length; x++ )
				{
					var patternPiece:PatternPiece = patternPieces[x];
					
					if ( touchLocation.x > patternPiece.x && touchLocation.x < patternPiece.x + patternPiece.width &&
					     touchLocation.y > patternPiece.y && touchLocation.y < patternPiece.y + patternPiece.height )
					{
						if ( patternPiece.value == patternPieces[currentPattern[currentPatternIndex]].value )
						{
							currentPatternIndex++;
							
							if ( currentPatternIndex >= currentPattern.length )
							{
								turns--;
								
								if ( turns <= 0 )
								{
									dispatchEventWith(LevelManager.LEVEL_COMPLETED);
								}
								
								patternSize += PATTERN_INCREASE;
								choosePattern();
							}
							
							trace("correct");
						}
						else 
						{
							dispatchEventWith(LevelManager.LEVEL_COMPLETED);
							trace("Game Over");
						}
						break;
					}
				}
			}
		}
		
		private function choosePattern():void
		{
			for ( var x:int = 0; x < patternSize; x++ )
			{
				currentPattern[x] = Math.floor(Math.random() * patternTypes.length);	
			}
			
			wasPatternDisplayedToPlayer = false;
			currentPatternIndex = 0;
		}
		
		private function onAnimationComplete():void
		{
			wasPatternDisplayedToPlayer = true;
		}
	}
}