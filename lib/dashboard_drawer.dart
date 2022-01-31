import 'package:flutter/material.dart';
import 'package:hospitalappointments/about_us.dart';
import 'package:hospitalappointments/utils.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'request_appointment.dart';
import 'department_list.dart';
import 'enquiry_complaints.dart';
import 'no_internet_dialog.dart';
import 'static_html_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hospitalappointments/notification_html_page.dart';

Widget DashboardHeader(BuildContext context) {
  var logoImage = new AssetImage('assets/logo.png');
  return Container(
    height: 100.0,
    color: LIST_BACKGROUND,
    child: new DrawerHeader(
      child: new Image(
        image: logoImage,
        fit: BoxFit.contain,
      ),
    ),
  );
}

bool _isProfile = false;
bool _isCentreOfExc = false;
bool _dharanGroup = false;
bool _dect = false;
bool _education = false;

var _selectedStyle = new TextStyle(color: Colors.blue);

Widget DashboardDrawer(BuildContext context, String notificationData) {
  return new Drawer(
    elevation: 5.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: new ListView(
            children: <Widget>[
              DashboardHeader(context),
              notificationData == null || notificationData.isEmpty  ? new Container() :
              new _MenuList(
                title: 'Notifications',
                icon: new Icon(FontAwesomeIcons.bell,color: TOOLBAR_COLOR,),
                text: new Text('Notifications',style: TextStyle(color: TOOLBAR_COLOR),),
                notificationData: notificationData,
              ),
              new _MenuList(
                title: 'Appointment',
                icon: new Icon(FontAwesomeIcons.calendarAlt,color: TOOLBAR_COLOR),
                text: new Text('Appointment',style: TextStyle(color: TOOLBAR_COLOR)),
                notificationData: notificationData,
              ),
              new _MenuList(
                title: 'Department',
                icon: new Icon(FontAwesomeIcons.hospital,color: TOOLBAR_COLOR),
                text: new Text('Department',style: TextStyle(color: TOOLBAR_COLOR)),
                notificationData: notificationData,
              ),
              new _MenuList(
                title: 'About App',
                icon: new Icon(FontAwesomeIcons.landmark,color: TOOLBAR_COLOR),
                text: new Text('About App',style: TextStyle(color: TOOLBAR_COLOR)),
              ),
              // _isProfile ? _ProfileWidget() : new Container(),
              // new _MenuList(
              //   title: 'Centre of Excellence',
              //   icon: _isCentreOfExc
              //       ? new Icon(
              //           FontAwesomeIcons.asterisk,
              //           color: Colors.blue,
              //         )
              //       : new Icon(FontAwesomeIcons.asterisk,color: TOOLBAR_COLOR),
              //   text: _isCentreOfExc
              //       ? new Text(
              //           'Centre of Excellence',
              //           style: _selectedStyle,
              //         )
              //       : new Text('Centre of Excellence',style: TextStyle(color: TOOLBAR_COLOR)),
              // ),
              // _isCentreOfExc ? _CenterofExcWidget() : new Container(),
              // new _MenuList(
              //   title: 'Dharan Group',
              //   icon: _dharanGroup
              //       ? new Icon(
              //           FontAwesomeIcons.layerGroup,
              //           color: Colors.blue,
              //         )
              //       : new Icon(
              //           FontAwesomeIcons.layerGroup,
              //       color: TOOLBAR_COLOR
              //         ),
              //   text: _dharanGroup
              //       ? new Text(
              //           'Dharan Group',
              //           style: _selectedStyle,
              //         )
              //       : new Text('Dharan Group',style: TextStyle(color: TOOLBAR_COLOR)),
              // ),
              // _dharanGroup ? _DharanGroupWidget() : new Container(),
              // new _MenuList(
              //   title: 'Dharan Educational Charitable Trust (DECT)',
              //   icon: _dect
              //       ? new Icon(
              //           FontAwesomeIcons.school,
              //           color: Colors.blue,
              //         )
              //       : new Icon(FontAwesomeIcons.school,color: TOOLBAR_COLOR),
              //   text: _dect
              //       ? new Text(
              //           'Dharan Educational Charitable Trust (DECT)',
              //           style: _selectedStyle,
              //         )
              //       : new Text('Dharan Educational Charitable Trust (DECT)',style: TextStyle(color: TOOLBAR_COLOR)),
              // ),
              // _dect ? _DECTWidget() : new Container(),
              // new _MenuList(
              //   title: 'Education',
              //   icon: _education
              //       ? new Icon(
              //           FontAwesomeIcons.graduationCap,
              //           color: Colors.blue,
              //         )
              //       : new Icon(FontAwesomeIcons.graduationCap,color: TOOLBAR_COLOR),
              //   text: _education
              //       ? new Text(
              //           'Education',
              //           style: _selectedStyle,
              //         )
              //       : new Text('Education',style: TextStyle(color: TOOLBAR_COLOR)),
              // ),
              // _education ? _EducationWidget() : new Container(),
              // new _MenuList(
              //   title: 'Enquiry and Complaints',
              //   icon: new Icon(FontAwesomeIcons.edit),
              //   text: new Text('Enquiry and Complaints'),
              // ),
              new _MenuList(
                title: 'Contact Us',
                icon: new Icon(
                  FontAwesomeIcons.phone,
                    color: TOOLBAR_COLOR
                ),
                text: new Text('Contact Us',style: TextStyle(color: TOOLBAR_COLOR)),
              ),
              new _MenuList(
                title: 'Rate App',
                icon: new Icon(FontAwesomeIcons.star,color: TOOLBAR_COLOR),
                text: new Text('Rate App',style: TextStyle(color: TOOLBAR_COLOR)),
              ),

            ],
          ),
        ),
        new Divider(),
        new Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: new Text('Follow us on'),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: new Row(
            children: <Widget>[
              new IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue[900],
                  ),
                  onPressed: () {
                    launch('https://www.facebook.com/SigmaComputersSalem/');
                    // launch('https://www.facebook.com/dharanhospital');
                  }),
              new IconButton(
                  icon: Icon(FontAwesomeIcons.instagram,
                      color: Colors.pink),
                  onPressed: () {

                    // launch('https://www.instagram.com/dharan_hospital');
                    launch('https://www.instagram.com/sigma_prestantia/');
                  }),
              new IconButton(
                  icon: Icon(FontAwesomeIcons.youtube, color: Colors.red),
                  onPressed: () {
                    launch('https://www.youtube.com/channel/UC1U3fyGCMc60Nej9m6ZSpWg');
                    // launch('https://www.youtube.com/channel/UCSucEGudkl9wSy7Pm83pobg');
                  }),
            ],
          ),
        ),
        Center(child: sigmaText(textColor: Colors.black38)),
      ],
    ),
  );
}
// Center sigmaText() {
//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: new GestureDetector(
//         child: new RichText(
//           text: TextSpan(children: <TextSpan>[
//             TextSpan(
//                 text: 'Powered by ', style: TextStyle(color: Colors.black)),
//             TextSpan(
//                 text: 'Sigma Computers',
//                 style: TextStyle(color: Colors.blue)),
//           ]),
//         ),
//         onTap: () {
//           launch('http://www.sigmacomputers.in');
//         },
//       ),
//     ),
//   );
// }



