import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fcm_push/fcm_push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validate/validate.dart';

import 'app_colors.dart';
import 'book_appointment.dart';
import 'dialogs.dart';
import 'urls.dart';

class OnlineConsultationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new OnlineConsultationFormState();
  }
}

class _AppointmentData {
  String consultant = '';
  String name = '';
  String email = '';
  String phone = '';
  String date = '';
  String comments = '';
}

List<ConsultantListModel> _consultantList = [];
List<ConsultantListModel> _searchList = [];

class OnlineConsultationFormState extends State<OnlineConsultationForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime appointmentDate;

  TextEditingController controller = new TextEditingController();

  bool _isAsyncCall = true;

  final Firestore _firestore = Firestore.instance;

  Future<String> _getCLData() async {
    _consultantList.clear();
    try {
      var res = await http.get(GET_DOCTORS_LIST);
      if (res.statusCode == 200) {
        setState(() {
          var resBody = json.decode(res.body);
          for (Map consultant in resBody["consultant_list"]) {
            _consultantList.add(ConsultantListModel.fromJson(consultant));
          }
          _isAsyncCall = false;
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

    return "Success";
  }

  Future<String> _postRequestAppointment() async {
    setState(() {
      _isAsyncCall = true;
    });

    var _queryParameters = {
      'consultant': _appointmentData.consultant.trim(),
      'name': _appointmentData.name.trim(),
      'phone': _appointmentData.phone.trim(),
      'appointment_date': appointmentDate,
      'created_date': DateTime.now(),
      'email': _appointmentData.email.trim(),
      'msgdetails': _appointmentData.comments.trim(),
    };

    print('params - $_queryParameters');

    _firestore.collection('Appointments').add(_queryParameters).then((val) {
      setState(() {
        _isAsyncCall = false;
      });
    }).catchError((error) {
      print('post error - $error');
    });

    final FCM fcm = new FCM(
        "AAAA1rgV70k:APA91bH8VPOh03BBtGKDO4JJq2JENGa5anIqxNCVFCkiYdhBQBTjC2EtPwsXhtStU0Aj7dvHteER6spnYF8PBcluYg1RpCsNdEmeLL2b-FQHxqneeYHjxahZJIroM17Aextrow3kComR");

    _firestore.collection('AdminTokens').getDocuments().then((value) {
      value.documents.forEach((val) {
        final Message fcmMessage = new Message()
          ..to = val.data['token']
          ..title = 'Appointment Request'
          ..body =
              'Mr.${_appointmentData.name} has sent an Appointment Request';
        fcm.send(fcmMessage).then((id) {
          print('Message id = $id');
        });
      });
    }).then((val) {
      appointmentSuccessDialog(context);
    }).catchError((error) {
      print('Appointment Error');
      errorDialog(context);
    });

//    print(_queryParameters);
//
//    var response =
//        await http.post(POST_APPOINTMENT_DETAILS, body: _queryParameters);
//
//    var res = jsonDecode(response.body);
//
//    print(res);
//
//    setState(() {
//      _isAsyncCall = false;
//      if (res['success'] == 1) {
//        successDialog(context);
//      } else {
//        errorDialog(context);
//      }
//    });

    return "success";
  }

  _AppointmentData _appointmentData = new _AppointmentData();

  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  String _validatePhone(String phone) {
    if (phone.length != 10) {
      return 'Mobile Number must be at least 10 characters.';
    }
    return null;
  }

  final dateFormat = DateFormat("dd-MM-yyyy");
  DateTime date;

  Future _getAdminSettingFuture;

  var _boxShadow = new BoxShadow(
      color: Colors.grey[300],
      offset: new Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: 0.0);

  @override
  void initState() {
    super.initState();
    _getAdminSettingFuture = getAdminSettings();
    _getCLData();
  }

  void _searchDoctor(String searchText) {
    _searchList.clear();

    _consultantList.forEach((counsultant) {
      if (counsultant.consultant.toLowerCase().contains(searchText)) {
        _searchList.add(counsultant);
      }
    });
  }

  bool _isHospital = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Request Appointment"),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: TOOLBAR_COLOR,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isAsyncCall,
        child: ListView(
          padding: EdgeInsets.only(top: 16.0),
          children: <Widget>[
            Form(
                key: _formKey,
                child: new Container(
                  child: Column(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isHospital = !_isHospital;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        _isHospital ? Colors.blue : Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                      child: Text('Sigma Appointments',
                                          style: TextStyle(
                                              color: _isHospital
                                                  ? Colors.blue
                                                  : Colors.grey))),
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isHospital = !_isHospital;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: !_isHospital
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                      child: Text(
                                    'Womans Care',
                                    style: TextStyle(
                                        color: !_isHospital
                                            ? Colors.blue
                                            : Colors.grey),
                                  )),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controller,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Select Doctor',
                              hintText: 'Select a Doctor',
                              labelStyle: new TextStyle(fontSize: 14.0),
                              contentPadding:
                                  const EdgeInsets.only(left: 8.0, top: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              prefixIcon: new Icon(Icons.person_pin),
                            ),
                          ),
                          getImmediateSuggestions: true,
                          onSuggestionSelected: (value) {
                            print('onSuggestionSelected - ' + value.consultant);
                            controller.text = value.consultant;
                            _appointmentData.consultant = value.consultant;
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    index.consultant,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                  new Text(
                                    index.department,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                ],
                              ),
                            );
                          },
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0))),
                            elevation: 5.0,
                          ),
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          suggestionsCallback: (value) {
                            _searchDoctor(value);
                            return _searchList;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Select a Doctor';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            print('on saved - ' + value);
                            _appointmentData.consultant = value;
                          },
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black, fontSize: 18.0, height: 1.0),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your Name';
                            }
                          },
                          onSaved: (String value) {
                            this._appointmentData.name = value;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            hintText: 'Enter your Name',
                            labelStyle: new TextStyle(fontSize: 14.0),
                            contentPadding:
                                const EdgeInsets.only(left: 8.0, top: 20.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            prefixIcon: new Icon(Icons.person),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          maxLines: 1,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your Mail-ID';
                            } else {
                              return this._validateEmail(value);
                            }
                          },
                          onSaved: (String value) {
                            this._appointmentData.email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Your Mail-ID',
                            hintText: 'Enter your Mail-ID',
                            labelStyle: new TextStyle(fontSize: 14.0),
                            contentPadding:
                                const EdgeInsets.only(left: 8.0, top: 20.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            prefixIcon: new Icon(Icons.email),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          maxLines: 1,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your Mobile Number';
                            } else {
                              return this._validatePhone(value);
                            }
                          },
                          onSaved: (String value) {
                            this._appointmentData.phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Your Mobile Number',
                            hintText: 'Enter your Mobile Number',
                            labelStyle: new TextStyle(fontSize: 14.0),
                            contentPadding:
                                const EdgeInsets.only(left: 8.0, top: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            prefixIcon: new Icon(Icons.phone_android),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new DateTimeField(
                            format: DateFormat('dd-MM-yyyy'),
                            maxLines: 1,
                            validator: (value) {
                              if (value == null) {
                                return 'Select a Date';
                              }
                            },
                            onSaved: (value) {
                              this._appointmentData.date = value.toString();
                              appointmentDate = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Appoinment Date',
                              hintText: 'Select a Date',
                              labelStyle: new TextStyle(fontSize: 14.0),
                              contentPadding:
                                  const EdgeInsets.only(left: 8.0, top: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              prefixIcon: new Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate:
                                      DateTime.now().add(Duration(days: 1)),
                                  initialDate:
                                      DateTime.now().add(Duration(days: 1)),
                                  lastDate: DateTime(2100));
                            }),
//                        child: new DateTimePickerFormField(
//                          maxLines: 1,
//                          validator: (value) {
//                            if (value == null) {
//                              return 'Select a Date';
//                            }
//                          },
//                          firstDate: DateTime.now(),
//                          onSaved: (value) {
//                            this._appointmentData.date = value.toString();
//                          },
//                          inputType: InputType.date,
//                          decoration: InputDecoration(
//                            labelText: 'Appoinment Date',
//                            hintText: 'Select a Date',
//                            labelStyle: new TextStyle(fontSize: 14.0),
//                            contentPadding:
//                                const EdgeInsets.only(left: 8.0, top: 20.0),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(8.0)),
//                            prefixIcon: new Icon(Icons.calendar_today),
//                          ),
//                          format: dateFormat,
//                          onChanged: (d) => setState(() => date = d),
//                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          maxLines: 2,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Comments';
                            }
                          },
                          onSaved: (String value) {
                            this._appointmentData.comments = value;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: 'Your Comments',
                            hintText: 'Enter Comments',
                            labelStyle: new TextStyle(fontSize: 14.0),
                            contentPadding:
                                const EdgeInsets.only(left: 8.0, top: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            prefixIcon: new Icon(Icons.comment),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(boxShadow: [_boxShadow]),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _postRequestAppointment();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            elevation: 5.0,
                            color: Colors.red[900],
                            child: new Text(
                              "BOOK AN APPOINTMENT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
//          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -2),
                    blurRadius: 10,
                    spreadRadius: .2)
              ],
              color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                'If you want to Book An Appointment Today',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<AdminSettingModal>(
                  future: _getAdminSettingFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      print('snapshot error - ${snapshot.error}');
                      return errorDialog(context);
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              launch(
                                  'tel: ${snapshot.data.adminSettings[0].adminSettingValue}');
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.blue,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              if (_appointmentData.consultant.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Please Select a Doctor'),
                                ));
                              } else {
                                launch(
                                    'whatsapp://send?phone=+91${snapshot.data.adminSettings[1].adminSettingValue}'
                                    '&text=Need an Appointment Today\n'
                                    'Counsultant : ${_appointmentData.consultant}');
                              }
                            },
                            child: Icon(
                              MdiIcons.whatsapp,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<AdminSettingModal> getAdminSettings() async {
    var res = await http.get(GET_ADMIN_SETTING);
    print('res - ${res.body}');
    if (res.statusCode == 200) {
      return adminSettingModalFromJson(res.body);
    } else {
      throw Exception('Admin Setting Request Error');
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
  final String appointment_from;
  final String appointment_to;
  final String appointment_duration;

  ConsultantListModel(
      {this.consultant_id,
      this.consultant,
      this.imgpath,
      this.thumbpath,
      this.department,
      this.appointment_fee,
      this.department_icon,
      this.appointment_from,
      this.appointment_to,
      this.appointment_duration});

  factory ConsultantListModel.fromJson(Map<String, dynamic> json) {
    return new ConsultantListModel(
      consultant_id: json['consultant_id'],
      consultant: json['consultant'],
      imgpath: json['imgpath'],
      thumbpath: json['thumbpath'],
      department: json['department'],
      department_icon: json['department_icon'],
      appointment_fee: json['appointment_fee'],
      appointment_from: json['appointment_from'],
      appointment_to: json['appointment_to'],
      appointment_duration: json['appointment_duration'],
    );
  }
}
