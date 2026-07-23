import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> bulkUploadQuestionsBatch6() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();
  final collection = firestore.collection('questions');

  for (final q in _batch6Questions) {
    final docRef = collection.doc();
    batch.set(docRef, q);
  }

  try {
    await batch.commit();
    debugPrint(
      '✅ Uploaded ${_batch6Questions.length} questions (Batch 6 - FINAL)',
    );
  } catch (e) {
    debugPrint('❌ Bulk upload failed: $e');
  }
}

final List<Map<String, dynamic>> _batch6Questions = [
  // ================= GENERAL (20) =================
  {
    'category': 'General',
    'question': 'What is the term for a person who cannot hear?',
    'options': ['Blind', 'Deaf', 'Mute', 'Dumb'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a traditional Indian dish made from lentils?',
    'options': ['Dal', 'Sabzi', 'Roti', 'Raita'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'What is the term for a baby goat?',
    'options': ['Lamb', 'Kid', 'Calf', 'Foal'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'Which of these shapes has exactly seven sides?',
    'options': ['Hexagon', 'Heptagon', 'Octagon', 'Nonagon'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'What is the common name for the study of maps and mapmaking?',
    'options': ['Geography', 'Cartography', 'Topology', 'Geology'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct term for a person who cannot speak?',
    'options': ['Deaf', 'Blind', 'Mute', 'Paralyzed'],
    'correctAnswerIndex': 2,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Indian bread cooked in a tandoor (clay oven)?',
    'options': ['Chapati', 'Naan', 'Paratha', 'Puri'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these animals is known for its ability to regenerate lost limbs?',
    'options': [
      'Frog',
      'Starfish',
      'Lizard (tail only)',
      'Both starfish and lizard show regeneration',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'What is the term for a shape with twelve sides?',
    'options': ['Decagon', 'Dodecagon', 'Undecagon', 'Icosagon'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a common Indian pickle ingredient known for its sourness?',
    'options': [
      'Mango',
      'Lemon',
      'Both mango and lemon are common',
      'Tamarind',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the correct term for a shape with no straight sides at all?',
    'options': ['Polygon', 'Curve/Circle', 'Vertex', 'Line'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these festivals involves flying kites and is celebrated in India in January?',
    'options': ['Holi', 'Makar Sankranti', 'Diwali', 'Navratri'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the common name for a young human being before adulthood?',
    'options': [
      'Infant only',
      'Child',
      'Adolescent only',
      'Child covers a broad range including infant and adolescent',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a traditional Indian sweet made by deep frying dough in sugar syrup?',
    'options': ['Barfi', 'Jalebi', 'Ladoo', 'Halwa'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the term for the study of ancient and fossilized remains of organisms?',
    'options': ['Archaeology', 'Paleontology', 'Anthropology', 'Geology'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for a female horse?',
    'options': ['Stallion', 'Mare', 'Foal', 'Colt'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Indian attire worn by women, consisting of a long piece of fabric draped around the body?',
    'options': ['Salwar Kameez', 'Saree', 'Lehenga', 'Ghagra'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a unit of measurement for the weight of precious gems?',
    'options': ['Ounce', 'Carat', 'Gram', 'Pound'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a person who cuts and styles hair professionally?',
    'options': ['Tailor', 'Barber', 'Beautician', 'Cobbler'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct term for the sound a lion makes?',
    'options': ['Growl', 'Roar', 'Howl', 'Bark'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },

  // ================= SCIENCE (20) =================
  {
    'category': 'Science',
    'question': 'What is the chemical symbol for lead?',
    'options': ['Ld', 'Le', 'Pb', 'Pl'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these is a function of the human liver?',
    'options': [
      'Pump blood',
      'Detoxify harmful substances',
      'Produce sound',
      'Regulate temperature only',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the layer of the atmosphere that contains the ozone layer?',
    'options': ['Troposphere', 'Stratosphere', 'Mesosphere', 'Thermosphere'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is a common example of a non-Newtonian fluid used in science demonstrations?',
    'options': [
      'Water',
      'Cornstarch and water mixture (oobleck)',
      'Oil',
      'Milk',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the process by which plants lose water vapor through their leaves?',
    'options': ['Photosynthesis', 'Transpiration', 'Respiration', 'Absorption'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these elements is used in the core of nuclear reactors?',
    'options': ['Carbon', 'Uranium', 'Iron', 'Aluminum'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'What is the medical term for the study of the nervous system?',
    'options': ['Cardiology', 'Neurology', 'Nephrology', 'Pulmonology'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the term for the number of protons plus neutrons in an atom?',
    'options': ['Atomic number', 'Mass number', 'Valence', 'Isotope number'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for animals that maintain a constant internal body temperature?',
    'options': ['Ectotherms', 'Endotherms', 'Poikilotherms', 'Heliotherms'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the correct order of the electromagnetic spectrum from longest to shortest wavelength (partial)?',
    'options': [
      'Radio, Microwave, Infrared, Visible',
      'Visible, Infrared, Microwave, Radio',
      'Gamma, X-ray, UV, Visible',
      'UV, Visible, Infrared, Radio',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'What is the common name for the compound NaHCO3?',
    'options': ['Table salt', 'Baking soda', 'Washing soda', 'Caustic soda'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the term for a substance that cannot be broken down into simpler substances chemically?',
    'options': ['Compound', 'Mixture', 'Element', 'Solution'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the study of the effects of drugs on the body?',
    'options': ['Toxicology', 'Pharmacology', 'Physiology', 'Pathology'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these organs is responsible for filtering blood and producing urine?',
    'options': ['Liver', 'Kidney', 'Bladder', 'Pancreas'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the point where an object floats neither sinking nor rising in a fluid?',
    'options': [
      'Equilibrium',
      'Buoyancy point',
      'Neutral buoyancy',
      'Density balance',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these vitamins is important for good vision?',
    'options': ['Vitamin A', 'Vitamin B', 'Vitamin E', 'Vitamin K'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the natural process by which the sun\'s energy is converted to chemical energy in plants?',
    'options': ['Respiration', 'Photosynthesis', 'Digestion', 'Fermentation'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these describes the movement of molecules from high to low concentration?',
    'options': ['Osmosis', 'Diffusion', 'Active transport', 'Filtration'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the scientific study of weather patterns and forecasting?',
    'options': ['Climatology', 'Meteorology', 'Geology', 'Oceanography'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the correct term for an organism that decomposes dead organic matter?',
    'options': ['Producer', 'Consumer', 'Decomposer', 'Predator'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },

  // ================= HISTORY (20) =================
  {
    'category': 'History',
    'question': 'Who was the founder of the Gupta Empire?',
    'options': [
      'Chandragupta I',
      'Samudragupta',
      'Chandragupta II',
      'Kumaragupta',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which country was the first to industrialize during the Industrial Revolution?',
    'options': ['Germany', 'England', 'France', 'USA'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Who was the leader of the Indian National Congress during the Non-Cooperation Movement?',
    'options': [
      'Motilal Nehru',
      'Mahatma Gandhi',
      'C.R. Das',
      'Lala Lajpat Rai',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The ancient Library of Nalanda was a famous center of learning located in which present-day Indian state?',
    'options': ['Uttar Pradesh', 'Bihar', 'West Bengal', 'Madhya Pradesh'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Who was the first emperor of the Roman Empire?',
    'options': ['Julius Caesar', 'Augustus', 'Nero', 'Constantine'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which Indian state was known as the princely state of Hyderabad before its integration into India?',
    'options': [
      'Telangana region',
      'Andhra Pradesh coastal region',
      'Karnataka',
      'Maharashtra',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'The Panama Canal connects which two oceans?',
    'options': [
      'Atlantic and Indian',
      'Pacific and Atlantic',
      'Pacific and Indian',
      'Arctic and Pacific',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question': 'Who was the last emperor of China?',
    'options': [
      'Guangxu Emperor',
      'Puyi',
      'Qianlong Emperor',
      'Kangxi Emperor',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian leader is credited with the establishment of the Indian Space Research Organisation (ISRO)?',
    'options': [
      'Homi Bhabha',
      'Vikram Sarabhai',
      'APJ Abdul Kalam',
      'C.V. Raman',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The ancient Aryan migration theory is associated with which period of Indian history?',
    'options': [
      'Indus Valley period',
      'Vedic period',
      'Mauryan period',
      'Gupta period',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the British East India Company official who won the Battle of Plassey?',
    'options': [
      'Robert Clive',
      'Warren Hastings',
      'Lord Cornwallis',
      'Lord Dalhousie',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Which country was formerly known as Ceylon?',
    'options': ['Maldives', 'Sri Lanka', 'Myanmar', 'Bangladesh'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Who was the Indian Prime Minister who introduced economic liberalization reforms in 1991?',
    'options': [
      'Rajiv Gandhi',
      'P.V. Narasimha Rao',
      'V.P. Singh',
      'Chandra Shekhar',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The ancient wonder "Temple of Artemis" was located in which present-day country?',
    'options': ['Greece', 'Turkey', 'Egypt', 'Italy'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Who was the first Secretary-General of the United Nations?',
    'options': ['Dag Hammarskjold', 'Trygve Lie', 'U Thant', 'Kurt Waldheim'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian dynasty is credited with building the famous Konark Sun Temple?',
    'options': ['Chola', 'Eastern Ganga dynasty', 'Pala', 'Chalukya'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The Berlin Airlift took place during which major geopolitical period?',
    'options': ['World War II', 'Cold War', 'World War I', 'Vietnam War'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the Mughal emperor known for his religious tolerance and marriage alliances with Rajput kingdoms?',
    'options': ['Babur', 'Humayun', 'Akbar', 'Jahangir'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question': 'Which country dropped the first atomic bomb used in warfare?',
    'options': ['Germany', 'USA', 'Soviet Union', 'Japan'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The Indian freedom struggle\'s "Swadeshi Movement" primarily promoted what?',
    'options': [
      'Foreign investment',
      'Use of Indian-made goods, boycotting British products',
      'Religious unity',
      'Educational reforms',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },

  // ================= GEOGRAPHY (20) =================
  {
    'category': 'Geography',
    'question': 'Which Indian city is known as the "Garden City of India"?',
    'options': ['Chandigarh', 'Bangalore', 'Mysore', 'Pune'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Libya?',
    'options': ['Benghazi', 'Tripoli', 'Misrata', 'Sabha'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which Indian river originates from the Gangotri glacier?',
    'options': ['Yamuna', 'Ganges', 'Brahmaputra', 'Indus'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Tunisia?',
    'options': ['Sfax', 'Tunis', 'Sousse', 'Bizerte'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which Indian state is bordered by both Pakistan and China?',
    'options': [
      'Punjab',
      'Jammu and Kashmir/Ladakh',
      'Himachal Pradesh',
      'Rajasthan',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Algeria?',
    'options': ['Oran', 'Algiers', 'Constantine', 'Annaba'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian hill station is known for its tea gardens and is called the "Tea Capital of India"?',
    'options': ['Munnar', 'Darjeeling', 'Ooty', 'Coorg'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Zimbabwe?',
    'options': ['Bulawayo', 'Harare', 'Mutare', 'Gweru'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which is the largest Indian state by population?',
    'options': ['Maharashtra', 'Uttar Pradesh', 'Bihar', 'West Bengal'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Ghana?',
    'options': ['Kumasi', 'Accra', 'Tamale', 'Cape Coast'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which country is home to the Amazon River\'s source in the Andes mountains?',
    'options': ['Brazil', 'Peru', 'Colombia', 'Ecuador'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Senegal?',
    'options': ['Dakar', 'Thies', 'Touba', 'Saint-Louis'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which Indian city is the capital of Karnataka?',
    'options': ['Mysore', 'Bangalore', 'Mangalore', 'Hubli'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Uganda?',
    'options': ['Entebbe', 'Kampala', 'Jinja', 'Gulu'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which continent is bordered by both the Atlantic and Indian Oceans?',
    'options': ['Asia', 'Africa', 'Australia', 'Europe'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Tanzania (official capital)?',
    'options': ['Dar es Salaam', 'Dodoma', 'Arusha', 'Zanzibar City'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which Indian state is famous for the Khajuraho temples?',
    'options': ['Uttar Pradesh', 'Madhya Pradesh', 'Rajasthan', 'Gujarat'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Rwanda?',
    'options': ['Butare', 'Kigali', 'Gisenyi', 'Musanze'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is famously known for the Golden Temple, a major Sikh pilgrimage site?',
    'options': ['Chandigarh', 'Amritsar', 'Ludhiana', 'Jalandhar'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Angola?',
    'options': ['Huambo', 'Luanda', 'Lobito', 'Benguela'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= SPORTS (20) =================
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer is the youngest to score a double century in ODI cricket?',
    'options': ['Rohit Sharma', 'Ishan Kishan', 'Shubman Gill', 'Virat Kohli'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the position of a player who plays closest to the opponent\'s goal in football?',
    'options': ['Defender', 'Striker/Forward', 'Midfielder', 'Goalkeeper'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian city hosts the annual Wankhede Stadium cricket matches?',
    'options': ['Delhi', 'Mumbai', 'Kolkata', 'Chennai'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a golf shot that goes directly into the hole from the tee?',
    'options': ['Eagle', 'Hole-in-one', 'Birdie', 'Albatross'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian sport is played on a rectangular court with seven players per side trying to touch and return to their half?',
    'options': [
      'Kho-Kho',
      'Kabaddi',
      'Both Kho-Kho and Kabaddi fit this general description',
      'Lagori',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a serve that is illegal or lands outside the correct box in tennis?',
    'options': ['Ace', 'Fault', 'Let', 'Winner'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'Which country has traditionally dominated men\'s field hockey Olympic gold medals since the 1980s?',
    'options': ['India', 'Netherlands', 'Germany', 'Australia'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the referee\'s decision to add extra playing time at the end of a football half?',
    'options': [
      'Overtime',
      'Stoppage time/Injury time',
      'Extra time',
      'Sudden death',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer scored the first double century in T20 international cricket?',
    'options': [
      'Rohit Sharma',
      'Suryakumar Yadav',
      'K.L. Rahul',
      'Virat Kohli',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a match that ends in a draw after extra time in a football knockout, requiring further tiebreaker?',
    'options': [
      'Replay',
      'Penalty shootout',
      'Golden goal (older rule)',
      'Both penalty shootout and golden goal have been used historically',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian gymnast became the first Indian woman to win an Olympic medal in gymnastics?',
    'options': [
      'Dipa Karmakar (finished 4th, no medal)',
      'No Indian woman has won an Olympic gymnastics medal yet',
      'Aruna Reddy',
      'Pranati Nayak',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the area behind the baseline in tennis where players typically stand to serve?',
    'options': ['Service box', 'Baseline area', 'Deuce court', 'Ad court'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian sport involves balancing and performing acrobatics on a vertical pole?',
    'options': ['Malkhamb', 'Kalaripayattu', 'Silambam', 'Gatka'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a batsman scoring runs by hitting the ball and running between the wickets, without a boundary?',
    'options': ['Boundary run', 'Running between the wickets', 'Bye', 'Extra'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which country hosted the first-ever Cricket World Cup in 1975?',
    'options': ['Australia', 'England', 'India', 'West Indies'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a wrestling technique where a wrestler lifts and slams the opponent?',
    'options': ['Suplex', 'Takedown', 'Reversal', 'Pin'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian sport is played using a small ball called "kancha" or marbles?',
    'options': ['Kancha/Marbles', 'Gilli-danda', 'Lattoo', 'Pithoo'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a football team\'s formation with four defenders, four midfielders, and two strikers?',
    'options': ['4-3-3', '4-4-2', '3-5-2', '4-2-3-1'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian city is home to the Eden Gardens cricket stadium?',
    'options': ['Mumbai', 'Kolkata', 'Chennai', 'Delhi'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the highest individual score achieved by a batsman in a single Test innings, held by Brian Lara?',
    'options': [
      '375',
      '400 not out',
      '365',
      '501 not out (first-class, not Test)',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= ENTERTAINMENT (20) =================
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known as the "Wall" of Bollywood for his stoic on-screen persona in the 1970s?',
    'options': [
      'Amitabh Bachchan',
      'Dharmendra',
      'Rajesh Khanna',
      'Vinod Khanna',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional street where Sesame Street is set?',
    'options': [
      'Sesame Street itself is the name',
      'Main Street',
      'Elm Street',
      'Grove Street',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian musician is known for blending classical Indian music with electronic sounds, popular in the 1990s-2000s?',
    'options': [
      'A.R. Rahman',
      'Bally Sagoo',
      'Talvin Singh',
      'All three are known for this fusion',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the popular animated series featuring a family of superheroes?',
    'options': [
      'The Incredibles',
      'Big Hero 6',
      'Justice League',
      'Teen Titans',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian film is known for the record of being India\'s first submission that won the Oscar for Best International Feature category consideration (nominated notably)?',
    'options': [
      'Lagaan',
      'Mother India',
      'Salaam Bombay!',
      'All three were nominated at different times',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional pirate captain in "Peter Pan"?',
    'options': [
      'Captain Hook',
      'Long John Silver',
      'Blackbeard',
      'Captain Flint',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian singer is known for devotional and Sufi music, including popular renditions of "Kun Faya Kun"?',
    'options': [
      'A.R. Rahman (composer/singer)',
      'Javed Ali',
      'Mohit Chauhan',
      'All three contributed to this song',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizarding chess variant played in Harry Potter with living pieces?',
    'options': [
      'Wizard Chess',
      'Gobstones',
      'Exploding Snap',
      'Wizard Chess is correct',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for method acting in films like "Gangs of Wasseypur" and "Raman Raghav 2.0"?',
    'options': [
      'Nawazuddin Siddiqui',
      'Manoj Bajpayee',
      'Both are known for intense method-acting roles',
      'Pankaj Tripathi',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional band featured in the movie "School of Rock"?',
    'options': [
      'School of Rock (the band name in film)',
      'The Rockers',
      'Battle of the Bands',
      'No specific band name given',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian classical vocalist is known as one of the greatest exponents of Hindustani classical music, often called "Bharat Ratna" recipient?',
    'options': [
      'Pandit Bhimsen Joshi',
      'Ustad Bismillah Khan',
      'M.S. Subbulakshmi',
      'All three are Bharat Ratna recipients in music',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional superhero group led by Professor Charles Xavier?',
    'options': ['Avengers', 'X-Men', 'Justice League', 'Fantastic Four'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for his negative roles in films like "Sholay" and "Don" during the 1970s-80s?',
    'options': [
      'Amjad Khan',
      'Pran',
      'Amrish Puri',
      'All three were prominent villain actors',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional talking horse in the classic TV show "Mister Ed"?',
    'options': ['Mister Ed', 'Silver', 'Trigger', 'Black Beauty'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress is known for winning the Miss Universe title in 1994?',
    'options': [
      'Aishwarya Rai',
      'Sushmita Sen',
      'Lara Dutta',
      'Priyanka Chopra',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional evil organization in the "Austin Powers" film series?',
    'options': [
      'SPECTRE',
      'Evil Inc.',
      'The Syndicate',
      'No specific formal name, led by Dr. Evil',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress won the Miss World title in 1994, the same year as Sushmita Sen\'s Miss Universe win?',
    'options': [
      'Aishwarya Rai',
      'Diana Hayden',
      'Yukta Mookhey',
      'Priyanka Chopra',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizarding radio station mentioned in Harry Potter and the Deathly Hallows?',
    'options': [
      'Potterwatch',
      'WWN (Wizarding Wireless Network)',
      'Both Potterwatch and WWN are mentioned',
      'The Daily Prophet Radio',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian composer is known for creating the theme music for Doordarshan and other iconic Indian TV shows?',
    'options': [
      'Vanraj Bhatia',
      'Ravindra Jain',
      'Both are known for TV/film compositions',
      'Louis Banks',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional theme park robot uprising movie starring Yul Brynner?',
    'options': ['Westworld', 'RoboCop', 'The Terminator', 'I, Robot'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
];
