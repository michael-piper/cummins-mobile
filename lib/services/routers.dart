import 'package:cummins/screen/notfound.dart';
import 'package:cummins/screen/pay-with.dart';
import 'package:flutter/material.dart';
import 'package:cummins/screen/landing.dart';
import 'package:cummins/screen/splash.dart';
import 'package:cummins/screen/auth.dart';
import 'package:cummins/screen/feedback.dart';
import 'package:cummins/screen/notification.dart';
import 'package:cummins/screen/settings.dart';
import 'package:cummins/screen/profile-details.dart';
import 'package:cummins/screen/request-for-service.dart';
import 'package:cummins/screen/make-payment.dart';
import 'package:cummins/screen/faq.dart';
import 'package:cummins/screen/load-calculator.dart';
class Routers{
  static landing(snapshot){
    if(snapshot.connectionState==ConnectionState.done){
      if(snapshot.hasData){
        if(snapshot.data['Role']!=null && snapshot.data['Role']['name']=="Driver"){
          return LandingPage();
        }else{
          return LandingPage();
        }
      }else{
        return AuthPage();
      }
    }else{
      return SplashPage();
    }
  }
  static splash(){
    return SplashPage();
  }
  static generatedRoutes(settings){
    List data=settings.name.split('/');
    if(data.length<=1) return;
    if(data[1]=='landing' && data[2]!=null) {
      return MaterialPageRoute(builder: (context) {
        return LandingPage();
      });
    }
    else{
      return MaterialPageRoute(builder: (context){
        return LandingPage();
      });
    }
  }
  static routes(){
    return <String, WidgetBuilder> {
      '/landing': (BuildContext context) => LandingPage(),
      '/feedback': (BuildContext context) => FeedbackPage(),
      '/notification': (BuildContext context) => NotificationPage(),
      '/settings': (BuildContext context) => SettingsPage(),
      '/profile-details': (BuildContext context) => ProfileDetailsPage(),
      '/request-for-service': (BuildContext context) => RequestForServicePage(),
      '/make-payment': (BuildContext context) => MakePaymentPage(),
      '/pay-with': (BuildContext context) => PayWithPage(),
      '/faq': (BuildContext context) => FAQPage(),
      '/load-calculator': (BuildContext context) => LoadCalculatorPage()
    };
  }
  static Route unKnownRoute(RouteSettings settings){
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,Animation<double> animation,
      Animation<double> secondaryAnimation){
        return NotFoundPage();
    });
  }
}