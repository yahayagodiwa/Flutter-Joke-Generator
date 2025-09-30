
import 'package:crypto_app/core/errors/exceptions.dart';
import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:crypto_app/features/auth/data/models/user_model.dart';
import 'package:crypto_app/features/auth/domain/entities/auth_result.dart';
import 'package:crypto_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences prefs;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.prefs,
    
    });

  @override
  Future<Either<Failure, AuthResultEntity>> register(String name, String email, String password) async {
    try {
      final UserModel userModel = await remoteDataSource.register(name, email, password);
      
      return Right(AuthResultEntity(user: userModel, token: userModel.token));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error during registration'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResultEntity>> login(String email, String password) async {
    try {
      final UserModel userModel = await remoteDataSource.login(email, password);
      await prefs.setString('token', userModel.token);
      return Right(AuthResultEntity(user: userModel, token: userModel.token));
    } on ServerException catch (e) {
      final msg = e.message ?? 'Server error during login';
      if (msg.toLowerCase().contains('invalid') || msg.toLowerCase().contains('credential')) {
        return Left(InvalidCredentialsFailure(message: msg));
      }
      return Left(ServerFailure(message: msg));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
