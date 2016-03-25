package game.levels.flow 
{
	import game.levels.flow.roadtypes.RoadPiece;
	/**
	 * ...
	 * @author Daniel
	 */
	public class PathSearch 
	{
		private var _numColumns:int;
		private var _layout:Vector.<RoadPiece>;
		
		private var _pathFound:Boolean = false;
		
		public function PathSearch() 
		{
			
		}
		
		public function searchForCompletePath():void
		{
			clear();
			
			for ( var x:int = 0; x < _numColumns; x++ )
			{
				if ( _layout[x].isConnectedTo(RoadPiece.TOP) )
				{
					searchTopDown(_layout[x], x);
					
					if ( _pathFound )
					{
						trace(_possiblePath.length);
						_completedPaths = _completedPaths.concat(_possiblePath);
						trace(_completedPaths.length);
						_pathFound = false;
					}
					
					_possiblePath.splice(0, _possiblePath.length);
				}
			}
			
			//trace(_completedPaths.length);
			if ( _completedPaths.length > 0 )
			{
				pathCompleted();
				return;
			}
			
			for ( x = _layout.length - _numColumns; x < _layout.length; x++ )
			{
				if ( _layout[x].isConnectedTo(RoadPiece.BOTTOM) )
				{
					searchBottomUp(_layout[x], x);
				}
			}
		}
		
		private function searchTopDown(road:RoadPiece, positionInLayoutVector:int):void
		{
			if ( road.isConnectedToTop )
			{
				return;
			}
			
			_possiblePath.push(positionInLayoutVector);
			
			if ( positionInLayoutVector >= _layout.length - _numColumns && positionInLayoutVector < _layout.length )
			{
				if ( _layout[positionInLayoutVector].isConnectedTo(RoadPiece.BOTTOM) )
				{
					_pathFound = true;
				}
			}
			
			road.isConnectedToTop = true;
			searchConnections(road, positionInLayoutVector, searchTopDown);
		}
		
		private function searchBottomUp(road:RoadPiece, positionInLayoutVector:int):void
		{
			if ( road.isConnectedToBottom )
			{
				return;
			}
			
			road.isConnectedToBottom = true;
			searchConnections(road, positionInLayoutVector, searchBottomUp);
		}
		
		private function searchConnections(road:RoadPiece, positionInLayoutVector:int, search:Function):void
		{
			road.highlight();
			
			var edges:Vector.<int> = road.edges();
			
			for ( var x:int = 0; x < edges.length; x++ )
			{
				var potentialConnectionPosition:int;
				switch(edges[x])
				{
					case RoadPiece.TOP:
						potentialConnectionPosition = positionInLayoutVector - _numColumns;
						
						if ( potentialConnectionPosition > 0 )
						{
							if ( _layout[potentialConnectionPosition].isConnectedTo(RoadPiece.BOTTOM) )
							{
								search(_layout[potentialConnectionPosition], potentialConnectionPosition);
							}
						}
						
						break;
						
					case RoadPiece.LEFT:
						if ( positionInLayoutVector % _numColumns != 0 )
						{
							potentialConnectionPosition = positionInLayoutVector - 1;
							
							if ( _layout[potentialConnectionPosition].isConnectedTo(RoadPiece.RIGHT) )
							{
								search(_layout[potentialConnectionPosition], potentialConnectionPosition);
							}
						}
						break;
						
					case RoadPiece.BOTTOM:
						potentialConnectionPosition = positionInLayoutVector + _numColumns;
						
						if ( potentialConnectionPosition < _layout.length )
						{
							if ( _layout[potentialConnectionPosition].isConnectedTo(RoadPiece.TOP) )
							{
								search(_layout[potentialConnectionPosition], potentialConnectionPosition);
							}
						}
						
						break;
						
					case RoadPiece.RIGHT:
						if ( (positionInLayoutVector + 1) % _numColumns != 0 )
						{
							potentialConnectionPosition = positionInLayoutVector + 1;
							
							if ( _layout[potentialConnectionPosition].isConnectedTo(RoadPiece.LEFT) )
							{
								search(_layout[potentialConnectionPosition], potentialConnectionPosition);
							}
						}
						break;
						
					default:
						throw new Error("Invalid input in roadpiece edges!");
				}
			}
		}
		
		private function clear():void
		{
			for ( var x:int = 0; x < _layout.length; x++ )
			{
				_layout[x].unhighlight();
				_layout[x].isConnectedToTop = false;
				_layout[x].isConnectedToBottom = false;
			}
		}
	}

}