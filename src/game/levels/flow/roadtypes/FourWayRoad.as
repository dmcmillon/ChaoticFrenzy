package game.levels.flow.roadtypes 
{
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Daniel
	 */
	public class FourWayRoad extends RoadPiece
	{
		[Embed(source = "../../../../../icons/android/pipes/4Pipe.png")]
		private static const RoadImage:Class;
		
		public function FourWayRoad(numberOfRotations:int = 0) 
		{
			super();
			
			_image = new Image(Texture.fromEmbeddedAsset(RoadImage));
			
			addChild(_image);
			_image.scaleX = 0.5;
			_image.scaleY = 0.5;
			_image.alignPivot();
			
			_edges.push(TOP, LEFT, BOTTOM, RIGHT);
			rotate(numberOfRotations);
		}
	}
}