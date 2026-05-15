import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flight_booking_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flight_booking_app/domain/Entities/auth/forgot_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/reset_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/verify_otp_result.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Exception, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await _remoteDataSource.login(email, password);

      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserEntity>> register(UserEntity user) async {
    try {
      final registerdUser = await _remoteDataSource.register(user);

      return Right(registerdUser);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, Unit>> logOut() async {
    try {
      await _localDataSource.clear();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, ForgotPasswordResult>> forgotPasswordWithSMS(
    String phone,
  ) async {
    try {
      final result = await _remoteDataSource.forgotPasswordWithSMS(phone);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, ForgotPasswordResult>> forgotPasswordWithEmail(
    String email,
  ) async {
    try {
      final result = await _remoteDataSource.forgotPasswordWithEmail(email);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, VerifyOtpResult>> verifyOtp({
    String? email,
    String? phone,
    required String otp,
  }) async {
    try {
      final result = await _remoteDataSource.verifyOtp(otp: otp);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, ResetPasswordResult>> resetPasswordBySMS(
    String phone,
    String newPassword,
  ) async {
    try {
      final result = await _remoteDataSource.resetPasswordBySMS(
        phone,
        newPassword,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, ResetPasswordResult>> resetPasswordByEmail(
    String email,
    String newPassword,
  ) async {
    try {
      final result = await _remoteDataSource.resetPasswordByEmail(
        email,
        newPassword,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
