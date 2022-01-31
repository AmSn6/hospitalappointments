import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'urls.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'book_appointment.dart';
import 'dialogs.dart';
import 'package:flutter/cupertino.dart';

class DoctorDetails extends StatefulWidget {
  final String id;

  DoctorDetails({this.id});

  @override
  DoctorDetailsState createState() {
    return new DoctorDetailsState();
  }
}

List<ConsultantDetail> _consultantDetailsList = [];

class DoctorDetailsState extends State<DoctorDetails> {
  bool _inAysncCall = true;

  Future<String> _getDoctorDetails() async {
    _consultantDetailsList.clear();
    try {
      var res = await http.get(GET_DOCTORS_DETAILS + widget.id + sCode);
      if(res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        print('resbody -${resbody}');
        setState(() {
          for (Map details in resbody['consultant_details']) {
            _consultantDetailsList.add(ConsultantDetail.fromJson(details));
          }
          _inAysncCall = false;
        });
      } else {
        _inAysncCall = false;
        print('status code ' + res.statusCode.toString());
        errorDialog(context);
      }
    } catch (e){
      _inAysncCall = false;
      print('Execption - '+e.toString());
      serverErrorDialog(context);
    }

    return 'success';
  }

  @override
  void initState() {
    super.initState();
    _getDoctorDetails();
  }

  Widget _appbar = new AppBar(
    title: new Text("ABOUT DOCTOR"),
    automaticallyImplyLeading: true,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );

