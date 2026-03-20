import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/diary_entry.dart';
import '../config/supabase_config.dart';

class SupabaseService {
  static const String _table = 'diary_entries';

  static SupabaseClient get client => Supabase.instance.client;

  /// Fetch all entries for the current user
  static Future<List<DiaryEntry>> fetchEntries() async {
    if (!SupabaseConfig.isConfigured) return [];

    try {
      final response = await client
          .from(_table)
          .select()
          .order('timestamp', ascending: false);
      
      return (response as List).map((data) => DiaryEntry(
        id: data['id'],
        rawInput: data['raw_input'],
        processedProse: data['processed_prose'],
        genre: Genre.values.firstWhere((e) => e.name == data['genre'], orElse: () => Genre.noir),
        mode: EntryMode.values.firstWhere((e) => e.name == data['mode'], orElse: () => EntryMode.digital),
        timestamp: DateTime.parse(data['timestamp']),
        imageUrl: data['image_url'],
        isFavorite: data['is_favorite'] ?? false,
        isPublic: data['is_public'] ?? false,
        language: data['language'] ?? 'en',
      )).toList();
    } catch (e) {
      print('Supabase fetch error: $e');
      return [];
    }
  }

  /// Fetch public community entries for Explore feed
  static Future<List<DiaryEntry>> fetchExploreEntries() async {
    if (!SupabaseConfig.isConfigured) return [];

    try {
      final response = await client
          .from(_table)
          .select()
          .eq('is_public', true)
          .order('timestamp', ascending: false);
      
      return (response as List).map((data) => DiaryEntry(
        id: data['id'],
        rawInput: data['raw_input'],
        processedProse: data['processed_prose'],
        genre: Genre.values.firstWhere((e) => e.name == data['genre'], orElse: () => Genre.noir),
        mode: EntryMode.values.firstWhere((e) => e.name == data['mode'], orElse: () => EntryMode.digital),
        timestamp: DateTime.parse(data['timestamp']),
        imageUrl: data['image_url'],
        isFavorite: data['is_favorite'] ?? false,
        isPublic: data['is_public'] ?? false,
        language: data['language'] ?? 'en',
      )).toList();
    } catch (e) {
      print('Supabase explore fetch error: $e');
      return [];
    }
  }

  /// Insert a new entry
  static Future<void> insertEntry(DiaryEntry entry) async {
    if (!SupabaseConfig.isConfigured) return;

    try {
      await client.from(_table).insert({
        'id': entry.id,
        'raw_input': entry.rawInput,
        'processed_prose': entry.processedProse,
        'genre': entry.genre.name,
        'mode': entry.mode.name,
        'timestamp': entry.timestamp.toIso8601String(),
        'image_url': entry.imageUrl,
        'is_favorite': entry.isFavorite,
        'is_public': entry.isPublic,
        'language': entry.language,
        // Make sure you have setup RLS properly if using auth
        // 'user_id': client.auth.currentUser?.id,
      });
    } catch (e) {
      print('Supabase insert error: $e');
    }
  }

  /// Update an entry (e.g. toggling favorite)
  static Future<void> updateEntry(DiaryEntry entry) async {
    if (!SupabaseConfig.isConfigured) return;

    try {
      await client.from(_table).update({
        'is_favorite': entry.isFavorite,
        'is_public': entry.isPublic,
      }).eq('id', entry.id);
    } catch (e) {
      print('Supabase update error: $e');
    }
  }

  /// Delete an entry
  static Future<void> deleteEntry(String id) async {
    if (!SupabaseConfig.isConfigured) return;

    try {
      await client.from(_table).delete().eq('id', id);
    } catch (e) {
      print('Supabase delete error: $e');
    }
  }
}
