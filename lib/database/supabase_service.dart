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
      url: 'https://ugvcmfripsepimuwetav.supabase.co', // Supabase URL
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVndmNtZnJpcHNlcGltdXdldGF2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYyODM4MTAsImV4cCI6MjA0MTg1OTgxMH0.jdOtxDcv6ZkDlNCQrzEhxaoyWaji4ThzBE65AG0bpqo', // Supabase anon key
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}


