import 'package:Ess_online/routes.dart';
import 'package:Ess_online/utils/constants.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/ActivatePage.dart';
import 'Pages/LoginPageWeb.dart';
import 'Provider/LoginProvider.dart';



 Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();

    runApp(GjInfoTech());
 }

class GjInfoTech extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<GjInfoTech> createState() => _GjInfoTechState();
}

class _GjInfoTechState extends State<GjInfoTech> {
  SharedPreferences? prefs;
  _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('activated') != null) {
      activated = true;
    }
  }

  bool? activated;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('activated') != null) {
        activated = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
       // ChangeNotifierProvider(create: (context) => StudentNotification()),
        // ChangeNotifierProvider(create: (context)=>StudentNotificationProvider()),
       // ChangeNotifierProvider(create: (context) => HomeProvider()),
        //ChangeNotifierProvider(create: (context) => StaffNotification()),
      ],
      child: MaterialApp(
        title: 'Ess Online',
        theme: ThemeData(
          primaryColor: UIGuide.PRIMARY,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black))),
          // primarySwatch: Colors.deepOrange,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: routes,
        home: SplashFuturePage(),
        debugShowCheckedModeBanner: false,
        //home : MyHomepage(),
        //home:LoginSecondPage(),
      ),
    );
  }
}

class SplashFuturePage extends StatefulWidget {
  SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  SharedPreferences? prefs;
  Future<Widget> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('activated') != null) {
      if (prefs.getString('accesstoken') != null) {
        var data = await parseJWT();
        return Future.value(LoginPageWeb());

      } else {
        return Future.value(LoginPageWeb());
      }
    } else {
      return Future.value(ActivatePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/logo.png'),
      title: Text(
        "Ess Online",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      futureNavigator: _checkSession(),
    );
  }
}
