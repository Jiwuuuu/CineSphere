// supabase_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  
  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: '', // Supabase URL
      anonKey: '', // Supabase anon key
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}


