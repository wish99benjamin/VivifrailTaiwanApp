import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'globals.dart' as globals;
import 'profile.dart' as profile;
import 'exam.dart' as exam;
import 'daily.dart' as daily;
import 'register.dart' as register;
import 'rw.dart' as rw;
import 'introduce.dart' as introduce;

import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';


Future<Database>? database;

void main() async{
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  initializeDateFormatting().then((_) => runApp(MyApp(storage: rw.UserStorage()),));

  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    Path.join(await getDatabasesPath(),'record.db'),
    onCreate: (db,version){
      return db.execute("CREATE TABLE record(user VARCHAR(30),time VARCHAR(30))",);
    },
    version: 1,
  );
}

Future<void> insertRecord(Record record) async{
  print("arrive");
  final Database db = await database!;
  print("arrive2");
  await db.insert('record', record.toMap(),conflictAlgorithm:ConflictAlgorithm.replace,);
  print("arrive3");
}
Future<List<Record>> records() async {
  final Database db = await database!;
  final List<Map<String, dynamic>> maps = await db.query('record');
  return List.generate(maps.length, (index){
    return Record(
      user: maps[index]['user'],
      time: maps[index]['time'],
    );
  });
}

var user1;


class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //first route
  String whereToStart = '/';

  @override
  void initState() {
    super.initState();
    widget.storage.ifFileExists().then((var value) {
      if (value) {
        widget.storage.readUserTxt().then((var temp) {
          setState(() {
            if (temp.length == 1) {
              globals.userList = [temp];
            } else {
              globals.userList.add(temp);
            }
            globals.setUp();
            globals.value = true;
          });
        });
      } else {
        widget.storage.readUserTxt().then((var temp) {
          setState(() {
            globals.value = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: whereToStart,
      routes: {
        '/': (context) => WelcomePage(storage: rw.UserStorage()),
        '/home': (context) => HomePage(storage: rw.UserStorage()),
        '/exercise': (context) => ExercisePage(storage: rw.UserStorage()),
        '/profile': (context) => profile.ProfilePage(storage: rw.UserStorage()),
        '/exam': (context) => exam.ExamPage(storage: rw.UserStorage()),
        '/daily': (context) => daily.DairyPage(storage: rw.UserStorage()),
        '/register': (context) => register.RegisterPage(storage: rw.UserStorage()),
        '/introduce': (context) => introduce.IntroducePage(storage: rw.UserStorage()),
      },
    );
  }
}

class Record{
  final String? user;
  final String? time;
  Record({this.user, this.time});

  Map<String,dynamic> toMap(){
    return{
      'user' : user,
      'time' : time,
    };
  }
  @override
  String toString(){
    return '$time';
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ButtonStyle style = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(0, 177, 64, 1.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('歡迎'),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                print(globals.value);
                globals.value == true
                    ? Navigator.pushReplacementNamed(context, '/home')
                    : Navigator.pushReplacementNamed(context, '/register'); //pushNamed是因為有定義page的名字
              },
              child: Text(
                '開始使用',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              style: style,
            ),
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ButtonStyle style = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(211, 211, 211, 1.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首頁'),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 1000,
            height: 160,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: globals.profileImageNumber == -1
                      ? Center(
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: MediaQuery.of(context).size.width / 5,
                          ),
                        )
                      : Image.asset(
                          'assets/images/profile/' +
                              globals.profileImageNumber.toString() +
                              '.png',
                          height: double.maxFinite,
                        ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    '    ' + globals.name + '    ',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              //Center Row contents horizontally,
              crossAxisAlignment:
                  CrossAxisAlignment.center, //Center Row contents vertically,
            ),
          ),
          SizedBox(
            width: 400,
            height: 150,
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/exercise'); //pushNamed是因為有定義page的名字
                },
                child: SizedBox(
                  width: 270,
                  height: 120,
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '  來運動',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.directions_run,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                style: style,
              ),
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 400,
            height: 150,
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/daily'); //pushNamed是因為有定義page的名字
                },
                child: SizedBox(
                  width: 270,
                  height: 120,
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '運動日記',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.calendar_today,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                style: style,
              ),
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 400,
            height: 150,
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/profile'); //pushNamed是因為有定義page的名字
                  setState(() {});
                },
                child: SizedBox(
                  width: 270,
                  height: 120,
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '個人資料',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.perm_contact_calendar_outlined,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                style: style,
              ),
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurant'),
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(width: 2.0, color: Color.fromRGBO(0, 177, 64, 1.0)),
      )));

  final ButtonStyle fin_style = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(0, 177, 64, 1.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(width: 2.0, color: Color.fromRGBO(0, 177, 64, 1.0)),
      )));

  int finish = 0, current = 0, all = 0;

  String img_path = '', timer_str = '開始';
  String audio_path = 'assets/audios/D/balance1.mp3';

  bool timer_running = false,
      reset = false,
      processing = false,
      audioPlaying = false;
  int min = 0, sec = 0, count = 0;
  VideoPlayerController? _videoController;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();



  final ScrollController _scrollController = ScrollController();

  var period = const Duration(milliseconds: 10);

  void timer_event() {
    if (reset == false) {
      if (timer_running) {
        timer_running = false;
      } else {
        timer_running = true;
      }
    }

    Timer.periodic(period, (timer) {
      if (reset == true) {
        timer_running = false;
        reset = false;
        timer.cancel();
        min = 0;
        sec = 0;
        count = 0;
      } else if (timer_running == false) {
        timer.cancel();
        // timer = null;
      } else {
        count++;
        if (count == 100) {
          count = 0;
          sec++;
          if (sec == 60) {
            min++;
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

    //運動介面需要的資料
    all = globals.exerciseList[globals.grade].length;

    if (globals.checkList.length !=
        globals.exerciseList[globals.grade].length) {
      for (int i = 0; i < all; i++) {
        globals.checkList.add(0);
      }
    }

    for (int i = 0; i < all; i++) {
      if (globals.checkList[i] == 1) {
        finish++;
      }
    }

    img_path = globals.exerciseList[globals.grade][current][1];

    //判斷是否有網路
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  void prepareAudio() async {
    await audioPlayer.open(Audio(audio_path),
        autoStart: false, showNotification: true);
    //await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  bool displayVideo() {
    if (globals.exerciseList[globals.grade][current][3] == 'none') {
      return false;
    }
    _videoController = VideoPlayerController.asset(
      globals.exerciseList[globals.grade][current][3],
    )..initialize().then((_) {
        setState(() {});
      });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('每日運動'),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
        actions: [
          IconButton(
            onPressed: () {
              if(finish == all) {
                user1 = Record(
                  user: globals.name,
                  time: globals.today,
                );
                print(user1);
                print(globals.today);
                upload();
              }
              Navigator.pushReplacementNamed(
                  context, '/home'); //pushNamed是因為有定義page的名字
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
        ],
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
              width: (MediaQuery.of(context).size.width),
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width) / 6,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          current = (current - 1) % all;
                          img_path =
                              globals.exerciseList[globals.grade][current][1];
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
                    width: (MediaQuery.of(context).size.width) / 6 * 4,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (globals.checkList[current] == 0) {
                            globals.checkList[current] = 1;
                            finish += 1;
                          } else {
                            globals.checkList[current] = 0;
                            finish -= 1;
                          }
                          if (finish == all) {
                            globals.completeToday = true;
                          }
                        });
                        globals.writeBack();
                        widget.storage.writeUserTxt(globals.userList[0][0], 0);
                        widget.storage.readUserTxt().then((var temp) {
                          print(temp);
                        });
                      },
                      child: SizedBox(
                        height: double.maxFinite,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    globals.exerciseList[globals.grade][current]
                                        [5],
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left,
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
                              globals.checkList[current] == 0
                                  ? globals.exerciseList[globals.grade][current]
                                      [0]
                                  : '完成',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      style:
                          globals.checkList[current] == 0 ? style : fin_style,
                    ),
                    alignment: Alignment.center,
                    color: Colors.white,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width) / 6,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          current = (current + 1) % all;
                          img_path =
                              globals.exerciseList[globals.grade][current][1];
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
          SizedBox(
            width: 600,
            height: 90,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      '計時器 ' +
                          min.toString().padLeft(2, '0') +
                          ':' +
                          sec.toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timer_event();
                          if (timer_running == false) {
                            timer_str = '開始';
                          } else {
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
                  flex: 1,
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

  upload() async{
    print(user1.toMap());
    await insertRecord(user1);
    print("enter here");
    globals.recordTimeList.add(await records());
    print('ecordTimeList');
    print(globals.recordTimeList);
  }

  _showDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            width: (MediaQuery.of(context).size.width) / 5 * 4,
            height: (MediaQuery.of(context).size.height) / 6 * 5,
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Material(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '示範影片',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: displayVideo()
                                  ? Column(children: [
                                      Expanded(
                                        flex: 3,
                                        child: AspectRatio(
                                            aspectRatio: _videoController!
                                                .value.aspectRatio,
                                            child:
                                                VideoPlayer(_videoController!)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                onPressed: () async {
                                                  await _videoController!
                                                      .play();
                                                },
                                                icon: Icon(
                                                    Icons.play_arrow_rounded,
                                                    size: 50,
                                                    color: Color.fromRGBO(
                                                        0, 177, 64, 1.0)),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                onPressed: () async {
                                                  await _videoController!
                                                      .pause();
                                                },
                                                icon: Icon(Icons.pause,
                                                    size: 50,
                                                    color: Color.fromRGBO(
                                                        0, 177, 64, 1.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])
                                  : Text(
                                      '本動作無示範影片',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
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
                                globals.exerciseList[globals.grade][current][4],
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
    await audioPlayer.stop();
    _videoController!.dispose();
  }
}

//網路
class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      new ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController =
      new StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
