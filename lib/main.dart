import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/MyThemes.dart';
import 'package:e_learning_sc/screens/game_menu_screen.dart';
import 'package:e_learning_sc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

List<Widget> myScreens = [HomeScreen(), GameMenuScreen()];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      routes: {
        '/': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkTheme ? Colors.grey.shade900 : Colors.white,
      systemNavigationBarColor:
          isDarkTheme ? Colors.grey.shade900 : Colors.white,
      systemNavigationBarIconBrightness:
          isDarkTheme ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return Scaffold(
      body: myScreens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 0.1,
                  spreadRadius: 0.1,
                )
              ],
            ),
            child: DefaultTabController(
              child: Material(
                color: isDarkTheme ? Colors.grey.shade900 : Colors.white,
                child: TabBar(
                  tabs: const [
                    Tab(
                        icon: Text(
                      "📚",
                      style: TextStyle(fontSize: 35),
                    )
                        //Icon(Icons.home, size: 35.0)
                        ),
                    Tab(
                        icon: Text(
                      "🎮",
                      style: TextStyle(fontSize: 35),
                    )
                        //Icon(Icons.import_contacts, size: 35.0)
                        ),
                  ],
                  labelColor: App.myBlack,
                  // //📚unselectedLabelColor: Colors.black26,
                  indicatorColor: App.myBlack,
                  onTap: _onItemTapped,
                ),
              ),
              length: 2,
              initialIndex: 0,
            )),
      ),
    );
  }
}