class _MenuList extends StatefulWidget {
  final String title, notificationData;
  final Icon icon;
  final Text text;

  _MenuList({this.title, this.icon, this.text, this.notificationData});

  @override
  _MenuListState createState() {
    return new _MenuListState();
  }
}

class _MenuListState extends State<_MenuList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: InkWell(
          onTap: () {
            switch (widget.title) {
              case 'Notifications':
                Navigator.pop(context);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => NotificationHtmlPage(
                            data: widget.notificationData)));
                break;

              case 'Appointment':
                if (widget.notificationData == "No Internet Connection") {
                  print('No Internet Connection');
                  Navigator.pop(context);
                  noInternetDialog(context);
                } else {
                  print('Yes Internet Connection');
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => RequestAppointmentForm()));
                }
                break;

              case 'Department':
                if (widget.notificationData == "No Internet Connection") {
                  print('No Internet Connection');
                  Navigator.pop(context);
                  noInternetDialog(context);
                } else {
                  print('Yes Internet Connection');
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => DepartmentList()));
                }
                break;

              case 'About App':
                Navigator.pop(context);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AboutApp(
                          title: widget.title,
                        )));
                // HomePage.of(context).setState(() {
                //   _isProfile = !_isProfile;
                //   _isCentreOfExc = false;
                //   _dharanGroup = false;
                //   _dect = false;
                //   _education = false;
                // });
                break;

              // case 'Centre of Excellence':
              //   HomePage.of(context).setState(() {
              //     _isProfile = false;
              //     _isCentreOfExc = !_isCentreOfExc;
              //     _dharanGroup = false;
              //     _dect = false;
              //     _education = false;
              //   });
              //   break;
              //
              // case 'Dharan Group':
              //   HomePage.of(context).setState(() {
              //     _isProfile = false;
              //     _isCentreOfExc = false;
              //     _dharanGroup = !_dharanGroup;
              //     _dect = false;
              //     _education = false;
              //   });
              //   break;
              //
              // case 'Dharan Educational Charitable Trust (DECT)':
              //   HomePage.of(context).setState(() {
              //     _isProfile = false;
              //     _isCentreOfExc = false;
              //     _dharanGroup = false;
              //     _dect = !_dect;
              //     _education = false;
              //   });
              //   break;
              //
              // case 'Education':
              //   HomePage.of(context).setState(() {
              //     _isProfile = false;
              //     _isCentreOfExc = false;
              //     _dharanGroup = false;
              //     _dect = false;
              //     _education = !_education;
              //   });
              //   break;

              // case 'Enquiry and Complaints':
              //   Navigator.pop(context);
              //   Navigator.push(context,
              //       CupertinoPageRoute(builder: (context) => EnquiryForm()));
              //   break;

              case 'Rate App':
                launch(
                    'https://play.google.com/store/apps/details?in.sigmacomputers.hospitalappointments');
                break;

              case 'Contact Us':
                Navigator.pop(context);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => StaticHtmlPage(
                              title: widget.title,
                            )));
                break;
            }
          },
          child: new Row(
            children: <Widget>[
              widget.icon,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: widget.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() {
    return new _ProfileWidgetState();
  }
}

class _ProfileWidgetState extends State<_ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 70.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new _SubMenuList(
            title: 'Dharan Hospital',
          ),
          new _SubMenuList(
            title: 'Management Team',
          ),
          new _SubMenuList(
            title: 'Milestones',
          ),
          new _SubMenuList(
            title: 'Medical Services',
          ),
          new _SubMenuList(
            title: 'Medical Facilities',
          ),
        ],
      ),
    );
  }
}

