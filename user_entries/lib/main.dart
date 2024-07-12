import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_entries/screens/user_lists.dart';

import 'bloc/users_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF-Pro',
      ),
      home: BlocProvider(
        create: (context) => UserBloc(),
        child: UserLists(),
      ),
    );
  }
}
