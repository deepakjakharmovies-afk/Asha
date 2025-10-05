import 'package:finishedapp/addBenifecry.dart';
import 'package:finishedapp/dashboard.dart';
import 'package:finishedapp/home.dart';
import 'package:finishedapp/loading.dart';
import 'package:finishedapp/login.dart';
import 'package:finishedapp/patiant_farm.dart';
import 'package:finishedapp/persion_details.dart';
import 'package:finishedapp/voice/voice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: Colors.blue,
      ),
      // home: BeneficiaryProfileScreen(),
      initialRoute: '/',
      routes: {
        // The first screen that appears
        '/': (context) => SplashScreen(),
        // The main hub of the application
        '/home/': (context) => HomePage() ,
        // // Your existing data entry page
        '/data_entry/': (context) => AddBeneficiaryScreen(), 
        // // Placeholder for the Vaccination Details screen
        '/vactination_detail/': (context) => AshaDataEntryScreen(),
        // Placeholder for other pages
        '/records/': (context) => const Placeholder(child: Center(child: Text("View Records Page"))),
        '/reports/': (context) => const Placeholder(child: Center(child: Text("Reports Page"))),
        '/sync/': (context) => const Placeholder(child: Center(child: Text("Sync Status Page"))),
      },
    );
  }
}

