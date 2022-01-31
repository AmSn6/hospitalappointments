import 'department_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'app_colors.dart';
import 'urls.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dialogs.dart';

class DepartmentList extends StatefulWidget {
  @override
  DepartmentListState createState() {
    return new DepartmentListState();
  }
}

List<DepartmentListModel> _departmentListModel = [];

class DepartmentListState extends State<DepartmentList> {
  bool _inAsyncCall = true;

  Future<String> _getDepartmentList() async {

    _departmentListModel.clear();
    try{
      var res = await http.get(GET_DEPARTMENT_LIST);
      if(res.statusCode == 200){
        var resBody = jsonDecode(res.body);
        print('resbody -$resBody');
        setState(() {
          for (Map list in resBody['department_list']) {
            _departmentListModel.add(DepartmentListModel.fromJson(list));
          }
          _inAsyncCall = false;
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
    _getDepartmentList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24 - 100) / 2;
    final double itemWidth = size.width / 2;
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Department List'),
        backgroundColor: TOOLBAR_COLOR,
        centerTitle: true,
        elevation: 5.0,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: LIST_BACKGROUND,
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: new Container(
          padding: EdgeInsets.all(8.0),
          child: new GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemHeight / itemWidth),
            children: List.generate(_departmentListModel.length, (index) {
              return Container(
                margin: EdgeInsets.all(3.0),
                child: new Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DepartmentDetails(
                                    id: _departmentListModel[index]
                                        .departmentId,
                                  )));
                    },
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image(
                          image: _departmentListModel[index].departmentIcon.isEmpty ?
                          AssetImage('assets/icon/icon.png'): NetworkImage(SITE_URL +
                              "admin/" +
                              _departmentListModel[index].departmentIcon),
                          height: 50.0,
                          width: 50.0,
                        ),
                        new SizedBox(
                          height: 10,
                        ),
                        new Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: new Text(
                            _departmentListModel[index].department,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DepartmentListModel {
  String departmentId;
  String department;
  String departmentIcon;

  DepartmentListModel({
    this.departmentId,
    this.department,
    this.departmentIcon,
  });

  factory DepartmentListModel.fromJson(Map<String, dynamic> json) =>
      new DepartmentListModel(
        departmentId: json["department_id"],
        department: json["department"],
        departmentIcon: json["department_icon"],
      );
}
