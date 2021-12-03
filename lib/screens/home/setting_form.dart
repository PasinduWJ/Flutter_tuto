import 'package:fire_tutuo/models/model_user.dart';
import 'package:fire_tutuo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fire_tutuo/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:fire_tutuo/shared/loading.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    ModelUser user = Provider.of<ModelUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew setting. ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(()=> _currentName =val),
                  ),
                  SizedBox(height: 20.0,),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(()=> _currentSugars =val),
                  ),
                  SizedBox(height: 10.0,),
                  Slider(
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (val) => setState(()=> _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text('Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? snapshot.data.name,
                              _currentSugars ?? snapshot.data.sugars,
                              _currentStrength ?? snapshot.data.strength);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ),
          );
        }else{
          return Loading();
        }

      }
    );
  }
}
