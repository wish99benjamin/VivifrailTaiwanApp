// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'rw.dart' as rw;

class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<IntroducePage> createState() => _IntroducePageState();
}


class _IntroducePageState extends State<IntroducePage> {

  List introduceImgPth = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21'];
  List introducePlot = [
    '首先介紹的是您的主頁面，上方為您的大頭照',
    '點選"來運動"會進入運動介面並開始運動',
    '點選"運動日記"會進入日記介面，可以查看到目前為止的運動紀錄',
    '點選"個人資料"會進入資料介面，可以查看個人資料或是更改大頭貼',
    '這是您的運動介面，您可以在這邊完成每日所需的運動',
    '箭頭指到的地方是顯示您今天已經做完多少運動',
    '中間的大方塊是您目前要做的運動',
    '點選箭頭的驚嘆號可以看到動作的詳細解說',
    '最上面的部分為動作示範影片，可以點擊播放按鈕觀看',
    '中間部分為台語語音解說，一樣透過下方按鈕播放',
    '下方為動作的文字說明',
    '點選中間圖片，圖片會變成綠色的，代表您已作完此動作',
    '點選左右指向兩個箭頭可以選擇其他動作',
    '下方為計時器，可以幫助您測量做動作的時間',
    '這是您的日記介面，您可以在這邊查看過去的運動狀況',
    '點選右上方的按紐，可以調整日曆的展示方式',
    '點選個別日期可以查看那天是否有完成全部的運動',
    '這是的個人資料介面，您可以查看您的個人資料',
    '點選大頭照的左下方圖示可以更改您的大頭照',
    '下方為您的個人資料',
    '點選右上角的驚嘆號，可以重看導覽'
  ];
  int all = 0,
      index = 0;

  String img_path = '';
  bool timer_running = false,
      reset = false,
      processing = false,
      audioPlaying = false;
  int min = 0,
      sec = 0,
      count = 0;

  @override
  initState() {
    super.initState();

    //運動介面需要的資料
    all = introducePlot.length;
    img_path = 'assets/introduce_image/'+introduceImgPth[0]+'.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('導覽'),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile');//pushNamed是因為有定義page的名字
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home'); //pushNamed是因為有定義page的名字
            },
            icon: Icon(
              Icons.cabin_sharp,
              size: 40,
            ),
          ),
        ],
      ),
      body: Container(
        child : Column(
          children: [
            SizedBox(
              width: 600,
              height: 70,
              child: Center(
                child: Text(
                  introduceImgPth[index]+'/$all',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: 400,
              child: SizedBox(
                width: (MediaQuery
                    .of(context)
                    .size
                    .width),
                child: Row(
                  children: [
                    Container(
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width) / 6,
                      child: (index==0)?Text(''):IconButton(
                        onPressed: () {
                          setState(() {
                            index = index - 1;
                            img_path = 'assets/introduce_image/'+introduceImgPth[index]+'.png';
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          size: 50,
                          color: Color.fromRGBO(0, 177, 64, 1.0),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width) / 6 * 4,
                      child: Image.asset(img_path),
                      alignment: Alignment.center,
                      color: Colors.white,
                    ),
                    Container(
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width) / 6,
                      child: (index==20)?Text(''):IconButton(
                        onPressed: () {
                          setState(() {
                            index = index + 1;
                            img_path = 'assets/introduce_image/'+introduceImgPth[index]+'.png';
                          });
                        },
                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          size: 50,
                          color: Color.fromRGBO(0, 177, 64, 1.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              height: 130,
              child : Container(
                alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 177, 64, 1.0),
                    border: Border.all(width: 0.8),borderRadius: BorderRadius.circular(12.0),
                  ),
                child:
                  Text(
                    introducePlot[index],
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

