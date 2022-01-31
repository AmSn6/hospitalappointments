import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:hospitalappointments/doctor_details.dart';
import 'package:fcm_push/fcm_push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hospitalappointments/doctor_details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validate/validate.dart';

import 'app_colors.dart';
import 'dialogs.dart';
import 'urls.dart';

class BookAppointmentForm extends StatefulWidget {
  final String imgURL;
  final String consultant;
  final String department;

  final ConsultantDetail consultantDetail;

  BookAppointmentForm({this.imgURL, this.consultant, this.department, this.consultantDetail});

  @override
  State<StatefulWidget> createState() {
    return new BookAppointmentFormState();
  }
}

class _AppointmentData {
  String name = '';
  String email = '';
  String phone = '';
  String date = '';
  String comments = '';
}

class BookAppointmentFormState extends State<BookAppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final Firestore _firestore = Firestore.instance;
  bool _inAsyncCall = false;
  bool _showTime = false;

  TextEditingController timeController = new TextEditingController();

  String _amount = "";

  List<String> timeSlots = [];
  String _choosenTimeSlot = "00:00:00";

  String transactionId = "test_id";

  final _razorpay = Razorpay();

  Future<String> _postBookAppointment() async {
    setState(() {
      _inAsyncCall = true;
    });

    var _queryParameters = {
      'consultant_id' : widget.consultantDetail.consultantId,
      'hospital_id' : widget.consultantDetail.hopital_id,
      'name':_appointmentData.name,
      'phone' : _appointmentData.phone,
      'email' : _appointmentData.email,
      'date' : _appointmentData.date,
      'time' : _choosenTimeSlot,
      'reason' : _appointmentData.comments,
      'razorpay_payment_id' : transactionId,
      'paid_amount' : widget.consultantDetail.appointment_fee
    };
    //
    // _firestore.collection('Appointments').add(_queryParameters).then((val) {
    //   setState(() {
    //     _inAsyncCall = false;
    //   });
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

    print('params - $_queryParameters');

   try{
     var response = await http.post(ADD_APPOINTMENT,body: _queryParameters);
     print(response.body);
     if(response.statusCode == 200){
       var res = jsonDecode(response.body);
       print(res);
       setState(() {
         _inAsyncCall = false;
         if(res['success'] == 1){
           successDialog(context);
         } else {
           errorDialog(context);
         }
       });
     } else {
       print(response.statusCode);
       serverErrorDialog(context);
     }
   } catch (e) {
     print(e);
     serverErrorDialog(context);
   }

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

  var _boxShadow = new BoxShadow(
      color: Colors.grey[300],
      offset: new Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: 0.0);

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    if(widget.consultantDetail.appointment_from.isNotEmpty){
      getTimeSlots();
    }
  }

  getTimeSlots(){
    String fromaa = widget.consultantDetail.appointment_from.split(" ").last;
    String fromHour = widget.consultantDetail.appointment_from.split(" ").first;

    if(fromaa == 'PM'){
      int hour = int.parse(widget.consultantDetail.appointment_from.split(" ").first.split(':').first);
      if(hour != 12){
        fromHour = '${hour+12}:${widget.consultantDetail.appointment_from.split(" ").first.split(':').last}';
      }
    }

    String toaa = widget.consultantDetail.appointment_to.split(" ").last;
    String toHour = widget.consultantDetail.appointment_to.split(" ").first;

    if(toaa == 'PM'){
      int hour = int.parse(widget.consultantDetail.appointment_to.split(" ").first.split(':').first);
      if(hour != 12){
        toHour = '${hour+12}:${widget.consultantDetail.appointment_to.split(" ").first.split(':').last}';
      }
    }

    DateTime fromTime = DateTime.parse('${DateFormat('Hms').parse(fromHour+':00')}');
    DateTime toTime = DateTime.parse('${DateFormat('Hms').parse(toHour+':00')}');

    print('fromtime - $fromTime, toTime - $toTime');

    try{
      int slot = toTime.difference(fromTime).inMinutes ~/ int.parse(widget.consultantDetail.appointment_duration);

      DateTime startSlot = fromTime;
      String sFromTime = DateFormat('hh:mm aa').format(startSlot);
      String sToTime = '';

      for(int i=0; i<slot; i++){
        startSlot = startSlot.add(Duration(minutes: int.parse(widget.consultantDetail.appointment_duration)));
        sToTime = DateFormat('hh:mm aa').format(startSlot);
        timeSlots.add('$sFromTime - $sToTime');
        sFromTime = sToTime;
      }
    } catch (e){
      print('error - $e');
      setState(() {
        _showTime = false;
      });
    }
    setState(() {
      _showTime = true;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    transactionId = response.paymentId;
    _postBookAppointment();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Book Appointment"),
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
        inAsyncCall: _inAsyncCall,
        child: ListView(
          children: <Widget>[
            Form(
                key: _formKey,
                child: new Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
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
                                            widget.imgURL)),
                              ),
                              width: 100.0,
                              height: 100.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    widget.consultant,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  new Text(widget.department),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
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
                      Padding(
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
                      Padding(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new DateTimeField(
                            format: DateFormat('dd-MM-yyyy'),
                            readOnly: true,
                            maxLines: 1,
                            validator: (value) {
                              if (value == null) {
                                return 'Select a Date';
                              }
                            },
                            onSaved: (value) {
                              this._appointmentData.date = value.toString();
                              date = value;
                            },
                            keyboardType: TextInputType.datetime,
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
                      if(_showTime)
                        new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new TypeAheadFormField<String>(
                            hideSuggestionsOnKeyboardHide: true,
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
                          ),
                        ),
                      Padding(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(boxShadow: [_boxShadow]),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(_appointmentData.date);
                                // _postBookAppointment();

                                var options = {
                                  'key': 'rzp_live_CE86S5cRdX9w6X',
                                  'amount': getRazorPayAmount(widget.consultantDetail.appointment_fee),
                                  'name': 'Sigma Appointments',
                                  'description': 'Appointment Booking',
                                };
                                _razorpay.open(options);

                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            elevation: 5.0,
                            color: TOOLBAR_COLOR,
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
                              String message = 'Need an Appointment Today Counsultant : ${widget.consultant}';
                              print('msg -$message');
                              launch('https://api.whatsapp.com/send?phone=+91${snapshot.data.adminSettings[1].adminSettingValue}&text=$message');
                              //
                              // launch(
                              //     'whatsapp://send?phone=+91${snapshot.data.adminSettings[1].adminSettingValue}'
                              //     '&text=Need an Appointment Today\n'
                              //     'Counsultant : ${widget.consultant}');
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

AdminSettingModal adminSettingModalFromJson(String str) =>
    AdminSettingModal.fromJson(json.decode(str));

String adminSettingModalToJson(AdminSettingModal data) =>
    json.encode(data.toJson());

class AdminSettingModal {
  List<AdminSetting> adminSettings;
  int success;
  String message;

  AdminSettingModal({
    this.adminSettings,
    this.success,
    this.message,
  });

  factory AdminSettingModal.fromJson(Map<String, dynamic> json) =>
      new AdminSettingModal(
        adminSettings: json["admin_settings"] == null
            ? null
            : new List<AdminSetting>.from(
                json["admin_settings"].map((x) => AdminSetting.fromJson(x))),
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "admin_settings": adminSettings == null
            ? null
            : new List<dynamic>.from(adminSettings.map((x) => x.toJson())),
        "success": success == null ? null : success,
        "message": message == null ? null : message,
      };
}

class AdminSetting {
  String adminSettingKey;
  String adminSettingValue;

  AdminSetting({
    this.adminSettingKey,
    this.adminSettingValue,
  });

  factory AdminSetting.fromJson(Map<String, dynamic> json) => new AdminSetting(
        adminSettingKey: json["admin_setting_key"] == null
            ? null
            : json["admin_setting_key"],
        adminSettingValue: json["admin_setting_value"] == null
            ? null
            : json["admin_setting_value"],
      );

  Map<String, dynamic> toJson() => {
        "admin_setting_key": adminSettingKey == null ? null : adminSettingKey,
        "admin_setting_value":
            adminSettingValue == null ? null : adminSettingValue,
      };
}
