import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bootstrapSupabase() async {
  await Supabase.initialize(
    url: 'https://gjgdunpydpudivcfohxv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqZ2R1bnB5ZHB1ZGl2Y2ZvaHh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg2ODk0MDAsImV4cCI6MjAyNDI2NTQwMH0.E92dy2RI0h4kgJxTZOTuAIICPKhXGKy2Fk2QZgGDjNM',
  );

  GetIt.instance.registerSingleton<SupabaseClient>(Supabase.instance.client);
}
