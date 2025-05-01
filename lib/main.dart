
import 'package:enviroewatch/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/about_screen.dart';
import 'screens/customerchat_screen.dart';
import 'screens/galleryscreen.dart';
import 'screens/helpfaqscreen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(EnviroEWatchApp());
}

class EnviroEWatchApp extends StatelessWidget {
  const EnviroEWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Enviro-ewatch',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromARGB(73, 158, 158, 158),
      ),
      home: BottomNav(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(73, 158, 158, 158),
                ), 
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('/images/env.png',
                    width: 230,
                    height: 230,
                    fit: BoxFit.cover ),
                  )
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About us',
                  style: TextStyle(fontFamily: 'RobotoMono'),
                ),
                onTap: () {
                  Get.to(AboutScreen());
                },
              ),
              SizedBox(width: 15),
              ListTile(
                leading: Icon(Icons.photo_library_outlined),
                title: Text('Gallery',
                  style: TextStyle(fontFamily: 'RobotoMono'),
                ),
                onTap: () {
                  Get.to(GalleryScreen());
                  _scaffoldKey.currentState?.closeDrawer();
                },
              ),
              SizedBox(width: 15),
              ListTile(
                leading: Icon(Icons.help_outlined),
                title: Text('Help'),
                onTap: () {
                  Get.to(HelpScreen());
                  _scaffoldKey.currentState?.closeDrawer();
                },
              ),
              SizedBox(width: 15),
              Image.asset('/images/artwithnature.jpg',
              width: 135,
              height: 135,
              alignment: Alignment.bottomCenter,)
            ],
          ),
        ),),
      appBar: AppBar(
        title: Image.asset('/images/envh.jpeg', 
        height: 23,
        alignment: Alignment.center,),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Text( 'Chat with experts', 
            style: TextStyle(
            fontFamily: 'RobotoMono', fontSize: 13, fontWeight: FontWeight.bold),),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () { Get.to(CustomerChatScreen()); },
              icon: Icon(Icons.chat, size: 13,), ),)
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 11, 159, 6),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),    );

  }
}
