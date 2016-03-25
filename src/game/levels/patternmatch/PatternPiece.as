package game.levels.patternmatch 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Daniel
	 */
	public class PatternPiece extends Sprite
	{	
		private var _image:Image;
		private var _value:String;
		
		public function get value():String
		{
			return _value;
		}
		
		public function PatternPiece(texture:Texture, value:String) 
		{
			_image = new Image(texture);
			addChild(_image);
			
			_value = value;
		}
		
		public function highlight():void
		{
			_image.color = 0;
		}
		
		public function cancelHighlight():void
		{
			_image.color = 0xffffff;
		}
		
	}

}