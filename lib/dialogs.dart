import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'app_colors.dart';
import 'main.dart';

successDialog(context) {
  // Reusable alert style
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: Duration(milliseconds: 800),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  Alert(
    context: context,
    style: alertStyle,
    type: AlertType.success,
    title: "Thank you",
    desc:
        "A member of staff will process your Enquiry/Complaints and will confirm with you shortly",
    buttons: [
      DialogButton(
        child: Text(
          "OK, Go Home",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => HomePage()));
        },
        // color: Color.fromRGBO(0, 179, 134, 1.0),
        color: TOOLBAR_COLOR,
        radius: BorderRadius.circular(8.0),
      ),
    ],
  ).show();
}

appointmentSuccessDialog(context) {
  // Reusable alert style
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: Duration(milliseconds: 800),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  Alert(
    context: context,
    style: alertStyle,
    type: AlertType.success,
    title: "Thank you",
    desc:
    "A member of staff will process your Appointment and will confirm with you shortly",
    buttons: [
      DialogButton(
        child: Text(
          "OK, Go Home",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => HomePage()));
        },

        color: TOOLBAR_COLOR,
        // color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(8.0),
      ),
    ],
  ).show();
}

errorDialog(context) {
  // Reusable alert style
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: Duration(milliseconds: 800),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  Alert(
    context: context,
    style: alertStyle,
    type: AlertType.error,
    title: "Error",
    desc: "Try again Later",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: TOOLBAR_COLOR,
        // color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(8.0),
      ),
    ],
  ).show();
}

serverErrorDialog(context) {
  // Reusable alert style
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: Duration(milliseconds: 800),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  Alert(
    context: context,
    style: alertStyle,
    type: AlertType.error,
    title: "Server Error",
    desc: "Try again Later",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: TOOLBAR_COLOR,
        // color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(8.0),
      ),
    ],
  ).show();
}

paymentFailureDialog(context) {
  // Reusable alert style
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: Duration(milliseconds: 800),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  Alert(
    context: context,
    style: alertStyle,
    type: AlertType.error,
    title: "Payment Failed",
    desc: "Your Payment Has been Failed",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: TOOLBAR_COLOR,
        // color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(8.0),
      ),
    ],
  ).show();
}
