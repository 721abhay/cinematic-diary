
/// A massive offline repository of cinematic phrases, intros, bridges, and words.
/// By having hundreds of variations, the permutations are in the millions,
/// ensuring the user never feels the app is repeating itself.
class CinematicCorpus {
  // --- NOIR DICTIONARY ---
  static const List<String> noirNegativeIntros = [
    'The rain didn\'t stop today, and neither did the ghosts.',
    'Another day chewed up and spat out by the city.',
    'The concrete was cold, much like the reality I woke up to.',
    'Sometimes, the shadows speak louder than the people.',
    'A bitter taste of cheap coffee and lingering regret.',
    'The neon signs flickered, mocking my attempts at a quiet day.',
    'Sirens in the distance. Always in the distance.',
    'I should have stayed in bed. The world outside was unforgiving.',
    'Grey skies, grey thoughts. That\'s how the story usually begins here.',
    'A day meant for forgetting, etched permanently into the record.',
  ];

  static const List<String> noirPositiveIntros = [
    'A rare quiet in a loud world.',
    'The cigarette smoke cleared just long enough to see the truth.',
    'Surprisingly, the city didn\'t try to break me today.',
    'A fleeting moment of sanity in an insane metropolis.',
    'The sun peeked through the smog, almost like an apology.',
    'A small victory. In this town, you take what you can get.',
    'For once, the shadows hid something beautiful.',
    'I found a silver lining wrapped in the bleak afternoon haze.',
    'The clock ticked a little slower today. A welcome mercy.',
    'A decent day. I\'ll write it down before the city steals it back.',
  ];

  static const List<String> noirBridges = [
    'I took a breath. ', 
    'Funny how things work out. ', 
    'Under the flickering streetlights, ', 
    'A thought crossed my mind like a stray bullet: ',
    'I leaned against the brick wall and realized, ',
    'The whiskey didn\'t help, but the thought remained. ',
    'Through the haze of the afternoon, ',
    'The streets had their own version of the truth: ',
    'Nobody asked, but the silence spoke volumes: ',
    'I muttered to myself, ',
    'I looked at my reflection in the dirty puddle. ',
    'The rhythmic tapping of the rain agreed. ',
    'A distant train whistle blew as I concluded: ',
    'The detective in my head scribbled a note: ',
    'It hit me like a cold breeze from the harbor. ',
  ];

  static const List<String> noirOutros = [
    'Nobody asked, but the silence spoke volumes.',
    'That\'s the truth. Or at least, the version I\'m sticking to.',
    'Tomorrow is another case entirely.',
    'I pulled my collar up against the chill, ready for whatever was next.',
    'The shadows grew longer, swallowing the day whole.',
    'Case closed. For now.',
    'Some memories you keep. Others you leave in the ashtray.',
    'The city went to sleep. I stayed awake.',
    'Just another page in a very dark notebook.',
    'I walked away, leaving the echoes behind.',
  ];

  static const Map<String, List<String>> noirVocab = {
    'bad': ['grim', 'corrupt', 'stained', 'shadowed', 'rotten', 'crooked', 'bleak', 'sinister'],
    'sad': ['melancholy', 'drowning in shadows', 'hollow', 'desolate', 'haunted', 'heavy'],
    'good': ['tolerable', 'a rare stroke of luck', 'untainted', 'decent', 'clean', 'fair'],
    'happy': ['briefly sane', 'grinning in the dark', 'foolishly content', 'satisfactory'],
    'tired': ['exhausted down to the bone', 'running on fumes and bad coffee', 'drained', 'worn out'],
    'car': ['rusty engine', 'steel coffin', 'getaway ride', 'battered sedan'],
    'city': ['concrete jungle', 'neon-lit labyrinth', 'asphalt monster', 'forgiving metropolis'],
    'saw': ['witnessed', 'glimpsed through the smoke', 'spotted in the reflection'],
    'talked': ['interrogated', 'muttered', 'exchanged quiet words', 'spilled the truth'],
    'went': ['prowled', 'navigated the alleys to', 'slunk towards', 'ambled down to'],
    'want': ['crave', 'seek', 'dwell on the need for', 'hunt for'],
    'eat': ['consume', 'dine in silence', 'fuel the addiction'],
    'work': ['the grind', 'serving the machine', 'clocking in with the devil'],
  };

