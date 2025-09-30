part of "joke_bloc.dart";

abstract class JokeState extends Equatable {
  const JokeState();

  @override
  List<Object?> get props => [];
}

class JokeInitial extends JokeState {}

abstract class JokeProcessing extends JokeState {
  const JokeProcessing();
}

class JokeLoading extends JokeProcessing {}

class JokeFetched extends JokeState {
  final JokeEntity joke;

  const JokeFetched({ required this.joke});

    @override
  List<Object?> get props => [joke];
}

class JokeError extends JokeState {
  final String message;

  const JokeError({required this.message});

  @override
  List<Object?> get props => [message];
}