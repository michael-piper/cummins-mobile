import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/utils/constants.dart';
class PaymentPage extends StatefulWidget {
  PaymentPage({Key key, this.title="Payment History"}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {
  List<Map<String,dynamic>>lists=[
    {'title':'Quotation #100000','createdAt':'3rd Jul, 2019','amount':'${CURRENCY['sign']} 200 000.00'},
    {'title':'Quotation #100000','createdAt':'3rd Jul, 2019','amount':'${CURRENCY['sign']} 200 000.00'},
    {'title':'Invoice #100005','createdAt':'3rd Jul, 2019','amount':'${CURRENCY['sign']} 200 000.00'},
    {'title':'Quotation #100000','createdAt':'3rd Jul, 2019','amount':'${CURRENCY['sign']} 200 000.00'},
  ];
  static Widget paymentList(Map<String,dynamic> list){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child:  Card(
          child: ListTile(
            title:Text('${list['title']}',style: TextStyle(color: noteColor,fontSize: 18,fontWeight: FontWeight.w600),),
            subtitle: Text('${list['createdAt']}',style: TextStyle(color: noteColor,fontSize: 15,fontWeight: FontWeight.normal),),
            trailing:  Text('${list['amount']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: lists.map<Widget>(paymentList).toList()
    );
  }
}