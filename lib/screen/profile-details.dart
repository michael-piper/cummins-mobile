import 'dart:io';
import 'package:cummins/ext/spinner.dart';
import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/utils/helper.dart';
import 'package:image_picker/image_picker.dart';
class ProfileDetailsPage extends StatefulWidget {
  ProfileDetailsPage({Key key,this.title:"Profile Details"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}
class _ProfileDetailsState extends State<ProfileDetailsPage>  {
  String _editing;
  bool _saving;
  File _image;
  @override
  void initState() {
    Helper.changeStatusBar(StatusBarType.LIGHT);
    // TODO: implement initState
    super.initState();
    _saving=false;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    edit(name: "image");
    setState(() {
      _image = image;
    });
  }

  edit({@required String name}){
    setState(() {
      _editing=name;
    });
  }
  editing({String name, bool notNil=false}){
    if(notNil)return _editing!=null;
    return _editing==name;
  }
  bool saving({bool status}){
    if(status == null){
      return _saving;
    }else{
      setState(() {
        _saving = status;
      });
      return status;
    }

  }
  save(){
    f(){
      if(_image!=null){
        setState(() {
          _image=null;
        });
      }
      edit(name: null);
      saving(status: false);
    }
    saving(status: true);
    Future.delayed(Duration(seconds: 10),f);
  }
  formContent(BuildContext context){
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Name"
          ),
          SizedBox(height: 3,),
          TextFormField(
            autocorrect: true,
            onTap: ()=>edit(name:'name'),
            decoration: InputDecoration(
                hintText: "Name",
                suffixIcon:
                saving()?Spinner(icon: Icons.refresh):editing(name:'name')?SizedBox():IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    edit(name:'name');
                  },
                )
            ),
          ),
          SizedBox(height: 10,),
          Text(
              "Company"
          ),
          SizedBox(height: 3,),
          TextFormField(
            autocorrect: true,
            onTap: ()=>edit(name:'company'),
            decoration: InputDecoration(
              hintText: "Company",
              suffixIcon: saving()?Spinner(icon: Icons.refresh):editing(name:'company')?SizedBox():IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){
                  edit(name:'company');
                },
              )
            ),
          ),
          SizedBox(height: 10,),
          Text(
              "Phone"
          ),
          SizedBox(height: 3,),
          TextFormField(
            autocorrect: true,
            decoration: InputDecoration(
                hintText: "Phone",
                filled: true,
                fillColor: textFillColor
            ),
          ),
          SizedBox(height: 10,),
          Text(
              "Email"
          ),
          SizedBox(height: 3,),
          TextFormField(
            autocorrect: true,
            decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: textFillColor
            ),
          ),
          SizedBox(height: 10,),
          Text(
              "Customer Code"
          ),
          SizedBox(height: 3,),
          TextFormField(
            autocorrect: true,
            decoration: InputDecoration(
                hintText: "Customer Code",
                filled: true,
                fillColor: textFillColor
            ),
          ),
          SizedBox(height: 30,),
//          MaterialButton(
//              padding: EdgeInsets.symmetric(vertical: 15),
//              color: primaryColor,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.vertical(
//                      top: Radius.elliptical(30.0,30.0),
//                      bottom: Radius.elliptical(30.0,30.0)
//                  ),
//                  side: BorderSide(color: primarySwatch)
//              ),
//              child: Text("Submit",style:TextStyle(color: primaryTextColor)),
//              onPressed: () {
//
//              }
//          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: CircleAvatar(
                  backgroundImage:_image==null?AssetImage('assets/images/profile.png'):FileImage(_image),
                  child: (saving() && _image!=null)?Spinner(icon: Icons.refresh):SizedBox(),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    getImage();
                  },
                  child:Text('Change Profile picture',style: TextStyle(color: actionColor,decoration:TextDecoration.underline),),
                ),
              )
            ],
          ),
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
            child:Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: bodyContent(context)
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
                IconButton(
                  icon:Icon(Icons.arrow_back_ios),
                    onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                ),
                Expanded(
                  child: Text(widget.title,style: TextStyle(color: liteTextColor,fontSize: 20,fontWeight: FontWeight.w600),),
                ),
                editing(notNil: true)?InkWell(onTap:save,child: Text("Save",style: TextStyle(color: primaryColor),),): SizedBox(),
                SizedBox(width: 15,),
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
