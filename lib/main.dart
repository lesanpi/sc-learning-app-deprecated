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

void main() async {
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,overlays: []);
  //WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize();

  runApp(const MyApp());
}
List<Widget> myScreens = [HomeScreen(), GameMenuScreen()];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyHomePage(title: 'Main Page')
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: myScreens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
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
              tabs: [
                Tab(
                    icon: Text("📚", style: TextStyle(fontSize: 35),)
                  //Icon(Icons.home, size: 35.0)
                ),
                Tab(
                    icon: Text("🎮", style: TextStyle(fontSize: 35),)
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
          )
        ),
      ),
      //backgroundColor: Color(0xFFf0fdff),
      //backgroundColor: Color(0xFFf5f5f5),
      /*BottomNavigationBar(
        showSelectedLabels: false,   // <-- HERE
        showUnselectedLabels: false,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: App.primaryColor,
        unselectedItemColor: const Color(0xFFe6e1e3),
        //backgroundColor: Color(0xFFDFFBFF),
        iconSize: 35,
        elevation: 10,
        onTap: _onItemTapped,
      ),*/

    );
  }
}
