package com.example.HexagonNumberMatrix {

import data.*;

import flash.data.EncryptedLocalStore;

import flash.display.BitmapData;
import flash.display.PixelSnapping;

import flash.events.*;

import data.Container;
import data.Warehouseman;

import flash.geom.Matrix;
import flash.geom.Rectangle;


import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

import com.greensock.TweenLite;

import flash.display.DisplayObject;
import flash.text.TextFieldAutoSize;
import flash.utils.ByteArray;

[SWF(width=960, height=620)]
public class ChanBoxMain extends Sprite {

//  [Embed(source="daythung/font/UTM AVOBOLD.TTF",
//          fontName="UTMfont",
//          mimeType = "application/x-font",
//          fontWeight="normal",
//          fontStyle="normal",
//          advancedAntiAliasing="true",
//          embedAsCFF="false")]
//  public const UTMfont:Class;

  [Embed(source='daythung/cut_play/phai.png')]
  private const BtnRight:Class;
  [Embed(source='daythung/cut_play/trai.png')]
  private const BtnLeft:Class;
  [Embed(source='daythung/cut_play/len.png')]
  private const BtnUp:Class;
  [Embed(source='daythung/cut_play/xuong.png')]
  private const BtnDown:Class;
  [Embed(source='daythung/menu/play.png')]
  private const BtnStart:Class;
  [Embed(source='daythung/menu/bg.png')]
  private const BGStart:Class;
  [Embed(source='daythung/cut_lv/bg.png')]
  private const BGLevels:Class;
  [Embed(source='daythung/cut_play/bg.png')]
  private const BGPlay:Class;
  [Embed(source='daythung/cut_lv/back.png')]
  private const BGLevelsBack:Class;
  [Embed(source='daythung/cut_play/huongdan1.png')]
  private const Line:Class;
  [Embed(source='daythung/cut_lv/volume.png')]
  private const BGVolume:Class;
  [Embed(source='img/ButtonClick.mp3')]
  private const MoveSound:Class;
  [Embed(source='img/Win.mp3')]
  private const WinSound:Class;
  [Embed(source='daythung/cut_winlose/bg_win.png')]
  private const BGWin:Class;
  [Embed(source='daythung/cut_winlose/bg_lose.png')]
  private const BGLose:Class;
  [Embed(source='daythung/cut_winlose/match_replay_icon_777727.png')]
  private const Reload:Class;
  [Embed(source='daythung/cut_winlose/Nuvola_arrow_left_pink copy 2.png')]
  private const Home:Class;
  [Embed(source='daythung/cut_winlose/Nuvola_arrow_left_pink copy 3.png')]
  private const Next:Class;

  private var widthBoard:int = 8;
  private var heightBoard:int = 14;

  private var startLevel:int = 1;
  private var currentLevel:int = 1;
  private var maxLevel:int = 16;

  private var win:int = 0;

  public var Consts:Object = {
    GAME_WIDTH:960,
    GAME_HEIGHT:620
  };

  /**
   * 1 = wall
   * 2 = point
   * 3 = key
   * 4 = warehouseman
   */
  private var matrix:Array = [
    [ //1
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 4, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 3, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //2
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 4, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 3, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //3
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 0, 4, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 3, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //4
      [0, 1, 0, 0, 0, 0, 3, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 4, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //5
      [0, 0, 1, 0, 0, 4, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 3, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //6
      [0, 0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 3, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 4, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //7
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 3, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 4, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //8
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 4, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1, 3, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //9
      [0, 0, 4, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 1, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 3, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //10
      [0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 3, 0, 0, 1, 0, 0],
      [0, 0, 1, 1, 1, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 4, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //11
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 3, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 4, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //12
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 4, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 3, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //13
      [0, 0, 1, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 0, 0, 0, 0],
      [0, 0, 0, 3, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [4, 0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [1, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //14
      [0, 1, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 1, 0],
      [1, 1, 1, 1, 4, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 3, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //15
      [0, 1, 0, 0, 0, 1, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 4, 0, 0, 1, 0],
      [3, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 1, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ],
    [ //16
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 3, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1, 0],
      [1, 0, 0, 0, 0, 0, 0, 4, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 1, 0],
      [0, 1, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
  ];

  public var winSound:* = new WinSound();
  public var moveSound:* = new MoveSound();

  public var mute:Boolean = false;

  private var warehouseman:Warehouseman = new Warehouseman(0, 0);

  private var startX:int = 40;
  private var startY:int = 150;

  private var containers:Array = new Array(Container);

  private var volumeOn:Volume= new Volume(true);
  private var volumeOff:Volume= new Volume(false);

  public function ChanBoxMain() {

    currentLevel = int(getLocalStorage("currentLevel"));

    if(!currentLevel){
      currentLevel = 1;

      saveLocalStorage("currentLevel","1");
    }

    welcomeGame();
  }

  private function welcomeGame():void {
    var popupWin:Sprite = new Sprite();
    popupWin.graphics.clear();
    popupWin.graphics.beginFill(0xFFFFFF, 0.9);
    popupWin.graphics.drawRoundRect(-86, 0, height, width, 0, 0);
    popupWin.graphics.endFill();
    addChild(popupWin);

    var bg:Bitmap = new BGStart();
    bg = getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
    addChild(bg);

    var btnStart:DisplayObject = new BtnStart();
    btnStart.scaleX = .9;
    btnStart.scaleY = .9;
    btnStart.x = Consts.GAME_WIDTH / 2 - btnStart.width / 2;
    btnStart.y = Consts.GAME_HEIGHT / 2 - btnStart.height / 2 + btnStart.height;

    var buttonWelcome:Sprite = new Sprite();
    buttonWelcome.graphics.clear();
    buttonWelcome.graphics.beginFill(0xD4D4D4, 0);
    buttonWelcome.graphics.drawEllipse(Consts.GAME_WIDTH / 2 - btnStart.width / 2, Consts.GAME_WIDTH / 2 - btnStart.height / 2, btnStart.width, btnStart.height);
    buttonWelcome.graphics.endFill();
    buttonWelcome.addChild(btnStart);

    buttonWelcome.buttonMode = true;

    addChild(buttonWelcome);

    buttonWelcome.addEventListener(MouseEvent.CLICK, mouseLevelHandler);
  }

  private function loadGame():void {
    while (this.numChildren > 0) {
      this.removeChildAt(0);
    }

    win = 0;

    var bg:Bitmap = new BGPlay();
    bg = getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
    addChild(bg);

    var bgLevelsBack:DisplayObject = new BGLevelsBack();

    bgLevelsBack.x = 30;
    bgLevelsBack.y = 20;

    bgLevelsBack.scaleX = bgLevelsBack.scaleY = .8;

    var buttonBack:Button = new Button(40, 15, mouseGoToWelcomeHandler);

    buttonBack.buttonMode = true;
    buttonBack.addChild(bgLevelsBack);

    addChild(buttonBack);

    volumeOff.x = Consts.GAME_WIDTH - 120;
    volumeOff.y = 20;

    addChild(volumeOff);

    volumeOff.addEventListener(MouseEvent.CLICK, mouseSoundOnHandler);

    volumeOn.x = Consts.GAME_WIDTH - 120;
    volumeOn.y = 20;

    addChild(volumeOn);

    volumeOn.addEventListener(MouseEvent.CLICK, mouseSoundOffHandler);

    var levelText:TextField = new TextField();

    var formatText:TextFormat = new TextFormat();
    formatText.size = 40;
    formatText.bold = true;
    formatText.color = "0xffffff";
//    formatText.font = "UTMfont";

    levelText.autoSize = TextFieldAutoSize.CENTER;
    levelText.x = Consts.GAME_WIDTH / 2;
    levelText.y = 25;
    levelText.defaultTextFormat = formatText;

    levelText.text = "LEVEL " + (startLevel + 1);
    addChild(levelText);

    if(startLevel >= maxLevel){
      var comingSoonText:TextField = new TextField();

      comingSoonText.autoSize = TextFieldAutoSize.CENTER;
      comingSoonText.x = Consts.GAME_WIDTH / 2;
      comingSoonText.y = Consts.GAME_HEIGHT / 2;
      comingSoonText.defaultTextFormat = formatText;

      comingSoonText.text = "Coming soon";
      addChild(comingSoonText);

      return;
    }

    var btnRight:DisplayObject = new BtnRight();
    btnRight.scaleX = btnRight.scaleY = 0.9;

    btnRight.x = Consts.GAME_WIDTH - 140;
    btnRight.y = Consts.GAME_HEIGHT - btnRight.height - 90;

    addChild(btnRight);

    var buttonRight:Button = new Button(btnRight.x, btnRight.y, mouseRightHandler);

    addChild(buttonRight);

    var btnUp:DisplayObject = new BtnUp();
    btnUp.scaleX = btnUp.scaleY = 0.9;

    btnUp.x = Consts.GAME_WIDTH - btnUp.width - 130;
    btnUp.y = Consts.GAME_HEIGHT - btnRight.height - btnUp.height - 70;

    addChild(btnUp);

    var buttonUp:Button = new Button(btnUp.x, btnUp.y, mouseUpHandler);

    addChild(buttonUp);

    var btnLeft:DisplayObject = new BtnLeft();
    btnLeft.scaleX = btnLeft.scaleY = 0.9;

    btnLeft.x = Consts.GAME_WIDTH - btnUp.width - btnLeft.width - 120;
    btnLeft.y = Consts.GAME_HEIGHT - btnLeft.height - 90;

    addChild(btnLeft);

    var buttonLeft:Button = new Button(btnLeft.x, btnLeft.y, mouseLeftHandler);

    addChild(buttonLeft);

    var btnDown:DisplayObject = new BtnDown();
    btnDown.scaleX = btnDown.scaleY = 0.9;

    btnDown.x = Consts.GAME_WIDTH - btnDown.width - 130;
    btnDown.y = Consts.GAME_HEIGHT - 110;

    addChild(btnDown);

    var buttonDown:Button = new Button(btnDown.x, btnDown.y, mouseDownHandler);

    addChild(buttonDown);

    if (startLevel == 0) {
      var helpLine:DisplayObject = new Line();
      helpLine.scaleX = helpLine.scaleY = 0.9;

      helpLine.x = startX + 185;
      helpLine.y = bg.height - 170;

      addChild(helpLine);

      var formatTextHelp:TextFormat = new TextFormat();
      formatTextHelp.size = 24;
      formatTextHelp.bold = true;
      formatTextHelp.color = "0xffffff";
//      formatTextHelp.font = "UTMfont";

      var helpText1:TextField = new TextField();

      helpText1.autoSize = TextFieldAutoSize.CENTER;
      helpText1.x = helpLine.x+160;
      helpText1.y = bg.height - 150;
      helpText1.defaultTextFormat = formatTextHelp;

      helpText1.text = "How to play: Use 4 control button";
      addChild(helpText1);

      var helpText2:TextField = new TextField();

      helpText2.autoSize = TextFieldAutoSize.CENTER;
      helpText2.defaultTextFormat = formatTextHelp;
      helpText2.x = helpLine.x+160;
      helpText2.y = bg.height - 120;

      helpText2.text = "to move the green box to the key.";

      addChild(helpText2);
    }

    for (var i:int = 0; i < heightBoard; i++) {
      for (var j:int = 0; j < widthBoard; j++) {
        if (matrix[startLevel][i][j] == 1 || matrix[startLevel][i][j] == 3) {
          var container:Container = new Container(startX + i * 50, startY + j * 50, matrix[startLevel][i][j]);

          containers[j * heightBoard + i] = container;

          addChild(container);
        }

        if (matrix[startLevel][i][j] == 4) {
          warehouseman.x = startX + i * 50;
          warehouseman.y = startY + j * 50;

          addChild(warehouseman);
        }
      }
    }
  }

  private function loadLevels():void {
    while (this.numChildren > 0) {
      this.removeChildAt(0);
    }

    var bg:Bitmap = new BGLevels();
    bg = getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);

    addChild(bg);

    var bgLevelsBack:DisplayObject = new BGLevelsBack();

    bgLevelsBack.x = 60;
    bgLevelsBack.y = 20;

    bgLevelsBack.scaleX = bgLevelsBack.scaleY = 0.8;

    var buttonBack:Button = new Button(40, 15, mouseGoToWelcomeHandler);

    buttonBack.buttonMode = true;
    buttonBack.addChild(bgLevelsBack);

    addChild(buttonBack);

    volumeOff.x = Consts.GAME_WIDTH - 140;
    volumeOff.y = 20;

    addChild(volumeOff);

    volumeOff.addEventListener(MouseEvent.CLICK, mouseSoundOnHandler);

    volumeOn.x = Consts.GAME_WIDTH - 140;
    volumeOn.y = 20;

    addChild(volumeOn);

    volumeOn.addEventListener(MouseEvent.CLICK, mouseSoundOffHandler);

    var levels:Array = new Array(Level);

    for (var i:int = 0; i < 18; i++) {
      levels[i] = new Level(i + 1, i < currentLevel);

      levels[i].x = bg.x + ((Consts.GAME_WIDTH / 6 - levels[i].width) / 2) + (i % 6) * ((Consts.GAME_WIDTH - 120) / 6) + 50;
      levels[i].y = bg.y + (Consts.GAME_HEIGHT / 3 - levels[i].height) / 2 + (levels[i].height + 30) * (int(i / 6)) + 100;

      addChild(levels[i]);

      if(i < currentLevel){
        levels[i].addEventListener(MouseEvent.MOUSE_DOWN, onLoadGame);
      }
    }
  }

  private function onLoadGame(e:MouseEvent):void {
    startLevel = e.target.lv - 1;

    loadGame();

    playMoveSound();
  }

  private function mouseUpHandler(event:MouseEvent):void {
    var distance:int = warehouseman.y;

    var positionStart:int = distance;

    while (true) {
      var i:int = (warehouseman.x - startX) / 50;
      var j:int = (distance - startY) / 50;

      if (matrix[startLevel][i][j - 1] == 3) {
        win = 1;
        break;
      }

      if (j <= 0) {
        win = -1;

        break;
      }

      if (matrix[startLevel][i][j - 1] == 1) {

        break;
      }

      distance -= 50;
    }

    var duration:Number = .025 * ((positionStart - distance) / 50);

    TweenLite.to(warehouseman, duration, {y: distance});

    playMoveSound();

    TweenLite.delayedCall(duration+.2, winHandler);

    var jNew:int = (distance - startY) / 50;
    var iNew:int = (warehouseman.x - startX) / 50;

    if (jNew >= 1 && (matrix[startLevel][iNew][jNew - 1] == 1 || matrix[startLevel][iNew][jNew - 1] == 3)) {
      TweenLite.delayedCall(duration, function ():void {
        var Y:int = containers[(jNew - 1) * heightBoard + iNew].y;
        TweenLite.to(containers[(jNew - 1) * heightBoard + iNew], .05, {y: Y - 10});
        TweenLite.delayedCall(.05, function ():void {
          TweenLite.to(containers[(jNew - 1) * heightBoard + iNew], .05, {y: Y});
        });
      });
    }
  }

  private function mouseDownHandler(event:MouseEvent):void {
    var distance:int = warehouseman.y;

    var yStart:int = distance;

    while (true) {
      var i:int = (warehouseman.x - startX) / 50;
      var j:int = (distance - startY) / 50;

      if (matrix[startLevel][i][j + 1] == 3) {
        win = 1;
        break;
      }

      if (j >= widthBoard) {
        win = -1;
        break;
      }

      if (matrix[startLevel][i][j + 1] == 1) {
        break;
      }

      distance += 50;
    }

    var duration:Number = .025 * ((distance - yStart) / 50);

    TweenLite.to(warehouseman, duration, {y: distance});

    playMoveSound();

    TweenLite.delayedCall(duration+.2, winHandler);

    var jNew:int = (distance - startY) / 50;
    var iNew:int = (warehouseman.x - startX) / 50;

    if (jNew  < heightBoard - 1  && (matrix[startLevel][iNew][jNew + 1] == 1 || matrix[startLevel][iNew][jNew + 1] == 3)) {
      TweenLite.delayedCall(duration, function ():void {
        var Y:int = containers[(jNew + 1) * heightBoard + iNew].y;
        TweenLite.to(containers[(jNew + 1) * heightBoard + iNew], .05, {y: Y + 10});
        TweenLite.delayedCall(.05, function ():void {
          TweenLite.to(containers[(jNew + 1) * heightBoard + iNew], .05, {y: Y});
        });
      });
    }
  }

  private function mouseSoundOnHandler(event:MouseEvent):void {
    mute = !mute;

    volumeOn.visible=true;
    volumeOff.visible=false;
  }

  private function mouseSoundOffHandler(event:MouseEvent):void {
    mute = !mute;

    volumeOn.visible=false;
    volumeOff.visible=true;
  }

  private function mouseLeftHandler(event:MouseEvent):void {
    var distance:int = warehouseman.x;

    var xStart:int = distance;

    while (true) {
      var i:int = (distance - startX) / 50;
      var j:int = (warehouseman.y - startY) / 50;

      if (i < 1) {
        win = -1;
        break;
      }

      if (matrix[startLevel][i - 1][j] == 3) {
        win = 1;
        break;
      }

      if (matrix[startLevel][i - 1][j] == 1) {
        break;
      }

      distance -= 50;
    }

    var duration:Number = .025 * ((xStart - distance) / 50);

    TweenLite.to(warehouseman, duration, {x: distance});

    playMoveSound();

    TweenLite.delayedCall(duration+.2, winHandler);

    var iNew:int = (distance - startX) / 50;
    var jNew:int = (warehouseman.y - startY) / 50;

    if (iNew >= 1 && (matrix[startLevel][iNew -1][jNew] == 1 || matrix[startLevel][iNew -1][jNew] == 3)) {
      TweenLite.delayedCall(duration, function ():void {
        var X:int = containers[(jNew) * heightBoard + iNew-1].x;
        TweenLite.to(containers[(jNew) * heightBoard + iNew-1], .05, {x: X - 10});
        TweenLite.delayedCall(.05, function ():void {
          TweenLite.to(containers[(jNew) * heightBoard + iNew-1], .05, {x: X});
        });
      });
    }
  }

  private function winHandler():void {
    if (win == 1) {
      if(!mute){
        winSound.play();
      }

      if(startLevel >= currentLevel){
        currentLevel++;

        saveLocalStorage("levelCurrent",currentLevel.toString());
      }

      startLevel++;

      popupWin(new BGWin());
    }

    if (win == -1) {
      popupWin(new BGLose());
    }
  }

  private function mouseRightHandler(event:MouseEvent):void {
    var distance:int = warehouseman.x;

    var xStart:int = distance;

    while (true) {
      var i:int = (distance - startX) / 50;
      var j:int = (warehouseman.y - startY) / 50;

      if ((i+1) >= 14){
        win = -1;
        break;
      }

      if (matrix[startLevel][i + 1][j] == 3) {
        win = 1;
        break;
      }

      if (i >= heightBoard) {
        win = -1;
        break;
      }

      if (matrix[startLevel][i + 1][j] == 1) {
        break;
      }

      distance+= 50;
    }

    var duration:Number = .025 * ((distance - xStart) / 50);

    TweenLite.to(warehouseman, duration, {x: distance});

    playMoveSound();

    TweenLite.delayedCall(duration, winHandler);

    var iNew:int = (distance - startX) / 50;
    var jNew:int = (warehouseman.y - startY) / 50;

    if (iNew + 1 < heightBoard && (matrix[startLevel][iNew+1][jNew] == 1 || matrix[startLevel][iNew+1][jNew] == 3)) {
      TweenLite.delayedCall(duration, function ():void {
        var X:int = containers[(jNew) * heightBoard + iNew+1].x;
        TweenLite.to(containers[(jNew) * heightBoard + iNew+1], .05, {x: X + 10});
        TweenLite.delayedCall(.05, function ():void {
          TweenLite.to(containers[(jNew) * heightBoard + iNew+1], .05, {x: X});
        });
      });
    }
  }

  private function mouseLevelHandler(event:MouseEvent):void {
    loadLevels();

    playMoveSound();
  }

  private function mouseGoToWelcomeHandler(event:MouseEvent):void {
    welcomeGame();

    playMoveSound();
  }

  private function popupWin(bg:Bitmap):void {
    bg = getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);

    var popupWin:Sprite = new Sprite();
    popupWin.graphics.clear();
    popupWin.graphics.beginFill(0xFFFFFF, 0.2);
    popupWin.graphics.drawRoundRect(-86, 0, 640, 920, 0, 0);
    popupWin.graphics.endFill();
    addChild(popupWin);

    addChild(bg);

    var reloadBtn:Sprite = new Sprite();
    var homeBtn:Sprite = new Sprite();
    var nextBtn:Sprite = new Sprite();

    function drawHomeButton():void {
      var home:DisplayObject = new Home();

      homeBtn.graphics.clear();
      homeBtn.graphics.beginFill(0x5D527D, 0);
      homeBtn.graphics.drawRect(0, 0, home.width, home.height);
      homeBtn.x = bg.x + (bg.width - homeBtn.width) / 2 - home.width - 10;
      homeBtn.y = bg.height - 140;
      homeBtn.graphics.endFill();
      homeBtn.buttonMode = true;

      home.x = homeBtn.x;
      home.y = homeBtn.y;

      home.scaleX = home.scaleY = 0.8;

      addChild(home);
    }

    function drawReloadButton():void {
      var reload:DisplayObject = new Reload();

      reloadBtn.graphics.clear();
      reloadBtn.graphics.beginFill(0x5D527D, 0);
      reloadBtn.graphics.drawRect(0, 0, 100, 50);
      reloadBtn.x = bg.x + (bg.width + reloadBtn.width) / 2 + 30;
      reloadBtn.y = bg.height - 140;
      reloadBtn.graphics.endFill();
      reloadBtn.buttonMode = true;

      reload.x = reloadBtn.x;
      reload.y = reloadBtn.y;

      reload.scaleX = reload.scaleY = 0.8;

      addChild(reload);
    }

    function drawNextButton():void {
      nextBtn.graphics.clear();
      nextBtn.graphics.beginFill(0x5D527D, 0);
      nextBtn.graphics.drawRect(0, 0, 100, 50);
      nextBtn.x = bg.x + (bg.width - nextBtn.width) / 2 + 5;
      nextBtn.y = bg.height - 140;
      nextBtn.graphics.endFill();
      nextBtn.buttonMode = true;
      var next:DisplayObject = new Next();
      next.x = nextBtn.x;
      next.y = nextBtn.y;

      next.scaleX = next.scaleY = 0.8;

      addChild(next);
    }

    function resetGameInPop(event:MouseEvent):void {
      if(win == 1){
        startLevel--;
      }

      loadGame();
    }

    function goToLevelsInPop(event:MouseEvent):void {
      loadLevels();
    }

    function nextLevelInPop(event:MouseEvent):void {
      loadGame();
    }

    addChild(homeBtn);
    homeBtn.addEventListener(MouseEvent.MOUSE_DOWN, goToLevelsInPop);

    addChild(reloadBtn);
    reloadBtn.addEventListener(MouseEvent.MOUSE_DOWN, resetGameInPop);

    addChild(nextBtn);
    nextBtn.addEventListener(MouseEvent.MOUSE_DOWN, nextLevelInPop);

    drawHomeButton();

    if(win == 1){
      drawNextButton();
    }

    drawReloadButton();
  }

  public static function getFitImage(object:DisplayObject,
                                     toWidth:Number,
                                     toHeight:Number,
                                     isCenter:Boolean = true,
                                     isFillBox:Boolean = true):Bitmap {

    var tempW:Number = object.width;
    var tempH:Number = object.height;

    object.width = toWidth;
    object.height = toHeight;

    var scale:Number = (isFillBox) ? Math.max(object.scaleX, object.scaleY) :
            Math.min(object.scaleX, object.scaleY);

    object.width = tempW;
    object.height = tempH;

    var scaleBmpd:BitmapData = new BitmapData(object.width * scale, object.height * scale);
    var scaledBitmap:Bitmap = new Bitmap(scaleBmpd, PixelSnapping.ALWAYS, true);
    var scaleMatrix:Matrix = new Matrix();
    scaleMatrix.scale(scale, scale);
    scaleBmpd.draw(object, scaleMatrix);

    if (scaledBitmap.width > toWidth || scaledBitmap.height > toHeight) {

      var cropMatrix:Matrix = new Matrix();
      var cropArea:Rectangle = new Rectangle(0, 0, toWidth, toHeight);

      var croppedBmpd:BitmapData = new BitmapData(toWidth, toHeight);
      var croppedBitmap:Bitmap = new Bitmap(croppedBmpd, PixelSnapping.ALWAYS, true);

      if (isCenter) {
        var offsetX:Number = Math.abs((toWidth - scaleBmpd.width) / 2);
        var offsetY:Number = Math.abs((toHeight - scaleBmpd.height) / 2);

        cropMatrix.translate(-offsetX, -offsetY);
      }

      croppedBmpd.draw(scaledBitmap, cropMatrix, null, null, cropArea, true);
      return croppedBitmap;

    } else {
      return scaledBitmap;
    }
  }

  private static function saveLocalStorage(k:String, v:String):void {
    var bytes:ByteArray = new ByteArray();
    bytes.writeUTFBytes(v);
    EncryptedLocalStore.setItem(k, bytes);
  }

  private static function getLocalStorage(k:String):* {
    var storedValue:ByteArray = EncryptedLocalStore.getItem(k);
    if (storedValue != null) {
      return storedValue.readUTFBytes(storedValue.length)
    } else {
      return null;
    }
  }

  private function playMoveSound():void {
    if(!mute){
      moveSound.play();
    }
  }
}
}
