
import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/features/auth/domain/entities/auth_result.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResultEntity>> register(String name, String email, String password);
  Future<Either<Failure, AuthResultEntity>> login(String email, String password);
}
