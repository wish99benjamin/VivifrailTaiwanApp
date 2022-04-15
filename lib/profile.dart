import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'rw.dart' as rw;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');//pushNamed是因為有定義page的名字
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/introduce'); //pushNamed是因為有定義page的名字
            },
            icon: Icon(
              Icons.report,
              size: 40,
            ),
          ),
        ],
        title: const Text('個人資料'),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Stack(
                children: [
                  globals.profileImageNumber == -1
                      ? Center(
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: MediaQuery.of(context).size.width / 3,
                          ),
                        )
                      : Image.asset(
                          'assets/images/profile/' + globals.profileImageNumber.toString() + '.png',
                          height: double.maxFinite,
                        ),
                  Align(
                    alignment: Alignment(-1, 0.9),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _showDialog();
                          });
                        },
                        icon: Icon(
                          Icons.image,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              width: (MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 6 * 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '姓名:',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              globals.name,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 6 * 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '生日:',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              globals.birth,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 6 * 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '性別:',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              globals.isMale? '男' : '女',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 6 * 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '總評:',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              'assets/images/grade/' + globals.grade.toString() + '.png',
                              height: double.maxFinite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(''),
          ),
        ],
      ),
    );
  }

  _showDialog() async{
    showDialog(
      context: context,
      builder: (ctx){
        return Center(
          child: Container(
            width: (MediaQuery.of(context).size.width) / 3 * 2,
            height: (MediaQuery.of(context).size.height) / 3 * 2,
            color: Colors.white,
            child: Material(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '請選擇個人檔案圖像',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: 8,
                      scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index){
                          return Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          globals.profileImageNumber = 0 + index * 2;
                                          globals.writeBack();
                                          widget.storage.writeUserTxt(globals.userList[0][0], 0);

                                        });
                                      },
                                      icon: Image.asset('assets/images/profile/' + (0 + index * 2).toString()+ '.png',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        globals.profileImageNumber = 1 + index * 2;
                                        globals.writeBack();
                                        widget.storage.writeUserTxt(globals.userList[0][0], 0);
                                      });
                                    },
                                    icon: Image.asset('assets/images/profile/' + (1 + index * 2).toString()+ '.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        '確認',
                        style: TextStyle(fontSize: 20),
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
  }
}


