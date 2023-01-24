import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_app/pages/pages.dart';
import 'package:qr_scanner_app/providers/providers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScansProvider()),
        ChangeNotifierProvider(create: (_) => UIProvider()),
      ],
      child: MaterialApp(
        title: 'QR Scanner App',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'map': (_) => const MapPage(),
        },
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange.shade400,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.orange.shade400,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.orange.shade400,
          ),
        ),
      ),
    );
  }
}
