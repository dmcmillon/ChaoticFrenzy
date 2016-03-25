package game.levels.flow.roadtypes 
{
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Daniel
	 */
	public class RoadPiece extends Sprite
	{
		public static var TOP:int = 0;
		public static var RIGHT:int = 1;
		public static var BOTTOM:int = 2;
		public static var LEFT:int = 3;
		
		public var isConnectedToTop:Boolean;
		public var isConnectedToBottom:Boolean;
		
		protected var _rotation:Number = 0;
		
		protected var _edges:Vector.<int>;
		
		protected var _image:Image;
		
		public function RoadPiece() 
		{
			_edges = new Vector.<int>();
		}
		
		public function highlight():void
		{
			if ( isConnectedToBottom )
			{
				_image.color = 0xffff00;
			}
			
			if ( isConnectedToTop )
			{
				_image.color = 0xff0000;
			}
		}
		
		public function unhighlight():void
		{
			_image.color = 0xffffff;
		}
		
		public function edges():Vector.<int>
		{
			var edgesCopy:Vector.<int> = new Vector.<int>();
			
			for ( var x:int = 0; x < _edges.length; x++ )
			{
				edgesCopy.push(_edges[x]);
			}
			
			return edgesCopy;
		}
		
		public function isConnectedTo(side:int):Boolean
		{
			var isConnected:Boolean = false;
			
			for ( var x:int = 0; x < _edges.length; x++ )
			{
				if ( side == _edges[x] )
				{
					isConnected = true;
					break;
				}
			}
			
			return isConnected;
		}
		
		public function rotate(numberOfRotations:int = 1):void
		{
			if ( _edges == null )
			{
				throw new Error("Edges must be initialized!");
			}
			
			_rotation += numberOfRotations * (Math.PI / 2);
			_image.rotation = _rotation;
			
			for ( var x:int = 0; x < _edges.length; x++ )
			{
				_edges[x] = (_edges[x] + numberOfRotations) % 4;
			}
		}
	}
}