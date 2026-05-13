import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity>> login(String email, String password);
  Future<Either<Exception, UserEntity>> register(UserEntity user);
  Future<Either<Exception, Unit>> logOut();
}
