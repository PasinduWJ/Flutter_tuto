import 'package:fire_tutuo/models/model_user.dart';
import 'package:fire_tutuo/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ModelUser>(context);
    print(user);

    //return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}