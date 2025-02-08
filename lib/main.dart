import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:replicamoteis/providers/motel_provider.dart';
import 'package:replicamoteis/widgets/date_selection_manager.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MotelProvider()),
        ChangeNotifierProvider(create: (context) => DateSelectionManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guia de Motéis',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  HomeScreen(),
      ),
    );
  }
}
