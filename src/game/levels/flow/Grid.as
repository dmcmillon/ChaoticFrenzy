package game.levels.flow 
{
	import flash.geom.Point;
	import game.levels.flow.roadtypes.BlankSquare;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	
	import game.levels.flow.roadtypes.FourWayRoad;
	import game.levels.flow.roadtypes.LShapedRoad;
	import game.levels.flow.roadtypes.RoadPiece;
	import game.levels.flow.roadtypes.StraightRoad;
	import game.levels.flow.roadtypes.ThreeWayRoad;
	/**
	 * ...
	 * @author Daniel
	 */
	public class Grid extends Sprite
	{
		public static const PATH_FOUND:String = "pathFound";
		
		private const POSSIBLE_ROTATIONS:int = 4;
		
		private var _numRows:int;
		private var _numColumns:int;
		
		private var _layout:Vector.<RoadPiece>;
		
		private var _pathFound:Boolean = false;
		private var _possiblePath:Vector.<int>;
		private var _completedPaths:Vector.<int>;
		
		private var _pathSearch:PathSearch;
		
		public function Grid(numRows:int, numColumns:int) 
		{
			_numRows = numRows;
			_numColumns = numColumns;
			
			_layout = new Vector.<RoadPiece>(_numRows * _numColumns, true);
			
			_possiblePath = new Vector.<int>();
			_completedPaths = new Vector.<int>();
			
			initGrid();
			
			_pathSearch = new PathSearch();
			_pathSearch.searchForCompletePath();
		}
		
		public function onTouch(touch:Touch):void
		{
			var touchLocation:Point = touch.getLocation(this);
			
			for ( var x:int = 0; x < _layout.length; x++ )
			{
				var roadPiece:RoadPiece = _layout[x];
				
				if ( touchLocation.x > (roadPiece.x - (roadPiece.width >> 1)) && touchLocation.x < (roadPiece.x + (roadPiece.width >> 1)) &&
					 touchLocation.y > (roadPiece.y - (roadPiece.height >> 1)) && touchLocation.y < (roadPiece.y + (roadPiece.height >> 1)) )
				{
					roadPiece.rotate();
					
					_pathSearch.searchForCompletePath();
					break;
				}
			}
		}
		
		private function pathCompleted():void
		{
			removeRoads();
			addNewRoads();
			
			_completedPaths.splice(0, _completedPaths.length);
			_pathSearch.searchForCompletePath();
		}
		
		private function initGrid():void
		{
			for ( var x:int = 0; x < _layout.length; x++ )
			{
				var road:RoadPiece = chooseRandomRoad();
				
				placeRoad(road, x);
				
				_layout[x] = road;
				addChild(road);
			}
		}
		
		private function placeRoad(road:RoadPiece, layoutPosition:int):void
		{
			road.x = ((layoutPosition % _numColumns) * road.width) + (road.width >> 1);
			road.y = (Math.floor(layoutPosition / _numColumns) * road.height) + (road.height >> 1);
		}
		
		private function chooseRandomRoad():RoadPiece
		{
			var randNum:Number = Math.random();
			var randRotation:int = Math.floor(Math.random() * POSSIBLE_ROTATIONS);
			var roadPiece:RoadPiece = null;
			
			if ( randNum < 0.25 )
			{
				roadPiece = new StraightRoad(randRotation);
				
			}
			else if ( randNum >= 0.25 && randNum < 0.5 )
			{
				roadPiece = new LShapedRoad(randRotation);
			}
			else if ( randNum >= 0.5 && randNum < 0.65 )
			{
				roadPiece = new ThreeWayRoad(randRotation);
			}
			else if ( randNum >= 0.65 && randNum < 0.75 )
			{
				roadPiece = new FourWayRoad(randRotation);
			}
			else 
			{
				roadPiece = new LShapedRoad(randRotation);
			}
			
			return roadPiece;
		}
		
		private function removeRoads():void
		{
			trace("remove");
			for ( var x:int = 0; x < _completedPaths.length; x++ )
			{
				removeChild(_layout[_completedPaths[x]]);
				_layout[_completedPaths[x]] = null;
			}
		}
		
		private function addNewRoads():void
		{
			var road:RoadPiece;
			
			for ( var x:int = 0; x < _completedPaths.length; x++ )
			{
				road = chooseRandomRoad();
				
				addChild(road);
				
				var index:int = _completedPaths[x];
				
				placeRoad(road, index);
				_layout[index] = road;
			}
		}
	}
}