import 'package:crypto_app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';


class AuthResultEntity extends Equatable {
  final UserEntity user;
  final String token;

  const AuthResultEntity({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}
