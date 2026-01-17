import 'package:flutter/material.dart';
import 'package:keep_in_touch/providers/auth_provider.dart';
import 'package:keep_in_touch/providers/animal_provider.dart';
import 'package:keep_in_touch/providers/form_provider.dart';
import 'package:keep_in_touch/providers/user_provider.dart';
import 'package:keep_in_touch/screens/home_screen.dart';
import 'package:keep_in_touch/screens/login_screen.dart';
import 'package:keep_in_touch/screens/animal_detail_screen.dart';
import 'package:keep_in_touch/screens/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AnimalProvider()),
        ChangeNotifierProvider(create: (_) => FormProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const AppContent(),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({super.key});

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep In Touch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: Consumer<AuthProvider>(
        builder: (_, auth, __) {
          if (auth.isAuthenticated) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/animal-detail': (_) => const AnimalDetailScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}
