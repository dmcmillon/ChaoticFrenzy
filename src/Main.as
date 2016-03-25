package
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import flash.desktop.NativeApplication;
	
	import starling.core.Starling;
	
	import game.ChaoticFrenzy;
	/**
	 * ...
	 * @author Daniel
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			var screenWidth:Number = stage.fullScreenWidth;
			var screenHeight:Number = stage.fullScreenHeight;
			var viewport:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);
			
			// Entry point
			var starling:Starling = new Starling(ChaoticFrenzy, stage, viewport);
			starling.start();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
			trace("Application should exit now");
		}
	}
}