  // --- ROMANTIC DICTIONARY ---
  static const List<String> romanticPositiveIntros = [
    'Today was painted in colors that only the heart can truly see.',
    'The morning unfolded like a delicate love letter.',
    'A gentle breeze whispered promises of a beautiful day.',
    'Sunlight danced across the room, waking my soul.',
    'There was music in the air today, a silent, sweet melody.',
    'Every moment felt like a scene from an old romantic film.',
    'My heart felt lighter than the morning mist.',
    'A day woven with golden threads and quiet joy.',
    'I found poetry in the mundane today.',
    'The world seemed to blush with an unexpected grace.',
  ];

  static const List<String> romanticNegativeIntros = [
    'Even the clouds seemed to hold a heavy, poetic silence today.',
    'A gray veil draped over the world, mirroring my wistful heart.',
    'The rain wept softly against the glass, a symphony of longing.',
    'A day of gentle ache and fading light.',
    'There is a certain beauty in melancholy, and today I felt it deeply.',
    'The wind carried a sigh that seemed meant only for me.',
    'Sometimes, the heart needs a quiet, sunless day to heal.',
    'Colors muted, sounds softened. A day for introspection.',
    'A tender sorrow lingered in the air, sweet but undeniable.',
    'The shadows whispered of things lost and deeply missed.',
  ];

  static const List<String> romanticBridges = [
    'Like petals catching the wind, ',
    'With every heartbeat, ',
    'The universe conspired beautifully— ',
    'I found myself smiling at the thought. ',
    'Time seemed to stand still for a heartbeat as ',
    'Wrapped in the warmth of the moment, ',
    'A quiet realization bloomed inside me: ',
    'Under the vast, silent sky, ',
    'With a fragile hope, ',
    'The air grew thick with unspoken words: ',
    'I closed my eyes and felt it: ',
    'A fleeting, breathless second passed. ',
    'My heart fluttered like a captured bird. ',
    'In the golden light of the fading sun, ',
    'I let out a breath I didn\'t know I was holding. ',
  ];

  static const List<String> romanticOutros = [
    'A perfect coda to a day wrapped in feeling.',
    'As the stars begin their ancient waltz, I whisper to the night.',
    'I will hold this memory like a pressed flower in a book.',
    'And so, the day gently falls asleep in my arms.',
    'With a full heart, I bid the sun farewell.',
    'Another chapter written in the ink of my soul.',
    'I close my eyes, letting the sweetness linger.',
    'The moon now takes the watch over my dreaming heart.',
    'A sigh escapes my lips. Goodnight, beautiful world.',
    'I tuck this day away, safe and cherished forever.',
  ];

  static const Map<String, List<String>> romanticVocab = {
    'bad': ['heartbreaking', 'shrouded in grey', 'a quiet tragedy', 'sorrowful', 'wistful'],
    'sad': ['weeping', 'heavy with unshed tears', 'yearning', 'melancholic', 'tenderly sorrowful'],
    'good': ['enchanting', 'radiant', 'woven with starlight', 'breathtaking', 'heavenly'],
    'happy': ['euphoric', 'dancing on air', 'blissful', 'glowing', 'overjoyed'],
    'tired': ['softly fading', 'ready for a peaceful slumber', 'languid', 'gently weary'],
    'beautiful': ['breathtaking', 'angelic', 'captivating', 'exquisite', 'ethereal'],
    'saw': ['gazed upon', 'beheld', 'admired', 'caught sight of'],
    'talked': ['whispered', 'murmured', 'shared secrets', 'spoke from the heart'],
    'went': ['wandered', 'strolled lazily to', 'drifted towards', 'journeyed to'],
    'want': ['long for', 'yearn for', 'dream of', 'ache for'],
    'eat': ['delight in', 'savor the flavors of', 'feast upon'],
    'work': ['my devotion', 'my labor of love', 'the quiet dance of productivity'],
  };

  // --- SCI-FI DICTIONARY ---
  static const List<String> sciFiPositiveIntros = [
    'System initialization successful. The day\'s parameters operated within optimal ranges.',
    'A stellar rotation marked by high-frequency positive anomalies.',
    'The cognitive matrix processed an unusually high volume of joy-data today.',
    'Energy reserves peaked. A brilliant day in the cosmic calendar.',
    'Navigating the day\'s orbit was smoother than calculated projections.',
    'All systems green. The localized environment provided excellent stimuli.',
    'A rare convergence of favorable probability matrices occurred.',
    'Harmonic frequencies detected across all sensory inputs.',
    'The daily cycle completed with maximum efficiency and high morale.',
    'Atmospheric conditions optimal for human flourishing.',
  ];

