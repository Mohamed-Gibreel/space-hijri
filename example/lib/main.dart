import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar', 'SA'),
        ],
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primaryColor: Colors.grey[300],
            accentColor: Colors.black54,
            brightness: Brightness.light,
            backgroundColor: Colors.blue,
            textTheme: TextTheme(caption: TextStyle(color: Colors.red)),
            dialogBackgroundColor: Colors.blue),
        home: MyHomePage(title: "Umm Alqura Calendar"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedDate = new HijriCalendar.now();

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    // HijriCalendar.setLocal(Localizations.localeOf(context).languageCode);
    HijriCalendar.setLocal("ar");
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: Container(
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: new Offset(0.0, 5))
          ], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: HijriMonthPicker(
            lastDate: HijriCalendar()
              ..hYear = 1445
              ..hMonth = 9
              ..hDay = 25,
            firstDate: HijriCalendar()
              ..hYear = 1438
              ..hMonth = 12
              ..hDay = 25,
            onChanged: (HijriCalendar value) {
              setState(() {
                print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
                var testVar = replaceFarsiNumber(value.toString());
                var dateToConvert = testVar.split("/");
                print(HijriCalendar.now());
                print(value.hijriToGregorian(int.parse(dateToConvert[0]),
                    int.parse(dateToConvert[1]), int.parse(dateToConvert[2])));
                print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
                selectedDate = value;
              });
            },
            selectedDate: selectedDate,
          ),
        ),
      ),
    );
  }
}
