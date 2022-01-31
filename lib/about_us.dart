import 'package:flutter/material.dart';
import 'package:hospitalappointments/app_colors.dart';

class AboutApp extends StatefulWidget {
  final  title;
  AboutApp({@required this.title});

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: TOOLBAR_COLOR,
          title: new Text(widget.title),
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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // border: Border.all()
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Column(
                    children: [
                      Text('Online consultation app development is your best bet as people are continually looking for reliable doctors on-demand mobile apps. The app will help you in offering healthcare and checkups. \n'
                        'Under this, the patients can access you and get your advice through their smartphones. Additionally, they also get notification\n'
                          'You can offer online consulting services to your current patients and also attract potential patients to use the service.\n'
                          'The best part about the mobile app is that anyone can consult any of the doctors who are located at any destination. The patients don’t have to travel long distances as they can quickly consult the doctor with a virtual visit feature-rich app.\n'
                          'With this feature, the doctors can manage their appointments easily as they can book and schedule the work as per their availability. You can either charge by the hour or by session. Above all, the app automatically draws payment from the patients.',
                      style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),

              ),

            ),
          ),
        ));
  }
}
