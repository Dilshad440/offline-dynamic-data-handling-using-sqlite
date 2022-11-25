part of 'jake_bloc_cubit.dart';

abstract class JakeBlocState extends Equatable {
  const JakeBlocState();

  @override
  List<Object> get props => [];
}

class JakeBlocInitial extends JakeBlocState {
  @override
  List<Object> get props => [];
}

class JakeBlocLoading extends JakeBlocState {
  @override
  List<Object> get props => [];
}

class JakeBlocError extends JakeBlocState {
  const JakeBlocError(this.error);
  final String error;
  @override
  List<String> get props => [error];
}

class JakeBlocCompleted extends JakeBlocState {
  const JakeBlocCompleted(this.jakeWharton);
  final List<JakeWharton> jakeWharton;

  @override
  List<Object> get props => [jakeWharton];
}
