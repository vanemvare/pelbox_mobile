import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pelbox_mobile/bloc/account_bloc.dart';
import 'package:pelbox_mobile/bloc/events/account_events.dart';
import 'package:pelbox_mobile/screens/edit/edit_city_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_cityaddress_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_country_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_firstname_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_gender_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_lastname_screen.dart';
import 'package:pelbox_mobile/screens/edit/edit_postalcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Account();
  }
}

class Account extends State<AccountScreen> {
  bool _hasMemberDetails = false;
  Map<String, dynamic> member = Map<String, dynamic>();

  bool _isInOrganization;

  @override
  void initState() {
    super.initState();
    _getMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Account'),
          ),
          body: _hasMemberDetails
              ? Container(
                  margin: EdgeInsets.all(17),
                  child: ListView(children: [
                    Container(
                      child: Text(
                        'ACCOUNT INFORMATION',
                        style: TextStyle(
                            color: Color(0xffc3c2c9),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => print('Username'),
                      child: Container(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['username'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () => print('Email'),
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['email'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditFirstNameScreen(
                                    member['first_name']))).then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'First name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['first_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditLastNameScreen(
                                    member['last_name']))).then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Last name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['last_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditGenderScreen(member['gender'])))
                            .then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['gender'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditCityScreen(member['city'])))
                            .then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['city'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditCityAddressScreen(
                                    member['city_address']))).then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['city_address'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditCountryScreen(
                                        member['country'].toString())))
                            .then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Country',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['country'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPostalCodeScreen(
                                        member['postal_code'].toString())))
                            .then((value) {
                          setState(() {
                            _hasMemberDetails = false;
                          });

                          setState(() {
                            _getMemberDetails();
                            _hasMemberDetails = true;
                          });
                        });
                      },
                      child: Container(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Postal code',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                member['postal_code'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                    _isInOrganization
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'DELIVERY ORGANIZATION INFORMATION',
                                  style: TextStyle(
                                      color: Color(0xffc3c2c9),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 55,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Company',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        member['organization_name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: Colors.white.withOpacity(0.8)),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                color: Colors.white.withOpacity(0.8),
                                height: 55,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        member['organization_email'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 2,
                          ),
                  ]),
                )
              : Center(
                  child: SpinKitCubeGrid(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _getMemberDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    _isInOrganization = prefs.getBool('is_in_organization');

    final _accountBloc = AccountBloc();
    _accountBloc.accountEventSink.add(AllSettings(accessToken));
    Map response = await _accountBloc.account.first;

    if (response['success']) {
      setState(() {
        member = response['message'];
        for (String key in member.keys) {
          member[key] = member[key] != null ? member[key] : "";
        }

        if (member["gender"].toString().isNotEmpty) {
          member['gender'] = member['gender'] == "M" ? "Male" : "Female";
        }

        _hasMemberDetails = true;
      });
    }
  }
}
