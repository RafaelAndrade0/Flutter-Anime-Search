import 'package:anime_search/domain/auth/auth_failure.dart';
import 'package:anime_search/domain/auth/user.dart';
import 'package:anime_search/domain/auth/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Option<User>> getSignedInUser();

  Future<void> signOut();
}
