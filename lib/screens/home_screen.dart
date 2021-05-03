import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pelbox_mobile/screens/box/pelbox_main_screen.dart';
import 'package:pelbox_mobile/screens/home_screen_main.dart';
import 'package:pelbox_mobile/screens/member_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'courier/courier_main_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Home();
  }
}

class Home extends State<HomeScreen> {
  Map<String, dynamic> member = Map<String, dynamic>();

  bool _hasMemberData = false;

  int _bottomNavigationBarIndex = 0;

  var _pages = [];

  @override
  void initState() {
    super.initState();
    _getMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _hasMemberData
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage('assets/images/background2.png'),
                      fit: BoxFit.cover),
                ),
                child: _pages[_bottomNavigationBarIndex])
            : SpinKitCubeGrid(
                color: Colors.white,
                size: 50.0,
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavigationBarIndex,
        backgroundColor: Color(0xff121212),
        items: member['isInOrganization'] == true
            ? [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.layers,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_shipping,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: '',
                ),
              ]
            : // if member is not in organization show only three items
            [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.layers,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: '',
                ),
              ],
        onTap: (index) {
          setState(() {
            _bottomNavigationBarIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Future<void> _getMemberDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String refreshToken = prefs.getString('refresh_token');
    bool isInOrganization = prefs.getBool('is_in_organization');

    Map<String, dynamic> payload = JwtDecoder.decode(accessToken);

    setState(() {
      _hasMemberData = true;
      member['username'] = payload['preferred_username'];
      member['accessToken'] = accessToken;
      member['refreshToken'] = refreshToken;
      member['isInOrganization'] = isInOrganization;

      if (isInOrganization) {
        _pages = [
          HomeScreenMain(),
          PelBoxScreen(),
          CourierMainScreen(),
          MemberSettingsScreen()
        ];
      } else {
        _pages = [
          HomeScreenMain(),
          PelBoxScreen(),
          MemberSettingsScreen()
        ];
      }
    });
  }
}
