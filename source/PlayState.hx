package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
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
 	var dragFactor = 12;
 	var ngAccelFactor = 5;
 	var ngDragFactor = 100;
 	var handlingFactor = .2;
 	var rotationOffset = .9;
 	var stopLevel = .0;
 	var stopFactor = .1;
 	var sideDrag = 20;
 	var allStopDrag = 80;
 	var allStop = false;
 	var pin = .0;
 	var shipZ = .0;
 	var zAccelFactor = .0001;
 	var zDragFactor = 1.1;
 	var zVelocity = .0;
 	var zStopThreshold = .0001;

 	var field:PlayField = new PlayField();

 	var _x = new FlxText(0,20,1000,"debug",10);
 	var _y = new FlxText(0,40,1000,"debug",10);
 	var _accel = new FlxText(0,60,1000,"debug",10);
 	var _ngaccel = new FlxText(0,80,1000,"debug",10);
 	var _drag = new FlxText(0,100,1000,"debug",10);
 	var _ngdrag = new FlxText(0,120,1000,"debug",10);
 	var _stoplevel = new FlxText(0,140,1000,"debug",10);
 	var _pin = new FlxText(0,160,1000,"debug",10);
 	var _zVelocity = new FlxText(0,180,1000,"debug",10);
 	var _shipZ = new FlxText(0,200,1000,"debug",10);
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	 override public function create():Void
	 {
	 	playerShip.loadGraphic("assets/images/miniship.png");

	 	starField(100);
	 	pointField(10);
	 	gridField(10);
	 	objField(20);

	 	_x.scrollFactor.set();
	 	_y.scrollFactor.set();
	 	_accel.scrollFactor.set();
	 	_ngaccel.scrollFactor.set();
	 	_drag.scrollFactor.set();
	 	_ngdrag.scrollFactor.set();
	 	_stoplevel.scrollFactor.set();
	 	_pin.scrollFactor.set();
	 	_zVelocity.scrollFactor.set();
	 	_shipZ.scrollFactor.set();

	 	field.init();
	 	add(field);

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
	 	add(_zVelocity);
	 	add(_shipZ);
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
	 	_zVelocity.text = "zVelocity: " + zVelocity;
	 	_shipZ.text = "shipZ: " + shipZ;
	 }

	 private function playerMovement(e:Float):Void {
	 	var up = FlxG.keys.anyPressed(["UP"]);
	 	var down = FlxG.keys.anyPressed(["DOWN"]);
	 	var left = FlxG.keys.anyPressed(["LEFT"]);
	 	var right = FlxG.keys.anyPressed(["RIGHT"]);
	 	var zup = FlxG.keys.anyPressed(["Q", "W", "E", "R", "T", "Y"]);
	 	var zstop = FlxG.keys.anyPressed(["A", "S", "D", "F", "G", "H"]);
	 	var zdown = FlxG.keys.anyPressed(["Z", "X", "C", "V", "B", "N"]);

	 	if (up) {
	 		playerShip.drag.x = 0;
	 		playerShip.drag.y = 0;
	 		playerShip.angularDrag = ngDragFactor;
	 		playerShip.acceleration.x = Math.cos(playerShip.angle * (Math.PI / 180)) * accelFactor;
	 		playerShip.acceleration.y = Math.sin(playerShip.angle * (Math.PI / 180)) * accelFactor;
	 	} else if (down) {
	 		playerShip.acceleration.x = 0;
	 		playerShip.acceleration.y = 0;
	 		var nx = 0;
	 		var ny = 0;
	 		var vl = Math.sqrt(Math.pow(playerShip.velocity.x, 2) + Math.pow(playerShip.velocity.y, 2));
	 		if (vl == 0) {
	 			vl = 1;
	 		}
	 		// var vl = FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		var nx = playerShip.velocity.x / vl;
	 		var ny = playerShip.velocity.y / vl;
	 		playerShip.drag.x = Math.abs(nx)*dragFactor*stopLevel;
	 		playerShip.drag.y = Math.abs(ny)*dragFactor*stopLevel;
	 		playerShip.angularAcceleration = 0;
	 		playerShip.angularDrag = ngDragFactor*2;
	 		stopLevel += stopFactor;
	 	} else if (right) {
	 		playerShip.angularDrag = 0;
	 		playerShip.angularAcceleration += ngAccelFactor;
	 		playerShip.acceleration.x = Math.cos((playerShip.angle * (Math.PI / 180))+rotationOffset)*handlingFactor*accelFactor;
	 		playerShip.acceleration.y = Math.sin((playerShip.angle * (Math.PI / 180))+rotationOffset)*handlingFactor*accelFactor;
	 		var nx = playerShip.velocity.x / FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		var ny = playerShip.velocity.y / FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		playerShip.drag.x = Math.abs(nx)*sideDrag;
	 		playerShip.drag.y = Math.abs(ny)*sideDrag;
	 	} else if (left) {
	 		playerShip.angularDrag = 0;
	 		playerShip.angularAcceleration -= ngAccelFactor;
	 		playerShip.acceleration.x = Math.cos((playerShip.angle * (Math.PI / 180))-rotationOffset)*handlingFactor*accelFactor;
	 		playerShip.acceleration.y = Math.sin((playerShip.angle * (Math.PI / 180))-rotationOffset)*handlingFactor*accelFactor;
	 		var nx = playerShip.velocity.x / FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		var ny = playerShip.velocity.y / FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		playerShip.drag.x = Math.abs(nx)*sideDrag;
	 		playerShip.drag.y = Math.abs(ny)*sideDrag;
	 	} else {
	 		stopLevel = 0;
	 		playerShip.acceleration.x = 0;
	 		playerShip.acceleration.y = 0;
	 		if (!allStop) {
	 			playerShip.drag.x = 0;
	 			playerShip.drag.y = 0;
	 			playerShip.angularDrag = ngDragFactor;
	 		}
	 		playerShip.angularAcceleration = 0;

	 	}

	 	if (zup) {
	 		accelerateZ(zAccelFactor, 0);
	 	} else if (zdown) {
	 		accelerateZ(-zAccelFactor, 0);
	 	} else if (zstop) {
	 		accelerateZ(0, zDragFactor);
	 	} else {
	 		accelerateZ(0);
	 	}

	 	if (FlxG.keys.justReleased.DOWN) {
	 		stopLevel = 0;
	 	} else if (FlxG.keys.justReleased.SPACE && Math.abs(playerShip.velocity.x)+Math.abs(playerShip.velocity.y) != 0) {
	 		allStop = true;
	 		var nx = playerShip.velocity.x / FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		var ny = playerShip.velocity.y / FlxMath.vectorLength(playerShip.velocity.x, playerShip.velocity.y);
	 		playerShip.drag.x = Math.abs(nx)*allStopDrag;
	 		playerShip.drag.y = Math.abs(ny)*allStopDrag;
	 		playerShip.angularDrag = allStopDrag*4;
	 	}

	 	if (Math.abs(playerShip.velocity.x)+Math.abs(playerShip.velocity.y) == 0 && playerShip.angularVelocity == 0) {
	 		playerShip.drag.x = 0;
	 		playerShip.drag.y = 0;
	 		stopLevel = 0;
	 		playerShip.angularDrag = ngDragFactor;
	 		allStop = false;
	 	} else {
	 		pin += e;
	 		if (pin > .5) {
	 			dropPin();
	 			pin = 0;
	 		}
	 	}

	 	updateZ(e);
	 }

	 private function accelerateZ(accel:Float, ?drag:Float=0) {
	 	if (drag != 0) {
	 		zVelocity = (zVelocity + accel)/drag;
	 		if (Math.abs(zVelocity) < zStopThreshold) {
	 			zVelocity = 0;
	 		}
	 	} else {
	 		zVelocity += accel;
	 	}
	 }

	 private function updateZ(e:Float):Void {
	 	shipZ += zVelocity;
	 	field.updateZ(playerShip.x, playerShip.y, shipZ);
	 }

	 private function dropPin():Void {
	 	var _pin = new FlxSprite(playerShip.x,playerShip.y);
	 	_pin.loadGraphic("assets/images/pin.png");
	 	// add(pin);
	 	field.addSprite(_pin, playerShip.x, playerShip.y, shipZ);
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

	 private function objField(n:Int):Void {
	 	var i = 0;
	 	var j = 0;
	 	while (i < n) {
	 		while (j < n) {
	 			var o = new FlxSprite(32*i, 32*j);
	 			o.loadGraphic("assets/images/pin2.png");
	 			// var blip = new FlxSprite(playerShip.x,playerShip.y);
	 			// blip.loadGraphic("assets/images/blip.png");
	 			field.addSprite(o, 32*i, 32*j, .0);
	 			// field.addSprite(blip, 32*i, 32*j, .0, false);
	 			j++;
	 		}
	 		j = 0;
	 		i++;
	 	}
	 	var ob = new FlxSprite(50, 44);
	 	ob.loadGraphic("assets/images/pin.png");
	 	field.addSprite(ob, 50, 44, .0, true);
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