  static const List<String> sciFiNegativeIntros = [
    'Warning: Emotional matrix detecting high levels of cognitive dissonance. Initiating recording.',
    'System errors logged. The solar cycle was fraught with unexpected friction.',
    'Energy reserves critically low. A challenging rotation through the sector.',
    'Gravitational anomalies detected in the emotional processing center.',
    'A day defined by high entropy and data corruption.',
    'Shields operating at maximum capacity to repel negative environmental feedback.',
    'The central processing unit struggled with today\'s illogical inputs.',
    'Alert: Sustained exposure to suboptimal circumstances recorded.',
    'navigating through a dense asteroid field of problems today.',
    'A dark matter day. Heavy, dense, and difficult to parse.',
  ];

  static const List<String> sciFiBridges = [
    'Scanning bio-wavelengths... ',
    'Data fragments from the memory core reveal: ',
    'Cross-referencing logic banks: ',
    'The optical sensors registered a discrepancy. ',
    'Initiating deep-thought subroutine—result: ',
    'The artificial horizon computed the following: ',
    'A spike in the telemetry indicated that ',
    'Re-calibrating neural pathways to process this: ',
    'The holographic display flickered with a truth: ',
    'Calculating the probability of success... ',
    'A glich in the matrix presented an unusual scenario: ',
    'Transmitting data packet to long-term storage. ',
    'The internal chronometer seemed to slow as ',
    'Engaging hyper-drive on this specific thought: ',
    'The primary directive mandated that ',
  ];

  static const List<String> sciFiOutros = [
    'The quantum probability matrix suggests tomorrow will be different. End log.',
    'Powering down for mandatory recharge cycle. Transmission ended.',
    'Data logged and encrypted. Awaiting next solar rotation.',
    'System entering sleep mode. Goodnight, sector.',
    'The stars remain indifferent. Comm-link severed.',
    'Archiving this cycle in the permanent mainframe.',
    'Diagnostics complete. Ready for tomorrow\'s unknown variables.',
    'Hypersleep sequence initiated. Closing file.',
    'The simulation continues. Signing off.',
    'May the universal algorithms favor the next rotation.',
  ];

  static const Map<String, List<String>> sciFiVocab = {
    'bad': ['sub-optimal', 'critical failure', 'corrupted', 'malfunctioning', 'anomalous'],
    'sad': ['experiencing emotional entropy', 'reporting low dopamine reserves', 'system depression'],
    'good': ['functioning optimally', 'stellar', 'quantum-aligned', 'highly efficient'],
    'happy': ['euphoric algorithm engaged', 'operating at peak efficiency', 'experiencing joy overflow'],
    'tired': ['power levels critical', 'requiring immediate recharge cycle', 'depleted'],
    'car': ['transport pod', 'ground vehicle', 'personal rover', 'hover-craft'],
    'city': ['megapolis', 'urban sector', 'concrete grid', 'habitation zone'],
    'saw': ['scanned', 'detected via optical sensors', 'registered on the visual feed'],
    'talked': ['transmitted audio data to', 'comm-linked with', 'exchanged vocal protocols'],
    'went': ['navigated coordinates to', 'transported to', 'relocated physical chassis to'],
    'want': ['require', 'command', 'program for', 'calculate a need for'],
    'eat': ['recharge via biological fuel', 'intake nutrients', 'execute nutrition protocol'],
    'work': ['processing tasks', 'operational maintenance', 'system uptime'],
  };
}

class HindiCinematicCorpus {
  // --- NOIR (Noir/Dark/Urban) ---
  static const List<String> noirIntros = [
    'शहर की रूह आज कुछ ज़्यादा ही काली लग रही थी।',
    'धुआँ, अंधेरा और एक अधूरी कहानी।',
    'सपनों की इस नगरी में आज एक हकीकत ने दम तोड़ दिया।',
    'खामोशी बहुत कुछ कहती है, अगर सुनने वाला कोई हो।',
    'आज की रात उन लोगों के लिए थी जो उजाले से डरते हैं।',
  ];

  static const List<String> noirBridges = [
    'हवाओं में एक अजीब सी कड़वाहट थी। ',
    'मैंने अपने आस-पास देखा और महसूस किया— ',
    'सच तो ये है कि— ',
    'परछाइयाँ भी आज मुझसे कुछ छिपा रही थीं। ',
    'वक़्त का कांटा जैसे थम सा गया था। ',
  ];

