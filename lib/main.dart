import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_app/attach_fleet.dart';
import 'package:flutter_learning_app/booking_history.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';
import 'package:flutter_learning_app/controllers/local_storage_controller.dart';
import 'package:flutter_learning_app/home_layout.dart';
import 'package:flutter_learning_app/login.dart';
import 'package:flutter_learning_app/models/user.dart' as userModel;
import 'package:flutter_learning_app/providers/login.dart';
import 'package:flutter_learning_app/providers/user_provider.dart';
import 'package:flutter_learning_app/splash_screen.dart';
import 'package:flutter_learning_app/your_fleets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'about_us.dart';
import 'edit_profile.dart';
import 'models/load.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorageUtils().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Shreem Fleet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.montserratTextTheme(),
            primaryColor: Color(0xff425C5A),
            primaryColorLight: Color(0xffFFB876),
            accentColor: Color(0xffFFCEA2)),
        // home: LocalStorageUtils().isUserLoggedIn() ? HomePage() : LoginScreen(),
        home: SplashScreen(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _pickUpLocation = TextEditingController();
  TextEditingController _dropLocation = TextEditingController();
  List<Load> _allLoads;
  int _currentPageIndex = 0;

  List<Widget> _allScreens = [HomeLayout(), BookingHistory(), AttachFleet()];

  @override
  void initState() {
    super.initState();
    HttpController.getAllLoads().then((List<Load> data) {
      _allLoads = data;
      setState(() {});
    });
    _pickUpLocation.addListener(onPickUpChanged);
    _dropLocation.addListener(onPickUpChanged);
  }

  onPickUpChanged() {
    String dropLocation = _dropLocation.text;
    String pickUpLocation = _pickUpLocation.text;
    if (pickUpLocation.length != 0) {
      _allLoads = _allLoads
          .where((e) => e.pickupLocation
              .toLowerCase()
              .contains(pickUpLocation.toLowerCase()))
          .toList();
      if (dropLocation.length != 0) {
        _allLoads = _allLoads
            .where((e) =>
                e.pickupLocation
                    .toLowerCase()
                    .contains(pickUpLocation.toLowerCase()) &&
                e.dropLocation
                    .toLowerCase()
                    .contains(dropLocation.toLowerCase()))
            .toList();
      }
      setState(() {});
    } else if (dropLocation.length != 0) {
      _allLoads = _allLoads
          .where((e) =>
              e.dropLocation.toLowerCase().contains(dropLocation.toLowerCase()))
          .toList();
    } else {
      HttpController.getAllLoads().then((List<Load> data) {
        _allLoads = data;
        setState(() {});
      });
    }
  }

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    userModel.User user = userProvider.user;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "History"),
            BottomNavigationBarItem(
                icon: Icon(Icons.playlist_add), label: "Add Fleet"),
          ],
          onTap: (pageIndex) {
            _currentPageIndex = pageIndex;
            setState(() {});
          },
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountEmail: Text(user.email),
                accountName: Text(user.name),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(loggedIn: true))),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Profile',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YourFleets())),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Your Fleets',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsPage())),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'About Us',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Help',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              InkWell(
                onTap: () {
                  LocalStorageUtils().clearStorage();
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Logout',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.notifications,
                size: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              color: Theme.of(context).primaryColor,
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(
            Icons.account_circle,
            size: 35,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            user.name,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: _allScreens[_currentPageIndex]);
  }
}
