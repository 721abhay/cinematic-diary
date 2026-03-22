import 'dart:math';
import '../models/diary_entry.dart';
import 'cinematic_corpus.dart';

/// Advanced Offline Cinematic Transformation Engine (Monster Edition)
/// 100% Free, 100% Offline with pseudo-NLP, sentiment analysis, 
/// and a massive data corpus so permutations never repeat.
class TransformationService {
  static final Random _random = Random();

  /// Transform raw text into an epic cinematic entry
  static Future<String> transform(String rawText, Genre genre, {String language = 'en'}) async {
    // Simulate AI thinking to build anticipation
    final delay = 1200 + _random.nextInt(800);
    await Future.delayed(Duration(milliseconds: delay));

    if (rawText.trim().isEmpty) {
      return _getEmptyState(genre, language);
    }

    if (language == 'hi') {
      return _transformHindi(rawText, genre);
    }

    // 1. Analyze Sentiment Profile
    final profile = _analyzeSentimentProfile(rawText);

    // 2. Clean and Segment Text
    final rawSentences = _segmentAndClean(rawText);

    // 3. Paraphrase and Enhance
    final processedSentences = rawSentences.map((s) {
      // First paraphrase the structure
      String p = _paraphraseStructure(s, genre);
      // Then enhance vocabulary
      return _enhanceVocabulary(p, genre);
    }).toList();

    // 4. Assemble with Genre-Specific Narrative
    switch (genre) {
      case Genre.noir:
        return _assembleNoir(processedSentences, profile);
      case Genre.romantic:
        return _assembleRomantic(processedSentences, profile);
      case Genre.sciFi:
        return _assembleSciFi(processedSentences, profile);
      case Genre.minimalist:
        return _assembleMinimalist(processedSentences);
    }
  }

  // --- 1. PSEUDO NLP: SENTIMENT PROFILE ---
  static SentimentProfile _analyzeSentimentProfile(String text) {
    final lower = text.toLowerCase();
    int joy = 0, sorrow = 0, anger = 0, energy = 0;

    final joyWords = ['happy', 'love', 'amazing', 'great', 'smile', 'joy', 'win', 'success', 'lucky', 'best', 'bliss'];
    final sorrowWords = ['sad', 'cry', 'tears', 'pain', 'hurt', 'fail', 'lose', 'lonely', 'broken', 'death', 'miss'];
    final angerWords = ['angry', 'hate', 'furious', 'mad', 'hell', 'hit', 'kill', 'betray', 'sick'];
    final energyWords = ['run', 'fast', 'work', 'busy', 'loud', 'strong', 'power', 'bright', 'fire'];

    for (var w in joyWords) {
      if (lower.contains(w)) joy++;
    }
    for (var w in sorrowWords) {
      if (lower.contains(w)) sorrow++;
    }
    for (var w in angerWords) {
      if (lower.contains(w)) anger++;
    }
    for (var w in energyWords) {
      if (lower.contains(w)) energy++;
    }

    if (joy > sorrow && joy >= anger) return SentimentProfile.joyous;
    if (sorrow > joy && sorrow >= anger) return SentimentProfile.melancholy;
    if (anger > joy) return SentimentProfile.intense;
    if (energy > 2) return SentimentProfile.energetic;
    
    return SentimentProfile.neutral;
  }

  // --- 2. TEXT CLEANING & SEGMENTATION ---
  static List<String> _segmentAndClean(String raw) {
    var sentences = raw.split(RegExp(r'(?<=[.!?])\s+'));
    if (sentences.length == 1 && !sentences[0].contains(RegExp(r'[.!?]'))) {
      sentences = raw.split(RegExp(r'(?<=[,])\s+')); 
    }
    
    return sentences.where((s) => s.trim().isNotEmpty).map((s) {
      var trimmed = s.trim();
      if (trimmed.isNotEmpty) {
        trimmed = trimmed[0].toUpperCase() + trimmed.substring(1);
      }
      return trimmed;
    }).toList();
  }

