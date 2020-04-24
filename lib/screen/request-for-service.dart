import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:flutter/rendering.dart';
import 'package:cummins/utils/helper.dart';
class RequestForServicePage extends StatefulWidget {
  RequestForServicePage({Key key,this.title:"Request For Service"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _RequestForServiceState createState() => _RequestForServiceState();
}
class _RequestForServiceState extends State<RequestForServicePage>  {
  @override
  void initState() {
    Helper.changeStatusBar(StatusBarType.DEFAULT);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  formContent(BuildContext context) {
    return  Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Name", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          TextFormField(
            expands: false,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "Name",
              suffixIcon: Icon(Icons.arrow_drop_down)
            ),
          ),
          SizedBox(height: 10,),
          Text("Description", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          TextFormField(
            expands: false,
            autocorrect: true,
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(
                hintText: "Describe your generator problem",
                filled: true,
                fillColor: textFillColor
            ),
          ),
          SizedBox(height: 10,),
          Text("Usage/Run hours  ( Daily )", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          TextFormField(
            expands: false,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "Usage/Run hours",
              suffixIcon: Icon(Icons.arrow_drop_down)
            ),
          ),
          SizedBox(height: 30,),
          MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 15),
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(30.0,30.0),
                    bottom: Radius.elliptical(30.0,30.0)
                ),
                side: BorderSide(color: primarySwatch)
            ),
            child: Text("Request",style:TextStyle(color: primaryTextColor)),
            onPressed: () {

            }
          ),
        ],
      ),
    );
  }
  bodyContent(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 25,),
          formContent(context),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
  buildBody(BuildContext context){
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: bodyContent(context)
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
                IconButton(icon:Icon(Icons.arrow_back_ios,color: primaryTextColor,),onPressed: (){
                  Navigator.of(context).pop(true);
                },),
                Text(widget.title,style: TextStyle(color: primaryTextColor,fontSize: 20,fontWeight: FontWeight.w600),)
              ],
            ),
          )
      ),
      leading: Container(),
      elevation: 0,
      backgroundColor: primaryColor,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: primaryTextColor),
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
