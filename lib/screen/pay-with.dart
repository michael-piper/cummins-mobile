import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/utils/helper.dart';
import 'package:cummins/utils/constants.dart';
String backendUrl = '{YOUR_BACKEND_URL}';
class PayWithPage extends StatefulWidget {
  PayWithPage({Key key,this.title:"PAY WITH"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _PayWithState createState() => _PayWithState();
}
class _PayWithState extends State<PayWithPage>  {
  @override
  void initState() {
    Helper.changeStatusBar(StatusBarType.LIGHT);
    // TODO: implement initState
    super.initState();
    PaystackPlugin.initialize(
        publicKey: PAYSTACT_PUBLIC_KEY);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  _getReference(){
    return "123333223";
  }
  Future<String> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code';
    String accessCode="123456";
//    try {
//      print("Access code url = $url");
//      http.Response response = await http.get(url);
//      accessCode = response.body;
//      print('Response for access code = $accessCode');
//    } catch (e) {
//    }
    return accessCode;
  }
  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: "",
      cvc: "",
      expiryMonth: 10,
      expiryYear: 12,
    );
  }
  _chargeBank()async{
    var accessCode = await _fetchAccessCodeFrmServer(_getReference());
    Charge charge = Charge()
      ..amount = 10000
      ..reference = _getReference()
      ..email = 'customer@email.com'
      ..accessCode = accessCode;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.bank, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if(response.status){

    }else{

    }
  }


  _chargeCard()async {

    Charge charge = Charge()
      ..amount = 10000
      ..reference = _getReference()
      ..email = 'customer@email.com';
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if(response.status){
      handleOnSuccess(response);
    }else{
      handleOnError(response);
    }
  }

  handleBeforeValidate(CheckoutResponse transaction) {
    // This is called only before requesting OTP
    // Save reference so you may send to server if error occurs with OTP
  }

  handleOnError(CheckoutResponse transaction) {
    // If an access code has expired, simply ask your server for a new one
    // and restart the charge instead of displaying error
  }

  handleOnSuccess(CheckoutResponse transaction) {
    // This is called only after transaction is successful
  }

  buildBody(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 4),
            child:Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                ),
                child:ListTile(
                  onTap: (){
                    _chargeCard();
                  },
                  leading: Icon(Icons.credit_card,size: 30,),
                  title: Text('Card'),
                )
            )
        ),
        Padding(
            padding: EdgeInsets.only(top: 4),
            child:Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                ),
                child:ListTile(
                  onTap: (){
                    _chargeBank();
                  },
                  leading: Icon(Icons.account_balance,size: 30,),
                  title: Text('Bank'),
                )
            )
        ),
        SizedBox(
          height:100 ,
        ),
        Expanded(
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Powered by"),
                Image(
                  image: AssetImage('assets/icons/paystack.png'),
                )
              ],
            ),
          ),
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
