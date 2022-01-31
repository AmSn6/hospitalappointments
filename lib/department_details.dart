import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'urls.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'app_colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'doctor_details.dart';
import 'book_appointment.dart';

class DepartmentDetails extends StatefulWidget {
  final String id;

  DepartmentDetails({this.id});

  @override
  DepartmentDetailsState createState() {
    return new DepartmentDetailsState();
  }
}

List<DepartmentDetail> _deparmentDetailList = [];

class DepartmentDetailsState extends State<DepartmentDetails> {
  bool _inAysncCall = true;

  Future<String> _getDepartmentDetails() async {
    _deparmentDetailList.clear();
    try{
      var res = await http.get(GET_DEPARTMENT_DETAILS + widget.id + sCode);
      if(res.statusCode == 200){
        var resBody = jsonDecode(res.body);
        print('resBody -${resBody}');
        setState(() {
          for (Map details in resBody['department_details']) {
            _deparmentDetailList.add(DepartmentDetail.fromJson(details));
          }
          _inAysncCall = false;
        });
      } else {
        print(res.statusCode);
        serverErrorDialog(context);
      }
    } catch (e) {
      print(e);
      serverErrorDialog(context);
    }

    return 'success';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDepartmentDetails();
  }

  var _boxShadow = new BoxShadow(
      color: Colors.grey[300],
      offset: new Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: 0.0);

  @override
  Widget build(BuildContext context) {
    final _tabs = <Tab>[
      Tab(text: 'Details', icon: new Icon(Icons.description)),
      Tab(
        text: 'Doctors',
        icon: new Icon(Icons.supervisor_account),
      ),
    ];

    final _tabPages = <Widget>[
      new DeptDetail(),
      new DocList(),
    ];

    // TODO: implement build
    return DefaultTabController(
      length: _tabs.length,
      child: new Scaffold(
          appBar: new AppBar(
            titleSpacing: 1,
            title: Titlebar(),
            automaticallyImplyLeading: true,
            backgroundColor: TOOLBAR_COLOR,
            elevation: 0.0,
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: _tabs,
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _inAysncCall,
            child: _deparmentDetailList.isEmpty
                ? new Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/app_background.png'),
                            fit: BoxFit.fill)),
                  )
                : new Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/app_background.png'),
                            fit: BoxFit.fill)),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.white,
                        margin: EdgeInsets.all(8.0),
                        elevation: 2.0,
                        child: new TabBarView(children: _tabPages)),
                  ),
          )),
    );
  }
}

class DocList extends StatelessWidget {
  final Widget _secondRow = new Divider(
    height: 1,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        shrinkWrap: true,
        itemCount:
            _deparmentDetailList == null ? 0 : _deparmentDetailList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: new Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                splashColor: Colors.lightBlue,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => DoctorDetails(
                                id: _deparmentDetailList[index].consultantId,
                              )));
                },
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            height: 50,
                            width: 50,
                            child: new Image(
                                image:_deparmentDetailList[index].thumbpath == null ?
                                AssetImage('assets/icon/icon.png') :NetworkImage(SITE_URL +
                                    "admin/" +
                                    _deparmentDetailList[index].thumbpath)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '${_deparmentDetailList[index].consultant ?? ''}',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                new Text(
                                    _deparmentDetailList[index].department ?? ''),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    _secondRow,
                    new Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              child: new Text(
                                "View Profile",
                                style: TextStyle(
                                    color: VIEW_PROFILE_TC,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: new Row(
                                children: <Widget>[
                                  new Icon(
                                    Icons.perm_contact_calendar,
                                    color: Colors.grey,
                                  ),
                                  new Text(
                                    "Book Appointment",
                                    style: TextStyle(
                                        color: VIEW_PROFILE_TC,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                              flex: 1,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class DeptDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SingleChildScrollView(
      child: Html(
        data: _deparmentDetailList[0].details,
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}

class Titlebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _deparmentDetailList.isEmpty
        ? new Container()
        : new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
//        new IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){Navigator.pop(context);}),
              new Image(
                image: _deparmentDetailList[0].departmentIcon.isEmpty ?
                AssetImage('assets/icon/icon.png')
                    : NetworkImage(SITE_URL +
                    "admin/" +
                    _deparmentDetailList[0].departmentIcon),
                height: 30.0,
                width: 30.0,
              ),
              new Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: new Text(
                  _deparmentDetailList[0].department,
                  style: TextStyle(color: Colors.white),
                ),
              ))
            ],
          );
  }
}

class DepartmentDetail {
  String departmentId;
  String department;
  String details;
  String departmentIcon;
  String consultantId;
  String consultant;
  String imgpath;
  String thumbpath;

  DepartmentDetail({
    this.departmentId,
    this.department,
    this.details,
    this.departmentIcon,
    this.consultantId,
    this.consultant,
    this.imgpath,
    this.thumbpath,
  });

  factory DepartmentDetail.fromJson(Map<String, dynamic> json) =>
      new DepartmentDetail(
        departmentId: json["department_id"],
        department: json["department"],
        details: json["details"],
        departmentIcon: json["department_icon"],
        consultantId: json["consultant_id"],
        consultant: json["consultant"],
        imgpath: json["imgpath"],
        thumbpath: json["thumbpath"],
      );

  Map<String, dynamic> toJson() => {
        "department_id": departmentId,
        "department": department,
        "details": details,
        "department_icon": departmentIcon,
        "consultant_id": consultantId,
        "consultant": consultant,
        "imgpath": imgpath,
        "thumbpath": thumbpath,
      };
}
