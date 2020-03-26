package data {

import flash.display.Bitmap;
import flash.display.Sprite;

public class Warehouseman extends Sprite {
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_play/me.png')]
  public const Block:Class;

  public function Warehouseman(x:int, y:int) {
    graphics.clear();

    var bg:Bitmap = new Block;

    bg.scaleX = bg.scaleY = .9;

    addChild(bg);

    this.x = x;
    this.y = y;

    this.width = 50;
    this.height = 50;
  }
}
}
