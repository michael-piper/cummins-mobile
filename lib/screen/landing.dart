import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cummins/utils/colors.dart';
import 'package:cummins/utils/helper.dart';
import 'package:cummins/screen/fragments/home.dart';
import 'package:cummins/screen/fragments/profile.dart';
import 'package:cummins/screen/fragments/payment.dart';
class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _LandingState createState() => _LandingState();
}
class _LandingState extends State<LandingPage> {
  static int initialPage = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();
  PageController _pageController = PageController(
    initialPage: initialPage,
  );
  List _pages=[];
  int _index=initialPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.changeStatusBar(StatusBarType.DEFAULT);
    _pages=[
      PaymentPage(),
      HomePage(),
      ProfilePage()
    ];
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    String title = _pages[_index].title;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),// here the desired height
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: title==null?Text(''):Center(child: Text(title,style: TextStyle(color: primaryTextColor,fontSize: 20,fontWeight: FontWeight.w600),),),
            )
          ),
          elevation: 0,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: primaryTextColor),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/icons/x.png',width: 50,height: 50),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index){
          final CurvedNavigationBarState navBarState = _bottomNavigationKey.currentState;
          navBarState.setPage(index);
        },
        children: _pages.map<Widget>((e)=>e).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: CurvedNavigationBar(
          backgroundColor: Colors.grey,
          key:_bottomNavigationKey,
          index: initialPage,
          height: 46,
          items: <Widget>[
            Padding(padding:EdgeInsets.all(5),child:Column(children: <Widget>[Icon(Icons.credit_card, size: 30),Text('Payment')],),),
            Padding(padding:EdgeInsets.all(5),child:Column(children: <Widget>[Icon(Icons.home, size: 30),Text('Home')],),),
            Padding(padding:EdgeInsets.all(5),child:Column(children: <Widget>[Icon(Icons.person, size: 30),Text('Profile')],),),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              _pageController.jumpToPage(index);
              _index=index;
            });
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
