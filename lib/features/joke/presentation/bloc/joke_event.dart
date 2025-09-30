part of "joke_bloc.dart";

abstract class JokeEvent extends Equatable {
  const JokeEvent();

  @override
  List<Object> get props => [];
}

class JokeRequested extends JokeEvent {
  final String id;
  final String type;
  final String setup;
  final String punchline;

  const JokeRequested({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });

 
  const JokeRequested.random()
      : id = '',
        type = '',
        setup = '',
        punchline = '';

  @override
  List<Object> get props => [id, type, setup, punchline];
}