  // --- 3. PARAPHRASING & RECONSTRUCTION ---
  static String _paraphraseStructure(String sentence, Genre genre) {
    String s = sentence;
    
    // Pattern Mappings: [Regex, [Replacement Templates]]
    final Map<String, List<String>> patterns = {
      r'^I went to (.*)': [
        r'My journey led me to $1',
        r'I found myself standing at $1',
        r'The path eventually brought me to $1',
        r'I navigated the winding route to $1',
      ],
      r'^I saw (.*)': [
        r'My eyes fell upon $1',
        r'I witnessed $1 as if for the first time',
        r'The image of $1 etched itself into my mind',
        r'I glimpsed $1 through the haze of the day',
      ],
      r'^I (feel|am feeling) (.*)': [
        r'A cocktail of emotions stirred within as I felt $2',
        r'There was a resonance of $2 that took hold of me',
        r'The weight of $2 settled in my chest',
        r'I was consumed by a sudden wave of $2',
      ],
      r'^It was (.*)': [
        r'The reality presented itself as $1',
        r'A certain $1 quality defined the moment',
        r'Everything seemed to dissolve into $1',
        r'The atmosphere was thick with $1',
      ],
      r'^I had to (.*)': [
        r'Duty called, and I found myself forced to $1',
        r'The necessity of the situation dictated that I $1',
        r'There was no choice but to $1',
        r'I was compelled by unseen forces to $1',
      ],
      r'^I have (.*)': [
        r'I possess $1, a small weight in this vast world',
        r'In my hands, I held $1',
        r'The presence of $1 provided a strange comfort',
      ],
    };

    bool matched = false;
    patterns.forEach((regex, templates) {
      if (!matched) {
        final match = RegExp(regex, caseSensitive: false).firstMatch(s);
        if (match != null) {
          final template = templates[_random.nextInt(templates.length)];
          s = template;
          for (int i = 1; i <= match.groupCount; i++) {
            s = s.replaceAll(r'$' + i.toString(), match.group(i) ?? '');
          }
          matched = true;
        }
      }
    });

    // Final punctuation check
    if (!s.endsWith('.') && !s.endsWith('!') && !s.endsWith('?')) {
      s += '.';
    }

    return s;
  }

  // --- 4. THESAURUS ENHANCEMENT ---
  static String _enhanceVocabulary(String sentence, Genre genre) {
    var enhanced = sentence;
    final replacements = _getDictionary(genre);

    replacements.forEach((target, synonyms) {
      if (synonyms.isNotEmpty) {
        // Only replace with 30% probability to avoid sounding "too forced" / "word salad"
        if (_random.nextDouble() < 0.4) {
          final replacement = synonyms[_random.nextInt(synonyms.length)];
          enhanced = enhanced.replaceAll(RegExp('\\b$target\\b', caseSensitive: false), replacement);
        }
      }
    });

    return enhanced;
  }

  static Map<String, List<String>> _getDictionary(Genre genre) {
    switch (genre) {
      case Genre.noir: return CinematicCorpus.noirVocab;
      case Genre.romantic: return CinematicCorpus.romanticVocab;
      case Genre.sciFi: return CinematicCorpus.sciFiVocab;
      case Genre.minimalist: return {}; 
    }
  }

  // --- 5. NARRATIVE ASSEMBLY ---

  static String _pick(List<String> list) => list[_random.nextInt(list.length)];

  static String _assembleNoir(List<String> sentences, SentimentProfile profile) {
    final buffer = StringBuffer();
    
    if (profile == SentimentProfile.melancholy || profile == SentimentProfile.neutral) {
      buffer.writeln('${_pick(CinematicCorpus.noirNegativeIntros)}\n');
    } else {
      buffer.writeln('${_pick(CinematicCorpus.noirPositiveIntros)}\n');
    }

    for (int i = 0; i < sentences.length; i++) {
      String s = sentences[i];
      if (i == 0) {
        buffer.writeln('It started with a simple truth: $s\n');
      } else if (i == sentences.length - 1) {
        buffer.writeln('${_pick(CinematicCorpus.noirBridges)}$s\n');
        buffer.writeln(_pick(CinematicCorpus.noirOutros));
      } else {
        buffer.writeln('$s\n');
      }
    }
    return buffer.toString().trim();
  }

  static String _assembleRomantic(List<String> sentences, SentimentProfile profile) {
    final buffer = StringBuffer();

    if (profile == SentimentProfile.joyous || profile == SentimentProfile.neutral) {
      buffer.writeln('${_pick(CinematicCorpus.romanticPositiveIntros)}\n');
    } else {
      buffer.writeln('${_pick(CinematicCorpus.romanticNegativeIntros)}\n');
    }

    for (int i = 0; i < sentences.length; i++) {
      String s = sentences[i];
      if (i == 0) {
        buffer.writeln('I whispered a prayer to the wind: $s\n');
      } else if (i == sentences.length - 1) {
        buffer.writeln('${_pick(CinematicCorpus.romanticBridges)}$s\n');
        buffer.writeln(_pick(CinematicCorpus.romanticOutros));
      } else {
        buffer.writeln('$s\n');
      }
    }
    return buffer.toString().trim();
  }

