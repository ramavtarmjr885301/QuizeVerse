// bulk_upload_questions_batch5.dart
//
// Same usage as previous batches — copy into your project, call
// `await bulkUploadQuestionsBatch5();` ONCE in main.dart (after Firebase.initializeApp()),
// run the app with a full stop+run (not hot reload), confirm the count increased,
// then REMOVE the call.
//
// This is BATCH 5 — another 180 questions, all different from Batches 1-4.
// Running all five batches gives you 900 total questions.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> bulkUploadQuestionsBatch5() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();
  final collection = firestore.collection('questions');

  for (final q in _batch5Questions) {
    final docRef = collection.doc();
    batch.set(docRef, q);
  }

  try {
    await batch.commit();
    debugPrint('✅ Uploaded ${_batch5Questions.length} questions (Batch 5)');
  } catch (e) {
    debugPrint('❌ Bulk upload failed: $e');
  }
}

final List<Map<String, dynamic>> _batch5Questions = [
  // ================= GENERAL (30) =================
  {
    'category': 'General',
    'question': 'What is the term for a shape with nine sides?',
    'options': ['Octagon', 'Nonagon', 'Decagon', 'Heptagon'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is a common ingredient used to leaven bread?',
    'options': ['Baking soda', 'Yeast', 'Cornstarch', 'Gelatin'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'What is the name for a baby cow?',
    'options': ['Foal', 'Calf', 'Kid', 'Cub'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for writing done by hand?',
    'options': ['Typography', 'Calligraphy', 'Lithography', 'Cartography'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Indian sweet made during Diwali using semolina?',
    'options': ['Sooji Halwa', 'Gulab Jamun', 'Rasgulla', 'Barfi'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'Which of these animals is known for building dams?',
    'options': ['Otter', 'Beaver', 'Muskrat', 'Platypus'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a person who studies the past through artifacts and ruins?',
    'options': [
      'Historian',
      'Archaeologist',
      'Paleontologist',
      'Anthropologist',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a unit used to measure the amount of information in computing?',
    'options': ['Watt', 'Byte', 'Volt', 'Hertz'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'What is the term for a young goat?',
    'options': ['Kid', 'Lamb', 'Foal', 'Fawn'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct term for the study of coins and currency?',
    'options': ['Philately', 'Numismatics', 'Vexillology', 'Heraldry'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional dish made of rice and lentils cooked together, popular across India?',
    'options': ['Biryani', 'Khichdi', 'Pulao', 'Pongal'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'Which of these is a common name for a shooting star?',
    'options': ['Comet', 'Meteor', 'Asteroid', 'Satellite'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a doctor who specializes in skin conditions?',
    'options': ['Cardiologist', 'Dermatologist', 'Neurologist', 'Orthopedist'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for the study of flags?',
    'options': ['Heraldry', 'Vexillology', 'Numismatics', 'Philately'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'What is the traditional headwear worn by Sikh men?',
    'options': ['Pagri/Turban', 'Topi', 'Fez', 'Beret'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a common ingredient in traditional Italian pesto sauce?',
    'options': ['Basil', 'Oregano', 'Thyme', 'Rosemary'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'What is the term for a group of crows?',
    'options': ['Flock', 'Murder', 'Gaggle', 'Covey'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is the largest species of shark?',
    'options': [
      'Great White Shark',
      'Whale Shark',
      'Tiger Shark',
      'Hammerhead Shark',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'What is the term for a fear of enclosed spaces?',
    'options': ['Agoraphobia', 'Claustrophobia', 'Acrophobia', 'Xenophobia'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct name for the study of stamps as a hobby?',
    'options': ['Numismatics', 'Philately', 'Vexillology', 'Cartophily'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Indian dessert made of thin batter fried and soaked in sugar syrup?',
    'options': ['Jalebi', 'Ladoo', 'Barfi', 'Peda'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct term for a scientist who studies weather patterns?',
    'options': ['Meteorologist', 'Geologist', 'Seismologist', 'Astronomer'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'What is the name for a baby horse?',
    'options': ['Colt', 'Foal', 'Both colt and foal are used', 'Filly only'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a traditional unit used to measure the age of a horse or the size of a horse?',
    'options': ['Hands', 'Feet', 'Meters', 'Furlongs'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the term for the collective sound made by a group of dogs?',
    'options': ['Howl', 'Bark', 'Bay', 'All are correct depending on context'],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a common Indian condiment made from mango, spices, and oil?',
    'options': ['Chutney', 'Pickle (Achaar)', 'Raita', 'Sambhar'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'What is the term for a triangle with two equal sides?',
    'options': ['Scalene', 'Isosceles', 'Equilateral', 'Obtuse'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these birds is known for its inability to fly but excellent running speed?',
    'options': ['Penguin', 'Ostrich', 'Kiwi', 'Emu'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'What is the term for money exchanged between countries at a set rate?',
    'options': ['Interest rate', 'Exchange rate', 'Inflation rate', 'Tax rate'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct term for a word opposite in meaning to another?',
    'options': ['Synonym', 'Antonym', 'Homonym', 'Acronym'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },

  // ================= SCIENCE (30) =================
  {
    'category': 'Science',
    'question': 'What is the chemical symbol for potassium?',
    'options': ['P', 'Po', 'K', 'Pt'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which part of the human body is responsible for producing red blood cells?',
    'options': ['Liver', 'Bone marrow', 'Spleen', 'Kidney'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the bending of light as it passes through different mediums?',
    'options': ['Reflection', 'Refraction', 'Diffraction', 'Dispersion'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which planet is often called Earth\'s "twin" due to similar size?',
    'options': ['Mars', 'Venus', 'Mercury', 'Jupiter'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'What is the medical term for a heart attack?',
    'options': [
      'Myocardial infarction',
      'Cardiac arrest',
      'Angina',
      'Arrhythmia',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which gas is used to fill most incandescent light bulbs to prevent the filament from burning?',
    'options': ['Oxygen', 'Argon', 'Hydrogen', 'Carbon dioxide'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the imaginary line that the Earth spins around?',
    'options': ['Equator', 'Axis', 'Orbit', 'Meridian'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the correct term for animals that give birth to live young?',
    'options': ['Oviparous', 'Viviparous', 'Ovoviviparous', 'Asexual'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the name of the process by which the body converts food into energy?',
    'options': ['Digestion', 'Metabolism', 'Respiration', 'Absorption'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'Which of these elements has the chemical symbol "Na"?',
    'options': ['Nitrogen', 'Sodium', 'Neon', 'Nickel'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'What is the term for the study of the universe beyond Earth?',
    'options': ['Geology', 'Astronomy', 'Meteorology', 'Oceanography'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these organs is responsible for producing digestive enzymes and insulin?',
    'options': ['Liver', 'Pancreas', 'Gallbladder', 'Spleen'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the transfer of heat through direct contact?',
    'options': ['Convection', 'Conduction', 'Radiation', 'Insulation'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these vitamins is essential for good eyesight?',
    'options': ['Vitamin A', 'Vitamin B', 'Vitamin C', 'Vitamin E'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for a group of stars that forms a recognizable pattern?',
    'options': ['Galaxy', 'Constellation', 'Nebula', 'Cluster'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these gases is toxic and produced by incomplete combustion of fuel?',
    'options': ['Carbon dioxide', 'Carbon monoxide', 'Nitrogen', 'Oxygen'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the name of the galaxy that contains our solar system?',
    'options': ['Andromeda', 'Milky Way', 'Whirlpool Galaxy', 'Triangulum'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the correct term for the largest artery in the human body?',
    'options': [
      'Pulmonary artery',
      'Aorta',
      'Carotid artery',
      'Femoral artery',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'What is the term for the amount of matter in an object?',
    'options': ['Weight', 'Mass', 'Volume', 'Density'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'Which of these is a function performed by the human lungs?',
    'options': [
      'Pump blood',
      'Filter waste',
      'Exchange oxygen and carbon dioxide',
      'Digest food',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the smallest particle of an element that retains its properties?',
    'options': ['Molecule', 'Atom', 'Compound', 'Ion'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question': 'Which of these is a common symptom of dehydration?',
    'options': [
      'Increased urination',
      'Dry mouth and thirst',
      'Weight gain',
      'High blood pressure only',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the process where solid turns directly into gas?',
    'options': ['Sublimation', 'Deposition', 'Evaporation', 'Condensation'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these is the chemical formula for methane?',
    'options': ['CH4', 'CO2', 'C2H6', 'NH3'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the number of times a wave oscillates per second?',
    'options': ['Amplitude', 'Frequency', 'Wavelength', 'Period'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these body parts produces sweat to help regulate temperature?',
    'options': ['Sweat glands in skin', 'Kidneys', 'Liver', 'Lungs'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for animals that hunt other animals for food?',
    'options': ['Prey', 'Predator', 'Scavenger', 'Herbivore'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the correct term for the region of space around Earth where satellites orbit?',
    'options': [
      'Stratosphere',
      'Orbit/Low Earth Orbit',
      'Exosphere only',
      'Troposphere',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'What is the common name for the compound NaHCO3?',
    'options': ['Table salt', 'Baking soda', 'Vinegar', 'Chalk'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the process plants use to lose water vapor through leaves?',
    'options': ['Respiration', 'Transpiration', 'Photosynthesis', 'Absorption'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= HISTORY (30) =================
  {
    'category': 'History',
    'question':
        'Which Indian emperor is known for his religious tolerance and the policy of "Sulh-i-Kul"?',
    'options': ['Babur', 'Akbar', 'Jahangir', 'Aurangzeb'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question': 'Who was the leader of the Bolshevik Revolution in Russia?',
    'options': [
      'Joseph Stalin',
      'Vladimir Lenin',
      'Leon Trotsky',
      'Nicholas II',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which ancient Indian text is considered one of the oldest religious scriptures in the world?',
    'options': ['Bhagavad Gita', 'Rigveda', 'Mahabharata', 'Ramayana'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the first woman to fly solo across the Atlantic Ocean?',
    'options': [
      'Bessie Coleman',
      'Amelia Earhart',
      'Harriet Quimby',
      'Jacqueline Cochran',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The Treaty of Tordesillas divided newly discovered lands between which two countries?',
    'options': [
      'England and France',
      'Spain and Portugal',
      'Netherlands and England',
      'France and Portugal',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian leader founded the Indian National Congress in 1885?',
    'options': [
      'Dadabhai Naoroji',
      'Allan Octavian Hume',
      'Gopal Krishna Gokhale',
      'W.C. Banerjee',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Who was the Greek philosopher who taught Alexander the Great?',
    'options': ['Socrates', 'Plato', 'Aristotle', 'Pythagoras'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The Gupta period in Indian history is often referred to as what?',
    'options': [
      'The Dark Age',
      'The Golden Age of India',
      'The Bronze Age',
      'The Age of Empires',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which country was the first to send a satellite into space (Sputnik)?',
    'options': ['USA', 'Soviet Union', 'China', 'Germany'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Who was the Indian freedom fighter and poet known for writing "Sare Jahan Se Achha"?',
    'options': [
      'Muhammad Iqbal',
      'Rabindranath Tagore',
      'Bankim Chandra Chatterjee',
      'Sarojini Naidu',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient Olympic Games were held in honor of which Greek god?',
    'options': ['Apollo', 'Zeus', 'Poseidon', 'Ares'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Who was the first woman to become President of India?',
    'options': [
      'Sonia Gandhi',
      'Pratibha Patil',
      'Droupadi Murmu',
      'Sushma Swaraj',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which empire built the ancient city of Petra in modern-day Jordan?',
    'options': [
      'Roman Empire',
      'Nabataean Kingdom',
      'Persian Empire',
      'Ottoman Empire',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The Salt March (Dandi March) covered a distance of approximately how many kilometers?',
    'options': ['100 km', '240 km', '385 km', '500 km'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the King of England during the signing of the Magna Carta?',
    'options': [
      'King Richard I',
      'King John',
      'King Henry III',
      'King Edward I',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Which Indian ruler is known as the "Napoleon of India"?',
    'options': [
      'Chandragupta Maurya',
      'Samudragupta',
      'Ashoka',
      'Vikramaditya',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The fall of Constantinople in 1453 marked the end of which empire?',
    'options': [
      'Roman Empire',
      'Byzantine Empire',
      'Ottoman Empire',
      'Persian Empire',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the leader of the Indian independence movement known for civil disobedience?',
    'options': [
      'Subhash Chandra Bose',
      'Mahatma Gandhi',
      'Bhagat Singh',
      'Jawaharlal Nehru',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'History',
    'question':
        'Which country was the origin point of the Black Death plague in the 14th century (commonly cited)?',
    'options': ['Italy', 'Central Asia', 'England', 'France'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the emperor of the Maurya dynasty who converted to Buddhism after the Kalinga War?',
    'options': [
      'Chandragupta Maurya',
      'Bindusara',
      'Ashoka',
      'Dasharatha Maurya',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
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
    'question': 'Who was the first Prime Minister of Pakistan?',
    'options': [
      'Muhammad Ali Jinnah',
      'Liaquat Ali Khan',
      'Ayub Khan',
      'Zulfikar Ali Bhutto',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian city was the site of the first session of the Indian National Congress in 1885?',
    'options': ['Calcutta', 'Bombay', 'Madras', 'Allahabad'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the ancient Chinese philosopher known for Confucianism?',
    'options': ['Laozi', 'Confucius', 'Sun Tzu', 'Mencius'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The Battle of Trafalgar was a major naval battle involving which country\'s fleet led by Nelson?',
    'options': ['France', 'Britain', 'Spain', 'Portugal'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Who was the first Indian woman to go to space?',
    'options': [
      'Sunita Williams',
      'Kalpana Chawla',
      'Both are Indian-origin astronauts',
      'Neither, no Indian woman has gone to space',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient city of Troy is located in modern-day which country?',
    'options': ['Greece', 'Turkey', 'Italy', 'Egypt'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Which Indian ruler built the Qutub Minar in Delhi?',
    'options': [
      'Qutb-ud-din Aibak',
      'Iltutmish',
      'Both started and completed it respectively',
      'Balban',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question': 'Who was the American president during the Louisiana Purchase?',
    'options': [
      'George Washington',
      'Thomas Jefferson',
      'John Adams',
      'James Madison',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian dynasty is credited with building the famous Konark Sun Temple?',
    'options': ['Chola', 'Eastern Ganga dynasty', 'Pallava', 'Chalukya'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= GEOGRAPHY (30) =================
  {
    'category': 'Geography',
    'question': 'What is the capital of Finland?',
    'options': ['Oslo', 'Helsinki', 'Stockholm', 'Copenhagen'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian state is landlocked and shares borders with the most number of other Indian states?',
    'options': [
      'Madhya Pradesh',
      'Uttar Pradesh',
      'Chhattisgarh',
      'Maharashtra',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Ecuador?',
    'options': ['Guayaquil', 'Quito', 'Cuenca', 'Manta'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which mountain range is home to the Matterhorn?',
    'options': ['Himalayas', 'Alps', 'Andes', 'Rockies'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Bhutan?',
    'options': ['Paro', 'Thimphu', 'Punakha', 'Phuentsholing'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is situated on seven islands, later joined together?',
    'options': ['Kolkata', 'Mumbai', 'Chennai', 'Goa'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Afghanistan?',
    'options': ['Kandahar', 'Kabul', 'Herat', 'Mazar-i-Sharif'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Geography',
    'question': 'Which is the largest bay in the world?',
    'options': [
      'Bay of Bengal',
      'Hudson Bay',
      'Bay of Biscay',
      'Chesapeake Bay',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Cambodia?',
    'options': ['Siem Reap', 'Phnom Penh', 'Battambang', 'Sihanoukville'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'Which Indian union territory is a former French colony?',
    'options': ['Goa', 'Puducherry', 'Daman and Diu', 'Lakshadweep'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Laos?',
    'options': ['Luang Prabang', 'Vientiane', 'Pakse', 'Savannakhet'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which river flows through Baghdad?',
    'options': ['Euphrates', 'Tigris', 'Nile', 'Jordan'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Panama?',
    'options': ['Colon', 'Panama City', 'David', 'Santiago'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is famous for its houseboats and backwaters?',
    'options': ['Alleppey (Kerala)', 'Goa', 'Mumbai', 'Chennai'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Kazakhstan?',
    'options': ['Almaty', 'Astana', 'Shymkent', 'Karaganda'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian state shares a border with Bangladesh and is famous for one-horned rhinoceros?',
    'options': ['West Bengal', 'Assam', 'Meghalaya', 'Tripura'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Uzbekistan?',
    'options': ['Samarkand', 'Tashkent', 'Bukhara', 'Khiva'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which continent is entirely in the Southern and Eastern Hemispheres (mostly)?',
    'options': ['Australia', 'Africa', 'South America', 'Antarctica'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Mongolia?',
    'options': ['Darkhan', 'Ulaanbaatar', 'Erdenet', 'Choibalsan'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian state is known for the Rann of Kutch, a large salt marsh?',
    'options': ['Rajasthan', 'Gujarat', 'Haryana', 'Punjab'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Ukraine?',
    'options': ['Kharkiv', 'Kyiv', 'Odesa', 'Lviv'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Geography',
    'question': 'Which desert is located in northern China and Mongolia?',
    'options': ['Sahara', 'Thar', 'Gobi', 'Kalahari'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Hungary?',
    'options': ['Debrecen', 'Budapest', 'Szeged', 'Pecs'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is often called the "Gateway of India" due to its historic monument?',
    'options': ['Mumbai', 'Goa', 'Kochi', 'Surat'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Romania?',
    'options': ['Cluj-Napoca', 'Bucharest', 'Timisoara', 'Iasi'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which sea is the world\'s largest inland body of water, often called a sea despite being a lake?',
    'options': ['Dead Sea', 'Caspian Sea', 'Aral Sea', 'Black Sea'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Bulgaria?',
    'options': ['Plovdiv', 'Sofia', 'Varna', 'Burgas'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian region is known as the "Switzerland of India" for its scenic beauty?',
    'options': ['Kashmir', 'Manali', 'Shimla', 'Darjeeling'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Croatia?',
    'options': ['Split', 'Zagreb', 'Dubrovnik', 'Rijeka'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which Indian city is home to the famous Golden Temple?',
    'options': ['Amritsar', 'Chandigarh', 'Ludhiana', 'Jalandhar'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },

  // ================= SPORTS (30) =================
  {
    'category': 'Sports',
    'question': 'Which Indian cricketer is known as "Captain Cool"?',
    'options': ['Virat Kohli', 'MS Dhoni', 'Rohit Sharma', 'Sourav Ganguly'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a football player scoring three goals in a single match?',
    'options': ['Double', 'Hat-trick', 'Triple', 'Trifecta'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question': 'Which country hosted the 2014 FIFA World Cup?',
    'options': ['South Africa', 'Brazil', 'Russia', 'Qatar'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the highest possible score in a single frame of ten-pin bowling with a strike?',
    'options': ['20', '30', '10', '15'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian sport involves seven players on each team trying to touch opponents in a designated area?',
    'options': ['Kho-Kho', 'Kabaddi', 'Gilli-danda', 'Malkhamb'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the maximum number of players allowed in a cricket team squad for an ODI match (playing XI plus substitutes considered)?',
    'options': ['11 playing, unlimited squad size varies', '11', '15', '13'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which country has won the most Cricket World Cups (men\'s ODI format)?',
    'options': ['India', 'Australia', 'West Indies', 'England'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the trophy contested between India and Australia in Test cricket?',
    'options': [
      'The Ashes',
      'Border-Gavaskar Trophy',
      'World Test Championship',
      'Frank Worrell Trophy',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian tennis player won a mixed doubles Grand Slam title partnering with Martina Hingis?',
    'options': [
      'Sania Mirza',
      'Saina Nehwal',
      'Ankita Raina',
      'Karman Kaur Thandi',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the area where a batsman stands to face the bowler in cricket?',
    'options': ['Crease', 'Pitch', 'Wicket', 'Boundary'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which country has traditionally dominated field hockey at the Olympics before the 1970s?',
    'options': ['Pakistan', 'India', 'Netherlands', 'Germany'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term used when a cricket bowler dismisses a batsman on the very first ball they face in the match?',
    'options': [
      'Golden duck',
      'First-ball duck',
      'Both mean the same',
      'Diamond duck',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question': 'Which sport is played in the "Davis Cup"?',
    'options': ['Golf', 'Tennis', 'Cricket', 'Badminton'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question': 'What is the term for a shuttle used in badminton?',
    'options': [
      'Puck',
      'Shuttlecock',
      'Birdie only informally',
      'Both shuttlecock and birdie are used',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question': 'Which Indian city hosts the annual Delhi Half Marathon?',
    'options': ['Mumbai', 'New Delhi', 'Bangalore', 'Chennai'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the highest individual score by a batsman in a single Test cricket innings, held by Brian Lara?',
    'options': ['375', '400 not out', '365', '501'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question': 'Which country won the inaugural ICC Champions Trophy?',
    'options': [
      'South Africa',
      'New Zealand',
      'India',
      'Both South Africa and New Zealand were joint winners',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a golf course typically consisting of how many holes played in a full round?',
    'options': ['9', '18', '27', '36'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian sport uses a small piece of wood struck with a stick, played in villages traditionally?',
    'options': ['Kabaddi', 'Gilli-danda', 'Kho-Kho', 'Malkhamb'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the highest level of achievement in judo, indicated by a black belt with additional degrees?',
    'options': ['Dan', 'Kyu', 'Sensei', 'Sempai'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which country is the traditional rival of India in cricket, often called the biggest rivalry in the sport?',
    'options': ['Australia', 'Pakistan', 'England', 'South Africa'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a wrestling move where an opponent is pinned to the mat?',
    'options': ['Pin', 'Takedown', 'Escape', 'Reversal'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer holds the record for the fastest century in ODI cricket (as of recent records)?',
    'options': [
      'Virender Sehwag',
      'Rohit Sharma',
      'AB de Villiers (non-Indian, fastest overall)',
      'Yuvraj Singh',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a boxer being knocked down and unable to get up within the count?',
    'options': ['TKO', 'Knockout (KO)', 'Disqualification', 'Standing count'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question': 'Which country won the first Kabaddi World Cup?',
    'options': ['Pakistan', 'India', 'Iran', 'Bangladesh'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the official rest period between rounds in a boxing match?',
    'options': [
      'Timeout',
      'Break',
      'Interval',
      'All are acceptable informal terms',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian shuttler won the BWF World Championship gold medal in 2019?',
    'options': [
      'Saina Nehwal',
      'P.V. Sindhu',
      'Kidambi Srikanth',
      'Sameer Verma',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the starting block used by sprinters in track events?',
    'options': [
      'Starting gate',
      'Starting blocks',
      'Launch pad',
      'Sprint frame',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which country is known for dominating men\'s field hockey in recent Olympic history (post-2000)?',
    'options': ['India', 'Australia', 'Germany', 'Netherlands'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the technique of hitting a cricket ball high into the air intentionally to clear fielders?',
    'options': ['Lofted shot', 'Slog', 'Both terms are used', 'Chip shot'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= ENTERTAINMENT (30) =================
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for his role as "Baazigar" and many action films in the 90s?',
    'options': ['Akshay Kumar', 'Shah Rukh Khan', 'Sunny Deol', 'Ajay Devgn'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the famous fictional wizard school rival house known for cunning in Harry Potter?',
    'options': ['Ravenclaw', 'Hufflepuff', 'Slytherin', 'Gryffindor'],
    'correctAnswerIndex': 2,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which musician is known for the hit song "Bohemian Rhapsody" as lead singer of Queen?',
    'options': ['Freddie Mercury', 'Brian May', 'Roger Taylor', 'John Deacon'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress is known for her role in "Queen" (2013) which won her a National Award?',
    'options': [
      'Deepika Padukone',
      'Kangana Ranaut',
      'Alia Bhatt',
      'Vidya Balan',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional city where Spider-Man primarily operates?',
    'options': ['Gotham City', 'New York City', 'Metropolis', 'Central City'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian singer is famous for the classic song "Chaudhvin Ka Chand" and many playback hits?',
    'options': ['Mohammed Rafi', 'Kishore Kumar', 'Mukesh', 'Talat Mahmood'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional detective created by Agatha Christie known for his mustache?',
    'options': ['Sherlock Holmes', 'Hercule Poirot', 'Sam Spade', 'Nero Wolfe'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian film won the National Award for Best Feature Film for "Lagaan"-era regional cinema? (general Bollywood trivia)',
    'options': [
      'Lagaan',
      'Devdas',
      'Both were major films of that era',
      'Mughal-e-Azam',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional planet that Superman was born on?',
    'options': ['Krypton', 'Asgard', 'Vulcan', 'Oa'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian playback singer is known for songs in the movie "Mughal-E-Azam"?',
    'options': [
      'Lata Mangeshkar',
      'Asha Bhosle',
      'Both sang for the film',
      'Noor Jehan',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional talking donkey in the "Shrek" movie series?',
    'options': ['Donkey', 'Mule', 'Jack', 'Eddie'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian music director duo is known for composing "Dil Chahta Hai" and other Farhan Akhtar films?',
    'options': [
      'Shankar-Ehsaan-Loy',
      'Vishal-Shekhar',
      'Salim-Sulaiman',
      'Ajay-Atul',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizard sport played in the air with broomsticks, featuring a golden ball called the Snitch?',
    'options': ['Quidditch', 'Wizard Chess', 'Broom Racing', 'Wand Duel'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question': 'Which actor played the role of "Neo" in "The Matrix" trilogy?',
    'options': ['Keanu Reeves', 'Will Smith', 'Tom Cruise', 'Brad Pitt'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian classical dance form originates from Kerala and involves elaborate makeup and costumes?',
    'options': [
      'Kathakali',
      'Bharatanatyam',
      'Mohiniyattam',
      'Both Kathakali and Mohiniyattam are from Kerala',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional country in the movie "Coming to America"?',
    'options': ['Wakanda', 'Zamunda', 'Genovia', 'Latveria'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for his comic roles in films like "Andaz Apna Apna"?',
    'options': [
      'Salman Khan and Aamir Khan (both leads)',
      'Govinda',
      'Kader Khan',
      'Paresh Rawal',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional teenage superhero also known as Peter Parker?',
    'options': ['Spider-Man', 'Iron Man', 'Ant-Man', 'Daredevil'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian singer known as "Nightingale of India" sang for over 1000 Hindi films?',
    'options': [
      'Asha Bhosle',
      'Lata Mangeshkar',
      'Geeta Dutt',
      'Suman Kalyanpur',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional theme park in "Jurassic Park"?',
    'options': [
      'Dino World',
      'Jurassic Park',
      'Isla Nublar Park',
      'Dinosaur Kingdom',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress made her Hollywood debut in "The Fall" and later starred in "Quantico"?',
    'options': [
      'Deepika Padukone',
      'Priyanka Chopra',
      'Freida Pinto',
      'Both Priyanka Chopra and Freida Pinto have Hollywood careers',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional pop star robot in the movie "Big Hero 6"?',
    'options': ['Baymax', 'WALL-E', 'Bender', 'Optimus Prime'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian film composer is known for scoring "Dilwale Dulhania Le Jayenge"?',
    'options': ['Jatin-Lalit', 'A.R. Rahman', 'Anu Malik', 'Nadeem-Shravan'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional talking cricket in Disney\'s "Pinocchio"?',
    'options': ['Jiminy Cricket', 'Cri-Kee', 'Flit', 'Iago'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for playing multiple roles including a double role in "Seeta Aur Geeta"?',
    'options': ['Hema Malini', 'Rekha', 'Sharmila Tagore', 'Jaya Bachchan'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional dwarf who is the leader in "Snow White and the Seven Dwarfs"?',
    'options': ['Doc', 'Grumpy', 'Happy', 'Sneezy'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian composer duo is known for "Ram-Leela" and "Bajirao Mastani" background scores?',
    'options': [
      'Sanjay Leela Bhansali (composer-director)',
      'Ajay-Atul',
      'Both composed for Bhansali films',
      'Shankar-Ehsaan-Loy',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizarding bank run by goblins in Harry Potter?',
    'options': [
      'Gringotts',
      'Ministry Vault',
      'The Goblin Bank',
      'Diagon Trust',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor won an honorary Oscar-adjacent recognition and is known as "Bollywood\'s first superstar"?',
    'options': ['Dilip Kumar', 'Rajesh Khanna', 'Raj Kapoor', 'Dev Anand'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional country club president in "Zootopia" (general animated trivia, mayor character)?',
    'options': [
      'Mayor Lionheart',
      'Mayor Bellwether (deputy mayor)',
      'Both are officials in the film',
      'Chief Bogo',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
];
