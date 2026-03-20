import '../models/diary_entry.dart';

/// Simulates AI transformation of diary entries into cinematic prose.
/// In production, this would call Gemini Pro API.
class TransformationService {
  /// Transforms raw diary text into cinematic prose based on selected genre.
  /// Currently uses local templates; will integrate Gemini Pro API later.
  static Future<String> transform(String rawText, Genre genre, {String language = 'en'}) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    if (rawText.trim().isEmpty) {
      return 'The pages remained blank, waiting for a story yet to be told...';
    }

    if (language == 'hi') {
      return _transformHindi(rawText, genre);
    }

    switch (genre) {
      case Genre.noir:
        return _transformNoir(rawText);
      case Genre.romantic:
        return _transformRomantic(rawText);
      case Genre.sciFi:
        return _transformSciFi(rawText);
      case Genre.minimalist:
        return _transformMinimalist(rawText);
    }
  }

  static String _transformNoir(String raw) {
    final sentences = raw.split(RegExp(r'[.!?]+'));
    final buffer = StringBuffer();

    buffer.writeln('The city never sleeps, and neither does the memory of today.\n');

    for (int i = 0; i < sentences.length; i++) {
      final s = sentences[i].trim();
      if (s.isEmpty) continue;

      if (i == 0) {
        buffer.writeln('It started like this: $s. The kind of beginning that doesn\'t warn you about the ending.\n');
      } else if (i == sentences.length - 1) {
        buffer.writeln('And in the end — $s. The shadows knew it all along, but they weren\'t talking.');
      } else {
        final noirPhrases = [
          'Through the haze of the afternoon, ',
          'The streets had their own version of the truth: ',
          'Nobody asked, but the silence spoke volumes — ',
          'Under the pale glow of fluorescent lights, ',
          'The clock ticked on, indifferent as always. ',
        ];
        buffer.writeln('${noirPhrases[i % noirPhrases.length]}${s.toLowerCase()}.\n');
      }
    }

    return buffer.toString().trim();
  }

  static String _transformRomantic(String raw) {
    final sentences = raw.split(RegExp(r'[.!?]+'));
    final buffer = StringBuffer();

    buffer.writeln('Today was painted in colors that only the heart can see.\n');

    for (int i = 0; i < sentences.length; i++) {
      final s = sentences[i].trim();
      if (s.isEmpty) continue;

      if (i == 0) {
        buffer.writeln('The morning unfolded like a love letter waiting to be read — $s.\n');
      } else if (i == sentences.length - 1) {
        buffer.writeln('And as the stars began their ancient waltz, $s — a perfect coda to a day wrapped in warmth.');
      } else {
        final romanticPhrases = [
          'With every heartbeat, the world whispered: ',
          'Like petals catching the monsoon rain, ',
          'The universe conspired beautifully — ',
          'In the golden light of the fading sun, ',
          'Each moment bloomed like jasmine at dusk: ',
        ];
        buffer.writeln('${romanticPhrases[i % romanticPhrases.length]}${s.toLowerCase()}.\n');
      }
    }

    return buffer.toString().trim();
  }

  static String _transformSciFi(String raw) {
    final sentences = raw.split(RegExp(r'[.!?]+'));
    final buffer = StringBuffer();

    buffer.writeln('Personal Log — Stardate ${DateTime.now().millisecondsSinceEpoch ~/ 86400000}. Sector: Earth.\n');

    for (int i = 0; i < sentences.length; i++) {
      final s = sentences[i].trim();
      if (s.isEmpty) continue;

      if (i == 0) {
        buffer.writeln('The neural interface recorded the first anomaly at dawn: $s. Cross-referencing with the cognitive archive.\n');
      } else if (i == sentences.length - 1) {
        buffer.writeln('Final entry before the temporal shift: $s. The quantum probability matrix suggests tomorrow will be... different. End log.');
      } else {
        final sciFiPhrases = [
          'Scanning bio-emotional wavelength: ',
          'The artificial horizon computed: ',
          'Data fragments from the memory core revealed: ',
          'Initiating deep-thought subroutine — result: ',
          'The holographic display flickered with a truth: ',
        ];
        buffer.writeln('${sciFiPhrases[i % sciFiPhrases.length]}${s.toLowerCase()}.\n');
      }
    }

    return buffer.toString().trim();
  }

  static String _transformMinimalist(String raw) {
    final sentences = raw.split(RegExp(r'[.!?]+'));
    final buffer = StringBuffer();

    buffer.writeln('Today.\n');

    for (int i = 0; i < sentences.length; i++) {
      final s = sentences[i].trim();
      if (s.isEmpty) continue;

      // Minimalist — short, clean, powerful
      final words = s.split(' ');
      if (words.length > 6) {
        buffer.writeln('${words.take(6).join(' ')}.');
        buffer.writeln('${words.skip(6).join(' ')}.\n');
      } else {
        buffer.writeln('$s.\n');
      }
    }

    buffer.writeln('That was enough.');

    return buffer.toString().trim();
  }

  static String _transformHindi(String raw, Genre genre) {
    final buffer = StringBuffer();

    switch (genre) {
      case Genre.noir:
        buffer.writeln('शहर कभी नहीं सोता, और न ही आज की यादें।\n');
        buffer.writeln(raw);
        buffer.writeln('\nपरछाइयाँ सब जानती थीं, पर वो बोलने वाली नहीं थीं।');
        break;
      case Genre.romantic:
        buffer.writeln('आज का दिन उन रंगों में रंगा था जो सिर्फ दिल देख सकता है।\n');
        buffer.writeln(raw);
        buffer.writeln('\nऔर जब तारों ने अपना प्राचीन नृत्य शुरू किया, हर पल चमेली की तरह खिल उठा।');
        break;
      case Genre.sciFi:
        buffer.writeln('व्यक्तिगत लॉग — तारांक ${DateTime.now().millisecondsSinceEpoch ~/ 86400000}. सेक्टर: पृथ्वी.\n');
        buffer.writeln(raw);
        buffer.writeln('\nक्वांटम संभावना मैट्रिक्स कहता है कल... अलग होगा। लॉग समाप्त।');
        break;
      case Genre.minimalist:
        buffer.writeln('आज।\n');
        buffer.writeln(raw);
        buffer.writeln('\nबस। इतना काफी था।');
        break;
    }

    return buffer.toString().trim();
  }
}