  static String _assembleSciFi(List<String> sentences, SentimentProfile profile) {
    final buffer = StringBuffer();
    final stardate = DateTime.now().millisecondsSinceEpoch ~/ 864000;

    buffer.writeln('LOG ID: [${_random.nextInt(9999)}] — UNIT 01 — STARDATE $stardate\n');
    
    if (profile == SentimentProfile.joyous || profile == SentimentProfile.neutral) {
      buffer.writeln('${_pick(CinematicCorpus.sciFiPositiveIntros)}\n');
    } else {
      buffer.writeln('${_pick(CinematicCorpus.sciFiNegativeIntros)}\n');
    }

    for (int i = 0; i < sentences.length; i++) {
      String s = sentences[i];
      if (i == 0) {
        buffer.writeln('Primary Input Stream: $s\n');
      } else if (i == sentences.length - 1) {
        buffer.writeln('${_pick(CinematicCorpus.sciFiBridges)}$s\n');
        buffer.writeln(_pick(CinematicCorpus.sciFiOutros));
      } else {
        buffer.writeln('$s\n');
      }
    }
    return buffer.toString().trim();
  }

  static String _assembleMinimalist(List<String> sentences) {
    final buffer = StringBuffer();
    buffer.writeln('${DateTime.now().day}/${DateTime.now().month}\n');
    for (var s in sentences) {
      buffer.writeln('$s\n');
    }
    buffer.writeln('Fin.');
    return buffer.toString().trim();
  }

  // --- HINDI (Localized Monster Mode) ---
  static String _transformHindi(String raw, Genre genre) {
    final buffer = StringBuffer();
    final parts = raw.split(RegExp(r'[।.!?]+')).where((e) => e.trim().isNotEmpty).toList();
    
    // Hindi pseudo-NLP (Keep for future logic expansion)
    // final isNegative = raw.contains(RegExp(r'दुख|बुरा|परेशान|अकेला|हार|मौत|दर्द|रोये'));

    switch (genre) {
      case Genre.noir:
        buffer.writeln('${_pick(HindiCinematicCorpus.noirIntros)}\n');
        for (var p in parts) {
          String s = p.trim();
          // Hindi Paraphrasing
          if (s.startsWith('मैं')) s = s.replaceFirst('मैं', 'मेरी रूह');
          if (s.startsWith('मैंने')) s = s.replaceFirst('मैंने', 'इन आँखों ने');

          buffer.writeln('${_pick(HindiCinematicCorpus.noirBridges)}$s।\n');
        }
        buffer.writeln(_pick(HindiCinematicCorpus.noirOutros));
        break;
      case Genre.romantic:
        buffer.writeln('${_pick(HindiCinematicCorpus.romanticIntros)}\n');
        for (var p in parts) {
          String s = p.trim();
          if (s.startsWith('मैं')) s = s.replaceFirst('मैं', 'ये आवारा दिल');
          buffer.writeln('${_pick(HindiCinematicCorpus.romanticBridges)}$s।\n');
        }
        buffer.writeln(_pick(HindiCinematicCorpus.romanticOutros));
        break;
      case Genre.sciFi:
        buffer.writeln('${_pick(HindiCinematicCorpus.sciFiIntros)}\n');
        for (var p in parts) {
          buffer.writeln('${_pick(HindiCinematicCorpus.sciFiBridges)}${p.trim()}।\n');
        }
        buffer.writeln(_pick(HindiCinematicCorpus.sciFiOutros));
        break;
      default:
        buffer.writeln(raw);
    }
    return buffer.toString().trim();
  }

  static String _getEmptyState(Genre genre, String language) {
    if (language == 'hi') return 'पन्ने खाली रहे, किसी अनकही कहानी के इंतजार में...';
    switch (genre) {
      case Genre.noir: return 'The pages remained blank. Just like the suspect\'s alibi.';
      case Genre.romantic: return 'A blank page, waiting for the ink of your heart.';
      case Genre.sciFi: return 'Error: Neural input empty. No data to synthesize.';
      case Genre.minimalist: return '.';
    }
  }
}

enum SentimentProfile { joyous, melancholy, intense, energetic, neutral }
