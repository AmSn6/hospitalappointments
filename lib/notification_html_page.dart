import 'package:hospitalappointments/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

import 'app_colors.dart';

class NotificationHtmlPage extends StatefulWidget {
  final data;

  NotificationHtmlPage({@required this.data});

  @override
  NotificationHtmlPageState createState() {
    return new NotificationHtmlPageState();
  }
}

class NotificationHtmlPageState extends State<NotificationHtmlPage> {
  @override
  Widget build(BuildContext context) {

    String _announcement =
        "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;\n" +
            "font-size: 15px;\n" +
            "font-weight: normal;\">\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"> "+widget.data+" </p>\n" +
            " \n" +
            "</body></html>";
    InAppWebViewInitialData data = InAppWebViewInitialData(_announcement);

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: TOOLBAR_COLOR,
          title: new Text('Announcement'),
          elevation: 0.0,
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/app_background.png'),
                  fit: BoxFit.fill)),
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
            child: InAppWebView(
              initialData: data,
            ),
            ),
          ),
        ));
  }
}
