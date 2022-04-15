import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'globals.dart' as globals;
import 'rw.dart' as rw;

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<ExamPage> createState() => _ExamPageState();
  
}

class _ExamPageState extends State<ExamPage> {
  final ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(width: 2.0, color: Color.fromRGBO(0, 177, 64, 1.0)),
          )
      )
  );
  final ButtonStyle fin_style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(0, 177, 64, 1.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(width: 2.0, color: Color.fromRGBO(0, 177, 64, 1.0)),
          )
      )
  );

  String audio_path = 'assets/test_audio/'+pictureList[0]+'.mp3';
  var result = '請選擇';
  var examCount=0;
  var examScore=0;
  var examFall=0;
  var examLevel=0;
  static List examPlotList = ['將您的雙腳並排站立。測量您能夠以該姿勢站立多久。超過十秒算一分，少於十秒算零分。',
    '將一腳腳跟置於另一腳大拇趾側，測量您能夠維持姿勢站立多久。超過十秒算一分，少於十秒算零分。',
    '將一腳腳跟置於另一腳大拇趾前端(即腳尖)，測量您能夠以該姿勢站立多久。過十秒算兩分，介於三到九秒算一分，少於三秒算零分。',
    '以正常速度走四公尺，進行三次。測量每一次的時間。以測得的最短時間為最後結果，在下方選單選取相對應的時間範圍。',
    '請將背打直、手臂交叉，然後盡可能以最快的速度從椅子上起身五次。測試以坐姿開始，站姿結束。計算起身五次的時間作為最後結果，在下方選單選取相對應的時間範圍。',
    '最近一年是否曾經跌倒兩次以上？或者是曾有一次因跌倒而就醫的經驗？',
    '聽到「起步走」時，請站起來，沿著地板上的線向前走3公尺，轉身，然後走回椅子坐下，以正常速度行走即可。',
    '以正常步速行走六公尺，進行兩次。計算步行六公尺所需的時間，以測得的最短時間為最後結果。',
    '是否被診斷為認知功能退化？'];
  static List examList = ['雙腳並排站立', '雙腳半並排站立', '雙腳直線站立', '步行速度測試', '從椅子起身測試', '最近跌倒次數', '計時起身行走測試', '步行速度測試(2)', '中度認知功能退化'];
  static List pictureList = ['0','1','2','3','4','5','6','7','8'];
  static List videoList = ['none', ];
  static List audioList = ['none', ];
  var examItem = {0:['<10秒','>10秒'],1:['<10秒','>10秒'],2:['<3秒','3~9秒','>10秒'],3:['無法執行','>8.7秒','6.2~8.7秒','4.8~6.2秒','<4.8秒'],
    4:['>60秒','16.7~59秒','13.7~16.7秒','11.2~13.7秒','<11.2秒'],5:['是','否'],6:['>20秒','<20秒'],7:['>7.5秒','<7.5秒'],8:['是','否']};
  DropdownMenuItem<String> buildExamItem(String item) => DropdownMenuItem(value: item, child: Text(item,style: TextStyle(fontSize: 25)));

  List controllers = [];
  List checkList = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int finish = 0, current = 0, all = examList.length, min = 0, sec = 0, count = 0;
  String img_path = 'assets/test_image/' + pictureList[0] + '.png', timer_str = '開始';
  String level_path = 'assets/test_level_image/0.png';
  bool timer_running = false, reset = false, processing = false, audioPlaying = false;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  final ScrollController _scrollController = ScrollController();

  var period = const Duration(milliseconds: 10);

  void prepareAudio() async {
    await audioPlayer.open(Audio(audio_path),
        autoStart: false, showNotification: true);
    //await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }
  void timer_event(){
    if(reset == false) {
      if (timer_running) {
        timer_running = false;
      }
      else {
        timer_running = true;
      }
    }

    Timer.periodic(period, (timer) {
      if(reset == true){
        timer_running = false;
        reset = false;
        timer.cancel();
        min = 0;
        sec = 0;
        count = 0;
      }
      else if (timer_running == false) {
        timer.cancel();
        // timer = null;
      }
      else{
        count ++;
        if(count == 100) {
          count = 0;
          sec++;
          if (sec == 60) {
            min ++;
            sec = 0;
          }
        }
      }
      setState(() {});
    });
  }

  StreamSubscription? _connectionChangeStream;

  bool isOffline = false;


  @override
  initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('測驗'),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 600,
            height: 70,
            child: Center(
              child: Text(
                '您好～' + globals.name + '！',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 600,
            height: 70,
            child: Center(
              child: Text(
                '$finish/$all',
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width:  (MediaQuery.of(context).size.width),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      width: double.maxFinite,
                      //width: (MediaQuery.of(context).size.width)/6 *3.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.green,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: double.maxFinite,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      ' ',
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          prepareAudio();
                                          _showDialog();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.report,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Image.asset(img_path)),
                              Text(
                                examList[examCount],
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children:[
                        Container(
                          height: 13,
                        ),
                        Container(
                          width: double.maxFinite,
                          height:50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green,width: 3),
                          ),
                          //padding: EdgeInsets.all(20),
                          alignment: Alignment.topCenter,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(

                              items: examItem[examCount]?.map(buildExamItem).toList(),
                              hint:Text(
                                result,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  result = value as String;
                                });
                              },
                          ),
                        ),
                      ),
                      Container(
                        height: 230,
                      ),
                      Container(
                        width: 100,
                        height:50,
                        child:ElevatedButton(
                          onPressed: () {
                            reset = true;
                            setState(() {
                              if(examCount==0){
                                if(result==">10秒"){
                                  examScore+=1;
                                }
                                else{
                                  examCount+=2;
                                  finish+=2;
                                }
                              }
                              if(examCount==1){
                                if(result==">10秒"){
                                  examScore+=1;
                                }
                                else{
                                  examCount+=1;
                                  finish+=1;
                                }
                              }
                              if(examCount==2){
                                if(result==">10秒"){
                                  examScore+=2;
                                }
                                if(result=="3~9秒"){
                                  examScore+=1;
                                }
                              }
                              if(examCount==3){
                                if(result=="<4.8秒"){
                                  examScore+=4;
                                }
                                if(result=="4.8~6.2秒"){
                                  examScore+=3;
                                }
                                if(result=="6.2~8.7秒"){
                                  examScore+=2;
                                }
                                if(result==">8.7秒"){
                                  examScore+=1;
                                }
                              }
                              if(examCount==4){
                                if(result=="<11.2秒"){
                                  examScore+=4;
                                }
                                if(result=="11.2~13.7秒"){
                                  examScore+=3;
                                }
                                if(result=="13.7~16.7秒"){
                                  examScore+=2;
                                }
                                if(result=="16.7~59秒"){
                                  examScore+=1;
                                }
                              }
                              if(examCount==5){
                                if(result=="是"){
                                  examFall = 1;
                                }
                              }
                              if(examCount==6){
                                if(result==">20秒"){
                                  examFall = 1;
                                }
                              }
                              if(examCount==7){
                                if(result==">7.5秒"){
                                  examFall = 1;
                                }
                              }
                              if(examCount==8){
                                if(result=="是"){
                                  examFall = 1;
                                }
                                if(examScore<4){
                                  examLevel=0;
                                }
                                else if(examScore<7){
                                  if(examFall==0){
                                    examLevel=1;
                                  }
                                  else{
                                    examLevel=2;
                                  }
                                }
                                else if(examScore<10){
                                  if(examFall==0){
                                    examLevel=3;
                                  }
                                  else{
                                    examLevel=4;
                                  }
                                }
                                else{
                                  examLevel=5;
                                }
                                globals.grade = examLevel;
                                level_path = 'assets/test_level_image/' + pictureList[examLevel] + '.png';
                                _showLevelDialog();
                              }
                              examCount+=1;
                              finish+=1;
                              img_path = 'assets/test_image/' + pictureList[examCount] + '.png';
                              audio_path = 'assets/test_audio/'+ pictureList[examCount] +'.mp3';
                              result = '請選擇';
                              prepareAudio();
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '完成',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          style: style,
                        ),
                      ),
                    ]),
                  ),

                  //Container(
                  //  width: (MediaQuery.of(context).size.width)/6,
                  //  child: IconButton(
                  //    onPressed: () {
                  //      setState(() {
                  //        current = (current + 1) % exerciseList.length;
                  //        img_path = 'assets/test_image/' + pictureList[current] + '.png';
                  //      });
                  //    },
                  //    icon: Icon(
                  //      Icons.arrow_forward_outlined,
                  //      size: 50,
                  //      color: Color.fromRGBO(0, 177, 64, 1.0),
                  //    ),
                  //  ),
                  //),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 600,
            height: 90,
            // child: Center(
            //   child: Text('Timer'),
            // )
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      '計時器 ' +  min.toString().padLeft(2, '0') + ':' + sec.toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    )
                ),
                Expanded(
                  flex:1,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timer_event();
                          if (timer_running == false) {
                            timer_str = '開始';
                          }
                          else {
                            timer_str = '暫停';
                          }
                        });
                      },
                      child: Container(
                        child: Text(
                          timer_str,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.center,
                      ),
                      style: style,
                    ),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  flex:1,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        reset = true;
                        setState(() {
                          timer_event();
                          timer_str = '開始';
                        });
                      },
                      child: Container(
                        child: Text(
                          '重設',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.center,
                      ),
                      style: style,
                    ),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showLevelDialog()async{
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:Container(
          alignment: Alignment.center,
          child:
          Text(
            '您的等級為',
            style: TextStyle(fontSize: 25),
          ),
        ),
        content: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green,width: 3),
          ),
          child: Image.asset(level_path),
        ),
        actions: <Widget>[
          TextButton(child: Text('前往導覽',style: TextStyle(fontSize: 25),),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
    Navigator.pushReplacementNamed(context, '/introduce');
  }


  _showDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            width: (MediaQuery
                .of(context)
                .size
                .width) / 5 * 4,
            height: (MediaQuery
                .of(context)
                .size
                .height) / 6 * 5,
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Material(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(
                                  '語音講解',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () async {
                                        await audioPlayer.play();
                                      },
                                      icon: Icon(Icons.play_arrow_rounded,
                                          size: 50,
                                          color:
                                          Color.fromRGBO(0, 177, 64, 1.0)),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: () async {
                                          await audioPlayer.pause();
                                        },
                                        icon: Icon(Icons.pause,
                                            size: 50,
                                            color: Color.fromRGBO(
                                                0, 177, 64, 1.0)),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () async {
                                        await audioPlayer.stop();
                                      },
                                      icon: Icon(
                                        Icons.stop,
                                        size: 50,
                                        color: Color.fromRGBO(0, 177, 64, 1.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: _scrollController,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: 1,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                examPlotList[examCount],
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment(1, -1),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            audioPlayer.stop();
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    globals.writeBack();
    widget.storage.writeUserTxt(globals.userList[0], 0);
    await audioPlayer.stop();
  }
}

