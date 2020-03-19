import 'package:chage_color_with_provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //It checks if we've saved a color
  SharedPreferences.getInstance().then((prefs) {
    //set a default color
    Color color = Color(0x00FF22);
    if (prefs.getInt('color') != null) {
      color = Color(prefs.getInt('color'));
    }
    runApp(
      //We've defined our color provider object
      ChangeNotifierProvider<ColorNotifier>(
        create: (context) => ColorNotifier(color),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF56D4F9),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
