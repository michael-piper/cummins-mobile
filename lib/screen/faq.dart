
import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:flutter/rendering.dart';
import 'package:cummins/utils/helper.dart';
class FAQPage extends StatefulWidget {
  FAQPage({Key key,this.title:"FAQ"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _FAQState createState() => _FAQState();
}
class _FAQState extends State<FAQPage>  {
  String _title="FAQ";
  String _description="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ";
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
  buildFAQ(){

  }
  buildBody(BuildContext context){
    return ListView(
      children:List.generate (5, (index){
          return FAQItem(title: _title,description: _description);
      }),
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

class FAQItem extends StatefulWidget{
  FAQItem({Key key,this.title="",this.description=""}): super(key: key);
  final String title;
  final String description;
  @override
  _FAQItem createState() => _FAQItem();
}
class _FAQItem extends State<FAQItem>{
  bool open=false;
  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.only(top: 1),
        child:Card(
          color: open?Color.fromRGBO(251, 240, 240, 1):liteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))
            ),
            child: ExpansionTile(
              title: Text(widget.title,style: TextStyle(color: primaryColor),),
              onExpansionChanged: (_)=>setState((){open=_;}),
              children:<Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.description),
                )
              ],
            )
        )
    );
  }
}
