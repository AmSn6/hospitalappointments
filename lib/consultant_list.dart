import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'urls.dart';
import 'app_colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'book_appointment.dart';
import 'doctor_details.dart';
import 'dialogs.dart';

class ConsultantList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ConsultantListState();
  }
}

List<ConsultantListModel> _consultantList = [];
List<ConsultantListModel> _searchList = [];

class ConsultantListState extends State<ConsultantList> {
  bool isInAysncCall = true;

  final String url = GET_DOCTORS_LIST;
  List consultantList;

  Future<String> getCLData() async {
    print('url -$url');

    _consultantList.clear();
    var res = await http.get(url);
    print('res - $res');
    try {
      if (res.statusCode == 200) {
        setState(() {
          var resBody = json.decode(res.body);
          consultantList = resBody["consultant_list"];
          for (Map consultant in resBody["consultant_list"]) {
            _consultantList.add(ConsultantListModel.fromJson(consultant));
          }
        });
        print(res.body);
      } else {
        print(res.statusCode);
        serverErrorDialog(context);
      }
    } catch (e) {
      print(e);
      serverErrorDialog(context);
    }

    isInAysncCall = false;
    return "Success";
  }

  Widget appBarTitle = new Text(
    "Doctor List",
    style: new TextStyle(color: Colors.white),
  );

  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();

  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();

  ConsultantListState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  Widget _secondRow = new Divider(
    height: 1,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: LIST_BACKGROUND,
      appBar: buildAppBar(context),
      body: ModalProgressHUD(
        child: new Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Flexible(
                    child: _searchList.length != 0 ||
                            _controller.text.isNotEmpty
                        ? new ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                _searchList == null ? 0 : _searchList.length,
                            itemBuilder: (context, index) {
                              return new Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                                child: InkWell(
                                  splashColor: Colors.lightBlue,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => DoctorDetails(
                                                  id: _searchList[index]
                                                      .consultant_id,
                                                )));
                                  },
                                  child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 8.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new Container(
                                              height: 50,
                                              width: 50,
                                              child: new Image(
                                                  image: NetworkImage(SITE_URL +
                                                      "admin/" +
                                                      _searchList[index]
                                                          .thumbpath)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    _searchList[index]
                                                        .consultant,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  new Text(_searchList[index]
                                                      .department),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      _secondRow,
                                      new Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: new Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: new Text(
                                                  "View Profile",
                                                  style: TextStyle(
                                                      color: VIEW_PROFILE_TC,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Icon(
                                                      Icons
                                                          .perm_contact_calendar,
                                                      color: Colors.grey,
                                                    ),
                                                    new Text(
                                                      "Book Appointment",
                                                      style: TextStyle(
                                                          color:
                                                              VIEW_PROFILE_TC,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0),
                                                      textAlign:
                                                          TextAlign.end,
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                ),
                                                flex: 1,
                                              )
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : new ListView.builder(
                            shrinkWrap: true,
                            itemCount: _consultantList == null
                                ? 0
                                : _consultantList.length,
                            itemBuilder: (context, index) {
                              return new Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                                child: InkWell(
                                  splashColor: Colors.lightBlue,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => DoctorDetails(
                                                  id: _consultantList[index]
                                                      .consultant_id,
                                                )));
                                  },
                                  child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 8.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new Container(
                                              height: 50,
                                              width: 50,
                                              child: new Image(
                                                  image: NetworkImage(SITE_URL +
                                                      "admin/" +
                                                      _consultantList[index]
                                                          .thumbpath)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    _consultantList[index]
                                                        .consultant,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  new Text(
                                                      _consultantList[index]
                                                          .department),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      _secondRow,
                                      new Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: new Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: new Text(
                                                  "View Profile",
                                                  style: TextStyle(
                                                      color: VIEW_PROFILE_TC,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Icon(
                                                      Icons
                                                          .perm_contact_calendar,
                                                      color: Colors.grey,
                                                    ),
                                                    new Text(
                                                      "Book Appointment",
                                                      style: TextStyle(
                                                          color:
                                                              VIEW_PROFILE_TC,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0),
                                                      textAlign:
                                                          TextAlign.end,
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                ),
                                                flex: 1,
                                              )
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
              ],
            )),
        inAsyncCall: isInAysncCall,
        color: TOOLBAR_COLOR,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
    this.getCLData();
  }

  final focusNode = FocusNode();

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: appBarTitle,
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              if (_isSearching) {
                _handleSearchEnd();
              } else {
                Navigator.pop(context);
              }
            }),
        backgroundColor: TOOLBAR_COLOR,
        actions: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _controller,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    focusNode: focusNode,
                    decoration: new InputDecoration(
                        hintText: "Search...", border: InputBorder.none),
                    onChanged: searchOperation,
                  );
                  FocusScope.of(context).requestFocus(focusNode);
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Doctor List",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
      _searchList.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    _searchList.clear();
    if (_isSearching != null) {
      print(consultantList.length);

      _consultantList.forEach((consultant) {
        if (consultant.consultant.toLowerCase().contains(searchText) ||
            consultant.department.toLowerCase().contains(searchText)) {
          _searchList.add(consultant);
        }
      });

      for (int i = 0; i < consultantList.length; i++) {
        String data = consultantList[i]["consultant"].toString().trim();

        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          print("success - " + searchText);
          searchresult.add(data);
        }
      }
    }
  }
}

class ConsultantListModel {
  final String consultant_id;
  final String consultant;
  final String imgpath;
  final String thumbpath;
  final String department;
  final String department_icon;
  final String appointment_fee;
  final String hospital_id;

  ConsultantListModel(
      {this.consultant_id,
      this.consultant,
      this.imgpath,
      this.thumbpath,
      this.department,
      this.department_icon,
      this.hospital_id,
      this.appointment_fee});

  factory ConsultantListModel.fromJson(Map<String, dynamic> json) {
    return new ConsultantListModel(
      consultant_id: json['consultant_id'],
      consultant: json['consultant'],
      imgpath: json['imgpath'],
      thumbpath: json['thumbpath'],
      department: json['department'],
      department_icon: json['department_icon'],
      appointment_fee: json['appointment_fee'],
      hospital_id: json['hospital_id']
    );
  }
}
