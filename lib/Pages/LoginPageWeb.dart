import 'dart:io';

import 'package:Ess_online/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class LoginPageWeb extends StatefulWidget {
  const LoginPageWeb({Key? key}) : super(key: key);

  @override
  _LoginPageWebState createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  String baseUrl = "";
  String schoolId = "";
  Future<String> session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return baseUrl = (prefs.getString("baseUrl"))!;
  }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: TextStyle(fontSize: 18),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes',style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        top: true,
        child: FutureBuilder(
            future: session(),
            builder: (context, snap) {
              return snap.hasData
                  ? WebView(
                      initialUrl: 'https://$baseUrl.esstestonline.in/login',
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {},
                    )
                  : Container(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ));
            }),
      ),
    );
  }
}