  static const List<String> noirOutros = [
    'कहानी अभी खत्म नहीं हुई है, बस पन्ना पलटा है।',
    'अंधेरा गहरा गया, और शहर सो गया। पर मैं नहीं।',
    'कल फिर वही खेल शुरू होगा।',
    'कुछ राज़ दफन ही अच्छे लगते हैं।',
    'अंत? शायद नहीं। बस एक ठहराव।',
  ];

  // --- ROMANTIC (Poetic/Sweet) ---
  static const List<String> romanticIntros = [
    'फिज़ाओं में आज एक नई महक घुली हुई थी।',
    'शायद आज का दिन मोहब्बत के नाम था।',
    'धूप की सुनहरी किरणों ने आज रूह को छू लिया।',
    'मौसम का मिजाज आज कुछ शायराना सा था।',
    'साँसों में एक धीमी सी सरगम बज रही थी।',
  ];

  static const List<String> romanticBridges = [
    'जैसे किसी ने चुपके से कोई राज़ कह दिया हो— ',
    'दिल की धड़कनों ने एक नया गीत छेड़ दिया। ',
    'कायनात जैसे मेरे हक़ में गवाही दे रही थी। ',
    'मुस्कुराहट खुद-ब-खुद लबों पर आ गई। ',
    'हर पल एक नई उम्मीद लेकर आया। ',
  ];

  static const List<String> romanticOutros = [
    'चाँद की चांदनी में आज एक सुकून था।',
    'ये लम्हे हमेशा के लिए दिल में कैद हो गए।',
    'शुक्रिया खुदा का, इस हसीन दिन के लिए।',
    'रात की आगोश में, एक मीठा सा सपना।',
    'बस, यही तो ज़िंदगी है।',
  ];

  // --- SCI-FI (Future/Space) ---
  static const List<String> sciFiIntros = [
    'डेटा स्ट्रीम का विश्लेषण: आज का दिन सामान्य नहीं था।',
    'सिस्टम में एक अजीब सा ग्लिच महसूस हुआ।',
    'ऊर्जा का स्तर आज सामान्य से अधिक था।',
    'न्यूरल लिंक ने एक अजीब संदेश रिसीव किया।',
    'भविष्य की परछाइयाँ आज साफ़ दिखाई दे रही थीं।',
  ];

  static const List<String> sciFiBridges = [
    'मैकेनिकल प्रोसेसिंग के दौरान पता चला कि— ',
    'हवाओं में नैनो-पार्टिकल्स की हरकत बढ़ गई थी। ',
    'लॉजिक कहता है कि मुमकिन नहीं, पर— ',
    'टाइम और स्पेस का तालमेल आज कुछ अलग था। ',
    'सिस्टम ने एक नई संभावना को स्कैन किया। ',
  ];

  static const List<String> sciFiOutros = [
    'लॉग एन्क्रिप्ट कर दिया गया है। गुडनाइट, अर्थ सेक्टर।',
    'डेटा सेव कर लिया गया है। कल की संभावनाएँ अनंत हैं।',
    'कनेक्शन लॉस्ट।',
    'अगली रोटेशन तक के लिए शटडाउन।',
    'यूनिवर्स का एल्गोरिदम हमेशा सही होता है।',
  ];

  static const Map<String, List<String>> vocab = {
    'bad': ['भयावह', 'अशुभ', 'कठिन', 'उलझा हुआ', 'खराब'],
    'sad': ['ग़मगीन', 'उदास', 'मायूस', 'अकेला', 'दर्दनाक'],
    'good': ['बेहतरीन', 'उम्दा', 'लाजवाब', 'सुखद', 'अच्छा'],
    'happy': ['प्रफुल्लित', 'खुशमिज़ाज', 'मगन', 'आनंदमय'],
    'beautiful': ['हसीन', 'खूबसूरत', 'लाजवाब', 'दिलकश', 'सुंदर'],
    'went': ['की ओर कदम बढ़ाए', 'की जानिब रवाना हुआ', 'वहाँ पहुँचा'],
    'saw': ['नज़ारा किया', 'पाया', 'महसूस किया', 'देखा'],
    'tired': ['थकान से चूर', 'बेहाल', 'सुकून की तलाश में'],
  };
}
