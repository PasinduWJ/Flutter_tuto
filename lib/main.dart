import 'package:fire_tutuo/models/model_user.dart';
import 'package:fire_tutuo/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ModelUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper()
      ),
    );
  }
}
