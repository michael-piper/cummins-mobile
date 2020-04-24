import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:cummins/utils/helper.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/ext/smallcard.dart';
import 'package:cummins/ext/tablebuilder.dart';
// import service here
import 'package:cummins/services/auth.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title="Profile"}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AuthService>(
      builder: (context, authService, child){
        List<Map<String,dynamic>>links=[
          {'avatar':'assets/icons/faq.png','title':'FAQ','onTap':(){
            Navigator.of(context).pushNamed('/faq').then((val){
              Helper.changeStatusBar(StatusBarType.DEFAULT);
            });
          }},
          {'avatar':'assets/icons/feedback.png','title':'Feedback','onTap':(){
            Navigator.of(context).pushNamed('/feedback').then((val){
              Helper.changeStatusBar(StatusBarType.DEFAULT);
            });
          }},
          {'avatar':'assets/icons/logout.png','title':'Logout','onTap':(){
            authService.logout();
          }},
          {'avatar':'assets/icons/info.png','title':'About','link':''},
          {'avatar':'assets/icons/notification.png','title':'Notification','onTap':(){
            Navigator.of(context).pushNamed('/notification').then((val){
              Helper.changeStatusBar(StatusBarType.DEFAULT);
            });
          }},
          {'avatar':'assets/icons/person.png','title':'View Profile','onTap':(){
            Navigator.of(context).pushNamed('/profile-details').then((val){
              Helper.changeStatusBar(StatusBarType.DEFAULT);
            });
          }},
          {'avatar':'assets/icons/settings.png','title':'Settings','onTap':(){
            Navigator.of(context).pushNamed('/settings').then((val){
              Helper.changeStatusBar(StatusBarType.DEFAULT);
            });
          }},
        ];
        return Stack(
          children: <Widget>[
            Container(
              color: primaryColor,
              width: MediaQuery.of(context).size.width,
              height: 240,
            ),
            Positioned(
              top:0,
              width: MediaQuery.of(context).size.width-50,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                        height: 200,
                        child:Padding(
                          padding: EdgeInsets.all(10),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed('/profile-details').then((val){
                                    Helper.changeStatusBar(StatusBarType.DEFAULT);
                                  });
                                },
                                child: SizedBox(
                                  width:120.0,
                                  height: 120.0,
                                  child: CircleAvatar(backgroundImage:AssetImage('assets/images/profile.png'),),
                                ),
                              ),
                              Text('Ademola Cole',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text('UBA groups',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                        child:Padding(
                            padding: EdgeInsets.all(10),
                            child:TableBuilder(links.map((link){
                              return  SmallCard(
                                avatar: link['avatar'],
                                name: link['title'],
                                height: 31,
                                width: 31,
                                link: link.containsKey('link')? link['link']:null,
                                onTap: link.containsKey('onTap')? link['onTap']:null,
                              );
                            }).toList(),column:3)
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }
    );

  }
}