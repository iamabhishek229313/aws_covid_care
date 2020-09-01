import 'package:aws_covid_care/models/user.dart';
import 'package:aws_covid_care/screens/covid_detail_screen.dart';
import 'package:aws_covid_care/screens/faq_screen.dart';
import 'package:aws_covid_care/screens/home_screen.dart';
import 'package:aws_covid_care/screens/myth_busters_screen.dart';
import 'package:aws_covid_care/services/firebase_authentication.dart';
import 'package:aws_covid_care/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
    @required User userDetails,
    @required Authentication authentication,
    @required SharedPreferences sharedPreferences,
  })  : _userDetails = userDetails,
        _authentication = authentication,
        _sharedPreferences = sharedPreferences,
        super(key: key);

  final User _userDetails;
  final Authentication _authentication;
  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Image.asset(
                  'assets/icons/mask_person.png',
                  width: 50.0,
                  height: 60.0,
                  fit: BoxFit.contain,
                ),
              ),
              accountName: Text(
                _userDetails.displayName.toUpperCase(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
              accountEmail: Text(_userDetails.email)),
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => MythBusterScreen()));
            },
            title: Text("Myth Busters"),
            trailing: Icon(FontAwesomeIcons.fileMedicalAlt),
          ),
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => CovidDetailScreen()));
            },
            title: Text("What is COVID-19?"),
            trailing: Icon(FontAwesomeIcons.viruses),
          ),
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => FAQScreen()));
            },
            title: Text("FAQ's"),
            trailing: Icon(FontAwesomeIcons.questionCircle),
          ),
          ListTile(
            onTap: () async {
              await Workmanager.cancelByTag(fetchBackground).then((value) => _authentication.handleSignOut());
              _sharedPreferences.remove(AppConstants.userId);
            },
            title: Text("Logout"),
            trailing: Icon(Icons.exit_to_app),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "#StayHomeStaySafe",
              style: TextStyle(fontSize: 16.0, color: Colors.red.shade900),
            ),
          )
        ],
      ),
    );
  }
}
