package data {

import flash.display.Bitmap;
import flash.display.Sprite;

public class Container extends Sprite {
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_play/block.png')]
  public const Block:Class;
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_play/lock.png')]
  public const Lock:Class;

  public function Container(x:int, y:int, _type:int) {
    graphics.clear();

    switch (_type) {
      case 1:
        var block:Bitmap = new Block;

        block.scaleX = block.scaleY = .9;

        addChild(block);
        break;
      case 3:
        var key:Bitmap = new Lock;

        key.scaleX = key.scaleY = .9;

        addChild(key);
        break;
      default:
        break;
    }

    this.x = x;
    this.y = y;

    this.width = 50;
    this.height = 50;
  }
}
}
