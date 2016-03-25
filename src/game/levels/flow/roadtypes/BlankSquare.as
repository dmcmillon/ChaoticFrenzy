package game.levels.flow.roadtypes 
{
	import starling.textures.Texture;
	import starling.display.Image;
	/**
	 * ...
	 * @author Daniel
	 */
	public class BlankSquare extends RoadPiece 
	{
		[Embed(source = "../../../../../icons/android/pipes/Blank.png")]
		private static const RoadImage:Class;
		
		public function BlankSquare(numberOfRotations:int = 0) 
		{
			super();
			
			_image = new Image(Texture.fromEmbeddedAsset(RoadImage));
			
			addChild(_image);
			_image.scaleX = 0.5;
			_image.scaleY = 0.5;
			_image.alignPivot();
		}
	}
}