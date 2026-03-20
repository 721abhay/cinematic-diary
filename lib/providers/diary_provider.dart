import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../services/storage_service.dart';
import '../services/transformation_service.dart';

class DiaryProvider extends ChangeNotifier {
  List<DiaryEntry> _entries = [];
  bool _isLoading = false;
  bool _isTransforming = false;
  String _language = 'en';
  String _username = 'Writer';

  List<DiaryEntry> get entries => List.unmodifiable(_entries);
  List<DiaryEntry> get favoriteEntries => _entries.where((e) => e.isFavorite).toList();
  bool get isLoading => _isLoading;
  bool get isTransforming => _isTransforming;
  String get language => _language;
  String get username => _username;
  int get totalEntries => _entries.length;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _entries = await StorageService.loadEntries();
    _language = await StorageService.getLanguage();
    _username = await StorageService.getUsername();

    _isLoading = false;
    notifyListeners();
  }

  Future<DiaryEntry> createAndTransformEntry({
    required String rawInput,
    required Genre genre,
    required EntryMode mode,
    String? imageUrl,
  }) async {
    _isTransforming = true;
    notifyListeners();

    try {
      final processedProse = await TransformationService.transform(
        rawInput,
        genre,
        language: _language,
      );

      final entry = DiaryEntry(
        rawInput: rawInput,
        processedProse: processedProse,
        genre: genre,
        mode: mode,
        imageUrl: imageUrl,
        language: _language,
      );

      _entries.insert(0, entry);
      await StorageService.saveEntries(_entries);

      _isTransforming = false;
      notifyListeners();

      return entry;
    } catch (e) {
      _isTransforming = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> toggleFavorite(String entryId) async {
    final index = _entries.indexWhere((e) => e.id == entryId);
    if (index == -1) return;

    _entries[index] = _entries[index].copyWith(
      isFavorite: !_entries[index].isFavorite,
    );
    await StorageService.saveEntries(_entries);
    notifyListeners();
  }

  Future<void> deleteEntry(String entryId) async {
    _entries.removeWhere((e) => e.id == entryId);
    await StorageService.saveEntries(_entries);
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    _language = lang;
    await StorageService.setLanguage(lang);
    notifyListeners();
  }

  Future<void> setUsername(String name) async {
    _username = name;
    await StorageService.setUsername(name);
    notifyListeners();
  }

  DiaryEntry? getEntryById(String id) {
    try {
      return _entries.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
