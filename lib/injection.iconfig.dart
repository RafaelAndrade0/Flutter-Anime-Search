// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:anime_search/infrastructure/core/firebase_injectable_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:anime_search/infrastructure/anime/anime_repository.dart';
import 'package:anime_search/domain/anime/i_anime_repository.dart';
import 'package:anime_search/infrastructure/auth/firebase_auth_facade.dart';
import 'package:anime_search/domain/auth/i_auth_facade.dart';
import 'package:anime_search/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:anime_search/application/anime/anime_bloc.dart';
import 'package:anime_search/application/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  g.registerLazySingleton<FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  g.registerLazySingleton<GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  g.registerLazySingleton<IAnimeRepository>(() => AnimeRepository());
  g.registerLazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(g<FirebaseAuth>(), g<GoogleSignIn>()));
  g.registerFactory<SignInFormBloc>(() => SignInFormBloc(g<IAuthFacade>()));
  g.registerFactory<AnimeBloc>(() => AnimeBloc(g<IAnimeRepository>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(g<IAuthFacade>()));
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
