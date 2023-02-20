import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/shared/bloc_observer.dart';
import 'package:to_do_app/shared/cubit/to_do_cubit.dart';
import 'layout/to_do_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ToDoCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TO Do APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ToDOScreen(),
      ),
    );
  }
}

