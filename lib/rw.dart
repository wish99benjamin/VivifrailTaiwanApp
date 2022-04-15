import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'globals.dart' as globals;

// void main() {
//   //final path = (await CounterStorage()._localPath);
//
//
//   runApp(
//     MaterialApp(
//       title: 'Reading and Writing Files',
//       home: FlutterDemo(storage: CounterStorage()),
//     ),
//   );
//
//
// }

class UserStorage {

  //找路徑
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //找檔案
  Future<File> get _localFile async {
    final path = await _localPath;

    bool value = await File('$path/user.txt').exists();
    if(value){
      print("it exist");
    }
    else{
      print("its not");
    }

    return File('$path/user.txt');
  }

  Future<bool> ifFileExists() async {
    final path = await _localPath;

    bool value = await File('$path/user.txt').exists();
    globals.value = value;
    return value;
  }

  //讀檔案
  Future<List> readUserTxt() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsLines();

      print(contents);

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  //寫檔案 一次寫一行
  Future<File> writeUserTxt(String str, int append) async {
    final file = await _localFile;

    // Write the file
    if(append == 1){
      print("appppppppppppppppppppppppppend");
      print(str);
      return file.writeAsString(str, mode: FileMode.append);
    }
    else{
      return file.writeAsString(str);
    }
  }
}

// class FlutterDemo extends StatefulWidget {
//   const FlutterDemo({Key? key, required this.storage}) : super(key: key);
//
//   final CounterStorage storage;
//
//   @override
//   _FlutterDemoState createState() => _FlutterDemoState();
// }
//
// class _FlutterDemoState extends State<FlutterDemo> {
//   int _counter = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.storage.readCounter().then((int value) {
//       setState(() {
//         _counter = value;
//         if(_counter == 20){
//           print("Hello");
//         }
//       });
//     });
//   }
//
//   Future<File> _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//
//     // Write the variable as a string to the file.
//     return widget.storage.writeCounter(_counter);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reading and Writing Files'),
//       ),
//       body: Center(
//         child: Text(
//           'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }