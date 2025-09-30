import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String password;
  final String email;
  final String token;

  const UserEntity({required this.id, 
  required this.email,
  required this.name,
  required this.password, 
  required this.token});

  @override
  List<Object> get props => [id, email, name, password, token];
}
