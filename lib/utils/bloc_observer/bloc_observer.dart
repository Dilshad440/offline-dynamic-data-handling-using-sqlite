import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) {
      print("##########------STATE CHANGED---- $bloc######### $change");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("#######=====TRANSITION========##########");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("BLOC IS CLOSED $bloc");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    print("BLOC IS CREATED $bloc");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    print("ERROR IN BLOC $bloc");
    print("ERROR:-- $error");
  }
}