  var _boxShadow = new BoxShadow(
      color: Colors.grey[300],
      offset: new Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: 0.0
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ModalProgressHUD(
          inAsyncCall: _inAysncCall,
          child: _consultantDetailsList.isEmpty
              ? new Container()
              : new Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/app_background.png"),
                          fit: BoxFit.fill)),
                  child: new Column(
                    children: <Widget>[
                      _appbar,
                      new Expanded(
                        child: new Card(
                          margin: EdgeInsets.all(12.0),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.white,
                          child: new ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(bottom: 16.0),
                                    width: 190.0,
                                    height: 190.0,
                                    decoration: BoxDecoration(
                                      boxShadow: [_boxShadow],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Hero(
                                      tag: 'doctorPhoto',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10000.0),
                                          child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/logo.png',
                                              image: SITE_URL +
                                                  "admin/" +
                                                  _consultantDetailsList[0]
                                                      .imgpath)),
                                    ),
                                  ),
                                  new DetailWidget(
                                    value: _consultantDetailsList[0].consultant,
                                    title: true,
                                  ),
                                  new DetailWidget(
                                    value:
                                        _consultantDetailsList[0].qualification,
                                    title: false,
                                  ),
                                  new DetailWidget(
                                    value:
                                        _consultantDetailsList[0].designation,
                                    title: false,
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    child: new Stack(
                                      alignment: Alignment(0.0, 0.0),
                                      children: <Widget>[
                                        new Container(
                                          color: Colors.grey[300],
                                          width: double.infinity,
                                          height: 30.0,
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: CircleAvatar(
                                                radius: 25.0,
                                                backgroundImage:
                                                    new NetworkImage(SITE_URL +
                                                        "admin/" +
                                                        _consultantDetailsList[
                                                                0]
                                                            .departmentIcon),
                                              ),
                                            ),
                                            new Text(
                                              _consultantDetailsList[0]
                                                  .department,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    child: new Stack(
                                      alignment: Alignment(0.0, 0.0),
                                      children: <Widget>[
                                        new Container(
                                          color: Colors.grey[300],
                                          width: double.infinity,
                                          height: 30.0,
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Text(
                                              "Years of Experience",
                                              textAlign: TextAlign.center,
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 5.0)),
                                                  child: new Center(
                                                    child: new Text(
                                                      _consultantDetailsList[0]
                                                          .experience,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  new DetailsWidget(
                                    keyName: 'Surgeries',
                                    keyValue: _consultantDetailsList[0]
                                        .surgeries
                                        .toString()
                                        .trim(),
                                  ),
                                  new DetailsWidget(
                                    keyName: 'Procedures',
                                    keyValue: _consultantDetailsList[0]
                                        .procedures
                                        .toString()
                                        .trim(),
                                  ),
                                  new DetailsWidget(
                                    keyName: 'Expertice',
                                    keyValue: _consultantDetailsList[0]
                                        .expertice
                                        .toString()
                                        .trim(),
                                  ),
                                  new DetailsWidget(
                                    keyName: 'Associations',
                                    keyValue: _consultantDetailsList[0]
                                        .associations
                                        .toString()
                                        .trim(),
                                  ),
                                  new DetailsWidget(
                                    keyName: 'Memberships',
                                    keyValue: _consultantDetailsList[0]
                                        .memberships
                                        .toString()
                                        .trim(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 12.0, right: 12.0),
                        child: Container(
                            width: double.infinity,
                            height: 50.0,
                            child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              elevation: 5.0,
                              color: TOOLBAR_COLOR,
                              // color: Colors.red,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            BookAppointmentForm(
                                              department:
                                                  _consultantDetailsList[0]
                                                      .department,
                                              consultant:
                                                  _consultantDetailsList[0]
                                                      .consultant,
                                              imgURL: _consultantDetailsList[0]
                                                  .thumbpath,
                                              consultantDetail: _consultantDetailsList[0],
                                            )));
                              },
                              child: new Text(
                                'Book Appointment',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  ),
                )),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String value;
  final bool title;

  DetailWidget({this.value, this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return value.isEmpty
        ? new Container()
        : title
            ? new Text(
                value.toString().trim(),
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              )
            : new Text(value.toString().trim());
  }
}

class DetailsWidget extends StatelessWidget {
  final String keyName;
  final String keyValue;

  DetailsWidget({this.keyName, this.keyValue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (keyValue.isEmpty) {
      return new Container();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(
              keyName,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Text(keyValue),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Divider(
                height: 1.0,
                color: Colors.grey[300],
              ),
            )
          ],
        ),
      );
    }
  }
}

class ConsultantDetail {
  String consultantId;
  String consultant;
  String departmentId;
  String qualification;
  String designation;
  String surgeries;
  String procedures;
  String expertice;
  String associations;
  String memberships;
  String siteStatus;
  String sortOrder;
  String depSortOrder;
  String statusId;
  String imgpath;
  String thumbpath;
  String experience;
  String department;
  String departmentIcon;
  String appointment_fee;
  String appointment_from;
  String appointment_to;
  String appointment_duration;
  String hopital_id;

  ConsultantDetail({
    this.consultantId,
    this.consultant,
    this.departmentId,
    this.qualification,
    this.designation,
    this.surgeries,
    this.procedures,
    this.expertice,
    this.associations,
    this.memberships,
    this.siteStatus,
    this.sortOrder,
    this.depSortOrder,
    this.statusId,
    this.imgpath,
    this.thumbpath,
    this.experience,
    this.department,
    this.departmentIcon,
    this.appointment_fee,
    this.appointment_from,
    this.appointment_to,
    this.appointment_duration,
    this.hopital_id,
  });

  factory ConsultantDetail.fromJson(Map<String, dynamic> json) =>
      new ConsultantDetail(
        consultantId: json["consultant_id"],
        consultant: json["consultant"],
        departmentId: json["department_id"],
        qualification: json["qualification"],
        designation: json["designation"],
        surgeries: json["surgeries"],
        procedures: json["procedures"],
        expertice: json["expertice"],
        associations: json["associations"],
        memberships: json["memberships"],
        siteStatus: json["site_status"],
        sortOrder: json["sort_order"],
        depSortOrder: json["dep_sort_order"],
        statusId: json["status_id"],
        imgpath: json["imgpath"],
        thumbpath: json["thumbpath"],
        experience: json["experience"],
        department: json["department"],
        departmentIcon: json["department_icon"],
        appointment_duration : json["appointment_duration"],
        appointment_to: json["appointment_to"],
        appointment_from: json["appointment_from"],
        appointment_fee: json["appointment_fee"],
        hopital_id: json["hospital_id"],
      );

  Map<String, dynamic> toJson() => {
        "consultant_id": consultantId,
        "consultant": consultant,
        "department_id": departmentId,
        "qualification": qualification,
        "designation": designation,
        "surgeries": surgeries,
        "procedures": procedures,
        "expertice": expertice,
        "associations": associations,
        "memberships": memberships,
        "site_status": siteStatus,
        "sort_order": sortOrder,
        "dep_sort_order": depSortOrder,
        "status_id": statusId,
        "imgpath": imgpath,
        "thumbpath": thumbpath,
        "experience": experience,
        "department": department,
        "department_icon": departmentIcon,
      };
}
