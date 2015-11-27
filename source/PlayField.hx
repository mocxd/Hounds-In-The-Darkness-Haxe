package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

/**
 * A FlxState which can be used for the actual gameplay.
 */
 class PlayField extends FlxGroup
 {

    var fieldObjects:Array<FlxSprite> = new Array();
    var fieldMark:Array<Bool> = new Array();
    var fieldMarkText = new FlxText(0, 0, 100, "mark");
    var fieldXYZ:Array<Point3D> = new Array();
    private var explodeFactor = 10;
    private var zoomFactor = 1.5;

    public function init() {
        add(fieldMarkText);
    }

    public function addSprite(obj:FlxSprite, x:Float, y:Float, z:Float, ?mark:Bool=true) {
        add(obj);
        fieldObjects.push(obj);
        fieldXYZ.push(new Point3D(x,y,z));
        fieldMark.push(mark);
    }

    public function updateZ(posX:Float, posY:Float, posZ:Float) {
        for (i in 0...fieldObjects.length) {
            var d = Math.sqrt(Math.pow(fieldXYZ[i].x-posX, 2)+Math.pow(fieldXYZ[i].y-posY, 2));
            var m = (fieldXYZ[i].y-posY)/(fieldXYZ[i].x-posX);
            var nx = (fieldXYZ[i].x-posX);
            var ny = (fieldXYZ[i].y-posY);
            if ((posZ-fieldXYZ[i].z) > -1) {
                fieldObjects[i].x = fieldXYZ[i].x+(posZ-fieldXYZ[i].z)*nx;
                fieldObjects[i].y = fieldXYZ[i].y+(posZ-fieldXYZ[i].z)*ny;
            } else {
                fieldObjects[i].x = posX;
                fieldObjects[i].y = posY;
            }
            if (zoomFactor*(posZ-fieldXYZ[i].z) > 0) {
                fieldObjects[i].scale.x = zoomFactor*(posZ-fieldXYZ[i].z);
                fieldObjects[i].scale.y = zoomFactor*(posZ-fieldXYZ[i].z);
            } else {
                fieldObjects[i].scale.x = 0;
                fieldObjects[i].scale.y = 0;
            }
            if (fieldMark[i] && (posZ-fieldXYZ[i].z) > -1) {
                fieldMarkText.x = fieldXYZ[i].x+(posZ-fieldXYZ[i].z)*nx;
                fieldMarkText.y = fieldXYZ[i].y+(posZ-fieldXYZ[i].z)*ny;
            } else {
                fieldMarkText.x = posX;
                fieldMarkText.y = posY;
            }
        }
    }
}
