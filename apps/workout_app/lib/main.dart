import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workout_app/routing/router.dart';
import 'package:authentication/src/authentication_module.dart';
import 'package:authentication/src/presentation/pages/home/auth_home_view_model.dart';
import 'package:wkout_core/wkout_core.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ipmhpufrbeoobpivmcyd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlwbWhwdWZyYmVvb2JwaXZtY3lkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIwMTA4ODYsImV4cCI6MjA2NzU4Njg4Nn0.EVJ2NSKf-2u5IhmJDWfHdwnqlU8nZ1yL5afN0k7uJaY',
  );

  // Inicializar o módulo de autenticação
  await AuthenticationModule().registerInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthHomeViewModel>(
          create: (context) => WkoutInjector.I.get<AuthHomeViewModel>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter App Demo',
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
