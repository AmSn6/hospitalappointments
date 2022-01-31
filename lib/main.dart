import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitalappointments/app_colors.dart';
import 'package:hospitalappointments/online_consultation_form.dart';
import 'package:hospitalappointments/static_html_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospitalappointments/utils.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_colors.dart';
import 'consultant_list.dart';
import 'dashboard_drawer.dart';
import 'department_list.dart';
import 'no_internet_dialog.dart';
import 'notification_html_page.dart';
import 'request_appointment.dart';
import 'urls.dart';

void main() {
  runApp(NewWidget());
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return new MaterialApp(
      theme: ThemeData(primarySwatch: primarySwatch),
//      home: StaticHtmlPage(title: 'test'),
      home: new MyApp(),
      title: "Hospital Appointments",
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _image = new AssetImage("assets/introscreen.png");
  final _image = new AssetImage("assets/app_background.png");
  final _imageLogo = new AssetImage(
    "assets/icon/icon.png",
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isUpdateAvailable = false;
  String appURL = "https://play.google.com/store/apps/details?id=in.sigmacomputers.hospitalappointments";


  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 4), () async {
      if (await checkApkVersion()) {
        setState(() {
          isUpdateAvailable = true;
        });
      } else {
        setState(() {
          isUpdateAvailable = false;
        });
        _firebaseAuth
            .signInWithEmailAndPassword(
                email: 'digitalmarketing@sigmacomputers.in',
                password: 'N6.7T:CNys^t38AVr.Hf')
            .then((val) {
              print('navigate');
          new Future.delayed(
              const Duration(seconds: 4),
              () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage())));
        });
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
    // _firebaseAuth
    //     .signInWithEmailAndPassword(
    //         email: 'digitalmarketing@sigmacomputers.in',
    //         password: 'N6.7T:CNys^t38AVr.Hf')
    //     .then((val) {
    //   new Future.delayed(
    //       const Duration(seconds: 4),
    //       () => Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => HomePage())));
    // });
  }

  static Future<bool> checkApkVersion() async {
    try {
      AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      print('info - ${info.updateAvailable}');
      return info.updateAvailable;
    } catch (e) {
      print('e - $e');
      return false;
    }
  }

  Widget oldVersionWidget({@required Function update}) {
    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('New Update Available'),
        content: Text(
            'Please Download the new Version of the App from Google Play Store'),
        actions: <Widget>[
          FlatButton(
            child: Text('Exit App'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          FlatButton(onPressed: update, child: Text('Update'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: TOOLBAR_COLOR,
      body: Stack(
        children: [
    //       Positioned.fill(
    //   child: Align(
    //   alignment: Alignment.topCenter,
    //     child: Container(
    //       decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage('assets/bg.jpg'),
    //             repeat: ImageRepeat.repeat,
    //           )),
    //     ),
    //   ),
    // ),
    //       Positioned.fill(
    //           child: Center(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: <Widget>[
    //                 Image.asset(
    //                   'assets/icon/icon.png',
    //                   height: 80,
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Center(child:   Text(
    //                   'Loading... Please Wait...',
    //                   style: TextStyle(color: Colors.white),
    //                 ),)
    //               ],
    //             ),
    //           )),
    //       Positioned.fill(
    //         child: Align(
    //           alignment: Alignment.topCenter,
    //           child: sigmaText(textColor: Colors.white),
    //         ),
    //       ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _image,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
          // Container(
          //     height: MediaQuery.of(context).size.height,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         gradient: LinearGradient(
          //             begin: FractionalOffset.topCenter,
          //             end: FractionalOffset.bottomCenter,
          //             colors: [
          //               Colors.grey.withOpacity(0.0),
          //               Colors.black.withOpacity(0.5),
          //             ],
          //             stops: [
          //               0.0,
          //               1.0
          //             ]))),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: isUpdateAvailable ?
            oldVersionWidget(update: () async{
              return await launch(appURL);
            }) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Image(
                  image: _imageLogo,
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Sigma Appointments',style: TextStyle(fontSize: 16,color: Colors.white),),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),


              ],
            ),
          )),
          Positioned.fill(child: Align(child: sigmaText(textColor: Colors.white),alignment: Alignment.bottomCenter,)),
        ],
      ),

    );
  }
}

_launchWebsiteURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HomePage extends StatefulWidget {
  static HomePageState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

StreamSubscription<ConnectivityResult> _connectivitySubscription;

class HomePageState extends State<HomePage> {
  final FirebaseMessaging _fireBaseMessaging = new FirebaseMessaging();
  final _dashboardImage = new AssetImage("assets/banner.jpeg");

  // final _dashboardImage = new AssetImage("assets/multispeciality_hospital.jpg");
  String _announcementData;
  bool _isNotiAvailable = false;
  bool _isConnected = false;

  void _checkForInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _isConnected = true;
          print('internet connected');
          _getAnnouncement();
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _isConnected = false;
        _isNotiAvailable = false;
        print('not connected');
      });
    }
  }

  Future<String> _getAnnouncement() async {
    print('get announcement running');
    var res = await http.get(GET_ANNOUNCEMENT);
    var resBody = jsonDecode(res.body);
    print(resBody);
    setState(() {
      if (resBody['success'] == 1) {
        print('announcement available');
        _isNotiAvailable = true;
        _announcementData = resBody['response'][0]['description'];
        print('announcement data ' + _announcementData);
      } else {
        print('announcement not available');
        _isNotiAvailable = false;
      }
    });
    return 'success';
  }

  Future<String> _getAnnouncementNotification(String title, String body) async {
    print('get announcement running');
    var res = await http.get(GET_ANNOUNCEMENT);
    var resBody = jsonDecode(res.body);
    print(resBody);
    setState(() {
      if (resBody['success'] == 1) {
        print('announcement available');
        _announcementData = resBody['response'][0]['description'];
        _pushLocalNotification(title, body, _announcementData);
        print('announcement data ' + _announcementData);
      } else {
        print('announcement not available');
      }
    });
    return 'success';
  }

  void toggleConnectivity() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);
      _checkForInternet();
    });
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) async {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => NotificationHtmlPage(data: payload)));
  }

  Future<String> _pushLocalNotification(
      String title, String body, String payload) async {
    print('local notification started');
    var android = new AndroidNotificationDetails(
        '012', 'Sigma Appointments', 'Healthy Life at its Best',
        importance: Importance.Max, priority: Priority.High);
    var iOS = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
    print('local notification pushed');
    return 'success';
  }

  @override
  void initState() {
    print('widget initstate');
    super.initState();
    _checkForInternet();
    toggleConnectivity();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _fireBaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print('onLaunch called');
      },
      onMessage: (Map<String, dynamic> msg) {
        print('onMessage called');
        var list = msg.values.toList();
        _getAnnouncementNotification(list[0]['title'], list[0]['body']);
//        _pushLocalNotification(list[0]['title'],list[0]['body']);
      },
      onResume: (Map<String, dynamic> msg) {
        print('onResume called');
      },
    );

    _fireBaseMessaging.getToken().then((token) {
      print(token);
    });
