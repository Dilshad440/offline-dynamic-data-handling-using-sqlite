import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_storage/cubit/jake_bloc_cubit.dart';
import 'package:offline_storage/utils/bloc_observer/bloc_observer.dart';
import 'package:offline_storage/views/main_page.dart';

void main() {
  Bloc.observer = MyAppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: ((context) => JakeBlocCubit()))],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}
