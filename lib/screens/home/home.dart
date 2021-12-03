import 'package:fire_tutuo/screens/home/setting_form.dart';
import 'package:fire_tutuo/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fire_tutuo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fire_tutuo/screens/home/brew_list.dart';
import 'package:fire_tutuo/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
        backgroundColor: Colors.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
          context: context,
          builder: (context){
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(40.0),
                    topRight: const  Radius.circular(40.0))
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 5.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                await _auth.signOut();
                },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: ()=> _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: BrewList(),
        ),
      ),
    );
  }
}