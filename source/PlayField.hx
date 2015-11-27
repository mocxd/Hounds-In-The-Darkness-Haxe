package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
 class PlayField extends FlxGroup
 {

    var fieldObjects:Array<FlxSprite> = new Array();
    var fieldXYZ:Array<Point3D> = new Array();
    private var explodeFactor = 10;
    private var zoomFactor = 1.5;

    public function addSprite(obj:FlxSprite, x:Float, y:Float, z:Float) {
        add(obj);
        fieldObjects.push(obj);
        fieldXYZ.push(new Point3D(x,y,z));
    }

    public function updateZ(posX:Float, posY:Float, posZ:Float) {
        for (i in 0...fieldObjects.length) {
            var d = Math.sqrt(Math.pow(fieldXYZ[i].x-posX, 2)+Math.pow(fieldXYZ[i].y-posY, 2));
            var m = (fieldXYZ[i].y-posY)/(fieldXYZ[i].x-posX);
            var nx = (fieldXYZ[i].x-posX);
            var ny = (fieldXYZ[i].y-posY);
            fieldObjects[i].x = fieldXYZ[i].x+posZ*nx;
            fieldObjects[i].y = fieldXYZ[i].y+posZ*ny;
            fieldObjects[i].scale.x = zoomFactor*posZ;
            fieldObjects[i].scale.y = zoomFactor*posZ;
        }
    }
}
