import 'package:flutter/material.dart';
import 'package:hospitalappointments/app_colors.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

// Center sigmaText() {
//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: new GestureDetector(
//         child: new RichText(
//           text: TextSpan(children: <TextSpan>[
//             TextSpan(
//                 text: 'Powered by ', style: TextStyle(color: Colors.black)),
//             TextSpan(
//                 text: 'Sigma Computers',
//                 style: TextStyle(color: TOOLBAR_COLOR)),
//           ]),
//         ),
//         onTap: () {
//           launch('http://www.sigmacomputers.in');
//         },
//       ),
//     ),
//   );
// }

 Future<String> getAppVersion() async {
final PackageInfo packageInfo = await PackageInfo.fromPlatform();
return packageInfo.version;
}

Widget sigmaText({@required Color textColor}) {
  return GestureDetector(
    onTap: () {
      launch('http://www.sigmacomputers.in');
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<String>(
            future: getAppVersion(),
            builder: (context, snapshot) {
              return Text(
                'App Version ${snapshot.data ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: textColor.withOpacity(.5)),
              );
            }),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icon/icon.png',
              height: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Powered By ',
                    style: TextStyle(
                        color: textColor.withOpacity(.5),
                        fontStyle: FontStyle.italic,
                        fontSize: 12)),
                Text(
                  'Sigma',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontFamily: 'Font',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
// RichText(
//   text: TextSpan(
//       text: 'Powered by ',
//       style: TextStyle(
//           color: textColor, fontStyle: FontStyle.italic),
//       children: [
//         TextSpan(
//             text: 'SIGMA,Salem',
//             style: TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16))
//       ]),
// )
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    ),
  );
}

