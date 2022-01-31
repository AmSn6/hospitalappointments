import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospitalappointments/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_colors.dart';

class StaticHtmlPage extends StatefulWidget {
  final title;

  StaticHtmlPage({@required this.title});

  @override
  StaticHtmlPageState createState() {
    return new StaticHtmlPageState();
  }
}

class StaticHtmlPageState extends State<StaticHtmlPage> {
  @override
  Widget build(BuildContext context) {
    InAppWebViewInitialData data =
        InAppWebViewInitialData(HtmlData().htmlData(widget.title, context));

    InAppWebViewController controller;

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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Image.asset('assets/logo.png',height: 80,),
                      SizedBox(height: 10,),
                      Text(
                        'N0.72, 3rd Floor, B-Block,\n'
                            'New Green Park Avenue [TNHB Apt],\n'
                            'Opp to Hotel Ganesh Mahal,\n'
                            'Near New Bus Stand,\n'
                            'Salem - 7, Tamil Nadu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20,),
                      // new Padding(
                      //   padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      //   child: new Text('Call us',),
                      // ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        new Text('Call :',style: TextStyle(fontSize: 18),),

                          Text(
                            '+91 - 98427 24034 \n  +91 - 427 - 4266034',
                            // '+91 - 98427 24034 | 95009 24034\n'
                            //     '+91 - 427 - 4266034 | +91 - 75029 73484 |',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15,color: TOOLBAR_COLOR),
                          ),
                          SizedBox(width: 5,),
                          new IconButton(
                              icon: Icon(MdiIcons.phone, color: Colors.blue),
                              onPressed: () {
                                launch('tel: +9198427 24034');
                                // launch('https://www.youtube.com/channel/UCSucEGudkl9wSy7Pm83pobg');
                              }),


                        ],
                      ),
                      Spacer(),
                      // FlatButton(
                      //   onPressed: () {
                      //     // launch('tel: ${snapshot.data.adminSettings[0].adminSettingValue}');
                      //   },
                      //   child: Icon(
                      //     Icons.call,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                      // FlatButton(
                      //   onPressed: () {
                      //     launch('whatsapp://send?phone=+9198427 24034}');
                      //   },
                      //   child: Icon(
                      //     MdiIcons.whatsapp,
                      //     color: Colors.green,
                      //   ),
                      // ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: new Text('Follow us on'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.blue[900],
                                ),
                                onPressed: () {
                                  launch('https://www.facebook.com/SigmaComputersSalem/');
                                  // launch('https://www.facebook.com/dharanhospital');
                                }),
                            new IconButton(
                                icon: Icon(FontAwesomeIcons.instagram,
                                    color: Colors.pink),
                                onPressed: () {

                                  // launch('https://www.instagram.com/dharan_hospital');
                                  launch('https://www.instagram.com/sigma_prestantia/');
                                }),
                            new IconButton(
                                icon: Icon(FontAwesomeIcons.youtube, color: Colors.red),
                                onPressed: () {
                                  launch('https://www.youtube.com/channel/UC1U3fyGCMc60Nej9m6ZSpWg');
                                  // launch('https://www.youtube.com/channel/UCSucEGudkl9wSy7Pm83pobg');
                                }),
                            new IconButton(
                                icon: Icon(MdiIcons.whatsapp, color: Colors.green),
                                onPressed: () {
                                  launch('https://api.whatsapp.com/send?phone=919842724034');
                                  // launch('https://www.youtube.com/channel/UCSucEGudkl9wSy7Pm83pobg');
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // child: InAppWebView(
              //   initialData: data,
              // ),
            ),
          ),
        ));
  }
}

