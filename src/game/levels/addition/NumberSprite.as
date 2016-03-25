package game.levels.addition 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Daniel
	 */
	public class NumberSprite extends Sprite 
	{
		private var _image:Image;
		private var _textField:TextField;
		
		private var _value:int;
		private var _active:Boolean;
		
		public function get value():int
		{
			return _value;
		}
		
		public function NumberSprite(texture:Texture, value:int) 
		{
			_image = new Image(texture);
			_image.color = 0;
			
			_textField = new TextField(_image.width, _image.height, value.toString(), "Verdana", 32, 0xffffff);
			_value = value;
			
			addChild(_image);
			addChild(_textField);
		}
		
		public function isActive():Boolean
		{
			return _active;
		}
		
		public function activate():void
		{
			_active = true;
			_image.color = 0xffff00;
			_textField.color = 0;
		}
		
		public function deactivate():void
		{
			_active = false;
			_image.color = 0;
			_textField.color = 0xffffff;
		}
	}
}