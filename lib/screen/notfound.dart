import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:flutter/rendering.dart';
import 'package:cummins/utils/helper.dart';
class NotFoundPage extends StatefulWidget {
  NotFoundPage({Key key,this.title:"Page Not Found"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _NotFoundState createState() => _NotFoundState();
}
class _NotFoundState extends State<NotFoundPage>  {
  @override
  void initState() {
    Helper.changeStatusBar(StatusBarType.LIGHT);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  buildBody(BuildContext context){
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child:Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                ),
                child:ListTile(
                  title: Text('Pay not found'),
                )
            )
        )
      ],
    );
  }
  appBar(BuildContext context){
    return AppBar(
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child:Row(
              children: <Widget>[
                IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){
                  Navigator.of(context).pop(true);
                },),
                Text(widget.title,style: TextStyle(color: liteTextColor,fontSize: 20,fontWeight: FontWeight.w600),)
              ],
            ),
          )
      ),
      leading: Container(),
      elevation: 0,
      backgroundColor: liteColor,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: liteTextColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),// here the desired height
            child: appBar(context)
        ),
        body: buildBody(context) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
