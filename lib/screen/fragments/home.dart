import 'package:cummins/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 5),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          OptionsCard(
            onTap: (){
              Navigator.of(context).pushNamed('/make-payment');
            },
            title:"Make Payments",
            subtitle: "You can pay for generators, service, parts or engines",
            backgroundImage: AssetImage('assets/images/make-payment.png',),),
          SizedBox(height: 10,),
          OptionsCard(
            onTap: (){
              Navigator.of(context).pushNamed('/request-for-service');
            },
            title:"Request for Services",
            subtitle: "You can make a request for generator service",
            backgroundImage: AssetImage('assets/images/request-service.png',),),
          SizedBox(height: 40,),
          Padding(padding: EdgeInsets.only(left: 20,right: 50),child: OptionsTryNow())
        ],
      ),
    );
  }
}

class OptionsCard extends StatelessWidget{
  OptionsCard({Key key, this.backgroundImage, this.title='', this.subtitle='', this.onTap}) : super(key: key);
  final ImageProvider backgroundImage;
  final String title;
  final String subtitle;
  final Function onTap;
  final  TextStyle titleTextStyle=TextStyle(color: primaryTextColor,fontSize:18, fontWeight: FontWeight.w700);
  final TextStyle subtitleTextStyle=TextStyle(color: primaryTextColor, fontSize:14, fontWeight: FontWeight.w700 );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImage,fit: BoxFit.fill),
        ),
        width: MediaQuery.of(context).size.width,
        height: 130,
        child:Padding(
          padding: EdgeInsets.symmetric(vertical: 4,horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(title,style: titleTextStyle,),
              SizedBox(
                  width: 250,
                  child: Text(subtitle,style: subtitleTextStyle,)
              )
            ],
          ) ,
        ),
      ),
    );
  }
}

class OptionsTryNow extends StatelessWidget{
    OptionsTryNow({Key key,}) : super(key: key);
    @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color.fromRGBO(191, 0, 0, 0.06),
        ),
        constraints: BoxConstraints(
          maxWidth: 200,
          minWidth: 200
        ),
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Load Calculator',style: TextStyle(color: primaryColor,fontSize: 15,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                SizedBox(width: 100,child: Text('Find out the generator capacity you need.',style: TextStyle(fontSize: 9,),),),
                SizedBox(height: 10,),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: primarySwatch)
                  ),
                  color: primaryColor,
                  onPressed: (){
                    Navigator.of(context).pushNamed('/load-calculator');
                  },
                  child: Text('Try Now',style: TextStyle(color: primaryTextColor),),
                )
              ],
            ),
            Center(
                child: Image.asset('assets/images/calculator-illustration.png',width: 200,height: 100,),
            ),
          ],
        ),
    );
  }
}