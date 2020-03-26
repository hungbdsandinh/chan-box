package data {

import flash.events.*;
import flash.display.Sprite;

public class Button extends Sprite {

  public function Button(x:int, y:int, func:Function) {
    graphics.clear();
    graphics.beginFill(0xFFFFFF, 0);
    graphics.drawRoundRect(x, y, 50, 50, 10, 10);
    graphics.endFill();

    buttonMode = true;

    addEventListener(MouseEvent.CLICK, func);
  }
}
}