class _CenterofExcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new _SubMenuList(
            title: 'Women IVF Centre',
          ),
          new _SubMenuList(
            title: 'Oncology Centre',
          ),
          new _SubMenuList(
            title: 'Transplant Centre',
          ),
        ],
      ),
    );
  }
}

class _DharanGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new _SubMenuList(
            title: 'Dharan Natural Stone Park',
          ),
          new _SubMenuList(
            title: 'Dharan Bath Care',
          ),
          new _SubMenuList(
            title: 'Dharan Bath Fittings',
          ),
          new _SubMenuList(
            title: 'Dharan Rock (100% EOU)',
          ),
        ],
      ),
    );
  }
}

class _DECTWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new _SubMenuList(
            title: 'DEC Trust',
          ),
          new _SubMenuList(
            title: 'Education',
          ),
          new _SubMenuList(
            title: 'Charity',
          ),
        ],
      ),
    );
  }
}

class _EducationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new _SubMenuList(
            title: 'Dharan Nursing College',
          ),
          new _SubMenuList(
            title: 'Dharan School of Nursing (DSN)',
          ),
          // new _SubMenuList(
          //   title: 'Dharan School of Paramedical Sciences (DSPS)',
          // ),
          new _SubMenuList(
            title: 'Dharan Institute of Health Sciences (DIHS)',
          ),
        ],
      ),
    );
  }
}

class _SubMenuList extends StatelessWidget {
  final String title;

  _SubMenuList({this.title}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => StaticHtmlPage(
                        title: title,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            title,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ));
  }
}
