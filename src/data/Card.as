package data {

import de.polygonal.ds.Array3;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.geom.Matrix;

import net.sandinh.components.Colors;

public class Card extends Sprite{
    public var number : Number;
    public var numberLv : Number;
    private var text : TextField = new TextField();
    private var lvText : TextField = new TextField();
    private var matrix: Array = [
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0],
      [0,0,0,0,0,0]
    ];

    public function Card(numberLv: int) {
        this.numberLv = numberLv + 5;
        this.number = random(-2,2);
        var formatText:TextFormat = new TextFormat();
        formatText.size = 120;
        formatText.color = Colors.BLUE;
        text.defaultTextFormat = formatText;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = this.number.toString();
        text.mouseEnabled = false;

        var formatLvText:TextFormat = new TextFormat();
        formatLvText.size = 40;
        formatLvText.color = Colors.RED;
        lvText.defaultTextFormat = formatLvText;
        lvText.autoSize = TextFieldAutoSize.CENTER;
        lvText.text = this.numberLv.toString();
        lvText.mouseEnabled = false;
        lvText.y = text.y - 30;
        addChild(text);
        addChild(lvText);
        buttonMode = true;

        if(numberLv == 0){
            removeChild(lvText);
        }
    }

    public function onClick(e: MouseEvent): void {
        this.number = this.random(-10,10);
        this.numberLv -= 1;

        if(this.numberLv == 0) {
            removeChild(text);
            this.numberLv = 0;
        }

        text.text = this.number.toString();
        lvText.text = this.numberLv.toString();
    }

    public function random(min:int, max:int):int {
        if (min == max) return min;
        if (min < max) return min + (Math.random() * (max - min + 1));
        else return max + (Math.random() * (min - max + 1));
    }

    public function sumResult(num : Number): void {
        this.number += num;
        text.text = this.number.toString();
    }

    public function getLevel() : Number {
        return this.numberLv
    }
}
}
