import 'package:fire_tutuo/services/auth.dart';
import 'package:fire_tutuo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fire_tutuo/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In')
          )
        ],
      ),
      body:Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0,),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val){
                    setState(() => email = val);
                  },
                  validator: (val)=>val.isEmpty? 'Enter Email' : null,
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                  validator: (val)=>val.length<5? 'Enter Password 4 chaars long' : null,
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result ==null){
                        setState(() {
                          loading = false;
                          error = 'please supply a valid email';
                         });
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0,),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 14),)
              ],
            ),
          )

      ),
    );
  }
}
