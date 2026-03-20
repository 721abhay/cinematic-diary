import 'package:uuid/uuid.dart';

enum EntryMode { digital, physical }
enum Genre { noir, romantic, sciFi, minimalist }

extension GenreExtension on Genre {
  String get displayName {
    switch (this) {
      case Genre.noir:
        return 'Noir';
      case Genre.romantic:
        return 'Romantic';
      case Genre.sciFi:
        return 'Sci-Fi';
      case Genre.minimalist:
        return 'Minimalist';
    }
  }

  String get emoji {
    switch (this) {
      case Genre.noir:
        return '🌑';
      case Genre.romantic:
        return '🌹';
      case Genre.sciFi:
        return '🚀';
      case Genre.minimalist:
        return '✦';
    }
  }

  String get description {
    switch (this) {
      case Genre.noir:
        return 'Dark, moody, detective-style prose';
      case Genre.romantic:
        return 'Warm, emotional, poetic writing';
      case Genre.sciFi:
        return 'Futuristic, imaginative narrative';
      case Genre.minimalist:
        return 'Clean, crisp, elegant simplicity';
    }
  }
}

class DiaryEntry {
  final String id;
  final String rawInput;
  final String processedProse;
  final Genre genre;
  final EntryMode mode;
  final DateTime timestamp;
  final String? imageUrl;
  final String language;
  final bool isFavorite;
  final bool isPublic;

  DiaryEntry({
    String? id,
    required this.rawInput,
    this.processedProse = '',
    this.genre = Genre.noir,
    this.mode = EntryMode.digital,
    DateTime? timestamp,
    this.imageUrl,
    this.language = 'en',
    this.isFavorite = false,
    this.isPublic = false,
  })  : id = id ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  DiaryEntry copyWith({
    String? rawInput,
    String? processedProse,
    Genre? genre,
    EntryMode? mode,
    DateTime? timestamp,
    String? imageUrl,
    String? language,
    bool? isFavorite,
    bool? isPublic,
  }) {
    return DiaryEntry(
      id: id,
      rawInput: rawInput ?? this.rawInput,
      processedProse: processedProse ?? this.processedProse,
      genre: genre ?? this.genre,
      mode: mode ?? this.mode,
      timestamp: timestamp ?? this.timestamp,
      imageUrl: imageUrl ?? this.imageUrl,
      language: language ?? this.language,
      isFavorite: isFavorite ?? this.isFavorite,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rawInput': rawInput,
      'processedProse': processedProse,
      'genre': genre.index,
      'mode': mode.index,
      'timestamp': timestamp.toIso8601String(),
      'imageUrl': imageUrl,
      'language': language,
      'isFavorite': isFavorite,
      'isPublic': isPublic,
    };
  }

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      rawInput: json['rawInput'],
      processedProse: json['processedProse'] ?? '',
      genre: Genre.values[json['genre'] ?? 0],
      mode: EntryMode.values[json['mode'] ?? 0],
      timestamp: DateTime.parse(json['timestamp']),
      imageUrl: json['imageUrl'],
      language: json['language'] ?? 'en',
      isFavorite: json['isFavorite'] ?? false,
      isPublic: json['isPublic'] ?? false,
    );
  }
}
