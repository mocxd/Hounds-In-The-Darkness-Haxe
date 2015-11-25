package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
//import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
 class MenuState extends FlxState
 {

 	private var currentSelection = 0;
 	private	var loadText = new FlxText(200, 333, 41, ">_", 20);
 	private var newText = new FlxText(380, 333, 21, "run", 20);
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	 override public function create():Void
	 {
	 	var menuTitleBg = new FlxSprite(-200,-100);
	 	menuTitleBg.loadGraphic("assets/images/hitd.png", false);
	 	menuTitleBg.setGraphicSize(900, 600);
	 	var menuTitleFg = new FlxSprite(-200,0);
	 	menuTitleFg.loadGraphic("assets/images/hitd2.png", false);
	 	menuTitleFg.setGraphicSize(900, 100);

	 	loadText.color = 0xff80ebed;
	 	newText.color = 0xffffffff;
	 	add(menuTitleBg);
	 	add(menuTitleFg);
	 	add(loadText);
	 	add(newText);
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
	 	menuActions();
	 	super.update(e);
	 }

	 private function menuActions():Void {
	 	//var up = FlxG.keys.anyJustPressed(["UP", "W"]);
	 	//var down = FlxG.keys.anyJustPressed(["DOWN", "S"]);
	 	var left = FlxG.keys.anyJustPressed(["LEFT", "A"]);
	 	var right = FlxG.keys.anyJustPressed(["RIGHT", "D"]);
	 	var ok = FlxG.keys.anyJustPressed(["ENTER", "SPACE"]);

	 	if (right) {
	 		jogSelection(1);
	 	} else if (left) {
	 		jogSelection(-1);
	 	} else if (ok) {
	 		clickMenu();
	 	}

	 	updateMenu();
	 }

	 private function updateMenu():Void {
	 	loadText.color = 0xffffffff;
	 	newText.color = 0xffffffff;
	 	if (currentSelection == 0) {
	 		loadText.color = 0xff80ebed;
	 	} else if (currentSelection == 1) {
	 		newText.color = 0xff80ebed;
	 	}
	 }

	 private function clickMenu():Void {
	 	if (currentSelection == 1) {
	 		FlxG.switchState(new PlayState());
	 	}
	 }

	 private function jogSelection(delta:Int):Void {
	 	var max = 1;
	 	currentSelection+=delta;
	 	if (currentSelection > max) {
	 		currentSelection = 0;
	 	} else if (currentSelection < 0) {
	 		currentSelection = max;
	 	}
	 }
	}