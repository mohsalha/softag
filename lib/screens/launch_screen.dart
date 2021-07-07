import 'package:flutter/material.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/size_config.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppController.instance;
    Future.delayed(Duration(seconds: 3),(){
      String route = AppController.instance.loggedIn() ? '/main_screen' :'/login_screen' ;
      Navigator.pushReplacementNamed(context, route);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(

        children: [
          SizedBox(width: MediaQuery.of(context).size.width,),
          Spacer(),
          Text(
            'Softag',
            style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(24),
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: SizeConfig.scaleHeight(20),
            ),
            child: Text(
              'Mohammed Salha',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: SizeConfig.scaleTextFont(14),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
