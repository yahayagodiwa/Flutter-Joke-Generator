import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server Failure'}) : super(message);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({String message = 'Invalid credentials'})
    : super(message);
}
