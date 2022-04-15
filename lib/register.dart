import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'rw.dart' as rw;


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}




class _RegisterPageState extends State<RegisterPage> {
  String? selectedCatagory = 'All';
  var gender = '請選擇';
  var selectedDateTime;
  var result;
  final ButtonStyle style = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
        Color.fromRGBO(0, 177, 64, 1.0)),
  );
  String dateSlug = '請選擇';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 250,
          height: 100,
          alignment: Alignment.center,
          child:
          Text(
            '註冊',
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
      ),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 120,
            alignment: Alignment.center,
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: 400,
              height: 100,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '姓名 : ',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged:(text) => globals.name = text,
                      autofocus: true,
                      decoration: InputDecoration(hintText: '請輸入 ...'),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: 400,
              height: 100,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '生日 : ',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 100,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        result = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900, 01),
                          lastDate: DateTime.now(),
                        );

                        if (result != null) {
                          setState(() {
                            selectedDateTime = result;
                            dateSlug = "${selectedDateTime.year
                                .toString()}-${selectedDateTime.month.toString()
                                .padLeft(2, '0')}-${selectedDateTime.day
                                .toString().padLeft(2, '0')}";
                            print(dateSlug);
                            globals.birth = dateSlug;
                          });
                        }
                      },
                      style: style,
                      child: Text(
                        dateSlug,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: 400,
              height: 100,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '性別 : ',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              '男',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            value: '男',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '女',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            value: '女',
                          ),
                        ],
                        hint: Text(
                          gender,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            gender = value as String;
                            if(gender == '男'){
                              globals.isMale = true;
                            }
                            else{
                              globals.isMale = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: 400,
              height: 100,
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 100,
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, '/exam');
                  },
                  style: style,
                  child: Text(
                    '申請註冊',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
