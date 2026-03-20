import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/diary_entry.dart';

class StorageService {
  static const String _entriesKey = 'diary_entries';
  static const String _onboardingKey = 'onboarding_complete';
  static const String _languageKey = 'preferred_language';
  static const String _usernameKey = 'username';

  static Future<List<DiaryEntry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_entriesKey);
    if (data == null) return _getSampleEntries();

    final List<dynamic> jsonList = json.decode(data);
    final entries = jsonList.map((j) => DiaryEntry.fromJson(j)).toList();
    if (entries.isEmpty) return _getSampleEntries();
    return entries;
  }

  static Future<void> saveEntries(List<DiaryEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = json.encode(entries.map((e) => e.toJson()).toList());
    await prefs.setString(_entriesKey, data);
  }

  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  static Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, lang);
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey) ?? 'Writer';
  }

  static Future<void> setUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, name);
  }

  static List<DiaryEntry> _getSampleEntries() {
    return [
      DiaryEntry(
        rawInput: 'Today I woke up early and watched the sunrise from my balcony. The sky turned orange and pink. I made chai and sat there for an hour just thinking about life. It was peaceful.',
        processedProse:
            'The city never sleeps, and neither does the memory of today.\n\nIt started like this: Today I woke up early and watched the sunrise from my balcony. The kind of beginning that doesn\'t warn you about the ending.\n\nThrough the haze of the afternoon, the sky turned orange and pink.\n\nNobody asked, but the silence spoke volumes — I made chai and sat there for an hour just thinking about life.\n\nAnd in the end — it was peaceful. The shadows knew it all along, but they weren\'t talking.',
        genre: Genre.noir,
        mode: EntryMode.digital,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isFavorite: true,
      ),
      DiaryEntry(
        rawInput: 'Met an old friend at the café today. We talked for hours about our college days. Laughed so much my stomach hurt. Some connections never fade no matter how much time passes.',
        processedProse:
            'Today was painted in colors that only the heart can see.\n\nThe morning unfolded like a love letter waiting to be read — met an old friend at the café today.\n\nWith every heartbeat, the world whispered: we talked for hours about our college days.\n\nLike petals catching the monsoon rain, laughed so much my stomach hurt.\n\nAnd as the stars began their ancient waltz, some connections never fade no matter how much time passes — a perfect coda to a day wrapped in warmth.',
        genre: Genre.romantic,
        mode: EntryMode.digital,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ),
      DiaryEntry(
        rawInput: 'Finished reading a book about quantum physics today. The idea that observing something changes it blew my mind. Maybe we are all just observers creating our own reality.',
        processedProse:
            'Personal Log — Stardate ${DateTime.now().millisecondsSinceEpoch ~/ 86400000}. Sector: Earth.\n\nThe neural interface recorded the first anomaly at dawn: Finished reading a book about quantum physics today. Cross-referencing with the cognitive archive.\n\nScanning bio-emotional wavelength: the idea that observing something changes it blew my mind.\n\nFinal entry before the temporal shift: maybe we are all just observers creating our own reality. The quantum probability matrix suggests tomorrow will be... different. End log.',
        genre: Genre.sciFi,
        mode: EntryMode.digital,
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        isFavorite: true,
      ),
    ];
  }
}
