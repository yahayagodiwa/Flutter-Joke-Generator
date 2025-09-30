import 'package:crypto_app/core/errors/exceptions.dart';
import 'package:crypto_app/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await client.post(
        '/api/register',
        data: { 'name': name, 'email': email, 'password': password},
      );

      final data = response.data;
      if (data is Map<String, dynamic> || data is Map) {
        final map = Map<String, dynamic>.from(data);
        return UserModel.fromJson(map);
      } else {
        throw ServerException('Unexpected response format from register');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final resp = e.response!.data;
        String message = 'Registration failed';
        if (resp is Map && resp['message'] != null) {
          message = resp['message'].toString();
        } else if (resp is Map && resp['error'] != null) {
          message = resp['error'].toString();
        }
        throw ServerException(message);
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await client.post(
        '/api/login',
        data: {'email': email, 'password': password},
      );

      final data = response.data;
      if (data is Map<String, dynamic> || data is Map) {
        final map = Map<String, dynamic>.from(data);
        return UserModel.fromJson(map);
      } else {
        throw ServerException('Unexpected response format from login');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final resp = e.response!.data;
        String message = 'Login failed';
        if (resp is Map && resp['message'] != null) {
          message = resp['message'].toString();
        } else if (resp is Map && resp['error'] != null) {
          message = resp['error'].toString();
        }
        throw ServerException(message);
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
