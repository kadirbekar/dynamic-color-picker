import 'package:chage_color_with_provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> countries = [
    "TURKEY",
    "GERMANY",
    "USA",
    "ITALY",
    "CHINA",
    "IRAN",
    "IRAK",
    "KATAR",
    "RUSSIA",
    "ENGLAND",
    "SYRIA",
    "INDIA"
  ];

  @override
  Widget build(BuildContext context) {
    //we've got an instance of Color notifir to listen it
    final colorTheme = Provider.of<ColorNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.getColor(),
        centerTitle: true,
        title: Text("Change Color"),
        actions: <Widget>[
          Tooltip(
            message: 'Open Color Dialog',
            child: Padding(
              child: IconButton(
                icon: Icon(
                  Icons.color_lens,
                  size: 35,
                  color: Colors.black,
                ),
                onPressed: () {
                  _openMaterialColorDialog(colorTheme);
                },
              ),
              padding: EdgeInsets.all(5),
            ),
          ),
          Tooltip(
            message: 'Reset Clear Prefs',
            child: Padding(
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 35,
                  color: Colors.black,
                ),
                onPressed: () async {
                  //clear default color from shared preferences
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  setState(() {});
                },
              ),
              padding: EdgeInsets.all(5),
            ),
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return listTile(countries[index], colorTheme.getColor());
            },
            itemCount: countries.length,
          )),
    );
  }

  //it shows name of countries as a listTile
  Widget listTile(String country, Color color) {
    return Padding(
      child: Card(
        color: color,
        child: ListTile(
          title: Text(
            country,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      padding: EdgeInsets.all(4),
    );
  }

  //When click on the color picker icon, it shows an alert dialog to pick one color
  void _alertColorDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.all(12),
        title: Text(title),
        content: content,
        actions: <Widget>[
          Padding(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "CLOSE",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                )),
            padding: EdgeInsets.all(15),
          ),
        ],
      ),
    );
  }

  //Material Color Dialog
  void _openMaterialColorDialog(ColorNotifier colorTheme) {
    _alertColorDialog(
        "Color Dialog",
        Padding(
          child: MaterialColorPicker(
              colors: fullMaterialColors,
              onColorChange: (color) async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setInt('color', color.value);
                colorTheme.setColor(color);
                setState(() {});
              }),
          padding: EdgeInsets.all(10),
        ));
  }
}
