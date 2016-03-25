package engine.baseentity 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Daniel
	 */
	public class Actor extends Sprite
	{
		protected var image:Image;
		
		public function Actor() 
		{
			
		}
		
		public function setImage(image:Image):void
		{
			if ( image != null )
			{
				this.image.dispose();
			}
			
			this.image = image;
		}
		
		public function setTexture(texture:Texture):void
		{
			if (image == null)
			{
				image = new Image(texture);
			}
			else
			{
				image.texture = texture;
			}
		}
	}
}