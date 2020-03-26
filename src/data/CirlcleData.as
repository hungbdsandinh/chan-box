package data {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;

public class CirlcleData{
    public var sprite:Sprite;
    public var id:int;
    public  var txtCurrentNumber:TextField;
    private var _isFillNumber:Boolean=false;
    private var _idBase:int;
    private var _isSetIntRandom:Boolean = false;
    private var _x:int;
    private var _y:int;
    private var _colorBase:ColorTransform;
    private var _isNumberSuggest:Boolean;
    private var _shape:Shape;
    private var _nearCircle:CirlcleData;
    public function get nearCircle():CirlcleData {
        return _nearCircle;
    }

    public function set nearCircle(value:CirlcleData):void {
        _nearCircle = value;
    }

    public function get shape():Shape {
        return _shape;
    }

    public function set shape(value:Shape):void {
        _shape = value;
    }

    public function get isNumberSuggest():Boolean {
        return _isNumberSuggest;
    }

    public function set isNumberSuggest(value:Boolean):void {
        _isNumberSuggest = value;
    }

    public function get colorBase():ColorTransform {
        return _colorBase;
    }

    public function set colorBase(value:ColorTransform):void {
        _colorBase = value;
    }


    public function get x():int {
        return _x;
    }

    public function set x(value:int):void {
        _x = value;
    }

    public function get y():int {
        return _y;
    }

    public function set y(value:int):void {
        _y = value;
    }

    public function get isSetIntRandom():Boolean {
        return _isSetIntRandom;
    }

    public function set isSetIntRandom(value:Boolean):void {
        _isSetIntRandom = value;
    }

    public function get idBase():int {
        return _idBase;
    }

    public function set idBase(value:int):void {
        _idBase = value;
    }

    public function CirlcleData() {

    }
    public function setText( n:int):void{
        txtCurrentNumber.text=n.toString();
    }
    public function setTextString( txt:String):void{
        txtCurrentNumber.text=txt;
    }
    public  function getText():TextField{
        return txtCurrentNumber;
    }

    public function get isFillNumber():Boolean {
        return _isFillNumber;
    }

    public function set isFillNumber(value:Boolean):void {
        _isFillNumber = value;
    }

}
}

