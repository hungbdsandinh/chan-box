package data {

import flash.display.Bitmap;
import flash.display.Sprite;

public class Key extends Sprite {
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_play/lock.png')]
  public const Lock:Class;

  public function Key(x:int, y:int) {
    graphics.clear();

    var bg:Bitmap = new Lock;

    bg.scaleX = bg.scaleY = .9;

    addChild(bg);

    this.x = x;
    this.y = y;

    this.width = 50;
    this.height = 50;
  }
}
}
