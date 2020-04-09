package data {

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

public class Level extends Sprite{
//  [Embed(source="../com/example/HexagonNumberMatrix/daythung/font/UTM_AVOBOLD.TTF",
//          fontName="UTMfont",
//          mimeType = "application/x-font",
//          fontWeight="normal",
//          fontStyle="normal",
//          advancedAntiAliasing="true",
//          embedAsCFF="false")]
//  public const UTMfont:Class;
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_lv/lv.png')]
  public const Lv:Class;
  [Embed(source='../com/example/HexagonNumberMatrix/daythung/cut_lv/lock.png')]
  public const Lock:Class;

  public var lv: Number = Number(0);
  public var imgLv: Bitmap = new Bitmap();
  public var lvTxt : TextField = new TextField();

  public function Level(lv: Number,unlock: Boolean) {
    this.lv = lv;
    lvTxt.text = lv.toString();
    imgLv.scaleX = imgLv.scaleY = .1;

    var formatText:TextFormat = new TextFormat();
    formatText.size = 60;
    formatText.bold = true;
    formatText.color = "0xffffff";
//    formatText.font = "UTMfont";

    imgLv = unlock ? new Lv : new Lock;

    addChild(imgLv);

    if(unlock){
      lvTxt.defaultTextFormat = formatText;
      lvTxt.autoSize = TextFieldAutoSize.CENTER;
      lvTxt.text = this.lv.toString();
      lvTxt.mouseEnabled = false;
      lvTxt.x = (imgLv.width - lvTxt.width)/2;
      lvTxt.y = (imgLv.height - lvTxt.height)/2;
      buttonMode = true;

      addChild(lvTxt);
    }
  }
}
}
