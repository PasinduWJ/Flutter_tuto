import 'package:flutter/material.dart';
import 'package:fire_tutuo/services/auth.dart';
import 'package:fire_tutuo/shared/constants.dart';
import 'package:fire_tutuo/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading =false;

   //text field state
  String email = '';
  String password = '';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 10.0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register')
          )
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
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
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result ==null){
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
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