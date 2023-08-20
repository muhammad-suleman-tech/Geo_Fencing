
import 'package:flutter/material.dart';
import 'package:geofencing_app/background_service.dart';
import 'package:geofencing_app/screens/home_screen.dart';
import 'package:get/get.dart';


void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp( const MyApp() );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geofencing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomeScreen(),
      home: const GeoFence(),

    );
  }
}