//    _getPushToken();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: new Scaffold(
        backgroundColor: LIST_BACKGROUND,
        appBar: AppBar(
          elevation: 5.0,
          titleSpacing: 1,
          title: new Text("Sigma Appointements"),
          backgroundColor: TOOLBAR_COLOR,
          actions: _isNotiAvailable
              ? <Widget>[
                  Shimmer.fromColors(
                    child: IconButton(
                      icon: new Icon(
                        FontAwesomeIcons.solidBell,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NotificationHtmlPage(
                                    data: _announcementData)));
                      },
                    ),
                    baseColor: Colors.yellow,
                    highlightColor: Colors.red,
                  ),
                ]
              : null,
        ),
        drawer: DashboardDrawer(context,
            _isConnected ? _announcementData : "No Internet Connection"),
        body: new ListView(
          children: <Widget>[
            new Container(
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Center(
                        child: new Card(
                          elevation: 2.0,
                          child: new Image(image: _dashboardImage),
                        ),
                      )),
                  // DashboardContainer(
                  //   assetImage: AssetImage("assets/find_doctor_icon.png"),
                  //   heading: "ONLINE CONSULTATION",
                  //   description: "consult doctor from anywhere",
                  //   checkInternet: _isConnected,
                  // ),
                  DashboardContainer(
                    assetImage: AssetImage("assets/appointment_icon.png"),
                    heading: "REQUEST AN APPOINTMENT",
                    description: "Book an appointment with Right Doctor",
                    checkInternet: _isConnected,
                  ),
                  DashboardContainer(
                    assetImage: AssetImage("assets/find_doctor_icon.png"),
                    heading: "FIND YOUR DOCTOR",
                    description: "find experts here",
                    checkInternet: _isConnected,
                  ),
                  DashboardContainer(
                    assetImage: AssetImage("assets/department.png"),
                    heading: "DEPARTMENT",
                    description: "find our departments",
                    checkInternet: _isConnected,
                  ),
                  DashboardContainer(
                    assetImage: AssetImage("assets/ambulance_icon.png"),
                    heading: "EMERGENCY CARE",
                    description: "Get Quick Care",
                    checkInternet: _isConnected,
                  ),
                  DashboardContainer(
                    assetImage: AssetImage("assets/map_icon.png"),
                    heading: "DIRECTIONS",
                    description: "Get the Fastest Route to Reach Us",
                    checkInternet: _isConnected,
                  ),
                  DashboardContainer(
                    assetImage: AssetImage("assets/web_icon.png"),
                    heading: "VISIT OUR WEBSITE",
                    description: "https://sigmacomputers.in/",
                    checkInternet: _isConnected,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> willPopCallback() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Please click BACK again to exit',
          textColor: Colors.white,
          backgroundColor: TOOLBAR_COLOR,
          fontSize: 16);
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }
}

