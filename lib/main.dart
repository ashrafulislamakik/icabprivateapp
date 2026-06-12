import 'package:flutter/material.dart';
import 'package:icab_private_app/providers/theme_providers.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ICAB Private Wing',
      themeMode: themeProvider.themeMode, // এখানে থিম মোড সেট হবে
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: const HomePage(),
    );
  }
}