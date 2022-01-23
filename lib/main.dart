import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/screens/game_menu_screen.dart';
import 'package:e_learning_sc/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                //📚unselectedLabelColor: Colors.black26,
                indicatorColor: App.myBlack,
                onTap: _onItemTapped,
              ),
              length: 2,
              initialIndex: 0,
            )),
      ),
    );
  }
}