class HtmlData {
  String htmlData(String html, BuildContext context) {
    String data;

    String test = "<!DOCTYPE html><html dir=\"ltr\" lang=\"en\" style=\"-moz-font-size:10px;max-width:100%;-webkit-font-smoothing:antialiased;font-family:sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;-webkit-tap-highlight-color:rgba(0,0,0,0);\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\"><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"><body style='-moz-line-height:1.42857143;color:#333;font-size:14px;font-family:\"Helvetica Neue\",Helvetica,Arial,sans-serif;font-weight:500;background-color:#fff;background-attachment:fixed;max-width:100%;overflow-x:hidden;margin:0;'><div id=\"wrapper\" class=\"clearfix\"><div class=\"main-content\"> <section style=\"display:block;\"><div class=\"container pb-30 pt-30\" style=\"padding-left:15px;margin-right:auto;margin-left:auto;padding-top:30px;padding-bottom:30px;\"><div class=\"section-content\"><div class=\"row\" style=\"padding-right:15px;padding-left:15px;\"><div class=\"thumb-tow\"><p style=\"-moz-margin-bottom:10px;margin:0 0 10px;\">Human Resource Department in Dharan Institutions, do follow the labor norms and policies as per the government guidelines of PF, ESI, Accident Coverage and Health Insurance Coverage to all the associated staff after completing their 3 Month probation period with Dharan.</p></div><div style=\"min-height:1px;padding-right:15px;padding-left:15px;\"><div class=\"schedule-box maxwidth500 mb-30\"><div class=\"clearfix p-15 pt-10\"><h5 class=\"font-16 title\" style=\"-moz-font-size:14px;margin-top:10px;margin-bottom:10px;font-family:inherit;font-weight:500;line-height:1.1;color:inherit;\"><a itemprop=\"url\" href=\"#\" style=\"-moz-color:#111111;text-decoration:none;background-color:transparent;-webkit-font-smoothing:antialiased;\">CONTACT PERSON</a></h5><p style=\"-moz-margin-bottom:10px;margin:0 0 10px;\">Ms. A. SHARMILA., MBA (HR), (Hr Executive)</p><p style=\"-moz-margin-bottom:10px;margin:0 0 10px;\">hr@dharanhospital.com</p><p style=\"-moz-margin-bottom:10px;margin:0 0 10px;\">Mobile : +91 - 97152 59997</p></div></div></div><div style=\"min-height:1px;padding-right:15px;padding-left:15px;width:100%;\"><div class=\"schedule-box maxwidth500 mb-30\"><div class=\"clearfix p-15 pt-10\"><h5 class=\"font-16 title\" style=\"-moz-font-size:14px;margin-top:10px;margin-bottom:10px;font-family:inherit;font-weight:500;line-height:1.1;color:inherit;\"><a itemprop=\"url\" href=\"#\" style=\"-moz-color:#111111;text-decoration:none;background-color:transparent;-webkit-font-smoothing:antialiased;\">RECRUITMENTS</a></h5><p style=\"-moz-margin-bottom:10px;margin:0 0 10px;\">Dharan has a rigorous recruitment policy, to maintain and retain its quality standards and accreditation protocols.</p><p style=\"-moz-margin-bottom:10px;margin:0 0 10px;\">Candidates seeking a career with Dharan, can forward their CV to hr@dharanhospital.com</p></div></div></div></div></div></div> </section></div></div></body></html>";

    String _comingSoon =
        "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;\n" +
            "font-size: 15px;\n" +
            "font-weight: normal;\">\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Coming Soon...</p>\n" +
            " \n" +
            "</body></html>";

    switch (html) {
      case "Contact Us":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body>\n" +
            "<ul>\n" +
            "<li style=\"color: #000;line-height: 28px;list-style: outside none none;margin-bottom: 12px;\n" +
            "width: 100%;\">Dharan Hospital <br> #14, Seelanaickanpatty byepass,<br>\n" +
            "Salem - 636 201, Tamilnadu.</li>\n" +
            "<li style=\"color: #000;line-height: 28px;list-style: outside none none;margin-bottom: 12px;\n" +
            "width: 100%;\"><a href=\"tel:+919585069990\">Tel : +91 - 427 - 2709999</a></li>\n" +
            "<li style=\"color: #000;line-height: 28px;list-style: outside none none;margin-bottom: 12px;\n" +
            "width: 100%;\"><a href=\"tel:+919585069990\">Mob : +91 - 99439 39990 </a></li>\n" +
            "<li style=\"color: #000;line-height: 28px;list-style: outside none none;margin-bottom: 12px;\n" +
            "width: 100%;\"><a href=\"tel:+919585069990\">Fax : + 91 - 427 - 2281716</a></li>\n" +
            "<li style=\"color: #000;line-height: 28px;list-style: outside none none;margin-bottom: 12px;\n" +
            "width: 100%;\">Email : <a style=\"color:#000;\" href=\"mailto:info@dharanhospital.com\"> info@dharanhospital.com</a></li>\n" +
            "</ul>\n" +
            "</body></html>";
        break;

      case 'test':
        data = test;
        break;

      case "Dharan Hospital":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;\n" +
            "font-size: 15px;\n" +
            "font-weight: normal;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/multispeciality_hospital.jpg\" style=\"width:100%;border-radius:10px 10px 0px 0px;margin-bottom:15px;\">\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"><span class=\"dropcap-one\" style=\"color: #00a79e;\n" +
            "display: block;\n" +
            "float: left;\n" +
            "font-size: 36px;\n" +
            "line-height: 36px;\n" +
            "margin: 2px 8px 0 0;\">W</span>ith a motto of \"GOOD HEALTH CARE FOR ALL\", Dharan Hospital is serving the mankind with its wide range of multi facet health care services for more than a decade. Dharan Hospital is incepted in the early 2007 with a dedicated team of like minded medical professionals has strong bonding with Dharan, is the key for happy go patients.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Hospital is synonym for 'Quality Health Care', which has latest technology and modern medical equipments at par to international standards, to diagnose patient ailments at affordable cost. Dharan has cutting edge 'Operational Practice' model, which supports the &lsquo;Medical Service&rsquo; model with hassle free process and protocols, without compromising medical standards.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Hospital has 24 X 7 cover of Accident and Emergency Care, In-Patient Service, Ambulance Service, Maternity/Labour Care, Critical Care Units (ICU&rsquo;s &amp; CCU&rsquo;s), Laboratory and Pharmacy.  Dharan has detail diagnostic medical services like Endo &amp; Laparoscopic Unit, Cath Lab Unit, Dialysis Unit covering 4 shifts, and Radio Imaging Unit (X-Ray, Ultrasound &amp; CT-Scan) which supports the 6 well equipped modernized Operations Theatres including Organ Transplant units.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Hospital is a 150+ Bedded Hospital, excluding 'Center of Excellence' units, covering General Ward, Private and Semi-Private Rooms, Deluxe and Suite Rooms as per the need of the patients with kind hospitality. 35+ Full-Time Consultants with 15+ Visiting Consultants were practicing their Out-Patient Clinic and utilizing In-Patient services in our hospital. Dharan is empanelled with leading private sector insurances and State Govt's Health Insurances including State Govt&rsquo;s Employee Scheme and Pensioners Scheme.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Hospital is a trusted symbol in the western region of Tamil Nadu in India, were a team of professionals in their work on National and International Patients and Medical Tourism focusing primarily in the middle-east and south-east Asian countries.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Overall, Dharan is ready to cuddle patients with utmost care, to heal the patient pain by our medical services with passionate care.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Welcome into Dharan world of Health Care Services.</p>\n" +
            "</body></html>";
        break;
      case "Management Team":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\"><div class=\"management dharan-management management-filter recent\">\n" +
            "      <style> .accordion { color: #fff;  cursor: pointer;  padding: 18px; border: none;  text-align: center outline: none;  font-size: 15px;  transition: 0.4s; } .active, .accordion:hover {  } .panel {display: none; border-radius: 8px; background-color: white; overflow: hidden; text-align: justify; padding: 8px;} </style>\n" +
            "      <img src=\"file:///android_asset/flutter_assets/assets/dr_selvaraja_director.jpg\" style=\"width:100%;border-radius:10px 10px 0 0;\">\n" +
            "      <div class=\"management-wrap\" style=\"position: relative;top: 100%;left: 0;margin: 0px 0px 0;\">\n" +
            "            <div class=\"management-team\" style=\"text-align: center;padding: 10px 10px 14px;background: rgba(0,167,157,0.9);line-height: 1;\n" +
            "            border-bottom: 3px; border-bottom-right-radius: 8px; border-bottom-left-radius: 8px; solid #fff; overflow: hidden;\">\n" +
            "            <span style=\"color: #fff; font-size: 16px; display: inline-block;margin: 9px 0px 15px;\"> Managing Director </span>\n" +
            "            <br><h6 class=\"accordion\" style=\"margin: 0px;font-size:18px;line-height: 1.3;font-weight:bold;color:#fff;\">Dr. V. SELVARAJA</h6>\n" +
            "            <div class=\"panel\">  <p>The Managing Director, Dr. V. SELVARAJA is the Chief Mentor of Dharan Hospital, who did his Doctorate at Annamalai University in 1994. In continuation, he did his Masters in Surgery at Kuvempu University, Shimoga, Karnataka in 1996. After gaining 5 years hands on medical and surgical experience, on 2001 he started his first private clinic practice  in a  clinic set up, with a staff nurse with utmost care and passion. This earned him a good name in the surroundingregion, results, repeat patients continuing their medical management for their 2nd generation family members. This evidence in Dharan Hospital present traffic with per day average of 150+ OP’s and 85+IP’s, at all seasons, covering core specialities 24 X7with 300+ staff in a span of 10+ years.\n" +
            "\n" +
            "                  Being a first generation venture conglomerate, Dr. Selvaraja, never hesitate to share his early days experience and his footpath to his hospital team, to ensure Ethical Practice, Patient Care, Affordability and Cleanliness, which he believes a lot, results regular repeat patients. This practically results in his outstanding medical statistics of 18,100+ General Surgeries, including Endoscopies and Laparoscopies without any commercial marketing till 2017.\n" +
            "\n" +
            "                  Dr. Selvaraja persuades across all corners in the hospital from entrance to lavatory, which is mastermind by him from inception. His structured operations skill and customized protocols in Dharan Hospital, evidence in the recent NABH Accreditation (Entry level) in early 2017.  He is supported by his younger brother Mr. V. GUNASEKAR., Joint Managing Director-Dharan Hospital, who takes care of core administrative services with a team of 2nd line management professionals and 3rd line admin heads. Mr. V. GUNASEKAR., plays an active role with Dr. V.SELVARAJA in hospital procurements, project works, statutory license, accreditations, for hassle free hospital operations.\n" +
            "\n" +
            "            Dr. V. SELVARAJA is happily wedded with Ms. SANGEETHA PRIYA., who is one of the member in Dharan Executive Management Board, who is designated as “Director - Finance & Accounts”. They both blessed with a Son name Mr. DHARANEESH. S.S, who is in near completion of his medical academics. His hobbies are listening music, magazines, who is a seasonal Cricket player after his college days. Mr. V. SELVARAJA is reachable at selva@dharanhospital.com</p> </div>\n" +
            "      </div>\n" +
            "</div>\n" +
            "<br>\n" +
            "<br><img src=\"file:///android_asset/flutter_assets/assets/gunasekar_jmd.jpg\" style=\"width:100%;\"><div class=\"management-wrap\" style=\"position: relative;top: 100%;left: 0;margin: 0px 0px 0;\">\n" +
            "      <div class=\"management-team\" style=\"text-align: center;padding: 10px 10px 14px;background: rgba(0,167,157,0.9);line-height: 1;\n" +
            "      border-bottom: 3px; border-bottom-right-radius: 8px; border-bottom-left-radius: 8px; solid #fff;overflow: hidden;\">\n" +
            "      <span style=\"color: #fff;font-size: 16px;display: inline-block;margin: 9px 0px 5px;\">Joint Managing Director </span>\n" +
            "      <h6 class=\"accordion\" style=\"margin: 0px;font-size:18px;line-height: 1.3;font-weight:bold;color:#fff;\">Mr. V. GUNASEKAR</h6>\n" +
            "       <div class=\"panel\">  <p>The Joint Managing Director, Mr. V. GUNASEKAR is the core administration backbone of Dharan Hospital, who did his graduate excellence in St. Joseph College, Trichy in 1991. Being an active person with administrative mind, on 1992, immediately after his graduation he started his career by joining as a ‘Purchase Executive’ in a private granite retail house. His enthusiasm and hard work elevated him to ‘Purchase Manager’ in that organization.\n" +
            "\n" +
            "From then no look back to Mr. V. GUNASEKAR, who travelled across all major countries in Asia, Middle East, South Africa, and Western countries to oversee the procurement and export plans for his granite employer. This work exposure is the base brain, for the inception of ‘Dharan Natural Stone Park’ in 2010 and ‘Dharan Rock’ - An 100% Export Oriented Unit in 2013.\n" +
            "\n" +
            "Mr. Gunasekar’s administrative and managing skills have thought-out well and systemized the administrative protocols of Dharan Hospital, which results from the foundation stone (2005) to recent NABH Accreditation-Entry level (2017). He is supported by his elder brother Dr. V. SELVARAJA., Managing Director-Dharan Hospital, who takes care of core medical services with a team of dedicated medical professionals. Dr. V.SELVARAJA plays an active role with Mr. V. GUNASEKAR in hospital operations with his inputs, for hassle free hospital operations as per the standards.\n" +
            "\n" +
            "Mr. Gunasekar is happily wedded with Ms. SASIKALA., who is one of the member in Dharan Executive Management Board, designated as “Director - Pharmacy Operations”. They both blessed with a Son name Mr. VIVIN LITHESH.V.G, who is in the near completion of his college academics. His hobbies are listening music and relax with some weekend movies, who is an active Football player. Mr. V. GUNASEKAR is reachable at pm@dharannsp.com</p> </div>\n" +
            "</div>\n" +
            "</div>\n" +
            "<br>\n" +
            "<br><img src=\"file:///android_asset/flutter_assets/assets/sangeetha_priya.jpg\" style=\"width:100%;\"><div class=\"management-wrap\" style=\"position: relative;top: 100%;left: 0;margin: 0px 0px 0;\">\n" +
            "      <div class=\"management-team\" style=\"text-align: center;padding: 10px 10px 14px;background: rgba(0,167,157,0.9);line-height: 1;\n" +
            "      border-bottom: 3px; border-bottom-right-radius: 8px; border-bottom-left-radius: 8px; solid #fff;overflow: hidden;\">\n" +
            "      <span style=\"color: #fff;font-size: 16px;display: inline-block;margin: 9px 0px 5px;\">Director - Finance </span>\n" +
            "      <h6 class=\"accordion\" style=\"margin: 0px;font-size:18px;line-height: 1.3;font-weight:bold;color:#fff;\">Mrs. SANGEETHA PRIYA. S</h6>\n" +
            "      <div class=\"panel\">  <p>The Director - Finance, Mrs. SANGEETHA PRIYA.S is one of the members in Executive Management Board of Dharan Hospital, who handles the oxygen portfolio ‘Finance’ and its related operations. Being an Annamalai University graduate in 2000, who has associated with Dharan from clinic age in the late 90’s. She plays an active role in Finance and Accounting Operations of Dharan Hospital, since its inception on January 2007.\n" +
            "\n" +
            "Mrs. Sangeetha Priya association with Dharan Hospital, has ensured Finance and Accounts operations in a proper direction from time to time, from the early Account Book Culture to till date GST Bill implementation. With the base practical knowledge about finance management from her family transport business, Ms. Sangeetha Priya, implemented financial protocols and process methodologies as per the current accounting trends and tax components. She keeps upgrading her, with recent happenings in the Financial Sector as one of her hobbies.\n" +
            "\n" +
            "Ms. Sangeetha Priya, is happily wedded with Dr. V. SELVARAJA.,- Managing Director, Dharan Hospital, who is the Chief Mentor of Dharan Hospital and chairperson of Dharan Executive Management Board. They both blessed with a Son, name Mr. DHARANEESH. S.S, who is in the near completion of his medical studies. Her hobbies are Interior Design and Textile, who plays Volley Ball in games. Mrs. Sangeetha Priya is reachable at info@dharanhospital.com</p> </div>\n" +
            "</div>\n" +
            "</div>\n" +
            "<br>\n" +
            "<br><img src=\"file:///android_asset/flutter_assets/assets/sasikala_director.jpg\" style=\"width:100%;\"><div class=\"management-wrap\" style=\"position: relative;top: 100%;left: 0;margin: 0px 0px 0;\">\n" +
            "      <div class=\"management-team\" style=\"text-align: center;padding: 10px 10px 14px;background: rgba(0,167,157,0.9);line-height: 1;\n" +
            "      border-bottom: 3px; border-bottom-right-radius: 8px; border-bottom-left-radius: 8px;  solid #fff;overflow: hidden;\">\n" +
            "      <span style=\"color: #fff;font-size: 16px;display: inline-block;margin: 9px 0px 5px;\">Director - Pharmacy Operations </span>\n" +
            "      <h6 class=\"accordion\" style=\"margin: 0px;font-size:18px;line-height: 1.3;font-weight:bold;color:#fff;\">Ms. SASIKALA. G</h6>\n" +
            "      <div class=\"panel\">  <p> The Director - Pharmacy Operations, Mrs. SASIKALA.G is one of the members in Executive Management Board of Dharan Hospitals, who handles the key portfolio 'Pharmacy Operations'. Being a Business Administrative graduate from Periyar University in 2001, who started her professional career in Dharan Hospital from the day of inception on January 2007.\n" +
            "\n" +
            "Mrs. Sasikala association with Dharan Hospital, has ensured the Pharmacy procurement and process, in trust worthy hands and system and process in place with hassle free 24 X 7 availability of medicine for OP and IP Patients. Her managerial skills and coordination, earned a respect and goodwill on brand DHARAN in the Pharma manufacturers and suppliers circle.\n" +
            "\n" +
            "Her recent work towards implementing NABH Standards in Pharmacy Division is one of the key evidence, of her administrative control over pharmacy division. She keeps upgrading her, with recent happenings and new inventions in the Pharma world, who has high visionary plans to expand the division, like online retail chains, Pharma distribution, etc,.\n" +
            "\n" +
            "Ms. Sasikala, is happily wedded with Ms. V. GUNASEKAR., - Joint Managing Director, Dharan Hospital, who is the administrative backbone of Dharan Hospital and member of Dharan Executive Management Board. They both blessed with a Son, name Mr. VIVIN LITHESH.V.G, who is in the near completion of his college academics. Her hobbies are listening Music, were she plays Shuttle and Volley Ball. Mrs. SASIKALA is reachable at info@dharanhospital.com</p> </div>\n" +
            "</div>\n" +
            "</div>\n" +
            "<script> var acc = document.getElementsByClassName(\"accordion\"); var i; for (i = 0; i < acc.length; i++) {  acc[i].addEventListener(\"click\", function() {    this.classList.toggle(\"active\");    var panel = this.nextElementSibling;    if (panel.style.display === \"block\") {      panel.style.display = \"none\";   } else {      panel.style.display = \"block\";    }  });} </script>\n" +
            "</div></body></html>";
        break;

      case "Milestones":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\"><div class=\"about-us\">\n" +
            "\t<div class=\"timeline\">\n" +
            "<div class=\"timeline-element\" style=\"position: relative;margin-left: 33px;margin-bottom: 20px;\">\n" +
            "<span class=\"date\" style=\"color: #7f1519;font-weight: 700;font-size: 18px;margin-top: -3px;\n" +
            "position: absolute;font-family:Roboto Slab;\">2018</span>\n" +
            "<p style=\"text-align:justify;line-height:28px;margin-bottom:10px;padding-top:25px;\">Dharan Hospital established its 1st 'Centre of Excellence' unit  DHARAN WOMENS CARE - FERTILITY CENTRE on 15th July, 2018 with top notch facilities and infrastructures that surpass the western standards.  Inaugurated by renowned industry stalwarts of Salem.</p>\n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone10.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone11.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone12.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            "</div>\n" +
            " \n" +
            "<br><br><div class=\"timeline-element\" style=\"position: relative;margin-left: 33px;margin-bottom: 20px;\">\n" +
            "<span class=\"date\" style=\"color: #7f1519;font-weight: 700;font-size: 18px;margin-top: -3px;\n" +
            "position: absolute;font-family:Roboto Slab;\">2016</span>\n" +
            "<p style=\"text-align:justify;line-height:28px;margin-bottom:10px;padding-top:25px;\">Dharan Hospital, Transformed into 150 Beds with 6 OT with CT, CATH LAB, ICU, ICCU, NICU Facilities. Inaugurated by, then Honb&rsquo;le. Highway Minister for Tamil Nadu, Mr. Eddappadi. K. Palaniswami.  The present Honb&rsquo;le Chief Minister of Tamil Nadu.</p>\n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone7.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone8.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone9.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            "</div>\n" +
            " \n" +
            "<br><br><div class=\"timeline-element\" style=\"position: relative;margin-left: 33px;margin-bottom: 20px;\">\n" +
            "<span class=\"date\" style=\"color: #7f1519;font-weight: 700;font-size: 18px;margin-top: -3px;\n" +
            "position: absolute;font-family:Roboto Slab;\">2010</span>\n" +
            "<p style=\"text-align:justify;line-height:28px;margin-bottom:10px;padding-top:25px;\">Dharan Hospital, Expanded in to 75 Beds with 4 OT, with CM Insurance scheme Ward.  Inaugurated by, then Honb&rsquo;le. Agriculture Minister for Tamil Nadu, Mr. Veerapandi A. Arumugam.</p>\n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone4.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone5.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone6.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            "</div>\n" +
            " \n" +
            "<br><br><div class=\"timeline-element\" style=\"position: relative;margin-left: 33px;margin-bottom: 20px;\">\n" +
            "<span class=\"date\" style=\"color: #7f1519;font-weight: 700;font-size: 18px;margin-top: -3px;\n" +
            "position: absolute;font-family:Roboto Slab;\">2007</span>\n" +
            "<p style=\"text-align:justify;line-height:28px;margin-bottom:10px;padding-top:25px;\">Dharan Hospital, 50 Beds / 2 OT Multispeciality Hospital incepted in Salem on  22.01.2007. Inaugurated by then Honb'le Veerapandi MLA , Mr. Veerapandi  V. RAJA.</p>\n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone1.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone2.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            " \n" +
            "<div style=\"width: 100%;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/milestone3.jpg\" style=\"width:100%;margin-bottom:30px;box-shadow:10px 10px 5px #ccc;\">\n" +
            "</div>\n" +
            "</div>\n" +
            "\t</div>\n" +
            "</div></body></html>\n";
        break;
      case "Medical Services":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body><ul style=\"padding-left:30px;\">\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Accident, Trauma, &amp; Emergency Care.</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Mobile ICU Van for Poison &amp; Snake Bite Care.</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Critical Care &amp; Full Time Intensivist.</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Multispeciality Consultant / Surgeon Care.</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Govt &amp; Private Insurance Care. </li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Stomach Pain Care (Gastroenterology)</li> \n" +
            "<li style=\"line-height:28px;\">\n" +
            "Heart (Angiography / PTCA)  Care (Cardiology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Miscarriage &amp; Labor (Normal / C-Sec) Care (Obstetrics &amp; Gynecology) </li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Baby &amp; Kids Care (Neonatal &amp; Paediatrics) </li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Bone &amp; Joints Care (Orthopedics)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Kidney Stone care. (Nephrology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Prostate, Urinal Care (Urology &amp; Andrology) </li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Asthma &amp; Breathing Difficulty Care (Pulmonology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Spine &amp; Brain Disorder Care (Neurology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Mental Disorder Care (Psychiatric)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Cancer (Medical / Surgical) Care (Oncology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Skin Care (Dermatology &amp; Cosmetology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Thyroid Care (Endocrinology)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Tonsillitis, Nasal Blocks &amp; Hearing Impairment Care (ENT)</li>\n" +
            "<li style=\"line-height:28px;\">\n" +
            "Eye Redness / Blephar Syndrome Care (Ophthalmology)</li>\n" +
            "</ul></body></html>";
        break;
      case "Medical Facilities":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body><ul style=\"padding-left:30px\">\n" +
            "<li style=\"line-height:28px;\">\n" +
            "IP Admission supported by 150 Beds including Private, Deluxe and Suite Rooms facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Fully Equipped Operations Theatre (6 Nos) including Organ Transplant facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Fully Equipped ICU, MICU, NICU and PICU with High-end Monitors &amp; Ventilators facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Dialysis Unit ( 12 Beds including 5 Flexi Chair Seat Beds / Isolated Positive Beds - 2 Nos.)</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Fully Equipped Cath Lab facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Flexible Ureteroscopy with Laser facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Laparoscopy, Endoscopy, Colonoscopy and ERCP (Endoscopic Retrograde Cholangio Pancreatography) facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Bronchoscopy Live video with Sleep Lab facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Fully Equipped Labor Ward facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Helical 3D CT Scan facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Radiology (X-Ray, Ultra Sound Scan &amp; Mammography) facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Laboratory ( Hematology, Biochemistry, Serology, Microbiology, Endocrinology, Histo Pathology,Clinical Pathology and Coagulation) facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Pharmacy facilities</li>\n" +
            "\t<li style=\"line-height:28px;\">\n" +
            "Physiotherapy facilities </li>\n" +
            "</ul></body></html>\n";
        break;
      case "Women IVF Centre":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;\n" +
            "font-size: 15px;\n" +
            "font-weight: normal;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/dwc.jpg\" style=\"width:100%;border-radius:10px 10px 0px 0px;margin-bottom:15px;\">\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Over Generations, human lifestyle has gone into enormous transformation from one stage to other, due to upgrade of civilization and lifestyle customization. Expectation of rapid result oriented activities with the support of modernized lifestyle electronic gadgets leads to poor health and unbalanced food practices. This makes present generation grow with hormonal deficiency and deficiency in organ functional rate. One such main challenge for present generation is fertility hazard to make a family.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Womens Care - Fertility Centre is the new name in the fertility treatment world, with a team of experts and stalwarts who has been in fertility treatment for decades. Dharan Womens Care is incepted in Salem as one of the ‘Centre of Excellence’ unit under the flagship Dharan Hospital.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Womens Care is a one stop solution, which evolves with hope, support, inspiration, transparency, confidentiality and motivation supported by clinical expertise to help the needy patients. This helps patients to meet the challenges and achieve their fertility dreams towards having a happy family. We Dharan Womens Care believe, every patient is unique in terms of physical and psychological way of dealing health issues, and we are passionate in finding the best solution that meets the fertility goals.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">The management of Dharan Hospital and the Clinical Team of Dharan Womens Care assures that, the journey of parenthood at Dharan Womens Care will be without any stress and hassle, and ensures secrecy and privacy of all information. Either Woman with long term fertile complexity or Men with mortality complications will be addressed with compassionate care.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Welcome to the fertility world of Dharan Womens Care.</p>\n" +
            "</body></html>";

        break;
      case "Oncology Centre":
        data = _comingSoon;
        break;
      case "Transplant Centre":
        data = _comingSoon;
        break;
      case "Dharan Natural Stone Park":
        data = _comingSoon;
        break;
      case "Dharan Bath Care":
        data = _comingSoon;
        break;
      case "Dharan Bath Fittings":
        data = _comingSoon;
        break;
      case "Dharan Rock (100% EOU)":
        data = "\n" +
            "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/dharan_rock.jpg\" style=\"width:100%;border-radius:10px 10px 0px 0px;margin-bottom:15px;\"><br><br><p style=\"line-height: 28px;margin: 0 0 10px;\"><span style=\"color: #00a79e;display: block;float: left;font-size: 36px;line-height: 36px;\n" +
            "margin: 2px 8px 0 0;text-align:justify;\">A</span>cross the Globe - existence of ancient histories and human civilization is known to us through Cave carvings and Sculptures in Rocks and plaques. These engraves symbolizes us that \"Stone Sculptures lives beyond Ages\", which has been the key yard stick to gauge the generation ages and their centuries. </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Like that, From the southern state of Tamil Nadu, India - Dharan Rock, An 100% Export Oriented Unit, (A unit from Dharan Group) is functioning towards the needs of the International market. Dharan Rock do export granite art works, granite carvings, customized grave works, household sculptures, as per international standards, covering 24 X 7 according to the needs and demands of the present hi-tech civilized community of 21st Century. </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Dharan Rock - An 100% Export Oriented Unit, is established in 2015, which has been made possible, based on 25 years hands on on-field experience in the stone and granite industry by its Joint Managing Director Mr. V. Gunasekar supported by its Director Dr. V. Selvaraja and Mr. Mahadevan.</p>\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Dharan Rock, is purely focused on International Market, fully equipped with modern technology, exclusively dedicated to the needs and design of international trends, patterns, style and tradition, according to each continent's lifestyle and climate conditions. Dharan Rock has been recognized in countries like UK, USA, Europe covering Germany including all European Countries. </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Overall, Dharan Rock is committed and strictly adheres to delivery commitments the expected, in the stipulated time with high vision of \"Quality, Integrity and Transparency\" in Work, to the international needs and requirements that has gained unique name and reputation across the globe. For more details please log in to <a target=\"_blank\" href=\"http://www.dharanrock.com\">www.dharanrock.com</a> </p>\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">So, welcome and experience the sculptures of Dharan Rock.</p>\n" +
            "</body></html>";
        break;
      case "DEC Trust":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:center;\">DHARAN EDUCATIONAL CHARITABLE TRUST</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:center;\">(Reg No: 3864/2017)</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:center;\">14/1 Seelanaickenpatty Bypass, Salem - 636 201</p>\n" +
            " \n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/trust_founder.jpg\" style=\"width:100%;border-radius:10px 10px 0px 0px;margin-bottom:15px;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:justify;\">Dharan Educational Charitable Trust (DECT) established on 2017, initiated with the blessings of Shri. M. VENKATACHALAM &nbsp; and&nbsp;  Smt.V. JAYAMMAL which is supported by the management team of Dharan Group, as DECT's Life Trustees. Dharan Educational Charitable Trust (DECT) is a one of the landmark initiative that has been engraved in DHARAN History, in remembrance of completing 10 Years in Health Care service to mankind, Under the flagship 'Dharan Hospital' since 2007. Dharan Hospital is one of the household healthcare name of Salem District and Western Districts of Tamil Nadu state in India.</p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:justify;\">Dharan Educational Charitable Trust (DECT) core activities will be revolving around 'Education' and 'Charity', which synonym in its title name. Because, DECT strongly believe that, quality education with technical expertise will eradicate the economic inequality, so that the next generation mankind will sound professional and stronger to compete rest of \t\n" +
            "</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:justify;\">In terms of 'Educational' activity, Dharan Educational Charitable Trust (DECT) has thoroughly analyzed the present younger generations pass-out ratio with the industrial demands in health care industry and decides to step in Health Care related paramedical courses, which can be supported with hands on, on-field training and experience on various specialties under flagship banner Dharan Hospital.</p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:justify;\">In terms of 'Charitable' activity, on the goodwill of renowned health care service provider in Salem, Dharan Educational Charitable Trust (DECT) has decided to do its core charity work in term of medical services to non affordables through, thorough analysis by a pool of BSE (Bureau of Social Experts) Team. This team will analyze the ground reality of the unaffordable parameters and recommend to Board of Life Trustees. Board of Life Trustees will decide on the medical requirements then and there, which will be consolidated in the Trust meetings and the same will be endorsed. The endorsement will be forwarded to BME (Bureau of Medical Experts) Team, who are noted medical professionals in the Industry for treatment at subsidiary rates supported by Dharan Educational Charitable Trust (DECT).</p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;text-align:justify;\"><i>For further details, please feel free to contact <a href=\"mailto:coo@dharanhospital.com\">coo@dharanhospital.com</a> / 95850-69990.</i></p>\n" +
            "</body></html>";
        break;
      case "Education":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\">\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;text-align:justify;\">Dharan Educational Charitable Trust (DECT) has a clear foresight to serve the mankind with  high motive, to educate the next generation youngsters in a right direction, with a vision of &ldquo;To create Knowledge, Professionals and Technical Experts, through Quality Education with Equality and Affordability to All\" This ensure technical education reaches every doorstep in India to enlighten next generation human lives. </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">The campus is located in 3/136, Nelavarapatti, Salem - 636 201. (Landmark: From Seelanaikanpatty Circle, towards 2 Kms in Salem-Namakkal Highway, Behind ABT Parcel Service).</p> \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>DECT has established the following institutions under its educational activities:</b>&nbsp;</p>\n" +
            " \n" +
            "\t<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table table-bordered\" style=\"width:100%;max-width:100%;margin-bottom:20px;border-collapse:collapse;border-spacing:0;border:1px solid #ddd;\"><tbody>\n" +
            "<tr>\n" +
            "<td colspan=\"2\" valign=\"top\" align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><u class=\"courses_color\" style=\"color: #00b9b0;\n" +
            "font-weight: bold;\n" +
            "font-size: 16px;\">Dharan School of Nursing (DSN)</u></p>\n" +
            "<b>Allied Nursing Midwifery - ANM</b><p style=\"line-height: 28px;margin: 0 0 10px;\"></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Approved by Directorate of Public Health &amp; Affiliate with Tamil Nadu\n" +
            "Nursing Council</p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td colspan=\"2\" valign=\"top\" align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><u class=\"courses_color\" style=\"color: #00b9b0;\n" +
            "font-weight: bold;\n" +
            "font-size: 16px;\">Dharan School of Paramedical Sciences (DSPS)</u></p>\n" +
            "<b>Health Inspector - HI</b>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Approved by Directorate of Public Health</p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td colspan=\"2\" valign=\"top\" align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><u class=\"courses_color\" style=\"color: #00b9b0;\n" +
            "font-weight: bold;\n" +
            "font-size: 16px;\">Dharan Institute of Health Sciences (DIHS)</u></p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "<tr valign=\"top\">\n" +
            "<td align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Cardiac Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Operation Theatre &amp; Anesthesia Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Critical Care Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Dialysis Technology</b></p>\n" +
            "</td>\n" +
            "<td align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Diploma\n" +
            "in Health Care Aide</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Diploma\n" +
            "in Scope Support Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Diploma\n" +
            "in Radiology Imaging Technology</b></p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td colspan=\"2\" valign=\"top\" align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p align=\"center\" style=\"line-height: 28px;margin: 0 0 10px;\">Affiliated with Dr. MGR Medical University. Chennai.</p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "</tbody></table>\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Every education unit is properly governed by team of Doctors and Experts in respective field, who has been appointed as principal's and faculty's under each institute, supported by team of admin experts.  For Admissions, please feel free to contact coo@dharanhospitals.com / 95850-69990.</p>\n" +
            "</body></html>";
        break;
      case "Charity":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\">\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">In terms of 'Charitable' activity, on the goodwill of renowned health care service provider in Salem, Dharan Educational Charitable Trust (DECT) has decided to do its core charity work in term of medical services to non affordables through, thorough analysis by a pool of BSE (Bureau of Social Experts) Team. This team will analyze the ground reality of the unaffordable parameters and recommend to Board of Life Trustees. Board of Life Trustees will decide then and there, which will be consolidated in the Trust meetings and the same will be endorsed.  </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Every amount that has been sourced and pooled for charitable activities in Dharan Educational Charitable Trust (DECT), hasbeen properly accounted and spent fully and purely for charitable activities for non-affordable mankind community. Primarily, DECT is focused on \"Free Medical Management\" and &ldquo;Free Surgical Management&rdquo; to non-affordables, after approval from &ldquo;Bureau of Social Experts&rdquo; team in DECT.</p>\n" +
            " \n" +
            "<h4>BSE Team</h4>\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Bureau of Social Experts team called as 'BSE Team' is a mixture of Life Trustee and Non-Trustee known noted members of Life Trustee, to utilize every individual's 'field expertise' and 'knowhow knowledge' in their walk of life. This help to analyze the ground reality of non affordableness, duly scrutinized and act fast for the needy people of medical service under trust fund.  </p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>BSE Team Members:</b></p>\n" +
            "  \n" +
            "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table table-bordered\" style=\"width:100%;max-width:100%;margin-bottom:20px;border-collapse:collapse;border-spacing:0;border:1px solid #ddd;\">\n" +
            "<thead><tr>\n" +
            "<th align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">S.No</th>\n" +
            "<th align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Name</th>\n" +
            "</tr></thead>\n" +
            "<tbody>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">1.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Dr. V.SELVARAJA. (Managing Director &ndash; Dharan Hospital)</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">2.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Mr. SEKAR. (Joint Managing Director &ndash; Dharan Hospital)</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">3.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Mr. M.VENKATACHALAM. ( Chairman &ndash; DECT)</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">4.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Mr. N.A.CHINNASAMY. (Founder Chairman &ndash; Saraswathi Transports)</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">5.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Mr. A.K.RAMASAMY. (Secretary &ndash; Bharathiyar College)</td>\n" +
            "</tr>\n" +
            "</tbody>\n" +
            "</table>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">For Donations, please feel free to contact <a href=\"mailto:coo@dharanhospital.com\">coo@dharanhospital.com</a> / 95850-69990.</p>\n" +
            " \n" +
            "<h4>BME Team</h4>\n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Bureau of Medical Experts team called as &lsquo;BME Team&rsquo; is a team of noted and renowned medical experts in the health care industry who has joined hands for noble cause to do life saving medical and surgical treatments at subsidized cost to cover only the medical expenses for the really needed un affordable peoples, who are recommend by BSE Team. BME Team has an active role, only after finance grant from DECT Life Trustees.</p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>BME Team Members:</b></p>\n" +
            " \n" +
            "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table table-bordered\" style=\"width:100%;max-width:100%;margin-bottom:20px;border-collapse:collapse;border-spacing:0;border:1px solid #ddd;\">\n" +
            "<thead><tr>\n" +
            "<th align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">S.No</th>\n" +
            "<th align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Name</th>\n" +
            "</tr></thead>\n" +
            "<tbody>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">1.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Dr. V.SELVARAJA<br>M.S., FICS., Managing Director, Gastro &amp; General Surgeon &ndash; Dharan Hospital) </td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;\">2.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;\">Dr. E.ARAVIND<br>M.S.,DNB (Gen.Srgry)., DNB (Uro). (HOD &ndash; Dept. of Urology, Dharan Hospital)</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">3.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Joining Shortly</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">4.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Joining Shortly</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">5.</td>\n" +
            "<td align=\"left\" style=\"padding: 6px 10px;border:1px solid #ddd;\">Joining Shortly</td>\n" +
            "</tr>\n" +
            "</tbody>\n" +
            "</table>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">For Medical help, please inform us at <a href=\"mailto:coo@dharanhospital.com\">coo@dharanhospital.com</a> / 95850-69990.</p>\n" +
            "</body></html>";
        break;
      case "Dharan Nursing College":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;\n" +
            "font-size: 15px;\n" +
            "font-weight: normal;\">\n" +
            "<p style=\"text-align:center;font-weight:700;color: #870e12;line-height: 1;margin: 0 0 10px;\">Dharan Nursing College</p>\n" +
            " \n" +
            "<p style=\"text-align:center;margin: 0 0 10px;\">Affiliated with</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Tamil Nadu Nursing Council (TNNC), Tamil Nadu Dr MGR Medical University, Indian Nursing Council(INC)</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"><b>Dharan Nursing College - DNC</b> is one of the educational divisions of Dharan Educational Charitable Trust. DNC is established exclusively to focus the quality nursing care under B.Sc Nursing Graduation Program.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">In the recent years, the need of nursing care professional is at sky high level due to the increase of human population, and the dip in medical institutions service quality and standards. This is due to poor educational practices, especially lack of live practical exposures during the time of study</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">DNC focuses primarily on quality education, practical expertise, live community health practices, on field training at varied health institutions with utmost care and passion towards students education to match the standard protocols of nursing care.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Dharan Nursing College – DNC’s B. Sc Nursing is the 4 Year program, revolves around quality theoretical study and live practical exposures about nursing care in Hospitals and Community Health Centers.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"><b>Basic Human Qualities:</b></p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Polite, Humble, Tolerance, Commitment, Conviction and Passion.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"><b>Educational Qualifications:</b></p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Higher Secondary (+2) education with Physics, Chemistry and Biology.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Higher Secondary (+2) Pass-Out with aggregate of 45% marks.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"><b>Eligibility Criteria:</b></p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Only GIRLS with (+2) qualification with the above ‘Educational Qualifications’ clause.</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\"><b>Placement Opportunities:</b></p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Government and Private Hospitals</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Clinical Research Institutions</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Pharma Manufacturers</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">Nursing Care Service Providers and Nursing Educational Institutes</p>\n" +
            "<p style=\"text-align:justify;margin: 0 0 10px;\">For further details about B.Sc Nursing program, Kindly contact 96558 19990 / 95850 69990 or email at dect@dharanhospital.com</p>\n" +
            "</body></html>";

        break;
      case "Dharan School of Nursing (DSN)":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"color: #444444;font-size: 15px;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/nursing_logo.png\"style=\"width:100%;\"><br><br>" +
//                        "<div style=\"text-align:center;\"><a style=\"color: #fff;text-align:center;\n" +
//                        "background-color: #d9534f;\n" +
//                        "border-color: #d43f3a;display: inline-block;\n" +
//                        "padding: 6px 12px;\n" +
//                        "margin-bottom: 0;\n" +
//                        "font-size: 14px;\n" +
//                        "font-weight: normal;\n" +
//                        "line-height: 1.42857143;\n" +
//                        "text-align: center;\n" +
//                        "white-space: nowrap;\n" +
//                        "vertical-align: middle;\n" +
//                        "-ms-touch-action: manipulation;\n" +
//                        "touch-action: manipulation;\n" +
//                        "border: 1px solid transparent;\n" +
//                        "border-radius: 4px;\" target=\"_blank\" href=\"http://www.dharanhospital.com/downloads/go-anm.pdf\">Goverment Order Copy</a></div><br>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\"><b>Dharan School of Nursing</b> is one of the educational divisions of Dharan Educational Charitable Trust. Dharan School of Nursing has a primary vision of conducting wide range of exclusive health care nursing oriented programs. These programs are approved by Department of Public Health, Government of Tamil Nadu, as well as to affiliate with Tamil Nadu Nursing Council. </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Dharan School of Nursing is exclusively focused in educating and guiding the next generation young feminine into qualified nursing professionals, based on the prevailing and growing need of medical assisting professionals, which is practically evidence over a decade in our flag ship health care division &lsquo;Dharan Hospital&rsquo;.</p>\n" +
            "<br><h2 style=\"color:#7f1519;font-size:20px;font-weight:700;line-height:40px;margin-bottom:10px;font-family:Roboto Slab;margin:-7px 0 10px;position:relative;\">2018 - 2019 Nursing Programs</h2>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">In the current academics (2018-2019), Dharan School of Nursing is enrolled with Auxiliary Nursing Midwifery [ANM] program. ANM is a two year regular under graduate certificate level course in medical nursing.  Minimum eligibility for ANM Course is GIRLS, who completed 10+2 with a minimum aggregate of 45% marks in any discipline.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">ANM program revolves with field of medicine and its related components. ANM program provides on field practical exposure to medical care needs to individuals, families and even to a section of community, in terms of care and heal their medical ailments and pains during life time medical complications and critical situations. This program helps to fulfill and maintain optimal health and quality life throughout the journey of human life.   </p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">ANM professionals are very much in demand in Government and Private Health Care Units. According to the need and the role in each Health Care units their designation varies. It ranges from assigning as Clinical Nurse Specialist, Legal Nurse Consultant, Travelling Nurse, Nursing Representative, Assistant Nurse Emergency Room, Midwife Nurse, etc.,</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Dharan Schools of Nursing provides quality teaching and practical on-field training to the max with regular academics. The lab practice and on-field training models will help them to face the real life demand of Health Care Organization.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">Enroll yourself with Dharan School of Nursing and be a sound nursing professional in the Health Care Industry.</p>\n" +
            " \n" +
            "<p style=\"text-align:justify;line-height: 28px;margin: 0 0 10px;\">For any further academic related queries, please contact <b>dihs.dect@gmail.com</b> or <b>coo@dharanhospital.com</b></p>\n" +
            "</body></html>";
        break;
      case "Dharan School of Paramedical Sciences (DSPS)":
        data = "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"text-align:justify;color: #444444;font-size: 15px;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/paramedical_logo.png\"style=\"width:100%;\"><br><br>\n" +
//                        "<div style=\"text-align:center\"><a style=\"color: #fff;text-align:center;background-color: #d9534f;border-color: #d43f3a;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 14px;font-weight: normal;line-height: 1.42857143;text-align: center;white-space: nowrap;vertical-align: middle;border: 1px solid transparent;border-radius: 4px;\" target=\"_blank\" href=\"downloads/go-paramedical-science.pdf\">Goverment Order Copy </a></div><br>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Dharan School of Paramedical Sciences</b> is the educational division of Dharan Educational Charitable Trust, with a primary vision of conducting wide range of exclusive health oriented programs. One such kind program is &lsquo;Health Inspector&rsquo;. This program is approved by Department of Public Health, Government of Tamil Nadu, for &ldquo;Health Inspector&rdquo; and &ldquo;Sanitary Inspector&rdquo; postings across Tamil Nadu. </p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Dharan School of Paramedical Sciences is exclusively focused in educating and guiding the next generation young MALES towards the need of health care jobs. Students will be well trained to address the society, through their professional approach and quality standards that has been thought throughout the program. </p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Health awareness got hyped in recent years due to life style modification that makes people depend more on packed products. Moreover, manufacturing Industries that exhaust chemical gas and let out of waste fluids and natural calamities like rain, flood, twisters has staged the need of &lsquo;Health Inspector&rsquo; role across Tamil Nadu. </p>\n" +
            "<br><h2 style=\"color:#7f1519;font-size:20px;font-weight:700;line-height:40px;margin-bottom:10px;font-family:Roboto Slab;margin:-7px 0 10px;position:relative;\">2018 &ndash; 2019 Health Inspector Programs:</h2>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">In the current academic year (2018-2019), Dharan School of Paramedical Sciences has rolled out the \"Health Inspector\" educational program as per the directions of Department of Public Health, Government of Tamil Nadu. This is a two year regular professional program to get in Government Jobs under Department of Public Health.  Minimum eligibility for 'Health Inspector' program is <b>Boys</b>, who has completed <b>10<sup>th</sup>, +2 under Biology group</b> with a minimum aggregate of 50% marks.</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Health Inspector program provides hands on practical field exposures, along with educational updates. This is a 2 year program, which covers not only the structured syllabus, but also covers national and international health protocols for cleanliness and quality standards through seminars and guest lecturers from the industry. This result pass out of qualified &lsquo;Health Inspector&rsquo; community, who will serve the nation by monitoring men, material, machinery and methodology as per Government norms without violating the National and International norms relate to respective industry. </p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Health Inspector program revolves with health standards and protocols across all areas that covers from Individual Houses, Industrial areas, Public Places, Commercial Outlets, etc., who will be assigned to govern and monitor the standards derived by the Government of Tamil Nadu.</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">So, enroll yourself with Dharan School of Paramedical Sciences and be a sound &lsquo;Health Care Professional&rsquo; to serve the community.</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">For any further academic related queries, please contact <b>dihs.dect@gmail.com</b> or <b>coo@dharanhospital.com / 95850 - 69990</b></p>\n" +
            "</body></html>";
        break;
      case "Dharan Institute of Health Sciences (DIHS)":
        data = "\n" +
            "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /><body style=\"text-align:justify;color: #444444;font-size: 15px;\">\n" +
            "<img src=\"file:///android_asset/flutter_assets/assets/health_science.png\"style=\"width:100%;\"><br><br>\n" +
//                       <!-- "<div style=\"text-align:center\"><a style=\"color: #fff;text-align:center;background-color: #d9534f;border-color: #d43f3a;display: inline-block;padding: 6px 12px;margin-bottom: 0;font-size: 14px;font-weight: normal;line-height: 1.42857143;text-align: center;white-space: nowrap;vertical-align: middle;border: 1px solid transparent;border-radius: 4px;\" href=\"file:///android_asset/flutter_assets/assets/go-health-science.jpg\">Goverment Order Copy </a></div><br>\n" +-->
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Dharan Institute of Health Sciences is the educational division of Dharan Educational Charitable Trust, with a primary vision of conducting wide range of exclusive health care oriented education programs. This &lsquo;Health Sciences&rsquo; division is associated with Dr. MGR Medical University in terms of conducting Allied Health Science programs uder B.Sc Degree. This is a 3 + 1 year program, covering 3 years of Academic &amp; Practical and 1 year of Internship.</p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Health awareness got hyped in recent years due to life style modification that makes people depend more on packed products. Moreover, manufacturing Industries that exhaust chemical gas and let out of waste fluids and natural calamities like rain, flood, twisters has staged the need of &lsquo;Health Care&rsquo; service professional need across India and World. </p>\n" +
            " \n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">Dharan Institute of Health Sciences is exclusively focused in educating and guiding the next generation youngsters towards the most demanding and needed &ldquo;Health Care&rdquo; service jobs. Students will be well trained to address the society, through their professional approach learning and quality standards practices that has been thought throughout the program.  </p>\n" +
            " \n" +
            "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table table-bordered\" style=\"width:100%;max-width:100%;margin-bottom:20px;border-collapse:collapse;border-spacing:0;border:1px solid #ddd;\"><tbody>\n" +
            "<tr>\n" +
            "<td style=\"padding: 6px 10px;border:1px solid #ddd;\" align=\"center\" valign=\"top\" colspan=\"2\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><u class=\"courses_color\">Dharan Institute of Health Sciences (DIHS)</u></p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "<tr valign=\"top\">\n" +
            "<td align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Cardiac Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Operation Theatre &amp; Anesthesia Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Critical Care Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>B.Sc\n" +
            "Dialysis Technology</b></p>\n" +
            "</td>\n" +
            "<td align=\"center\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Diploma\n" +
            "in Health Care Aide</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Diploma\n" +
            "in Scope Support Technology</b></p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\"><b>Diploma\n" +
            "in Radiology Imaging Technology</b></p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "<tr>\n" +
            "<td align=\"center\" valign=\"top\" colspan=\"2\" style=\"padding: 6px 10px;border:1px solid #ddd;\">\n" +
            "<p align=\"center\" style=\"line-height: 28px;margin: 0 0 10px;\">Affiliated with Dr. MGR Medical University. Chennai.</p>\n" +
            "</td>\n" +
            "</tr>\n" +
            "</tbody></table><br>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">So, enroll yourself with Dharan Institute of Health Sciences and be a part of &lsquo;Health Care&rsquo; Service provider to support the  community.</p>\n" +
            "<p style=\"line-height: 28px;margin: 0 0 10px;\">For any further academic related queries, please contact <a href=\"mailto:dsps.dect@gmail.com\">dsps.dect@gmail.com</a> or <a href=\"mailto:coo@dharanhospital.com\">coo@dharanhospital.com</a> / <a href=\"tel:+919585069990\">9585069990</a></p>\n" +
            "</body></html>\n";
        break;
    }
    return data;
  }
}
