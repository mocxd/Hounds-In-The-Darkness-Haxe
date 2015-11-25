package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
//import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
 class PlayState extends FlxState
 {
 	var playerShip = new FlxSprite(0,0);
 	var accelFactor = 60;
 	var dragFactor = 10;
 	var ngAccelFactor = 5;
 	var ngDragFactor = 50;
 	var handlingFactor = .1;
 	var rotationOffset = .8;
 	var stopLevel = .0;
 	var stopFactor = .1;
 	var allStopDrag = 40;
 	var allStop = false;
 	var pin = .0;

 	var _x = new FlxText(0,20,1000,"debug",10);
 	var _y = new FlxText(0,40,1000,"debug",10);
 	var _accel = new FlxText(0,60,1000,"debug",10);
 	var _ngaccel = new FlxText(0,80,1000,"debug",10);
 	var _drag = new FlxText(0,100,1000,"debug",10);
 	var _ngdrag = new FlxText(0,120,1000,"debug",10);
 	var _stoplevel = new FlxText(0,140,1000,"debug",10);
 	var _pin = new FlxText(0,160,1000,"debug",10);
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	 override public function create():Void
	 {
	 	playerShip.loadGraphic("assets/images/miniship.png");

	 	starField(100);
	 	pointField(10);
	 	gridField(10);

	 	_x.scrollFactor.set();
	 	_y.scrollFactor.set();
	 	_accel.scrollFactor.set();
	 	_ngaccel.scrollFactor.set();
	 	_drag.scrollFactor.set();
	 	_ngdrag.scrollFactor.set();
	 	_stoplevel.scrollFactor.set();
	 	_pin.scrollFactor.set();

	 	add(new FlxText(0,0, "origin"));
	 	add(playerShip);

	 	add(_x);
	 	add(_y);
	 	add(_accel);
	 	add(_ngaccel);
	 	add(_drag);
	 	add(_ngdrag);
	 	add(_stoplevel);
	 	add(_pin);
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
	 	playerMovement(e);
	 	debugVars();
	 	super.update(e);
	 }

	 private function debugVars():Void {
	 	_x.text = "x: " + playerShip.x;
	 	_y.text = "y: " + playerShip.y;
	 	_accel.text = "accel: " + playerShip.acceleration.x + ", " + playerShip.acceleration.y;
	 	_drag.text = "drag: " + playerShip.drag.x + ", " + playerShip.drag.y;
	 	_ngaccel.text = "ngaccel: " + playerShip.angularAcceleration;
	 	_ngdrag.text = "ngdrag: " + playerShip.angularDrag;
	 	_stoplevel.text = "stoplevel: " + stopLevel;
	 	_pin.text = "pin: " + pin;
	 }

	 private function playerMovement(e:Float):Void {
	 	var up = FlxG.keys.anyPressed(["UP", "W"]);
	 	var down = FlxG.keys.anyPressed(["DOWN", "S"]);
	 	var left = FlxG.keys.anyPressed(["LEFT", "A"]);
	 	var right = FlxG.keys.anyPressed(["RIGHT", "D"]);

	 	if (up) {
	 		playerShip.drag.x = 0;
	 		playerShip.drag.y = 0;
	 		playerShip.angularDrag = ngDragFactor;
	 		playerShip.acceleration.x = Math.cos(playerShip.angle * (Math.PI / 180)) * accelFactor;
	 		playerShip.acceleration.y = Math.sin(playerShip.angle * (Math.PI / 180)) * accelFactor;
	 	} else if (down) {
	 		playerShip.acceleration.x = 0;
	 		playerShip.acceleration.y = 0;
	 		playerShip.drag.x = dragFactor*stopLevel;
	 		playerShip.drag.y = dragFactor*stopLevel;
	 		playerShip.angularAcceleration = 0;
	 		playerShip.angularDrag = ngDragFactor*2;
	 		stopLevel += stopFactor;
	 	} else if (right) {
	 		playerShip.angularDrag = 0;
	 		playerShip.angularAcceleration += ngAccelFactor;
	 		playerShip.acceleration.x = Math.cos((playerShip.angle * (Math.PI / 180))+rotationOffset)*handlingFactor*accelFactor;
	 		playerShip.acceleration.y = Math.sin((playerShip.angle * (Math.PI / 180))+rotationOffset)*handlingFactor*accelFactor;
	 		playerShip.drag.x = Math.cos(playerShip.angle * (Math.PI / 180)) * accelFactor * -1;
	 		playerShip.drag.y = Math.sin(playerShip.angle * (Math.PI / 180)) * accelFactor * -1;
	 	} else if (left) {
	 		playerShip.angularDrag = 0;
	 		playerShip.angularAcceleration -= ngAccelFactor;
	 		playerShip.acceleration.x = Math.cos((playerShip.angle * (Math.PI / 180))-rotationOffset)*handlingFactor*accelFactor;
	 		playerShip.acceleration.y = Math.sin((playerShip.angle * (Math.PI / 180))-rotationOffset)*handlingFactor*accelFactor;
	 		playerShip.drag.x = Math.cos(playerShip.angle * (Math.PI / 180)) * accelFactor * -1;
	 		playerShip.drag.y = Math.sin(playerShip.angle * (Math.PI / 180)) * accelFactor * -1;
	 	} else {
	 		playerShip.acceleration.x = 0;
	 		playerShip.acceleration.y = 0;
	 		if (!allStop) {
	 			playerShip.drag.x = 0;
	 			playerShip.drag.y = 0;
	 		}
	 		playerShip.angularAcceleration = 0;
	 		playerShip.angularDrag = ngDragFactor;
	 	}

	 	if (Math.abs(playerShip.velocity.x)+Math.abs(playerShip.velocity.y) == 0) {
	 		playerShip.drag.x = 0;
	 		playerShip.drag.y = 0;
	 		stopLevel = 0;
	 		allStop = false;
	 	} else {
	 		pin += e;
	 		if (pin > .5) {
	 			dropPin();
	 			pin = 0;
	 		}
	 	}

	 	if (FlxG.keys.justReleased.DOWN) {
	 		stopLevel = 0;
	 	} else if (FlxG.keys.justReleased.SPACE) {
	 		allStop = true;
	 		playerShip.drag.x = allStopDrag;
	 		playerShip.drag.y = allStopDrag;
	 	}
	 }

	 private function dropPin():Void {
	 	var pin = new FlxSprite(playerShip.x+8,playerShip.y+8);
	 	pin.loadGraphic("assets/images/pin.png");
	 	add(pin);
	 }

	 private function starField(n:Int):Void {
	 	for (i in 0...n) {
	 		var star = new FlxSprite(Math.floor(Math.random()*640), Math.floor(Math.random()*480));
	 		star.loadGraphic("assets/images/star1.png");
	 		star.scrollFactor.set();
	 		add(star);
	 	}
	 }

	 private function pointField(n:Int):Void {
	 	for (i in 0...n) {
	 		for (j in 0...n) {
	 			var star = new FlxSprite(i*100,j*100);
	 			star.loadGraphic("assets/images/star1.png");
	 			add(star);
	 		}
	 	}
	 }

	 private function gridField(n:Int):Void {
	 	var i = 0;
	 	var j = 0;
	 	while (i < n) {
	 		while (j < n) {
	 			var gridTile = new FlxSprite(32, 32);
	 			gridTile.x = 32*i;
	 			gridTile.y = 32*j;
	 			gridTile.loadGraphic("assets/images/tile.png");
	 			add(gridTile);
	 			j++;
	 		}
	 		j = 0;
	 		i++;
	 	}

	 }
	}