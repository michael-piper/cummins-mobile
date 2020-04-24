import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/utils/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:cummins/utils/helper.dart';
class MakePaymentPage extends StatefulWidget {
  MakePaymentPage({Key key,this.title:"Make Payment"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MakePaymentState createState() => _MakePaymentState();
}
class _MakePaymentState extends State<MakePaymentPage>  {
  List<String>types;
  List<String>referenceTypes;
  Map<String,String> _form;
  @override
  void initState() {
    Helper.changeStatusBar(StatusBarType.DEFAULT);
    // TODO: implement initState
    super.initState();
    types=[
      'Payment for Generators',
      'Payment for Service',
      'Payment for Parts',
      'Payment for Engine'
    ];
    referenceTypes=[
      'Quotation',
      "Last"
    ];
    _form={
      'type':null,
      'reference_type':null
    };
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
          Text("Type", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          DropdownButtonFormField(
            items: types.map((e)=>DropdownMenuItem(value: e,child: Text(e),)).toList(),
            onChanged: (_) {
              // do other stuff with _category
              setState(() => _form['type'] = _);
            },
            isExpanded: true,
            hint: Text("Select Type"),
            value: _form['type'],
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(1, 2, 1, 2),
            )
          ),
          SizedBox(height: 10,),
          Text("Reference Type", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          DropdownButtonFormField(
            items: referenceTypes.map((e)=>DropdownMenuItem(value: e,child: Text(e),)).toList(),
            onChanged: (_) {
              // do other stuff with _category
              setState(() => _form['reference_type'] = _);
            },
            isExpanded: true,
            hint: Text("Select Type"),
            value: _form['reference_type'],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(1, 2, 1, 2),
            )
          ),
          SizedBox(height: 10,),
          Text("Reference no", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          TextFormField(
            expands: false,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "Enter Number",
            ),
          ),
          SizedBox(height: 10,),
          Text("Amount ( ${CURRENCY['name']} )", style: TextStyle(fontSize: 14),),
          SizedBox(height: 3,),
          TextFormField(
            expands: false,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "Enter Amount",
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
              child: Text("Proceed to Payment",style:TextStyle(color: primaryTextColor)),
              onPressed: () {
                Navigator.of(context).pushNamed('/pay-with').then((v)=>Helper.changeStatusBar(StatusBarType.DEFAULT));
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
