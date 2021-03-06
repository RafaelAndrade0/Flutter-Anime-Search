import 'dart:ui';

import 'package:anime_search/application/anime/anime_bloc.dart';
import 'package:anime_search/application/auth/auth_bloc.dart';
import 'package:anime_search/injection.dart';
import 'package:anime_search/presentation/home/widgets/build_anime_initial.dart';
import 'package:anime_search/presentation/home/widgets/build_anime_loaded.dart';
import 'package:anime_search/presentation/loader/loader.dart';
import 'package:anime_search/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        state.maybeWhen(
          unauthenticated: () => ExtendedNavigator.of(context)
              .pushReplacementNamed(Routes.signInPage),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          drawerScrimColor: Colors.deepPurple[700].withOpacity(0.6),
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            elevation: 0,
            title: Row(
              children: <Widget>[
                Text(
                  'Anime',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          drawer: Drawer(
            // elevation: 0.5,
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.deepPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple[200],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'PROFILE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple[200],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'FAVORITES',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple[200],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  FlatButton(
                    onPressed: () => context.bloc<AuthBloc>()
                      ..add(const AuthEvent.signedOut()),
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.deepPurple[200],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
              // child: ListView(
              //   padding: EdgeInsets.zero,
              //   children: <Widget>[
              //     ListTile(
              //       title: const Text('Item 1'),
              //       onTap: () {},
              //     ),
              //     ListTile(
              //       title: const Text('SignOut'),
              //       onTap: () {
              //         context.bloc<AuthBloc>()..add(AuthEvent.signedOut());
              //       },
              //     ),
              //   ],
              // ),
            ),
          ),
          body: BlocProvider(
            create: (context) => getIt<AnimeBloc>(),
            child: BlocConsumer<AnimeBloc, AnimeState>(
              listener: (context, state) {
                state.maybeWhen(
                    animeError: () => Flushbar(
                          title: "Error!",
                          message: "Are you connected to the internet?",
                          backgroundGradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.purple],
                          ),
                          margin: EdgeInsets.all(8),
                          borderRadius: 8,
                          icon: Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: Colors.red[300],
                          ),
                          duration: Duration(seconds: 6),
                        )..show(context),
                    orElse: () => {});
              },
              builder: (context, state) {
                return state.map(
                  animeLoading: (e) => Loader(),
                  animeLoaded: (e) => BuildAnimeLoaded(
                    animeList: e.animeList,
                  ),
                  animeError: (e) => BuildAnimeInitial(),
                  animeInitial: (e) => BuildAnimeInitial(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
