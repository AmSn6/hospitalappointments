import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcm_push/fcm_push.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hospitalappointments/urls.dart';
import 'main.dart';
import 'app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:validate/validate.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dialogs.dart';

class EnquiryForm extends StatefulWidget {
  @override
  _EnquiryFormState createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  bool _inAsyncCall = false;
  final _formKey = GlobalKey<FormState>();

  String _name = '', _email = '', _phone = '', _comments = '', _enquiry = '';

  final Firestore _firestore = Firestore.instance;

  List<String> _enquiryList = ['Enquiry', 'Complaint'];

  TextEditingController controller = new TextEditingController();

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

  var _boxShadow = new BoxShadow(
      color: Colors.grey[300],
      offset: new Offset(0.0, 10.0),
      blurRadius: 15.0,
      spreadRadius: 0.0);

  Future<String> _PostData() async {
    setState(() {
      _inAsyncCall = true;
    });
    var _queryParameters = {
      'form_type': _enquiry,
      'name': _name,
      'phone': _phone,
      'email': _email,
      'msgdetails': _comments,
      'created_date':DateTime.now(),
    };


    _firestore.collection('Enquiries').add(_queryParameters).then((val) {
      setState(() {
        _inAsyncCall = false;
      });
    });

    final FCM fcm = new FCM(
        "AAAA1rgV70k:APA91bH8VPOh03BBtGKDO4JJq2JENGa5anIqxNCVFCkiYdhBQBTjC2EtPwsXhtStU0Aj7dvHteER6spnYF8PBcluYg1RpCsNdEmeLL2b-FQHxqneeYHjxahZJIroM17Aextrow3kComR");

    _firestore.collection('AdminTokens').getDocuments().then((value) {
      value.documents.forEach((val) {
        final Message fcmMessage = new Message()
          ..to = val.data['token']
          ..title = '$_enquiry'
          ..body = 'Mr.${_name} has sent an $_enquiry';
        fcm.send(fcmMessage).then((id) {
          print('Message id = $id');
        });
      });
    }).then((val){
      successDialog(context);
    }).catchError((error){
      print('Enquiry Error');
      errorDialog(context);
    });

//    try{
//      var res = await http.post(POST_ENQUIRY_DETAILS, body: _queryParameters);
//      if(res.statusCode == 200){
//        var resBody = jsonDecode(res.body);
//        print(resBody['success']);
//        setState(() {
//          _inAsyncCall = false;
//          if (resBody['success'] == 1) {
//            successDialog(context);
//          } else {
//            errorDialog(context);
//          }
//        });
//      } else {
//        print(res.statusCode);
//        serverErrorDialog(context);
//      }
//    } catch(e){
//      print(e);
//      serverErrorDialog(context);
//    }

    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('For Enquiry and Complaints'),
        backgroundColor: TOOLBAR_COLOR,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: new ListView(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          children: <Widget>[
            new Form(
              child: Column(
                children: <Widget>[
                  new TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Criteria',
                        hintText: 'Choose a Criteria',
                        labelStyle: new TextStyle(fontSize: 14.0),
                        contentPadding:
                            const EdgeInsets.only(left: 8.0, top: 20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        prefixIcon: new Icon(FontAwesomeIcons.edit),
                      ),
                    ),
                    getImmediateSuggestions: true,
                    suggestionsCallback: (value) {
                      return _enquiryList;
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: new Text(
                          index.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      );
                    },
                    onSuggestionSelected: (value) {
                      print(value);
                      controller.text = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Choose a Criteria';
                      }
                    },
                    onSaved: (value) {
                      _enquiry = value;
                    },
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black, fontSize: 18.0, height: 1.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Name';
                      }
                    },
                    onSaved: (String value) {
                      _name = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      hintText: 'Enter your Name',
                      labelStyle: new TextStyle(fontSize: 14.0),
                      contentPadding:
                          const EdgeInsets.only(left: 8.0, top: 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      prefixIcon: new Icon(Icons.person),
                    ),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Mail-ID';
                      } else {
                        return this._validateEmail(value);
                      }
                    },
                    onSaved: (String value) {
                      _email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Your Mail-ID',
                      hintText: 'Enter your Mail-ID',
                      labelStyle: new TextStyle(fontSize: 14.0),
                      contentPadding:
                          const EdgeInsets.only(left: 8.0, top: 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      prefixIcon: new Icon(Icons.email),
                    ),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Mobile Number';
                      } else {
                        return this._validatePhone(value);
                      }
                    },
                    onSaved: (String value) {
                      _phone = value;
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
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    maxLines: 2,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Comments';
                      }
                    },
                    onSaved: (String value) {
                      _comments = value;
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
                  new SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(boxShadow: [_boxShadow]),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _PostData();
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      elevation: 5.0,
                      color: Colors.red[900],
                      child: new Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              key: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}
