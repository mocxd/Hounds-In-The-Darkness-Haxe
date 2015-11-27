package;

/**
 * A FlxState which can be used for the actual gameplay.
 */
 class Point3D
 {
    public var x:Float;
    public var y:Float;
    public var z:Float;

    public function new (?_x:Float=0, ?_y:Float=0, ?_z:Float=0) {
        x = _x;
        y = _y;
        z = _z;
    }
}