import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreenMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<HomeScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover
        ),
      ),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(17),
          child: Container(
            child: Center(
              child: SpinKitCubeGrid(
                color: Colors.white.withOpacity(0.8),
                size: 50
              ),
            ),
          ),
        )
      ),
    );
  }
}
