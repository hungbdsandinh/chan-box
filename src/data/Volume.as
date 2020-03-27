package data {

import flash.display.Bitmap;
import flash.display.Sprite;

public class Volume extends Sprite {
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_lv/volume.png')]
  public const VolumeUp:Class;
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_lv/volume2.png')]
  public const VolumeDown:Class;

  public function Volume(up:Boolean) {

    buttonMode = true;

    var bg:Bitmap = up ? new VolumeUp : new VolumeDown;

    bg.scaleX = bg.scaleY = .8;

    addChild(bg);
  }
}
}