class DashboardContainer extends StatefulWidget {
  final AssetImage assetImage;
  final String heading;
  final String description;
  final bool checkInternet;

  const DashboardContainer(
      {this.assetImage, this.heading, this.description, this.checkInternet});

  @override
  DashboardContainerState createState() {
    return new DashboardContainerState();
  }
}

class DashboardContainerState extends State<DashboardContainer> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: new Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: new InkWell(
          splashColor: Colors.lightBlue,
          onTap: () {
            switch (widget.heading) {
              case 'VISIT OUR WEBSITE':
                widget.checkInternet
                    // ? _launchWebsiteURL("http://www.dharanhospital.com")
                    ? _launchWebsiteURL("https://sigmacomputers.in/")
                    : noInternetDialog(context);
                break;

              case 'FIND YOUR DOCTOR':
                widget.checkInternet
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ConsultantList()))
                    : noInternetDialog(context);
                break;

              case 'DEPARTMENT':
                widget.checkInternet
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => DepartmentList()))
                    : noInternetDialog(context);
                break;

              case 'REQUEST AN APPOINTMENT':
                widget.checkInternet
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => RequestAppointmentForm()))
                    : noInternetDialog(context);
                break;

              case 'ONLINE CONSULTATION':
                widget.checkInternet
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => OnlineConsultationForm()))
                    : noInternetDialog(context);
                break;

              case 'EMERGENCY CARE':
                showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: new Text(
                            'Call for an Ambulance',
                            style: TextStyle(color: Colors.blue),
                          ),
                          content: new Text('Are you sure want to call?'),
                          actions: <Widget>[
                            new TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                )),
                            new TextButton(
                                onPressed: () {
                                  _launchWebsiteURL('tel://0427-0000034');
                                  // _launchWebsiteURL('tel://0427-4266034');
                                },
                                child: new Text(
                                  'Call',
                                  style: TextStyle(color: Colors.green),
                                )),
                          ],
                        ));
                break;


              case 'DIRECTIONS':
                _launchWebsiteURL(
                    'http://maps.google.com/maps?daddr=11.668654 78.143184');
                // _launchWebsiteURL('http://maps.google.com/maps?daddr=11.625260, 78.145182');
                break;
            }
          },
          child: new Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
//                    margin: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Container(
                      width: 50,
                      height: 50,
                      child: new Image(image: widget.assetImage),
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
//                  margin: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          widget.heading,
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                        ),
                        new Text(
                          widget.description,
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  flex: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
