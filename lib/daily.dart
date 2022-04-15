import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'rw.dart' as rw;

import 'globals.dart' as globals;

class DairyPage extends StatefulWidget {
  const DairyPage({Key? key, required this.storage}) : super(key: key);
  final rw.UserStorage storage;

  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {

  CalendarController _controller = CalendarController();
  TextEditingController _eventController = TextEditingController();
  final Map<DateTime,List<dynamic>> _events={};

  //SharedPreferences? prefs;
    final _selectedDate = DateTime.now();
    List<dynamic> _selectedEvents = [];

    @override
    void initState(){
      super.initState();
      //initPrefs();
      print('FINISH');
      print(globals.recordTimeList.length);
      for(int i=0;i<globals.recordTimeList.length;i++){
        print(globals.recordTimeList[0][i].toString());
        _events[DateTime.parse(globals.recordTimeList[0][i].toString()+' 00:00:00.000')] = ['done'];
      }
    }

    //initPrefs() async {
    //  prefs = await SharedPreferences.getInstance();
    //  setState(() {
    //    _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs!.getString("events") ?? "{}")));
    //  });
    //}

    Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map){
      Map<String,dynamic> newMap = {};
      map.forEach((key, value) {
        newMap[key.toString()] = map[key];
      });
      return newMap ;
    }

    Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
      Map<DateTime,dynamic> newMap = {};
      map.forEach((key, value) {
        newMap[DateTime.parse(key)] = map[key];
      });
      return newMap;
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '運動日記',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          backgroundColor: Color.fromRGBO(0, 177, 64, 1.0),
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
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                locale: 'zh_CN',
                calendarStyle: CalendarStyle(
                    todayColor: Colors.green,
                    selectedColor: Colors.cyan,
                ),
                headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonShowsNext: false
                ),
                events: _events,
                onDaySelected: (date,events,_){
                  setState(() {
                    _selectedEvents = events;
                  });
                },
                calendarController: _controller,),
              //..._selectedEvents.map((event) => ListTile(
              //  title: Text(event),
              //)),
              _buildEventList(),
            ],
          ),
        ),
        //floatingActionButton: FloatingActionButton(
        //  child: Icon(Icons.add),
        //  onPressed: _showAddDialog,
        //),
      );
    }
    _showAddDialog(){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:Text(
            '加入備註',
            style: TextStyle(fontSize: 25),
          ),
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            TextButton(child: Text('儲存',style: TextStyle(fontSize: 25),),
              onPressed: (){
                if(_eventController.text.isEmpty) return;
                setState(() {
                  if(_events[_controller.selectedDay]!= null){
                    _events[_controller.selectedDay]?.add(_eventController.text);
                  }
                  else{
                    _events[_controller.selectedDay] = [_eventController.text];
                  }
                  //prefs!.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      );
    }
    Widget _buildEventList(){
      return SizedBox(
        height: 500,
        child: ListView(
          children:
          _selectedEvents.map((event) => Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              border: Border.all(width: 0.8),borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 2.0,
              vertical: 3.0,
            ),
            child: ListTile(
              title: Text(
                event.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
          ).toList(),
        ),
      );
    }
  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.cake,
      size: 20.0,
      color: Colors.lightGreenAccent,
    );
  }
}
