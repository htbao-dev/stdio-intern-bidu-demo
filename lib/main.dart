import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const BiduApp());
}

class BiduApp extends StatelessWidget {
  const BiduApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => HomeRepository(),
        child: BlocProvider(
          create: (context) => HomeBloc(
            homeRepository: RepositoryProvider.of<HomeRepository>(context),
          )..add(LoadBannerAndCategory()),
          child: const HomeScreen(),
        ),
      ),
      theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.grey),
          fontFamily: 'Lexend'),
    );
  }
}
