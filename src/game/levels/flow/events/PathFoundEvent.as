package game.levels.flow.events 
{
	import starling.events.Event;
	
	import game.levels.flow.roadtypes.RoadPiece;
	/**
	 * ...
	 * @author Daniel
	 */
	public class PathFoundEvent extends Event
	{
		private var _completePath:Vector.<int>;
		private var _gridLayout:Vector.<RoadPiece>;
		
		public function PathFoundEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}