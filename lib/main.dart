import 'package:flutter/material.dart';
// Ensure this path is correct
// Ensure this path is correct
import 'database/supabase_service.dart'; // Ensure this path is correct
import 'package:cinesphere/screens/splash_screen.dart';

// Colors
const bg_color = Color(0xff07130E);
const text = Color(0xffE2F1EB);
const header_text = Color(0xff40E49F);
const icon_color = Color(0xff8CDDBB);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseService().initializeSupabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF212429),
      ),
      home: SplashScreen(),
    );
  }
}



