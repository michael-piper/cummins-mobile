// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
// import service here
import 'package:cummins/services/auth.dart';
// import color
import 'package:cummins/utils/colors.dart';
import 'package:cummins/utils/helper.dart';
import 'package:cummins/ext/smartalert.dart';
import 'package:cummins/ext/dialogman.dart';
/// This Widget is the main application widget.
class AuthPage extends StatelessWidget {
  // static const String _title = 'Welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  _MyStatefulWidgetState(){
    _text_controller.text=_username;
    tryRemember();
  }
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  final String _rememberme_key = "@login-remeberme";
  int _screen=1;
  bool _loading=false;
  bool _eye_signup=true;
  bool _eye_signin=true;
  bool _rememberme=false;
  final TextEditingController _text_controller = TextEditingController();
  Map<String, String> _signUpData={'firstname':'','lastname':'','fullname':'','country':null,'company':'','email':'','phone':'','password':'','confirm_password':'','remeberme':'0'};

  final DialogMan dialogMan = DialogMan(child: Scaffold(
      backgroundColor: Colors.transparent,
      body:Center(
          child:CircularProgressIndicator()
      )
  ));
  @override
  void initState(){
    super.initState();
    Helper.changeStatusBar(StatusBarType.DEFAULT);
  }
  tryRemember()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.get(_rememberme_key);
    if(data!=null){
//      print('$data');
      setState(() {
        _username=data;
        _text_controller.text=data;
        _rememberme=true;
      });
    }
  }
  updateRememberMe(value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_rememberme_key, value).then((val){
//      print('$val');
    });
  }
  Widget login(authService){
    return  Container(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Form(
          key: _formKey,
          child:Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(padding:EdgeInsets.only(top: 20),),
                  Text(
                    'Login',
                    style: TextStyle(fontFamily: "Lato",fontStyle:FontStyle.normal,fontWeight: FontWeight.w600,fontSize: 20),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _text_controller,
                    onSaved: (value)=> _username = value,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person,color: secondaryTextColor),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color:  secondaryTextColor,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) => _username = v,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your username or email';
                      }
                      return null;
                    },
                  ),
                  Stack(
                      alignment: Alignment(1.0,0.0), // right & center
                      children: <Widget>[
                        TextFormField(

                          obscureText: _eye_signin,
                          initialValue: _password,
                          onSaved: (value)=> _password = value,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: secondaryTextColor),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: secondaryTextColor,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (v) => _password = v,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Positioned(
                            child:IconButton(
                              icon: Icon(_eye_signin?Icons.visibility_off:Icons.visibility,color: secondaryTextColor),
                              onPressed: (){
                                setState(() {
                                  _eye_signin=!_eye_signin;
                                });
                              },
                            )
                        )
                      ]
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value:_rememberme,
                        onChanged: (v){
                          setState((){_rememberme=!_rememberme;});
                        },),
                      Expanded(
                        child: InkWell(

                          onTap: (){
                            if(_loading) {
                              return;
                            }
                            setState((){_rememberme=!_rememberme;});
                          },
                          child: Text("Remember me",
                            style: TextStyle(
                              color:  actionColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height:25.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text("")),
                      InkWell(

                        onTap: (){
                          if(_loading) {
                            return;
                          }
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPasswordScreen(),),).then((_)=>Helper.changeStatusBar(StatusBarType.DEFAULT));
                        },
                        child: Text("Forgot Password?",
                          style: TextStyle(
                            color:  actionColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
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
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid
                      final form = _formKey.currentState;
                      form.save();


                      if (_formKey.currentState.validate()) {
                        if(_loading){
                          return;
                        }
                        setState(() {
                          _loading=true;
                        });
                        if(_rememberme){
                          updateRememberMe(_username);
                        }
                        var wait=authService.loginUser(username: _username, password: _password);
                        wait.then((status){
                          setState(() {
                            _loading=false;
                          });

                          if(status == null){
                            return  Scaffold.of(context).showSnackBar(SnackBar(content:Text('Invalid username number')));
                          }
                          else if(status == false){
                            return  Scaffold.of(context).showSnackBar(SnackBar(content:Text("Internet error")));
                          }
                          else if(status != true){
                            return Scaffold.of(context).showSnackBar(SnackBar(content:Text(status)));
                          }
                          return null;
                        }).catchError((e)=>print(e));
                      }
                    },
                    child: Text((_loading?'loading...':'Login'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don’t have an account?"),
                      InkWell(
                        onTap: (){
                          if(_loading) {
                            return;
                          }
                          setState(() {
                            // Process data.
                            _screen=2;
                          });
                        },
                        child: Text(" Register",
                          style: TextStyle(
                            color:  actionColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
          ),
        )
    );
  }
  Widget signUp(authService){
    return Container(
        child: Form(
          key: _formKey,
          child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(padding:EdgeInsets.only(top: 20),),
                    Text(
                      'Create Account',
                      style: TextStyle(fontFamily: "Lato",fontStyle:FontStyle.normal,fontWeight: FontWeight.normal,fontSize: 20),

                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: _signUpData['fullname'] ,
                      onSaved: (value)=> _signUpData['fullname'] = value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person,color: secondaryTextColor),
                        labelText: 'Full name',
                        labelStyle: TextStyle(
                          color: secondaryTextColor,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      // textInputAction: TextInputAction.continueAction,
                      onChanged: (v) => _signUpData['fullname'] = v,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _signUpData['email'] ,
                      onSaved: (value)=> _signUpData['email'] = value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email,color: secondaryTextColor),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color:  secondaryTextColor,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      // textInputAction: TextInputAction.continueAction,
                      onChanged: (v) => _signUpData['email'] = v,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      key: UniqueKey(),
                      initialValue: _signUpData['phone'],
                      onSaved: (value)=> _signUpData['phone'] = value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.call,color: secondaryTextColor),
                        labelText: 'Phone number',
                        labelStyle: TextStyle(
                          color:  secondaryTextColor,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      // textInputAction: TextInputAction.continueAction,
                      onChanged: (v) => _signUpData['phone'] = v,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    Stack(
                        alignment: Alignment(1.0,0.0), // right & center
                        children: <Widget>[
                          TextFormField(
                            obscureText: _eye_signup,
                            initialValue:  _signUpData['password'],
                            onSaved: (value)=> _signUpData['password'] = value,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock,color: secondaryTextColor),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color:  secondaryTextColor,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            // textInputAction: TextInputAction.continueAction,
                            onChanged: (v) => _signUpData['password'] = v,
                            validator: (value) {
                              if (value.isEmpty ) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          Positioned(
                              child:IconButton(
                                icon: Icon(_eye_signup?Icons.visibility_off:Icons.visibility,color: secondaryTextColor),
                                onPressed: (){
                                  setState(() {
                                    _eye_signup=!_eye_signup;
                                  });
                                },
                              )
                          )
                        ]
                    ),
                    TextFormField(
                      initialValue: _signUpData['company'] ,
                      onSaved: (value)=> _signUpData['company'] = value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person,color: secondaryTextColor,),
                        labelText: 'Company',
                        labelStyle: TextStyle(
                          color: secondaryTextColor,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      // textInputAction: TextInputAction.continueAction,
                      onChanged: (v) => _signUpData['company'] = v,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your company name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _signUpData['customer_code'] ,
                      onSaved: (value)=> _signUpData['customer_code'] = value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person,color: secondaryTextColor,),
                        labelText: 'Customer Code',
                        labelStyle: TextStyle(
                          color: secondaryTextColor,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      // textInputAction: TextInputAction.continueAction,
                      onChanged: (v) => _signUpData['customer_code'] = v,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your customer code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value:_signUpData['remeberme']=='1'?true:false,
                          onChanged: (v)=>setState((){
                            _signUpData['remeberme']=v?'1':'0';
                          }),
                        ),
                        Text("i Agree to the terms ",
                          style: TextStyle(
                            color:  secondaryTextColor,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if(_loading) {
                              return;
                            }
                            //                                  setState(() {
                            //                                    // Process data.
                            //                                    _screen=3;
                            //                                  });
                          },
                          child: Text("Terms of Service",
                            style: TextStyle(
                              color:  actionColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
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
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        final form = _formKey.currentState;
                        form.save();

                        if (_formKey.currentState.validate()) {
                          if(_loading) {
                            return;
                          }
                          setState(() {
                            _loading=true;
                          });
                          _signUpData['fullname']=_signUpData['firstname']+' '+_signUpData['lastname'];
                          var wait=authService.createUser(_signUpData);
                          wait.then((status){
                            setState(() {
                              _loading=false;
                            });

                            if(status == null){
                              return  Scaffold.of(context).showSnackBar(SnackBar(content:Text('Invalid username number')));
                            }
                            else if(status == false){
                              return  Scaffold.of(context).showSnackBar(SnackBar(content:Text("Internet error")));
                            }
                            else if(status != true){
                              return Scaffold.of(context).showSnackBar(SnackBar(content:Text(status)));
                            }
                            setState(() {
                              // Process data.
                              _screen=1;
                            });
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Welcome '+_signUpData['fullname']),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('Your account have been created.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          );
                        }
                      },
                      child: Text(
                        (_loading?'loading...':'Create'),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an Account?"),
                        InkWell(

                          onTap: (){
                            if(_loading) {
                              return;
                            }
                            setState(() {
                              // Process data.
                              _screen=1;
                            });
                          },
                          child: Text(" Login",
                            style: TextStyle(
                              color:  actionColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,

                    ),
                  ]
              )
          )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    dialogMan.buildContext(context);
    Widget buildBody(_body) {
      return Stack(
        fit:StackFit.expand,
        children: <Widget>[
          Positioned(
            bottom: 0,
            height: 150,
            child: Image(
              image: AssetImage('assets/images/login-bottom.png'),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 0,
            height: 150,
            child: Image(
              image: AssetImage('assets/icons/x.png'),
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            child: ListView(
              shrinkWrap: false,
              children: <Widget>[
                _body,
              ],
            ),
          ),
        ],
      );

    }
    switchScreen(authService) {
      switch (_screen) {
        case 2:
          {
            return signUp(authService);
          }
          break;
        default:
          {
            return login(authService);
          }
          break;
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),// here the desired height
        child: AppBar(
            elevation: 0,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: primaryTextColor),
        ),
      ),
      body:Consumer<AuthService>(
        builder: (context, authService, child){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: buildBody(switchScreen(authService)),
          );
        },
      )
    );
  }
}


class ForgetPasswordScreen extends StatefulWidget{
  _ForgetPasswordScreen createState()=>_ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen>{
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;
  String _forgotDetails;
  void initState(){
    super.initState();
    Helper.changeStatusBar(StatusBarType.LIGHT);
  }
  Widget forgotPassword(authService){
    return Container(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
        child: Form(
          key: _formKey,
          child:Padding(
              padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(padding:EdgeInsets.only(top: 20),),
                  Center(
                    child: Image(
                        image: AssetImage('assets/icons/reset.png'),
                        width: 165,
                        height: 160.05
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(fontFamily: "Lato",fontStyle:FontStyle.normal,fontWeight: FontWeight.w600,fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'No problem! \nJust enter your email address and we\’ll send you a \npassword reset link',
                    style: TextStyle(color:noteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(

                    initialValue:_forgotDetails ,
                    onSaved: (value)=> _forgotDetails = value,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person,color: secondaryTextColor),
                      labelText: 'Email or Phone',
                      labelStyle: TextStyle(
                        color:  secondaryTextColor,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) => _forgotDetails = v,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your phone or email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 25,
                  ),
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
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid
                      final form = _formKey.currentState;
                      form.save();


                      if (_formKey.currentState.validate()) {
                        if(_loading){
                          return;
                        }
                        setState(() {
                          _loading=true;
                        });
                        var wait=authService.forgotPassword(phone: _forgotDetails);
                        wait.then((status){
                          setState(() {
                            _loading=false;
                          });

                          if(status == null){
                            return showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context ){
                                  return SmartAlert(title:'Alert',description: "Invalid user details");
                                }
                            );
                          }
                          else if(status == false){
                            return showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context ){
                                  return SmartAlert(title:'Alert',description: "Internet error");
                                }
                            );
                          }
                          else if(status != true){
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context ){
                                  return SmartAlert(title:'Alert',description: status);
                                }
                            );
                          }
                          return null;
                        });
                      }
                    },
                    child: Text((_loading?'loading...':'Reset'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              )
          ),
        )
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
    // TODO: implement build
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),// here the desired height
            child: appBar(context)
        ),
        backgroundColor:primaryTextColor,
        body:Consumer<AuthService>(
        builder: (context, authService, child){
          return ListView(
            children: <Widget>[
              forgotPassword(authService)
            ],
          );
        }
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}