package game.levels.flow 
{
	import starling.events.Touch;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	
	import game.levels.flow.events.PathFoundEvent;
	/**
	 * ...
	 * @author Daniel
	 */
	public class PeopleEscape extends Sprite
	{
		[Embed(source = "../../../../icons/android/icons/icon_48.png")]
		private static const boatImage:Class;
		
		private const Y_PADDING:int = 10;
		
		private var _numRows:int;
		private var _numColumns:int;
		
		private var _boatsLeft:int;
		
		private var _grid:Grid;
		private var _boats:Vector.<Image>;
		
		public function PeopleEscape(numRows:int, numColumns:int) 
		{
			_numRows = numRows;
			_numColumns = numColumns;
			
			_boats = new Vector.<Image>(_numColumns, true);
			
			for ( var x:int = 0; x < _boats.length; x++ )
			{
				_boats[x] = new Image(Texture.fromEmbeddedAsset(boatImage));
				_boats[x].scaleX = 1.25;
				_boats[x].scaleY = 1.25;
				
				_boats[x].x = x * _boats[x].width;
				_boats[x].y = Y_PADDING;
				
				addChild(_boats[x]);
			}
			
			_boatsLeft = _numColumns;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onTouch(touch:Touch):void
		{
			_grid.onTouch(touch);
		}
		
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_grid = new Grid(_numRows, _numColumns);
			_grid.x = (stage.stageWidth - _grid.width) >> 1;
			_grid.y = Y_PADDING + _boats[0].height;
			addChild(_grid);
			
			_grid.addEventListener(Grid.PATH_FOUND, onPathFound);
		}
		
		private function onPathFound(event:PathFoundEvent):void
		{
			
		}
	}
}