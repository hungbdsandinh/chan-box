package com.example.HexagonNumberMatrix {
import com.myflashlab.air.extensions.firebase.core.Firebase;
import com.myflashlab.air.extensions.firebase.fcm.FCM;
import com.myflashlab.air.extensions.firebase.fcm.FcmEvents;

import data.CirlcleData;
import data.NumberBaseData;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;

import net.sandinh.Consts;
import net.sandinh.room.services.IApi;

import net.sandinh.components.button.BitmapButton;
import net.sandinh.room.utils.SDUtils;


[SWF(width=960, height=620)]
public class DigitMain extends Sprite {

    public var api:IApi;

    var listSprite:Array = [];
    var sprite:Sprite = new Sprite();
    var sprite1:Sprite = new Sprite();
    var loader:Loader = new Loader();
    var n:int = 0;
    var nextNumber:int = 2;
    var txtNextNumber:TextField = new TextField();
    var listIntBase:Array = [];
    var numberNextBase:NumberBaseData = new NumberBaseData();
    var switchCheck:Boolean = true;
    var isPlusType:Boolean = true;
    var x1:int;
    var y1:int;
    var nLevel:int = 5;
    var rLevel:Number;
    var numShape = 0;
    var n2:int = nLevel / 2;
    var conf:int = 26;
    var confRight:int = 59;
    var listSrpiteLevel:Array = [];
    var listTxtLevel:Array = [];
    var numberSuggest:int = 9;
    var numberPoint:int = 4;
    var cir1Draw:CirlcleData = new CirlcleData();
    var cir2Draw:CirlcleData = new CirlcleData();
    var sizee:int = 30;
    var distanceX = 54;
    var distanceY = 47;
    var confDistanceShape:Number = 7;
    var time:int = 30; //in secs +1
    var delay:int = 1000; // in milliseconds
    public var myTimer:Timer = new Timer(0);
    var firstClick:Boolean = new Boolean;
    var posEachLevelY:int;
    var posMainButtonY:int = 65;

    //Embed Image
    [Embed(source='art/new_bg/main.jpg')]
    private const BGStart:Class;
    [Embed(source='art/new_bg/ingame.jpg')]
    private const bg_itSao:Class;
    [Embed(source='art/new_bg/win.jpg')]
    private const BGWIn:Class;
    [Embed(source='art/new_bg/lost.jpg')]
    private const BGLose:Class;
    [Embed(source='art/time.png')]
    private const timeSpriteImg:Class;

    [Embed(source='art/soundOff.png')]
    private const SoundOff:Class;

    [Embed(source='art/soundOn.png')]
    private const SoundOn:Class;

    [Embed(source='img/Logodo.png')]
    private const LogoSD:Class;
    [Embed(source='img/btnStart.png')]
    private const BtnStartChan:Class;
    private const BtnStart:Class;
    [Embed(source='art/new_bg/ingame.jpg')]
    private const BgIngame:Class;
    [Embed(source='art/pause.png')]
    private const btnPause:Class;
    [Embed(source='art/help.png')]
    private const BtnHelp:Class;
    [Embed(source='img/access-denied.png')]
    private const BtnClose:Class;
    [Embed(source='art/help.png')]
    private const HelpIcon:Class;
    [Embed(source='art/Vector Smart Object copy 7.png')]
    private const SiverIcon:Class;
    [Embed(source='art/Vector Smart Object copy 25.png')]
    private const Bronze:Class;
    [Embed(source='art/Vector Smart Object copy 24.png')]
    private const Gold:Class;
    [Embed(source='art/Vector Smart Object copy 3.png')]
    private const Platium:Class;
    [Embed(source='art/Vector Smart Object copy 23.png')]
    private const Diamond:Class;
    [Embed(source='art/Vector Smart Object copy 17.png')]
    private const Mater:Class;
    [Embed(source='art/btn_Resume.png')]
    private const Reload:Class;
    //embed  sound
    [Embed(source='img/ButtonClick.mp3')]
    private const SoundClick:Class;
    [Embed(source='img/Win.mp3')]
    private const LevelClick:Class;
    [Embed(source='img/Purple-Planet.mp3')]
    private const MainSound:Class;
    [Embed(source='img/PickCell.mp3')]
    private const WinSound:Class;


    public var con:SoundChannel;
    var isLoad:Boolean=true;
    var sou=new SoundClick();
    var winSound=new WinSound();
    var levelClick=new LevelClick();
    public var mainSound=new MainSound();
    var listSound = new Array();
    public var btnShowChan:BitmapButton = new BitmapButton(new LogoSD, new LogoSD, new LogoSD);

    public function DigitMain() {
//        Firebase.init();
//        initPushNotify();
        welcomeGame();
    }

    private function initPushNotify():void {
        if (Firebase.os == Firebase.ANDROID) Firebase.checkGoogleAvailability(onCheckResult);
        else onCheckResult(Firebase.SUCCESS);

        function onCheckResult($result:int):void {
            switch ($result) {
                case Firebase.SUCCESS:
                    // now you can use FCM
                    initFCM();
                    break;
            }
        }
    }

    private function initFCM():void {
        FCM.init();
        FCM.listener.addEventListener(FcmEvents.TOKEN_REFRESH, onTokenRefresh);
        FCM.listener.addEventListener(FcmEvents.MESSAGE, onMessage);
        trace(FCM.getToken());
    }

    private function onTokenRefresh(e:FcmEvents):void {
        trace("onTokenRefresh = " + e.token);
    }

    private function onMessage(e:FcmEvents):void {
        trace(e.msg);
        var payload:Object = FCM.parsePayloadFromString(e.msg);

        if (payload) {
            for (var name:String in payload) {
                trace(name + " = " + payload[name]);
                if (name == "link") navigateToURL(new URLRequest(payload[name]))
            }
        }
    }

    private function welcomeGame():void {
//        con=mainSound.play();
//        con.addEventListener( Event.SOUND_COMPLETE, finishMainSound);
        var popupWin:Sprite = new Sprite();
        popupWin.graphics.clear();
        popupWin.graphics.beginFill(0xFFFFFF, 0.9);
        popupWin.graphics.drawRoundRect(-86, 0, height, width,0,0 );
        popupWin.graphics.endFill();
        addChild(popupWin);
        var bg:Bitmap = new BGStart();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
        addChild(bg);
        var btnStart:DisplayObject = new BtnStart();
        btnStart.scaleX = .5;
        btnStart.scaleY = .5;
        btnStart.x = (bg.x + bg.width) / 2 - btnStart.width / 2;
        btnStart.y = (bg.x + bg.height) / 2 - btnStart.height / 2;
        var buttonWelcome:Sprite = new Sprite();
        buttonWelcome.graphics.clear();
        buttonWelcome.graphics.beginFill(0xD4D4D4, 0);
        buttonWelcome.graphics.drawEllipse((bg.x + bg.width) / 2 - btnStart.width / 2, (bg.x + bg.height) / 2 - btnStart.height / 2, btnStart.width, btnStart.height);
        buttonWelcome.graphics.endFill();
        buttonWelcome.addChild(btnStart);
        addChild(buttonWelcome);
        buttonWelcome.addEventListener(MouseEvent.CLICK, onButtonWelcomeClick);
    }
    public var volumeAdjust:SoundTransform = new SoundTransform();
    public function finishMainSound(event:Event):void {
        con=mainSound.play();
        con.addEventListener(Event.SOUND_COMPLETE, finishMainSound);
    }

    private function onButtonWelcomeClick(event:MouseEvent):void {
        //sou.play();
        mainMenu();
    }

    private function mainMenu():void {
        settingMenu();
    }
    private function loadGame():void {
        loadBoard();
        timer();
        loadNextNumber();
        loadBase();
        randomSuggest();
    }

    private function randomSuggest():void {
        var listS:Array = [];
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null) {
                    listS.push(listSprite[i][j]);
                }
            }
        }
        for (var i:int = 0; i < numberPoint; i++) {
            randomS(listS);
        }
    }

    private function randomS(listS:Array):void {
        var cir:CirlcleData = new CirlcleData();
        cir = listS[int(Math.random() * listS.length)];
        var nearCir:CirlcleData = new CirlcleData();
        nearCir = randomNear(cir.x, cir.y, cir);
        cir.nearCircle = nearCir;
        if (nearCir != null) {

            var myShape:Shape = new Shape();
            var size:int = 4;
            var pointA:Point = new Point(0, 0);
            myShape.graphics.moveTo(pointy_hex_corner(pointA, size, 0).x, pointy_hex_corner(pointA, size, 0).y);
            myShape.graphics.beginFill(0x000000);
            for (var i:int = 0; i < 7; i++) {
                myShape.graphics.lineStyle(2, 0xFF888B);
                myShape.graphics.lineTo(pointy_hex_corner(pointA, size, i).x, pointy_hex_corner(pointA, size, i).y);
                addChild(myShape);
            }
            myShape.graphics.endFill();
            myShape.x = (cir.sprite.x + cir.sprite.width / 2 + nearCir.sprite.x + cir.sprite.width / 2) / 2;
            myShape.y = (cir.sprite.y + cir.sprite.width / 2 + nearCir.sprite.y + cir.sprite.width / 2) / 2;
            var cortran:ColorTransform = new ColorTransform();
            cortran.color = 0xBAF6F7;
            myShape.transform.colorTransform = new ColorTransform(0xF0FF00);
        }
    }

    private function randomNear(i:int, j:int, cir:CirlcleData):CirlcleData {
        var templist:Array = new Array();
        if (listSprite[i][j - 1] != null) {
            templist.push(listSprite[i][j - 1]);
        }
        if (listSprite[i][j + 1] != null) {
            templist.push(listSprite[i][j + 1]);
        }
        if (i < n2) {

            if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j - 1] != null) {
                templist.push(listSprite[i - 1][j - 1]);
            }
            if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null) {
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null) {
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i + 1][j + 1] != null) {
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == n2) {
                if (listSprite[i - 1][j - 1] != null) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (listSprite[i + 1][j - 1] != null) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (listSprite[i - 1][j] != null) {
                    listSprite[i - 1][j].x = i - 1;
                    listSprite[i - 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            } else {
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null) {
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i - 1][j + 1] != null) {
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i + 1][j - 1] != null) {
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null) {
                    templist.push(listSprite[i - 1][j]);
                }
            }
        }
        for (var l:int; l < templist.length; l++) {
            if (templist[l].idBase == cir.idBase + 1) {
                return templist[l];
            }
        }
        return null;
    }

    var timerTextField:TextField = new TextField();
    var timeSprite:DisplayObject = new timeSpriteImg();

    public function timer():void {
        timeSprite.visible = true;
        myTimer.delay = delay;
        myTimer.repeatCount = time;
        switch (time) {
            case 31, 91, 211:
                runClock(time);
                break;
            default:
                runClock(time);
                break;
        }

        function runClock(a:int):void {
            myTimer.addEventListener(TimerEvent.TIMER, onTimer);
            myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
            myTimer.start();
            var tf:TextFormat = new TextFormat();
            tf.size = 40;
            tf.bold = true;
            tf.font = "Agency FB"
            tf.color = 0x3cd91c;
            tf.align = "center";
            timerTextField.defaultTextFormat = tf;
            timerTextField.width = 120;
//            timeSprite.graphics.beginFill(0x696969, 0.3);
//            timeSprite.graphics.drawRoundRect(5, -155, 85, 35, 20, 40);
//            timeSprite.addChild(timerTextField);
//            timeSprite.graphics.endFill();
            timeSprite.x = 100;
            timeSprite.y = 180;
            timeSprite.scaleX = timeSprite.scaleY = 1.2;
            addChild(timeSprite);

            function onTimer(e:TimerEvent):void {
                if (startCheck()) {
                    myTimer.stop();
                } else {
                    timerTextField.text = String(Math.floor((myTimer.repeatCount - myTimer.currentCount) / 60)).substr(-2) + ":" + ("0" + ((myTimer.repeatCount - myTimer.currentCount) % 60)).substr(-2);         //Seconds
                    timerTextField.x = 122;
                    timerTextField.y = 182;
                    addChild(timerTextField);
                }
            }

            function onComplete(e:TimerEvent):void {
                myTimer.reset();
                popupWin(new BGLose());

            }
        }
    }
    var soundon:DisplayObject=new SoundOn();
    var soundoff:DisplayObject=new SoundOff();
    private function loadNextNumber():void {
        trace(height + " "+ width);
        var sprite:Sprite = new Sprite();
        sprite.graphics.clear();
        sprite.graphics.beginFill(0xFF4600, 0);
        sprite.graphics.drawEllipse(0, 0, 40, 40);
        sprite.graphics.endFill();
        sprite.x = 200;
        sprite.y = 410;
        drawHex(220, 435, sizee + 20).transform.colorTransform = new ColorTransform(0xF0FF00);
        var sprite1:Sprite = new Sprite();
        sprite1.graphics.clear();
        sprite1.graphics.beginFill(0xFF8E63, 1);
        sprite1.graphics.drawEllipse(0, 0, 50, 50);
        sprite1.x = 100;
        sprite1.y = 450;
        sprite1.graphics.endFill();
        sprite1.transform.colorTransform = new ColorTransform(0xF0FF00);
        var sprite2:Sprite = new Sprite();
        sprite2.graphics.clear();
        sprite2.graphics.beginFill(0xFF8E63, 1);
        sprite2.graphics.drawEllipse(0, 0, 50, 50);
        sprite2.x = 100;
        sprite2.y = 380;
        sprite2.graphics.endFill();
        sprite2.transform.colorTransform = new ColorTransform(0xF0FF00);
        addChild(sprite);
        addChild(sprite1);
        addChild(sprite2);
        var tfNum:TextFormat = new TextFormat();
        tfNum.bold = true;
        tfNum.size = 40;
        tfNum.font = "Agency FB";
        txtNextNumber.text = nextNumber.toString();
        txtNextNumber.defaultTextFormat = tfNum;
        txtNextNumber.x = sprite.x - 5;
        txtNextNumber.y = sprite.y + 2;
        txtNextNumber.width = 48;
        txtNextNumber.height = 48;
        var tf:TextFormat = new TextFormat();
        tf.bold = true;
        tf.size = 40;
        tf.font = "Agency FB";
        tf.align = "center";
        var txtPlus:TextField = new TextField();
        txtPlus.x = sprite2.x + 4;
        txtPlus.y = sprite2.y;
        txtPlus.width = 42;
        txtPlus.height = 42;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "+";
        var txtSub:TextField = new TextField();
        txtSub.x = sprite1.x + 4;
        txtSub.y = sprite1.y;
        txtSub.mouseEnabled = false;
        txtSub.width = 42;
        txtSub.height = 42;
        txtSub.defaultTextFormat = tf;
        txtSub.text = "-";
        txtNextNumber.mouseEnabled = false;

        txtNextNumber.defaultTextFormat = tf;


        addChild(txtNextNumber);
        addChild(txtPlus);
        addChild(txtSub);
        sprite1.addEventListener(MouseEvent.MOUSE_DOWN, onClickSub);
        sprite2.addEventListener(MouseEvent.MOUSE_DOWN, onClickPlus);


        var btnHelp:Sprite = new Sprite();
        btnHelp.graphics.clear();
        btnHelp.graphics.beginFill(0x5B527F, 1);
        btnHelp.graphics.drawEllipse(100, posMainButtonY, 75, 75);
        btnHelp.graphics.endFill();
        addChild(btnHelp);
        btnHelp.addEventListener(MouseEvent.CLICK, onClickHelp);
        var btnHel:DisplayObject=new BtnHelp();
        btnHel.scaleY = 0.9;
        btnHel.scaleX = 0.9;
        btnHel.x= 100;
        btnHel.y= posMainButtonY;
        addChild(btnHel);

        var btnNewgame:Sprite = new Sprite();
        btnNewgame.graphics.clear();
        btnNewgame.graphics.beginFill(0x5B527F, 0);
        btnNewgame.graphics.drawEllipse(0, 0, 75, 75);
        btnNewgame.graphics.endFill();
        btnNewgame.x = btnHel.x + btnHel.width + 10;
        btnNewgame.y = posMainButtonY;
        addChild(btnNewgame);
        btnNewgame.addEventListener(MouseEvent.CLICK, onClickNewGame);
        var btnPaus:DisplayObject=new btnPause();
        btnPaus.scaleX = 0.9;
        btnPaus.scaleY = 0.9;
        btnPaus.x=btnNewgame.x;
        btnPaus.y= posMainButtonY;
        addChild(btnPaus);
//        btnNewgame.x = btnPaus.x;
//        btnNewgame.y = btnPaus.y;

        trace(btnNewgame.x +" and "+ btnPaus.x + " X");
        trace(btnNewgame.y +" and "+ btnPaus.y + " Y");

        var btnSound:Sprite = new Sprite();
        btnSound.graphics.clear();
        btnSound.graphics.beginFill(0x5B527F, 1);
        btnSound.graphics.drawEllipse(btnNewgame.x + btnNewgame.width + 10, posMainButtonY, 75, 75);
        btnSound.graphics.endFill();
        addChild(btnSound);
        btnSound.addEventListener(MouseEvent.CLICK, onClickButtonSound);


        soundon.x=btnNewgame.x + btnNewgame.width + 10;
        soundon.y=posMainButtonY;
        soundon.scaleX = 0.9;
        soundon.scaleY = 0.9;
        addChild(soundon);


        soundoff.x=btnNewgame.x + btnNewgame.width + 10;
        soundoff.y=posMainButtonY;
        soundoff.scaleX = 0.9;
        soundoff.scaleY = 0.9;
        addChild(soundoff);
        if (isSoundOn) {
            soundoff.visible=false;
        }
        else soundoff.visible =true;
    }

    private function onClickButtonSound(event:MouseEvent):void {
        settingSound();
    }

    private function onClickHelp(event:MouseEvent):void {
        //sou.play();
        myTimer.stop();
        var bg:Bitmap=new bg_itSao();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
//        bg.x=-86;
//        bg.scaleX=1;
//        bg.scaleY=1;
        addChild(bg);
        listSrpiteLevel.push(bg);
        var tf:TextFormat = new TextFormat();
        tf.bold = true;
        tf.size = 18;
        tf.font = "Arial";
        tf.align = "center";
        var btnLevelClose:Sprite = new Sprite();
        btnLevelClose.graphics.clear();
        btnLevelClose.graphics.beginFill(0x5D527D, 1);
        btnLevelClose.graphics.drawEllipse(0, 0, 50, 50);
        btnLevelClose.graphics.endFill();
        btnLevelClose.x = width-btnLevelClose.width - 170;
        btnLevelClose.y = 60;
        listSrpiteLevel.push(btnLevelClose);
        addChild(btnLevelClose);
        btnLevelClose.addEventListener(MouseEvent.CLICK, onClickCloseHelp);

        var btnClos:DisplayObject=new BtnClose();
        btnClos.scaleX=0.45;
        btnClos.scaleY=0.45;
        btnClos.x=btnLevelClose.x + 10;
        btnClos.y=72;
        addChild(btnClos);
        listSrpiteLevel.push(btnClos);

        var helpIcon:DisplayObject=new HelpIcon();
        helpIcon.scaleX=1;
        helpIcon.scaleY=1;
        helpIcon.x=(bg.width-helpIcon.width)/2;
        helpIcon.y= 30;
        addChild(helpIcon);
        listSrpiteLevel.push(helpIcon);

        var txt:TextField = new TextField();
        txt.width = 200;
        txt.height = 50;
        txt.x = (bg.width - txt.width)/2;
        txt.y = 150;
        txt.mouseEnabled = false;
        tf.size = 25;
        tf.color = 0xFFFFFF;
        tf.font = "Arial Black";
        txt.defaultTextFormat = tf;
        txt.autoSize = "center";
        txt.text = "HOW TO PLAY";
        listTxtLevel.push(txt);
        addChild(txt);
        message("Tap on an empty cell to fill it with the number indicated above the grid.", txt.y + txt.height + 20, (bg.width -300)/ 2);
        message("Start a path from a given number by clicking on it.", txt.y + txt.height + 40, (bg.width -300)/ 2);
        message("Erase a number with one click on a filled cell.", txt.y + txt.height + 60, (bg.width -300)/ 2);
        message("_________RULES_________", txt.y + txt.height + 80, (bg.width -300)/ 2);
        message("Put the numbers create a path of consecutive numbers.", txt.y + txt.height + 100, (bg.width -300)/ 2);
        message("Numbers and links between cells are given to help finish the game.", txt.y + txt.height + 120, (bg.width -300)/ 2);
        message("Two following numbers must be next to each other", txt.y + txt.height + 140, (bg.width -300)/ 2);
        message("A link indicates a crossing point of the path.", txt.y + txt.height + 160, (bg.width -300)/ 2);
        message("At the end, the entire grid must be full!", txt.y + txt.height + 180, (bg.width -300)/ 2);
    }

    private function message(txtHelpPa:String, dis:int, midPos:int):void {
        var tf:TextFormat = new TextFormat();
        tf.bold = true;
        var txtHelp:TextField = new TextField();
        txtHelp.width = 300;
        txtHelp.height = 60;
        txtHelp.x = midPos;
        txtHelp.y = dis;
        txtHelp.mouseEnabled = false;
        tf.size = 20;
        tf.color = 0xFFFFFF;
        tf.font = "Arial Black";
        txtHelp.defaultTextFormat = tf;
        txtHelp.autoSize = "center";
        txtHelp.text = txtHelpPa;
        listTxtLevel.push(txtHelp);
        addChild(txtHelp);
    }

    private function onClickCloseHelp(event:MouseEvent):void {
        //sou.play();
        myTimer.start();
        for (var i:int = 0; i < listSrpiteLevel.length; i++) {
            listSrpiteLevel[i].visible = false;
        }
        for (var i:int = 0; i < listTxtLevel.length; i++) {
            listTxtLevel[i].visible = false;
        }
    }

    private function onClickLevelXXL(event:MouseEvent):void {
//        levelClick.play();
        posEachLevelY = -60
        nLevel = 11;
        conf = -54 + 24;
        confRight = -26 + 27;
        numShape = 0;
        n2 = nLevel / 2;
        numberSuggest = 10;
        numberPoint = 12;
        sizee = 24;
        distanceX = 45;
        distanceY = 38;
        confDistanceShape = 6.2;
        time = 1001;
        timeSprite.visible = false;
        myTimer.reset();
        confDistanceShape = 2.5;
        loadGame();
    }

    private function onClickLevelEvil(event:MouseEvent):void {
//        levelClick.play();
        posEachLevelY = -60
        nLevel = 11;
        conf = -54 + 24;
        confRight = -26 + 27;
        numShape = 0;
        n2 = nLevel / 2;
        numberSuggest = 20;
        numberPoint = 8;
        sizee = 24;
        distanceX = 45;
        distanceY = 38;
        confDistanceShape = 6.2;
        time = 301;
        timeSprite.visible = false;
        myTimer.reset();
        confDistanceShape = 2.5;
        loadGame();
    }

    private function onClickLevelXL(event:MouseEvent):void {
//        levelClick.play();
        posEachLevelY = -60;
        nLevel = 11;
        conf = -54 + 24;
        confRight = -26 + 27;
        numShape = 0;
        n2 = nLevel / 2;
        numberSuggest = 15;
        numberPoint = 10;
        sizee = 24;
        distanceX = 45;
        distanceY = 38;
        confDistanceShape = 6.2;
        time = 241;
        timeSprite.visible = false;
        myTimer.reset();
        confDistanceShape = 2.5;
        loadGame();
    }

    private function onClickLevelHa(event:MouseEvent):void {
//        levelClick.play();
        posEachLevelY = - 30;
        time = 211;
        nLevel = 9;
        conf = -28;
        confRight = 5;
        numShape = 0;
        n2 = nLevel / 2;
        numberSuggest = 12;
        numberPoint = 7;
        myTimer.reset();
        timeSprite.visible = false;
        distanceX = 54;
        distanceY = 47;
        sizee = 30;
        confDistanceShape = 7;
        loadGame();
    }

    private function onClickLevelMe(event:MouseEvent):void {
//        levelClick.play();
        if(isLoad){
            posEachLevelY = 0;
            isLoad=false;
            time = 91;
            nLevel = 7;
            conf = -1;
            confRight = 28 + 5;
            numShape = 0;
            n2 = nLevel / 2;
            numberSuggest = 12;
            numberPoint = 7;
            myTimer.reset();
            timeSprite.visible = false;
            distanceX = 54;
            distanceY = 47;
            sizee = 30;
            confDistanceShape = 7;
            loadGame();
        }
    }

    private function onClickLevelBe(event:MouseEvent):void {
//        levelClick.play();
        posEachLevelY = 30;
        time = 31;
        nLevel = 5;
        conf = 26;
        confRight = 59;
        numShape = 0;
        n2 = nLevel / 2;
        numberSuggest = 6;
        numberPoint = 4;
        myTimer.reset();
        timeSprite.visible = false;
        distanceX = 54;
        distanceY = 47;
        sizee = 30;
        confDistanceShape = 7;
        loadGame();
    }

    private function onClickNewGame(event:MouseEvent):void {
        settingMenu();
    }

    var listSettingSprite:Array = [];
    var settingPannel:Sprite = new Sprite();
    var settingButtonPannel: Sprite = new Sprite();
    var settingButtonTxt:TextField = new TextField();
    var newGameButtonTxt: TextField = new TextField();
    var newGameButton: Sprite = new Sprite();
    private function settingMenu1():void {
        for (var i:int = 0 ;i < listSettingSprite.length ;i++){
            if (contains(listSettingSprite[i])) {
                removeChild(listSettingSprite[i]);
            }
        }
        for (var i:int = 0 ;i < listSettingSprite.length ;i++){
            listSettingSprite[i].visible = true;
        }
        myTimer.stop();
        if (contains(timeSprite)) {
            removeChild(timeSprite);
        }
        if (contains(timerTextField)) {
            removeChild(timerTextField);
        }

        settingPannel.graphics.clear();
        settingPannel.graphics.beginFill(0xFFFFFF, 0.9);
        settingPannel.graphics.drawRoundRect( 0, -185, 640, 920, 0,0);
        settingPannel.graphics.endFill();
        addChild(settingPannel);
        listSettingSprite.push(settingPannel);
        newGameButton.graphics.beginFill(0xff0000,0.1);
        newGameButton.graphics.drawRoundRect(0, 0, 180, 40, 15 ,15);
        newGameButton.graphics.endFill();
        newGameButton.x = 180;
        newGameButton.y = -86;
        var tf:TextFormat = new TextFormat();
        tf.bold = true;
        tf.font = "Courier New";
        tf.size = 20;
        tf.align = "center";
        tf.bold = true;
        tf.color = "0xff0000";
        newGameButtonTxt.defaultTextFormat= tf;
        newGameButtonTxt.text = "New Game";
        newGameButtonTxt.x = newGameButton.x +10;
        newGameButtonTxt.y = newGameButton.y +5;
        newGameButtonTxt.width = newGameButton.width;
        newGameButtonTxt.height = newGameButton.height;
        addChild(newGameButtonTxt);
        addChild(newGameButton);
        listSettingSprite.push(newGameButton);
        listSettingSprite.push(newGameButtonTxt);
        newGameButton.addEventListener(MouseEvent.MOUSE_DOWN, newGameMenu);

        settingButtonPannel.graphics.beginFill(0xff0000,1);
        settingButtonPannel.graphics.drawRect(0, 0, 190, 40);
        settingButtonPannel.graphics.endFill();
        settingButtonPannel.x = 180;
        settingButtonPannel.y = -40;
        addChild(settingButtonTxt);
        addChild(settingButtonPannel);
        listSettingSprite.push(settingButtonPannel);
        settingButtonPannel.addEventListener(MouseEvent.MOUSE_DOWN, onClickSound);
        var btnLevelClose:Sprite = new Sprite();
        btnLevelClose.graphics.clear();
        btnLevelClose.graphics.beginFill(0x5D527D, 1);
        btnLevelClose.graphics.drawEllipse(0, 0, 50, 50);
        btnLevelClose.graphics.endFill();
        btnLevelClose.x = width-btnLevelClose.width-140-20;
        btnLevelClose.y = -105;
        addChild(btnLevelClose);
        listSettingSprite.push(btnLevelClose);
        btnLevelClose.addEventListener(MouseEvent.CLICK, onClickCloseSetting);

        var btnClos:DisplayObject=new BtnClose();
        btnClos.scaleX=0.4;
        btnClos.scaleY=0.4;
        btnClos.x=width-btnLevelClose.width-140-20+12;
        btnClos.y=-105+12;
        addChild(btnClos);
        listSettingSprite.push(btnClos);
    }
    private function settingMenu():void{
        popupNewGame();
    }
    private function onClickCloseSetting(event: MouseEvent):void{
        resume();
    }
    private function resume():void{
        //sou.play();
        myTimer.start();
        addChild(timeSprite);
        for (var i:int = 0 ;i < listSettingSprite.length ;i++){
            listSettingSprite[i].visible = false;
        }
    }
    var isSoundOn:Boolean=true;
    private function onClickSound(event: MouseEvent):void{
        settingSound();
    }
    private function settingSound():void{
        isSoundOn=!isSoundOn;
        if(isSoundOn){
            soundon.visible=true;
            soundoff.visible=false;
            volumeAdjust.volume = 1;
            con.soundTransform = volumeAdjust;
        }else {
            soundon.visible=false;
            soundoff.visible=true;
            volumeAdjust.volume = 0;
            con.soundTransform = volumeAdjust;
        }
    }
    private function newGameMenu(event:MouseEvent):void{
        popupNewGame();
    }

    private function onClickPlus(event:MouseEvent):void {
        var tempPlus = nextNumber;
        while (true) {
            tempPlus++;
            if (tempPlus == numShape || !checkBoard(tempPlus)) break;
        }
        if (tempPlus < numShape) {
            nextNumber = tempPlus;
            txtNextNumber.text = nextNumber.toString();
            isPlusType = true;
        }
    }

    private function onClickSub(event:MouseEvent):void {
        var temp:int = nextNumber;
        while (true) {
            temp--;
            if (temp == 0 || !checkBoard(temp)) break;
        }
        if (temp != 0) {
            nextNumber = temp;
            txtNextNumber.text = nextNumber.toString();
            isPlusType = false;
        }
    }

    private function loadBoard():void {
        var popupWin:Sprite = new Sprite();
        popupWin.graphics.clear();
        popupWin.graphics.beginFill(0xFFFFFF, 0.9);
        popupWin.graphics.drawRoundRect(-86, 0, width, height,0,0 );
        popupWin.graphics.endFill();
        addChild(popupWin);
        var bg:Bitmap=new BgIngame();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
//        bg.x=-86;
//        bg.scaleX=1;
//        bg.scaleY=1;
        addChild(bg);
        n2 = nLevel / 2;
        for (var i:int = 0; i < nLevel; i++) {
            var arr:Array = [];
            if (i <= n2) {
                for (var j:int = 0; j < n2 + 1 + i; j++) {
                    var circle:CirlcleData = new CirlcleData();
                    circle.shape = drawHex(
                            confRight - 20 * i + 137 + distanceX * j - confDistanceShape * i + 420,
                            distanceY * i + posEachLevelY + 20 + (bg.width / 6), sizee
                    );
                    var sprite:Sprite = new Sprite();
                    sprite.graphics.clear();
                    sprite.graphics.beginFill(0xBAF6F7, 1);
                    sprite.graphics.drawEllipse(0, 0, 40, 40);
                    sprite.x = confRight - 20 * i + 117 + distanceX * j - confDistanceShape * i + 420;
                    sprite.y = distanceY * i + (bg.width / 6) + posEachLevelY + 1;
                    trace(sprite.x + "vl 1");
                    trace(bg.x + "vl 2");
                    trace(bg.width + "vl 3");
                    trace(bg.y + "bg y")
                    sprite.alpha = 0;
                    sprite.graphics.endFill();
                    sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OVER, onMouseMoveCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                    addChild(sprite);
                    circle.sprite = sprite;
                    var textfield:TextField = new TextField();
                    textfield.textColor = 0x000000;
                    textfield.x = sprite.x;
                    textfield.y = sprite.y + 5;
                    textfield.mouseEnabled = false;
                    textfield.width = 40;
                    textfield.height = 40;
                    var tf:TextFormat = new TextFormat();
                    tf.bold = true;
                    tf.font = "Arial";
                    tf.size = 18;
                    tf.align = "center";
                    textfield.defaultTextFormat = tf;
                    addChild(textfield);
                    circle.txtCurrentNumber = textfield;
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xFF4803;
                    circle.colorBase = corTran;
                    circle.x = i;
                    circle.y = j;
                    arr[j] = circle;
                    numShape++;
                }
            } else {
                for (var j:int = 0; j < nLevel + n2 - i; j++) {
                    var circle:CirlcleData = new CirlcleData();
                    circle.shape = drawHex(confRight + 420 + conf - 28 - 15 + 20 * (i - n2) + 100 + distanceX * j + confDistanceShape * (i - n2),
                            distanceY * i + posEachLevelY + 20 + (bg.width / 6), sizee);
                    var sprite:Sprite = new Sprite();
                    sprite.graphics.clear();
                    sprite.graphics.beginFill(0xBAF6F7, 1);
                    sprite.graphics.drawEllipse(0, 0, 40, 40);
                    sprite.x = confRight + 420 + conf - 28 - 15 + 20 * (i - n2) + 100 + distanceX * j - 20 + confDistanceShape * (i - n2);
                    sprite.y = distanceY * i + (bg.width / 6) + posEachLevelY + 1;
                    sprite.alpha = 0;
                    sprite.graphics.endFill();
                    sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OVER, onMouseMoveCircle);
                    sprite.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                    addChild(sprite);
                    circle.sprite = sprite;
                    var textfield:TextField = new TextField();
                    textfield.textColor = 0x000000;
                    textfield.x = sprite.x;
                    textfield.y = sprite.y + 5;
                    textfield.mouseEnabled = false;
                    textfield.width = 40;
                    textfield.height = 40;
                    var tf:TextFormat = new TextFormat();
                    tf.bold = true;
                    tf.size = 18;
                    tf.font = "Arial";
                    tf.align = "center";
                    textfield.defaultTextFormat = tf;
                    addChild(textfield);
                    circle.txtCurrentNumber = textfield;
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xFF4803;
                    circle.colorBase = corTran;
                    circle.x = i;
                    circle.y = j;
                    arr[j] = circle;
                    numShape++;
                }
            }
            listSprite[i] = arr;
        }
        listSprite[n2][n2].setTextString("");
        listSprite[n2][n2].shape.transform.colorTransform = new ColorTransform(0xB6FF00, 0xB6FF00, 0xB6FF00);
        (listSprite[n2][n2].sprite as Sprite).removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
        listSprite[n2][n2] = null;
    }

    private function onMouseOutCircle(event:MouseEvent):void {
        var corTran:ColorTransform = new ColorTransform();
        corTran.color = 0xBAF6F7;
        //   (event.currentTarget as Sprite).transform.colorTransform = corTran;

        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {
                    var corTran:ColorTransform = new ColorTransform();
                    corTran.color = 0xBAF6F7;
                    listSprite[i][j].shape.transform.colorTransform = new ColorTransform(0xF0FF00);
                }
            }
        }
    }

    private function onMouseMoveCircle(event:MouseEvent):void {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {
                    // (event.currentTarget as Sprite).transform.colorTransform = listSprite[i][j].colorBase;
                    listSprite[i][j].shape.transform.colorTransform = new ColorTransform(0xFF865);
                }
            }
        }
    }

    private function onMouseDownCircle(event:MouseEvent):void {
        //sou.play();
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null && listSprite[i][j].sprite == event.currentTarget) {

                    if (listSprite[i][j].isNumberSuggest) {

                        onIsNumberSuggest(listSprite[i][j]);
                    } else {
                        if (listSprite[i][j].isFillNumber) {
                            onIsFill(listSprite[i][j]);
                        } else {
                            onNotFill(listSprite[i][j]);
                        }
                    }

                }
            }
        }
    }

    private function onIsNumberSuggest(cir:CirlcleData):void {
        if (switchCheck) {
            var temp:int = cir.id;
            while (true) {
                temp--;
                if (temp == 0 || checkBoard(temp) == false) break;
            }
            if (temp != 0) {
                nextNumber = temp;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = false;
                switchCheck = !switchCheck;
            } else {
                var tempPlus = cir.id;
                while (true) {
                    tempPlus++;
                    if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
                }
                if (tempPlus)
                    nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
                switchCheck = !switchCheck;
            }

        } else {
            var tempPlus = cir.id;
            while (true) {
                tempPlus++;
                if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
            }
            if (tempPlus < numShape) {
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
                switchCheck = !switchCheck;
            }
        }
    }

    private function checkBoard(a:int):Boolean {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null) {
                    if (a == listSprite[i][j].id) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private function onNotFill(cir:CirlcleData):void {
        cir.isFillNumber = true;
        cir.getText().text = txtNextNumber.text;
        cir.id = nextNumber;
        var key:int = 0;
        if (isPlusType) {
            var tempPlus = cir.id;
            while (true) {
                tempPlus++;
                key = tempPlus == numShape ? numShape : 0;
                if (tempPlus == numShape || checkBoard(tempPlus) == false) {
                    break;
                }
            }
            if (tempPlus < numShape) {
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
            } else {
                var temp:int = cir.id;
                while (true) {
                    temp--;
                    if (temp == 0 || checkBoard(temp) == false) break;
                }
                nextNumber = temp;
                txtNextNumber.text = nextNumber.toString();
                if (temp == 0) {
                    var tempPlus = cir.id;
                    while (true) {
                        tempPlus++;
                        key = tempPlus == numShape ? numShape : 0;
                        if (tempPlus == numShape || checkBoard(tempPlus) == false) {
                            break;
                        }
                    }
                    nextNumber = tempPlus;
                    txtNextNumber.text = nextNumber.toString();
                    isPlusType = true;
                }
            }
        } else {
            var temp:int = cir.id;
            while (true) {
                temp--;
                if (temp == 0 || checkBoard(temp) == false) break;
            }
            nextNumber = temp;
            txtNextNumber.text = nextNumber.toString();
            if (temp == 0) {
                var tempPlus = cir.id;
                while (true) {
                    tempPlus++;
                    key = tempPlus == numShape ? numShape : 0;
                    if (tempPlus == numShape || checkBoard(tempPlus) == false) {
                        break;
                    }
                }
                nextNumber = tempPlus;
                txtNextNumber.text = nextNumber.toString();
                isPlusType = true;
            }
        }
        if (startCheck()) {
            if (checkWin(x1, y1, listSprite[x1][y1])) {
                drawLineWin(x1, y1, listSprite[x1][y1]);
                var myTimer:Timer = new Timer(1500, 1);
                myTimer.addEventListener(TimerEvent.TIMER, timerListener);
                myTimer.start();
            } else {
                popupWin(new BGLose());
            }
        }
    }

    function timerListener(e:TimerEvent):void {
        //winSound.play();
        popupWin(new BGWIn());
    }

    private function drawLineWin(i:int, j:int, cir:CirlcleData):void {
        var templist:Array = new Array();
        if (listSprite[i][j - 1] != null) {
            listSprite[i][j - 1].x = i;
            listSprite[i][j - 1].y = j - 1;
            templist.push(listSprite[i][j - 1]);
        }
        if (listSprite[i][j + 1] != null) {
            listSprite[i][j + 1].x = i;
            listSprite[i][j + 1].y = j + 1;
            templist.push(listSprite[i][j + 1]);
        }
        if (i < n2) {

            if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j - 1] != null) {
                listSprite[i - 1][j - 1].x = i - 1;
                listSprite[i - 1][j - 1].y = j - 1;
                templist.push(listSprite[i - 1][j - 1]);
            }
            if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null) {
                listSprite[i - 1][j].x = i - 1;
                listSprite[i - 1][j].y = j;
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null) {
                listSprite[i + 1][j].x = i + 1;
                listSprite[i + 1][j].y = j;
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i + 1][j + 1] != null) {
                listSprite[i + 1][j + 1].x = i + 1;
                listSprite[i + 1][j + 1].y = j + 1;
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == n2) {
                if (listSprite[i - 1][j - 1] != null) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (listSprite[i + 1][j - 1] != null) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (listSprite[i - 1][j] != null) {
                    listSprite[i - 1][j].x = i - 1;
                    listSprite[i - 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            } else {
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i - 1][j + 1] != null) {
                    listSprite[i - 1][j + 1].x = i - 1;
                    listSprite[i - 1][j + 1].y = j + 1;
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i + 1][j - 1] != null) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null) {
                    listSprite[i - 1][j].x = i - 1;
                    listSprite[i - 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            }
        }
        for (var i:int = 0; i < templist.length; i++) {
            if (templist[i].id == cir.id + 1) {
                cir1Draw = cir;
                cir2Draw = templist[i];
//                var timer:Timer=new Timer(0,1);
//                timer.addEventListener(TimerEvent.TIMER, delayDraw)
//                timer.start();
                delayDraw();
                drawLineWin(templist[i].x, templist[i].y, templist[i]);
            }
        }
    }

    private function delayDraw():void {
        var shapee:Shape = new Shape();
        shapee.graphics.moveTo(cir1Draw.sprite.x + cir1Draw.sprite.width / 2, cir1Draw.sprite.y + cir1Draw.sprite.width / 2);
        shapee.graphics.lineStyle(1, 0x000000);
        shapee.graphics.lineTo(cir2Draw.sprite.x + cir1Draw.sprite.width / 2, cir2Draw.sprite.y + cir2Draw.sprite.width / 2);
        addChild(shapee);
    }

    private function popupWin(bg:Bitmap):void {
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);

        var popupWin:Sprite = new Sprite();
        popupWin.graphics.clear();
        popupWin.graphics.beginFill(0xFFFFFF, 0.9);
        popupWin.graphics.drawRoundRect(-86, 0, 640, 920,0,0 );
        popupWin.graphics.endFill();
        addChild(popupWin);
        var button:Sprite = new Sprite();

        addChild(bg);

        function drawButton():void {
            button.graphics.clear();
            button.graphics.beginFill(0x5D527D, 0); // grey color
            button.graphics.drawRect(0, 0, 100, 50);
            button.x= (bg.width - button.width) / 2;
            button.y= bg.height - 100;
            button.graphics.endFill();
            var reload:DisplayObject=new Reload();
            reload.x=button.x - 30;
            reload.y=button.y;
            reload.scaleX=0.85;
            reload.scaleY=0.85;
            addChild(reload);
        }
        function resetGameinPop(event:MouseEvent):void {
            //sou.play();
            myTimer.reset();
            numShape = 0;
            n2 = nLevel / 2;
            loadGame();
        }

        if (contains(timeSprite)) {
            removeChild(timeSprite);
        }
        if (contains(timerTextField)) {
            removeChild(timerTextField);
        }
        timeSprite.visible = false;
        button.graphics.clear();
        addChild(button);
        button.addEventListener(MouseEvent.MOUSE_DOWN, resetGameinPop);
        drawButton();

    }

    private function popupNewGame():void {
        //sou.play();
        myTimer.stop();
//        var popupWin:Sprite = new Sprite();
//        popupWin.graphics.clear();
//        popupWin.graphics.beginFill(0xFFFFFF, 0.9);
//        popupWin.graphics.drawRoundRect( 0, -86, 640, 920, 0,0);
//        popupWin.graphics.endFill();
//        addChild(popupWin);
        var bgInGame:Bitmap = new bg_itSao();
        bgInGame = SDUtils.getFitImage(bgInGame, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
//        bgInGame.scaleY = 0.7;
//        bgInGame.scaleX = 0.7;
//        bgInGame.x = -86;
        addChild(bgInGame);
        listSrpiteLevel.push(bgInGame);

        var spaceLevelLeft = bgInGame.width / 10;
        var spaceLevelRight = spaceLevelLeft + (bgInGame.x + bgInGame.width) / 4;
        var spaceLevelRight2 = bgInGame.width - (bgInGame.width / 10) - 120;
        var spaceLevelLeft2 = spaceLevelRight2 - (bgInGame.width / 4);
        var middleY = (bgInGame.y + bgInGame.height) / 2 - 25;
        var middleYBtn = middleY - 10;


        var tf:TextFormat = new TextFormat();
        tf.size = 30;
        tf.bold = true;
        tf.font = "Arial"
        tf.color = 0x000000;
        tf.align = "center";
        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x= spaceLevelLeft;
        txtPlus.y=middleY + 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Begin";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);
        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x=spaceLevelRight;
        txtPlus.y=middleY + 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Begin";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);

        var siverIcon:DisplayObject=new Bronze();
        siverIcon.scaleX=1;
        siverIcon.scaleY=1;
        siverIcon.x=(spaceLevelLeft + txtPlus.width + spaceLevelRight) /2 - siverIcon.width /2 ;
        siverIcon.y=middleYBtn + 130;
        addChild(siverIcon);
        var btnLevelBeginner:Sprite = new Sprite();
        btnLevelBeginner.graphics.clear();
        btnLevelBeginner.graphics.beginFill(0x008AF0, 0);
        btnLevelBeginner.graphics.drawEllipse(0, 0, 75, 75);
        btnLevelBeginner.graphics.endFill();
        btnLevelBeginner.x = (spaceLevelLeft + txtPlus.width + spaceLevelRight) / 2 - btnLevelBeginner.width/2;
        btnLevelBeginner.y = middleYBtn + 130;

        listSrpiteLevel.push(siverIcon);
        listSrpiteLevel.push(btnLevelBeginner);
        addChild(btnLevelBeginner);
        btnLevelBeginner.addEventListener(MouseEvent.CLICK, onClickLevelBe);

        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x=spaceLevelLeft;
        txtPlus.y=middleY;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Medium";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);
        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelRight;
        txtPlus.y=middleY;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Medium";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);
        var btnLevelMedium:Sprite = new Sprite();
        btnLevelMedium.graphics.clear();
        btnLevelMedium.graphics.beginFill(0x0057F0, 0);
        btnLevelMedium.graphics.drawEllipse(0, 0, 75, 75);
        btnLevelMedium.graphics.endFill();
        btnLevelMedium.x = (spaceLevelLeft + txtPlus.width + spaceLevelRight) /2 - btnLevelMedium.width /2 ;
        btnLevelMedium.y = middleYBtn;

        var siverIcon:DisplayObject=new SiverIcon();
        siverIcon.scaleX=1;
        siverIcon.scaleY=1;
        siverIcon.x=(spaceLevelLeft + txtPlus.width + spaceLevelRight) /2 - siverIcon.width /2 ;
        siverIcon.y=middleYBtn;
        addChild(siverIcon);
        listSrpiteLevel.push(siverIcon);
        listSrpiteLevel.push(btnLevelMedium);
        addChild(btnLevelMedium);
        btnLevelMedium.addEventListener(MouseEvent.CLICK, onClickLevelMe);


        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelLeft;
        txtPlus.y=middleY - 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Hard";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);
        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelRight;
        txtPlus.y=middleY - 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Hard";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);

        var btnLevelHard:Sprite = new Sprite();
        btnLevelHard.graphics.clear();
        btnLevelHard.graphics.beginFill(0x001DF0, 0);
        btnLevelHard.graphics.drawEllipse(0, 0, 75, 75 );
        btnLevelHard.graphics.endFill();
        btnLevelHard.x = (spaceLevelLeft + txtPlus.width + spaceLevelRight) /2 - btnLevelHard.width /2;
        btnLevelHard.y = middleYBtn - 130;
        var siverIcon:DisplayObject=new Gold();
        siverIcon.scaleX=1;
        siverIcon.scaleY=1;
        siverIcon.x=(spaceLevelLeft + txtPlus.width + spaceLevelRight) /2 - siverIcon.width /2;
        siverIcon.y=middleYBtn - 130;
        addChild(siverIcon);
        listSrpiteLevel.push(siverIcon);
        listSrpiteLevel.push(btnLevelHard);
        addChild(btnLevelHard);
        btnLevelHard.addEventListener(MouseEvent.CLICK, onClickLevelHa);


        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelLeft2;
        txtPlus.y=middleY;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Xl";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);
        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelRight2;
        txtPlus.y=middleY;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Xl";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);

        var btnLevelXL:Sprite = new Sprite();
        btnLevelXL.graphics.clear();
        btnLevelXL.graphics.beginFill(0xFF04C6, 0);
        btnLevelXL.graphics.drawEllipse(0, 0, 75,75);
        btnLevelXL.graphics.endFill();
        btnLevelXL.x = (spaceLevelLeft2 + txtPlus.width + spaceLevelRight2) /2 - btnLevelXL.width /2 + 10;
        btnLevelXL.y = middleYBtn;
        var siverIcon:DisplayObject=new Diamond();
        siverIcon.scaleX=1;
        siverIcon.scaleY=1;
        siverIcon.x=(spaceLevelLeft2 + txtPlus.width + spaceLevelRight2) /2 - siverIcon.width /2 + 10;
        siverIcon.y=middleYBtn;
        addChild(siverIcon);
        listSrpiteLevel.push(siverIcon);
        listSrpiteLevel.push(btnLevelXL);
        addChild(btnLevelXL);
        btnLevelXL.addEventListener(MouseEvent.CLICK, onClickLevelXL);

        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelLeft2;
        txtPlus.y=middleY - 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "XXl";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelRight2;
        txtPlus.y=middleY- 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "XXl";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);

        var btnLevelXXL:Sprite = new Sprite();
        btnLevelXXL.graphics.clear();
        btnLevelXXL.graphics.beginFill(0xFF0404, 0);
        btnLevelXXL.graphics.drawEllipse(0, 0, 85, 85);
        btnLevelXXL.graphics.endFill();
        btnLevelXXL.x = btnLevelXL.x;
        btnLevelXXL.y = middleYBtn - 130;
        var siverIcon:DisplayObject=new Mater();
        siverIcon.scaleX=1;
        siverIcon.scaleY=1;
        siverIcon.x=btnLevelXL.x;
        siverIcon.y=middleYBtn - 130;
        addChild(siverIcon);
        listSrpiteLevel.push(siverIcon);
        listSrpiteLevel.push(btnLevelXXL);
        addChild(btnLevelXXL);
        btnLevelXXL.addEventListener(MouseEvent.CLICK, onClickLevelXXL);

        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelLeft2;
        txtPlus.y=middleY + 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Evil";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);
        var txtPlus:TextField = new TextField();
        txtPlus.width = 120;
        txtPlus.height = 50;
        txtPlus.x = spaceLevelRight2;
        txtPlus.y=middleY + 130;
        txtPlus.mouseEnabled = false;
        txtPlus.defaultTextFormat = tf;
        txtPlus.text = "Evil";
        addChild(txtPlus);
        listTxtLevel.push(txtPlus);

        var btnLevelEvil:Sprite = new Sprite();
        btnLevelEvil.graphics.clear();
        btnLevelEvil.graphics.beginFill(0x6D00F0, 0);
        btnLevelEvil.graphics.drawEllipse(0, 0, 75, 75);
        btnLevelEvil.graphics.endFill();
        btnLevelEvil.x = btnLevelXL.x;
        btnLevelEvil.y = middleYBtn + 130;
        var siverIcon:DisplayObject=new Platium();
        siverIcon.scaleX=1;
        siverIcon.scaleY=1;
        siverIcon.x=btnLevelXL.x;
        siverIcon.y=middleYBtn + 130;
        addChild(siverIcon);
        listSrpiteLevel.push(siverIcon);
        listSrpiteLevel.push(btnLevelEvil);
        addChild(btnLevelEvil);
        btnLevelEvil.addEventListener(MouseEvent.CLICK, onClickLevelEvil);

        var btnLevelClose:Sprite = new Sprite();
        btnLevelClose.graphics.clear();
        btnLevelClose.graphics.beginFill(0x5D527D, 1);
        btnLevelClose.graphics.drawEllipse(0, 0, 50, 50);
        btnLevelClose.graphics.endFill();
        btnLevelClose.x = width-btnLevelClose.width - 170;
        btnLevelClose.y = bgInGame.y + 60;
        listSrpiteLevel.push(btnLevelClose);
        addChild(btnLevelClose);
        btnLevelClose.addEventListener(MouseEvent.CLICK, onClickClose);

        var btnClos:DisplayObject=new BtnClose();
        btnClos.scaleX=0.45;
        btnClos.scaleY=0.45;
        btnClos.x=btnLevelClose.x + 10;
        btnClos.y=bgInGame.y + 72;
        addChild(btnClos);
        listSrpiteLevel.push(btnClos);
    }

    private function onClickClose(event:MouseEvent):void {
        // sou.play();
        myTimer.start();
        for (var i:int = 0; i < listSrpiteLevel.length; i++) {
            listSrpiteLevel[i].visible = false;
        }
        for (var i:int = 0; i < listTxtLevel.length; i++) {
            listTxtLevel[i].visible = false;
        }
    }

    private function resetGame(event:MouseEvent):void {
        numShape = 0;
        n2 = nLevel / 2;
        loadGame();
    }

    private function startCheck():Boolean {
        for (var i:int = 0; i < nLevel; i++) {
            for (var j:int = 0; j < nLevel; j++) {
                if (listSprite[i][j] != null) {
                    if (listSprite[i][j].isFillNumber == false) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    private function checkWin(i:int, j:int, cir:CirlcleData):Boolean {
        if (cir.id == numShape - 1) {
            return true;
        }
        var templist:Array = new Array();
        if (listSprite[i][j - 1] != null) {
            listSprite[i][j - 1].x = i;
            listSprite[i][j - 1].y = j - 1;
            templist.push(listSprite[i][j - 1]);
        }
        if (listSprite[i][j + 1] != null) {
            listSprite[i][j + 1].x = i;
            listSprite[i][j + 1].y = j + 1;
            templist.push(listSprite[i][j + 1]);
        }
        if (i < n2) {

            if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j - 1] != null) {
                listSprite[i - 1][j - 1].x = i - 1;
                listSprite[i - 1][j - 1].y = j - 1;
                templist.push(listSprite[i - 1][j - 1]);
            }
            if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null) {
                listSprite[i - 1][j].x = i - 1;
                listSprite[i - 1][j].y = j;
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null) {
                listSprite[i + 1][j].x = i + 1;
                listSprite[i + 1][j].y = j;
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i + 1][j + 1] != null) {
                listSprite[i + 1][j + 1].x = i + 1;
                listSprite[i + 1][j + 1].y = j + 1;
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == n2) {
                if (listSprite[i - 1][j - 1] != null) {
                    listSprite[i - 1][j - 1].x = i - 1;
                    listSprite[i - 1][j - 1].y = j - 1;
                    templist.push(listSprite[i - 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (listSprite[i + 1][j - 1] != null) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (listSprite[i - 1][j] != null) {
                    listSprite[i - 1][j].x = i - 1;
                    listSprite[i - 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            } else {
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null) {
                    listSprite[i + 1][j].x = i + 1;
                    listSprite[i + 1][j].y = j;
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i - 1][j + 1] != null) {
                    listSprite[i - 1][j + 1].x = i - 1;
                    listSprite[i - 1][j + 1].y = j + 1;
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i + 1][j - 1] != null) {
                    listSprite[i + 1][j - 1].x = i + 1;
                    listSprite[i + 1][j - 1].y = j - 1;
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null) {
                    listSprite[i - 1][j].x = i - 1;
                    listSprite[i - 1][j].y = j;
                    templist.push(listSprite[i - 1][j]);
                }
            }
        }

        for (var i:int = 0; i < templist.length; i++) {
            if (templist[i].id == cir.id + 1) {
                return checkWin(templist[i].x, templist[i].y, templist[i]);
            }
        }
        var tempB:Boolean = false;
        for (var i:int = 0; i < templist.length; i++) {
            if (templist[i].id == cir.id + 1) {
                tempB = true;
            }
        }
        return tempB;
    }

    private function onIsFill(cir:CirlcleData):void {
        cir.isFillNumber = false;
        nextNumber = cir.id;
        cir.id = 0;
        txtNextNumber.text = nextNumber.toString();
        cir.getText().text = "";

    }


    private function loadBase():void {
        var randomHardLevel = Math.random();
        if (nLevel < 9) {
            while (true) {
//            var x:int=Math.random()*7;
//            var n:int=0;
//            trace(x);
                //    var nestBase:int=0;
                // nestBase = 0;
                for (var i:int = 0; i < nLevel; i++) {
                    for (var j:int = 0; j < nLevel; j++) {
                        if (listSprite[i][j] != null) {
                            listSprite[i][j].isSetIntRandom = false;
                        }
                    }
                }
                numberNextBase.nextBase = 0;
                while (true) {
                    x1 = Math.random() * nLevel;
                    y1 = Math.random() * nLevel;
                    if (listSprite[x1][y1] != null) {
                        listSprite[x1][y1].idBase = ++numberNextBase.nextBase;
                        listSprite[x1][y1].isSetIntRandom = true;
                        FindPath(listSprite[x1][y1], x1, y1, numberNextBase);
                        break;
                    }
                }
//                trace(numShape - 1);
//                trace(numberNextBase.nextBase);
                if (numberNextBase.nextBase == numShape - 1) {
                    break;
                }
            }
        } else {
            switch (nLevel) {
                case 9: {
                    var listNumber:Array = [9, 8, 7, 4, 3, 11, 10, 6, 5, 2, 1, 12, 13, 14, 44, 45, 46, 48, 20, 19, 18, 15, 43, 42, 47, 49, 21, 22, 17, 16, 41, 52, 51, 50, 23, 24, 28, 39, 40, 53, 54, 55, 25, 27, 29, 38, 37, 57, 56, 26, 30, 33, 35, 36, 58, 31, 32, 34, 60, 59];
                    var listNumber2:Array = [56, 55, 52, 51, 50, 58,57, 54, 53, 48, 49, 59, 9 ,8,7,47,45,44,60,11,10,5,6,46,43,42,13,12,1,4,28,38,39,41,14,2,3,26,27,29,37,40,15,16,17,25,30,35,36,19,18,24,23,31,34,20,21,22,32,33];
                    var finalListNumber:Array;
                    if(randomHardLevel > 0.5){
                        finalListNumber = listNumber;
                    } else {
                        finalListNumber = listNumber2;
                    }
                    var l:int = 0;
                    x1 = 1;
                    y1 = 5;
                    for (var i:int = 0; i < nLevel; i++) {
                        for (var j:int = 0; j < nLevel; j++) {
                            if (listSprite[i][j] != null) {
                                listSprite[i][j].idBase = finalListNumber[l];
                                l++;
                            }
                        }
                    }
                    break;
                }
                case 11: {
                    var listNumber:Array = [49, 48, 47, 46, 45, 44, 51, 50, 57, 59, 61, 62, 43, 52, 55, 56, 58, 60, 63, 42, 41, 53, 54, 9, 7, 5, 3, 64, 40, 39, 13, 11, 10, 8, 6, 4, 2, 65, 37, 38, 14, 12, 80, 79, 78, 1, 68, 66, 36, 35, 15, 82, 81, 77, 76, 75, 69, 67, 32, 34, 16, 83, 86, 87, 74, 73, 70, 31, 33, 17, 84, 85, 88, 72, 71, 28, 30, 18, 19, 89, 90, 24, 27, 29, 20, 21, 22, 23, 25, 26];
                    var l:int = 0;
                    x1 = 5;
                    y1 = 6;
                    for (var i:int = 0; i < nLevel; i++) {
                        for (var j:int = 0; j < nLevel; j++) {
                            if (listSprite[i][j] != null) {
                                listSprite[i][j].idBase = listNumber[l];
                                l++;
                            }
                        }
                    }
                    break;
                }
            }
        }
        listSprite[x1][y1].setText(listSprite[x1][y1].idBase);
        listSprite[x1][y1].isFillNumber = true;
        listSprite[x1][y1].isNumberSuggest = true;
        listSprite[x1][y1].id = listSprite[x1][y1].idBase;
        listSprite[x1][y1].colorBase = new ColorTransform(0xFF865);
        listSprite[x1][y1].shape.transform.colorTransform = listSprite[x1][y1].colorBase;
        listSprite[x1][y1].sprite.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
        var temp:int = 0;
        while (true) {
            var x:int = Math.random() * nLevel;
            var y:int = Math.random() * nLevel;
            if (listSprite[x][y] != null && listSprite[x][y].isFillNumber == false) {
                listSprite[x][y].setText(listSprite[x][y].idBase);
                listSprite[x][y].isFillNumber = true;
                listSprite[x][y].isNumberSuggest = true;
                listSprite[x][y].id = listSprite[x][y].idBase;
                listSprite[x][y].shape.transform.colorTransform = new ColorTransform(0xFF865);
                listSprite[x][y].sprite.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutCircle);
                temp++;
                if (temp == numberSuggest - 1) {
                    break;
                }
            }
        }
        var tempPlus = 1;
        while (true) {
            tempPlus++;
            if (tempPlus == numShape || checkBoard(tempPlus) == false) break;
        }
        nextNumber = tempPlus;
        txtNextNumber.text = nextNumber.toString();
        isPlusType = true;
        switchCheck = !switchCheck;
        isLoad=true;
    }

    private function FindPath(cir:CirlcleData, i:int, j:int, numberNextBase:NumberBaseData):void {
        var templist:Array = new Array();
        if (listSprite[i][j - 1] != null && listSprite[i][j - 1].isSetIntRandom == false) {
            templist.push(listSprite[i][j - 1]);
        }
        if (listSprite[i][j + 1] != null && listSprite[i][j + 1].isSetIntRandom == false) {
            templist.push(listSprite[i][j + 1]);
        }
        if (i < n2) {

            if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j - 1] != null) {
                if (listSprite[i - 1][j - 1].isSetIntRandom == false) {
                    templist.push(listSprite[i - 1][j - 1]);
                }
            }
            if (i - 1 >= 0 && i - 1 < nLevel && j >= 0 && j < nLevel && listSprite[i - 1][j] != null && listSprite[i - 1][j].isSetIntRandom == false) {
                templist.push(listSprite[i - 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                templist.push(listSprite[i + 1][j]);
            }
            if (i + 1 >= 0 && i + 1 < nLevel && j + 1 >= 0 && j + 1 < nLevel && listSprite[i + 1][j + 1] != null && listSprite[i + 1][j + 1].isSetIntRandom == false) {
                templist.push(listSprite[i + 1][j + 1]);
            }
        } else {
            if (i == n2) {
                if (listSprite[i - 1][j - 1] != null && listSprite[i - 1][j - 1].isSetIntRandom == false) {
                    templist.push(listSprite[i - 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    templist.push(listSprite[i + 1][j]);
                }
                if (listSprite[i + 1][j - 1] != null && listSprite[i + 1][j - 1].isSetIntRandom == false) {
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    templist.push(listSprite[i + 1][j]);
                }
            } else {
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    templist.push(listSprite[i + 1][j]);
                }
                if (i - 1 >= 0 && i - 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i - 1][j + 1] != null && listSprite[i - 1][j + 1].isSetIntRandom == false) {
                    templist.push(listSprite[i - 1][j + 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j - 1 >= 0 && j - 1 < nLevel && listSprite[i + 1][j - 1] != null && listSprite[i + 1][j - 1].isSetIntRandom == false) {
                    templist.push(listSprite[i + 1][j - 1]);
                }
                if (i + 1 >= 0 && i + 1 < nLevel && j >= 0 && j < nLevel && listSprite[i + 1][j] != null && listSprite[i + 1][j].isSetIntRandom == false) {
                    templist.push(listSprite[i + 1][j]);
                }
            }
        }
        if (templist.length > 0) {
            var random:int = Math.random() * templist.length;
            templist[random].idBase = ++numberNextBase.nextBase;
            templist[random].isSetIntRandom = true;
            FindPath(templist[random], templist[random].x, templist[random].y, numberNextBase);
        } else {
            return;
        }

    }

    public function drawHex(a:int, b:int, sizee:int):Shape {
        var myShape:Shape = new Shape();
        var size:int = sizee;
        var pointA:Point = new Point(0, 0);
        myShape.graphics.moveTo(pointy_hex_corner(pointA, size, 0).x, pointy_hex_corner(pointA, size, 0).y);
        myShape.graphics.beginFill(0xFFF888);
        for (var i:int = 0; i < 7; i++) {
            myShape.graphics.lineStyle(2, 0xFF888B);
            myShape.graphics.lineTo(pointy_hex_corner(pointA, size, i).x, pointy_hex_corner(pointA, size, i).y);
            addChild(myShape);
        }
        myShape.graphics.endFill();
        myShape.x = a;
        myShape.y = b;
        var cortran:ColorTransform = new ColorTransform();
        cortran.color = 0xBAF6F7;
        myShape.transform.colorTransform = new ColorTransform(0xF0FF00);
        return myShape;
    }

    public function pointy_hex_corner(center, size, i):Point {
        var angle_deg = 60 * i - 30;
        var angle_rad = Math.PI / 180 * angle_deg;
        return new Point(center.x + size * Math.cos(angle_rad), center.y + size * Math.sin(angle_rad))
    }
}
}
