import 'package:famibo/login/bloc_cubit/auth_cubit.dart';
import 'package:famibo/login/bloc_cubit/auth_state.dart';
import 'package:famibo/login/repo/auth_repo.dart';
import 'package:famibo/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/routes.dart';

void main() async { 
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ProviderScope(child: RoutePage(),));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {

        //Bloc Cubit
    return BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuth.instance, authRepository, AuthInitial()),
     child:const RoutePage(),    
    );
  }
}
