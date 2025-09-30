import 'package:crypto_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/core/di/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/joke/presentation/bloc/joke_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<JokeBloc>(
          create: (context) => di.sl<JokeBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Joke App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginPage(),
      ),
    );
  }
}
