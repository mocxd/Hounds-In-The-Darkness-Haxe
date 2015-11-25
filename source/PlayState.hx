package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
//import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var playerShip = new FlxSprite(333,333);
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		playerShip.loadGraphic("assets/images/miniship.png");
		add(new FlxText(333,333, "origin"));
		add(playerShip);
		FlxG.camera.follow(playerShip, FlxCameraFollowStyle.NO_DEAD_ZONE);
		super.create();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(e:Float):Void
	{
		playerMovement();
		super.update(e);
	}

	private function playerMovement():Void {
	 	var up = FlxG.keys.anyPressed(["UP", "W"]);
	 	var down = FlxG.keys.anyPressed(["DOWN", "S"]);
	 	var left = FlxG.keys.anyPressed(["LEFT", "A"]);
	 	var right = FlxG.keys.anyPressed(["RIGHT", "D"]);
	 	if (up) {
	 		playerShip.acceleration.x += 1;
	 	} else if (down) {
	 		playerShip.acceleration.x = 0;
	 	} else if (right) {
	 		playerShip.angle += 5;
	 	} else if (left) {
	 		playerShip.angle -= 5;
	 	}
	}
}