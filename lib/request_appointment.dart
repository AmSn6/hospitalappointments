import 'dart:async';
import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:hospitalappointments/hospital_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validate/validate.dart';

import 'app_colors.dart';
import 'book_appointment.dart';
import 'dialogs.dart';
import 'urls.dart';

class RequestAppointmentForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RequestAppointmentFormState();
  }
}

class _AppointmentData {
  String consultant = '';
  String name = '';
  String email = '';
  String phone = '';
  String date = '';
  String comments = '';
  String amount = '';
  String fromTime = "";
  String toTime = "";
  String duration = "";
}

List<ConsultantListModel> _consultantList = [];
List<ConsultantListModel> _searchList = [];

class RequestAppointmentFormState extends State<RequestAppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime appointmentDate;

  TextEditingController controller = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController hospitalController = new TextEditingController();
  String hospitalId = "";
  String doctorId = "";
  List<HospitalList> _hospitalList = [];

  bool _isHospitalChoosen = false;

  bool _isAsyncCall = true;

  bool _showTime = false;

  String transactionId = "";

  // final Firestore _firestore = Firestore.instance;

  Future<String> _getCLData() async {
    _hospitalList.clear();
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

        var res2 = await http.get(HOSPITAL_LIST);
        if (res2.statusCode == 200) {
          HospitalListModel model = hospitalListModelFromJson(res2.body);
          _hospitalList = model.hospitalList;
        }
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

    // var _queryParameters = {
    //   'consultant': _appointmentData.consultant.trim(),
    //   'name': _appointmentData.name.trim(),
    //   'phone': _appointmentData.phone.trim(),
    //   'appointment_date': appointmentDate,
    //   'created_date': DateTime.now(),
    //   'email': _appointmentData.email.trim(),
    //   'msgdetails': _appointmentData.comments.trim(),
    // };

    // print('params - $_queryParameters');
    //
    // _firestore.collection('Appointments').add(_queryParameters).then((val) {
    //   setState(() {
    //     _isAsyncCall = false;
    //   });
    // }).catchError((error) {
    //   print('post error - $error');
    // });
    //
    // final FCM fcm = new FCM(
    //     "AAAA1rgV70k:APA91bH8VPOh03BBtGKDO4JJq2JENGa5anIqxNCVFCkiYdhBQBTjC2EtPwsXhtStU0Aj7dvHteER6spnYF8PBcluYg1RpCsNdEmeLL2b-FQHxqneeYHjxahZJIroM17Aextrow3kComR");
    //
    // _firestore.collection('AdminTokens').getDocuments().then((value) {
    //   value.documents.forEach((val) {
    //     final Message fcmMessage = new Message()
    //       ..to = val.data['token']
    //       ..title = 'Appointment Request'
    //       ..body =
    //           'Mr.${_appointmentData.name} has sent an Appointment Request';
    //     fcm.send(fcmMessage).then((id) {
    //       print('Message id = $id');
    //     });
    //   });
    // }).then((val) {
    //   appointmentSuccessDialog(context);
    // }).catchError((error) {
    //   print('Appointment Error');
    //   errorDialog(context);
    // });

    var _queryParameters = {
      'consultant_id': doctorId,
      'hospital_id': hospitalId,
      'name': _appointmentData.name,
      'phone': _appointmentData.phone,
      'email': _appointmentData.email,
      'date': _appointmentData.date,
      'time': _choosenTimeSlot,
      'reason': _appointmentData.comments,
      'razorpay_payment_id': "fsdfa",
      'paid_amount': "250"
    };

    print(_queryParameters);

    print('url - $ADD_APPOINTMENT');

    var response = await http.post(ADD_APPOINTMENT, body: _queryParameters);

    var res = jsonDecode(response.body);

    print(res);

    setState(() {
      _isAsyncCall = false;
      if (res['success'] == 1) {
        successDialog(context);
      } else {
        errorDialog(context);
      }
    });

    return "success";
  }

  // String _amount = "";

  List<String> timeSlots = [];
  String _choosenTimeSlot = "00:00:00";

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

  var _boxShadow = new BoxShadow(
      color: Colors.grey[300],
      offset: new Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: 0.0);

  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _getCLData();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    transactionId = response.paymentId;
    _postRequestAppointment();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    paymentFailureDialog(context);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Payment Cancelled'), backgroundColor: Colors.red));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  int getRazorPayAmount(String amount) {
    if (amount.contains('.')) {
      List<String> amountList = amount.split('.');
      return (int.parse(amountList.first) * 100) + int.parse(amountList.last);
    } else {
      return (int.parse(amount) * 100);
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _searchDoctor(String searchText) {
    _searchList.clear();

    _consultantList.forEach((counsultant) {
      if (counsultant.consultant.toLowerCase().contains(searchText) &&
          counsultant.hospital_id == hospitalId) {
        _searchList.add(counsultant);
      }
    });
  }

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
                        padding: const EdgeInsets.all(8.0),
                        child: new TypeAheadFormField<HospitalList>(
                          // hideKeyboard: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: hospitalController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Choose Hospital',
                              hintText: 'Choose a Hospital',
                              labelStyle: new TextStyle(fontSize: 14.0),
                              contentPadding:
                                  const EdgeInsets.only(left: 8.0, top: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              prefixIcon: new Icon(Icons.local_hospital),
                            ),
                          ),
                          getImmediateSuggestions: true,
                          onSuggestionSelected: (value) {
                            hospitalController.text = value.hospital;
                            hospitalId = value.hospitalId;
                            setState(() {
                              _isHospitalChoosen = true;
                            });
                            controller.text = "";
                            doctorId = "";
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: new Text(
                                index.hospital,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
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
                            return _hospitalList;
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
                      if (_isHospitalChoosen)
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
                                prefixIcon: new Icon(MdiIcons.doctor),
                              ),
                            ),
                            getImmediateSuggestions: true,
                            onSuggestionSelected: (value) {
                              print(
                                  'onSuggestionSelected - ' + value.consultant);
                              controller.text = value.consultant;
                              _appointmentData.consultant = value.consultant;
                              _appointmentData.amount = value.appointment_fee;
                              doctorId = value.consultant_id;

                              if (value.appointment_from
                                  .toString()
                                  .isNotEmpty) {
                                _appointmentData.fromTime =
                                    value.appointment_from;
                                _appointmentData.toTime = value.appointment_to;
                                _appointmentData.duration =
                                    value.appointment_duration;

                                String fromaa =
                                    _appointmentData.fromTime.split(" ").last;
                                String fromHour =
                                    _appointmentData.fromTime.split(" ").first;

                                if (fromaa == 'PM') {
                                  int hour = int.parse(_appointmentData.fromTime
                                      .split(" ")
                                      .first
                                      .split(':')
                                      .first);
                                  if (hour != 12) {
                                    fromHour =
                                        '${hour + 12}:${_appointmentData.fromTime.split(" ").first.split(':').last}';
                                  }
                                }

                                String toaa =
                                    _appointmentData.toTime.split(" ").last;
                                String toHour =
                                    _appointmentData.toTime.split(" ").first;

                                if (toaa == 'PM') {
                                  int hour = int.parse(_appointmentData.toTime
                                      .split(" ")
                                      .first
                                      .split(':')
                                      .first);
                                  if (hour != 12) {
                                    toHour =
                                        '${hour + 12}:${_appointmentData.toTime.split(" ").first.split(':').last}';
                                  }
                                }

                                DateTime fromTime = DateTime.parse(
                                    '${DateFormat('Hms').parse(fromHour + ':00')}');
                                DateTime toTime = DateTime.parse(
                                    '${DateFormat('Hms').parse(toHour + ':00')}');

                                print('fromtime - $fromTime, toTime - $toTime');

                                try {
                                  int slot =
                                      toTime.difference(fromTime).inMinutes ~/
                                          int.parse(_appointmentData.duration);

                                  DateTime startSlot = fromTime;
                                  String sFromTime =
                                      DateFormat('hh:mm aa').format(startSlot);
                                  String sToTime = '';

                                  for (int i = 0; i < slot; i++) {
                                    startSlot = startSlot.add(Duration(
                                        minutes: int.parse(
                                            _appointmentData.duration)));
                                    sToTime = DateFormat('hh:mm aa')
                                        .format(startSlot);
                                    timeSlots.add('$sFromTime - $sToTime');
                                    sFromTime = sToTime;
                                  }
                                } catch (e) {
                                  print('error - $e');
                                  setState(() {
                                    _showTime = false;
                                  });
                                }
                                setState(() {
                                  _showTime = true;
                                });
                              } else {
                                setState(() {
                                  _showTime = false;
                                });
                              }
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
                          ),
                        ),
                      new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black, fontSize: 18.0, height: 1.0),
                          validator: (value) {
                            return value.isEmpty ? 'Enter your Name' : null;
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
                              return value == null ? 'Select a Date' : null;
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
                      ),
                      if (_showTime)
                        new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new TypeAheadFormField<String>(
                            // hideKeyboard: true,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: timeController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: 'Select a Time Slot',
                                hintText: 'Select a Time Slot',
                                labelStyle: new TextStyle(fontSize: 14.0),
                                contentPadding:
                                    const EdgeInsets.only(left: 8.0, top: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                prefixIcon: new Icon(Icons.access_time),
                              ),
                            ),
                            getImmediateSuggestions: true,
                            onSuggestionSelected: (value) {
                              timeController.text = value;
                              _choosenTimeSlot = value;
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: new Text(
                                  index,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
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
                              // _searchDoctor(value);
                              return timeSlots;
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
                          maxLines: 2,
                          validator: (value) {
                            return value.isEmpty ? 'Enter Comments' : null;
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
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(
                                    'paisa - ${getRazorPayAmount(_appointmentData.amount)}');
                                var options = {
                                  'key': 'rzp_live_CE86S5cRdX9w6X',
                                  'amount': getRazorPayAmount(
                                      _appointmentData.amount),
                                  'name': 'Sigma Appointments',
                                  'description': 'Appointment Booking',
                                };
                                _razorpay.open(options);
                                // _postRequestAppointment();
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                              elevation: MaterialStateProperty.all(5),
                              backgroundColor: MaterialStateProperty.all(TOOLBAR_COLOR)
                            ),
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
                  future: getAdminSettings(),
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
                          TextButton(
                            onPressed: () {
                              launch(
                                  'tel: ${snapshot.data.adminSettings[0].adminSettingValue}');
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.blue,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              String message = 'Need an Appointment Today Counsultant : ${_appointmentData.consultant}';
                              print('msg -$message');
                              if (_appointmentData.consultant.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Please Select a Doctor'),
                                ));
                              } else {
                                launch('https://api.whatsapp.com/send?phone=+91${snapshot.data.adminSettings[1].adminSettingValue}&text=$message');
                                // launch('https://api.whatsapp.com/send?phone=91${snapshot.data.adminSettings[1].adminSettingValue}&text=Need an Appointment Today\n''Counsultant : ${_appointmentData.consultant}');
                                // launch(
                                //     'whatsapp://send?phone=+91${snapshot.data.adminSettings[1].adminSettingValue}'
                                //     '&text=Need an Appointment Today\n'
                                //     'Counsultant : ${_appointmentData.consultant}');
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
  final String hospital_id;

  ConsultantListModel(
      {this.consultant_id,
      this.hospital_id,
      this.consultant,
      this.imgpath,
      this.thumbpath,
      this.department,
      this.department_icon,
      this.appointment_fee,
      this.appointment_to,
      this.appointment_from,
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
      hospital_id: json['hospital_id'],
    );
  }
}
