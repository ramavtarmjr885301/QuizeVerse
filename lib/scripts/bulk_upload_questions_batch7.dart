import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> bulkUploadQuestionsBatch7() async {
  final firestore = FirebaseFirestore.instance;

  // Duplicate-prevention: check if this exact batch was already uploaded
  final markerRef = firestore.collection('_migrations').doc('batch7_uploaded');
  final marker = await markerRef.get();
  if (marker.exists) {
    debugPrint('⚠️ Batch 7 already uploaded, skipping.');
    return;
  }

  // Sanity check: verify category names before writing anything
  const validCategories = {
    'General',
    'Science',
    'History',
    'Geography',
    'Sports',
    'Entertainment',
  };
  for (final q in _batch7Questions) {
    final cat = q['category'] as String;
    if (!validCategories.contains(cat)) {
      debugPrint('❌ Invalid category "$cat" found — aborting upload.');
      return;
    }
  }

  final batch = firestore.batch();
  final collection = firestore.collection('questions');

  for (final q in _batch7Questions) {
    final docRef = collection.doc();
    batch.set(docRef, q);
  }

  batch.set(markerRef, {
    'uploadedAt': FieldValue.serverTimestamp(),
    'count': _batch7Questions.length,
  });

  try {
    await batch.commit();
    debugPrint('✅ Uploaded ${_batch7Questions.length} questions (Batch 7)');
  } catch (e) {
    debugPrint('❌ Bulk upload failed: $e');
  }
}

final List<Map<String, dynamic>> _batch7Questions = [
  // ================= GENERAL (30) =================
  {
    'category': 'General',
    'question': 'What is the term for a fear of the number 13?',
    'options': [
      'Triskaidekaphobia',
      'Numerophobia',
      'Decaphobia',
      'Arithmophobia',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a traditional Korean fermented cabbage dish?',
    'options': ['Miso', 'Kimchi', 'Natto', 'Tempeh'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a word that sounds like the sound it describes, like "buzz"?',
    'options': ['Onomatopoeia', 'Alliteration', 'Assonance', 'Metaphor'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for a baby swan?',
    'options': ['Chick', 'Cygnet', 'Gosling', 'Duckling'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Thai soup known for its hot and sour flavor?',
    'options': ['Pho', 'Tom Yum', 'Miso soup', 'Wonton soup'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these numbers has no numerical value but is used as a placeholder in math?',
    'options': ['One', 'Zero', 'Infinity', 'Pi'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a shape with four unequal sides and no parallel sides?',
    'options': [
      'Trapezoid',
      'Rhombus',
      'Irregular quadrilateral',
      'Parallelogram',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a common name for the fruit of the cacao tree, used to make chocolate?',
    'options': ['Cocoa bean', 'Coffee bean', 'Vanilla pod', 'Tonka bean'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a person who repairs and makes clocks or watches?',
    'options': ['Locksmith', 'Watchmaker/Horologist', 'Jeweler', 'Machinist'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these animals is known to have a pouch used for storing food in its cheeks?',
    'options': ['Squirrel', 'Hamster', 'Both squirrel and hamster', 'Chipmunk'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional French pastry made of thin layers of dough and butter?',
    'options': ['Baguette', 'Croissant', 'Eclair', 'Macaron'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the correct term for the sound an owl makes?',
    'options': ['Screech', 'Hoot', 'Caw', 'Chirp'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question': 'What is the name for a triangle with two equal sides?',
    'options': ['Scalene', 'Equilateral', 'Isosceles', 'Right-angled'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a traditional Indian sweet made from reduced milk, shaped into small discs?',
    'options': [
      'Peda',
      'Barfi',
      'Kalakand',
      'All are milk-based sweets, Peda is disc-shaped',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the common term for a document that certifies ownership of land or property?',
    'options': ['Lease', 'Deed', 'Mortgage', 'Contract'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for a young eagle?',
    'options': ['Chick', 'Eaglet', 'Fledgling', 'Hatchling'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Spanish dish made of rice, saffron, and seafood or meat?',
    'options': ['Paella', 'Tapas', 'Gazpacho', 'Churros'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a unit of measurement used specifically for the speed of ships and aircraft?',
    'options': ['Mach', 'Knot', 'Mile per hour', 'Kilometer per hour'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the common name for the practice of writing with a special pointed instrument on wax tablets in ancient times?',
    'options': ['Calligraphy', 'Stylus writing', 'Engraving', 'Etching'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these fruits is technically classified as a berry, unlike strawberries?',
    'options': [
      'Banana',
      'Strawberry (not a true berry)',
      'Both banana and grape are true berries',
      'Raspberry',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'What is the traditional Indian musical instrument that resembles a harmonium but is played with a bellows?',
    'options': ['Harmonium', 'Shehnai', 'Been', 'Dhol'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question':
        'Which of these is the term for a shape that is symmetrical on both sides of a central line?',
    'options': [
      'Asymmetrical',
      'Bilateral symmetry',
      'Radial symmetry',
      'Rotational symmetry',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'What is the common name for a group of jellyfish?',
    'options': ['School', 'Smack', 'Pod', 'Bloom'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a traditional Middle Eastern sweet made of layered pastry, nuts, and honey?',
    'options': ['Baklava', 'Halva', 'Kunafa', 'Maamoul'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'What is the term for the fear of thunder and lightning?',
    'options': [
      'Astraphobia',
      'Brontophobia',
      'Both are correct terms',
      'Ombrophobia',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for a baby owl?',
    'options': ['Owlet', 'Chick', 'Fledgling', 'Hatchling'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'General',
    'question': 'What is the traditional Japanese tea ceremony called?',
    'options': ['Ikebana', 'Chanoyu', 'Kabuki', 'Origami'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question':
        'Which of these is a common term for money set aside for future use or emergencies?',
    'options': ['Expenditure', 'Savings', 'Liability', 'Debt'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'General',
    'question':
        'What is the term for a word that has two meanings that are opposite, like "cleave"?',
    'options': ['Synonym', 'Contronym', 'Homograph', 'Antonym'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'General',
    'question': 'Which of these is the correct term for a young deer?',
    'options': ['Kid', 'Fawn', 'Calf', 'Cub'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },

  // ================= SCIENCE (30) =================
  {
    'category': 'Science',
    'question':
        'What is the term for the study of the classification of living organisms?',
    'options': ['Ecology', 'Taxonomy', 'Physiology', 'Morphology'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these gases is responsible for the blue color of the sky due to scattering of light?',
    'options': [
      'Oxygen scatters light this way',
      'Nitrogen and oxygen molecules scatter blue light most',
      'Carbon dioxide',
      'Argon',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'What is the medical term for difficulty in breathing?',
    'options': ['Dyspnea', 'Apnea', 'Tachypnea', 'Bradypnea'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is a unit used to measure the intensity of an earthquake?',
    'options': ['Decibel', 'Richter scale', 'Pascal', 'Beaufort scale'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for plants and animals found only in a specific geographic region?',
    'options': [
      'Invasive species',
      'Endemic species',
      'Migratory species',
      'Extinct species',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these is the innermost layer of the Earth?',
    'options': ['Crust', 'Mantle', 'Outer core', 'Inner core'],
    'correctAnswerIndex': 3,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the buildup of static electricity being suddenly released?',
    'options': [
      'Conduction',
      'Electric discharge',
      'Induction',
      'Polarization',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these organs produces digestive enzymes and insulin?',
    'options': ['Liver', 'Pancreas', 'Stomach', 'Gallbladder'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for animals that are active during twilight hours (dawn and dusk)?',
    'options': ['Nocturnal', 'Diurnal', 'Crepuscular', 'Cathemeral'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question': 'Which of these is the correct chemical formula for ammonia?',
    'options': ['NH3', 'NH4', 'N2H4', 'HNO3'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the scientific study of fossils and prehistoric life?',
    'options': ['Archaeology', 'Paleontology', 'Geology', 'Anthropology'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which vitamin deficiency is known to cause the bone-softening disease rickets in children?',
    'options': ['Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin B12'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the imaginary boundary around a black hole from which nothing can escape?',
    'options': [
      'Singularity',
      'Event horizon',
      'Accretion disk',
      'Photon sphere',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is a naturally occurring greenhouse gas released by cattle and rice paddies?',
    'options': ['Carbon dioxide', 'Methane', 'Nitrous oxide', 'Ozone'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the process of a caterpillar forming a protective shell before becoming a butterfly?',
    'options': [
      'Larva stage',
      'Pupa/Chrysalis stage',
      'Nymph stage',
      'Egg stage',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these describes the bending of light as it passes from one medium to another?',
    'options': ['Reflection', 'Refraction', 'Diffraction', 'Absorption'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for an organism that can survive both in water and on land?',
    'options': ['Aquatic', 'Amphibious', 'Terrestrial', 'Semi-aquatic'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'Which of these elements is the primary component of natural diamonds?',
    'options': ['Silicon', 'Carbon', 'Graphite (form of carbon)', 'Quartz'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the medical term for the surgical removal of the appendix?',
    'options': ['Appendectomy', 'Gastrectomy', 'Colectomy', 'Splenectomy'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these planets has the shortest day (fastest rotation) in our solar system?',
    'options': ['Mercury', 'Jupiter', 'Earth', 'Venus'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the region of a plant cell that contains chlorophyll for photosynthesis?',
    'options': ['Nucleus', 'Chloroplast', 'Mitochondria', 'Vacuole'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the correct term for water that has dissolved minerals from rocks and soil?',
    'options': [
      'Distilled water',
      'Hard water',
      'Soft water',
      'Purified water',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the total amount of matter in an object, regardless of gravity?',
    'options': ['Weight', 'Mass', 'Density', 'Volume'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question': 'Which of these blood cells are responsible for clotting?',
    'options': ['Red blood cells', 'White blood cells', 'Platelets', 'Plasma'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for the layer of the sun visible during a total solar eclipse?',
    'options': ['Photosphere', 'Corona', 'Chromosphere', 'Core'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these is the scientific name for the common cold-causing group of viruses?',
    'options': [
      'Influenza virus',
      'Rhinovirus',
      'Coronavirus (general term)',
      'Adenovirus',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for plants that grow on other plants without harming them, like some orchids?',
    'options': ['Parasites', 'Epiphytes', 'Saprophytes', 'Symbionts'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these correctly describes the function of red blood cells?',
    'options': [
      'Fight infection',
      'Carry oxygen via hemoglobin',
      'Clot wounds',
      'Produce antibodies',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Science',
    'question':
        'What is the term for a chemical reaction that absorbs heat from its surroundings?',
    'options': ['Exothermic', 'Endothermic', 'Catalytic', 'Combustion'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Science',
    'question':
        'Which of these organs is primarily responsible for regulating body temperature via sweating?',
    'options': ['Liver', 'Skin', 'Kidney', 'Lungs'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },

  // ================= HISTORY (30) =================
  {
    'category': 'History',
    'question':
        'Which Indian dynasty is credited with building the Brihadeeswarar Temple in Thanjavur?',
    'options': ['Pandya', 'Chola', 'Chera', 'Pallava'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The Opium Wars in the 19th century were fought primarily between China and which country?',
    'options': ['France', 'Britain', 'Japan', 'Russia'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the Mongol ruler credited with founding one of the largest contiguous land empires in history?',
    'options': ['Kublai Khan', 'Genghis Khan', 'Timur', 'Ogedei Khan'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which Indian ruler is credited with defeating the Portuguese and establishing the Maratha navy?',
    'options': [
      'Shivaji Maharaj',
      'Kanhoji Angre',
      'Both contributed to Maratha naval power',
      'Baji Rao I',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The Spanish Armada, defeated in 1588, was sent to invade which country?',
    'options': ['France', 'England', 'Netherlands', 'Portugal'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the leader of the Zulu resistance against British colonization in the Anglo-Zulu War of 1879?',
    'options': ['Shaka Zulu', 'Cetshwayo', 'Dingane', 'Mpande'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian city was the site of the historic Dandi Salt March\'s conclusion in 1930?',
    'options': ['Ahmedabad', 'Dandi', 'Surat', 'Vadodara'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'The Thirty Years\' War in Europe was fought primarily in which century?',
    'options': ['16th century', '17th century', '18th century', '19th century'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the Indian ruler known for resisting Mughal expansion in the Deccan, particularly Aurangzeb?',
    'options': [
      'Shivaji Maharaj',
      'Sambhaji',
      'Both resisted Mughal rule in the Deccan',
      'Rajaram',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient Phoenicians are credited with spreading which writing system across the Mediterranean?',
    'options': [
      'Cuneiform',
      'Hieroglyphics',
      'Alphabet (Phoenician alphabet)',
      'Sanskrit script',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian king is known for the rock-cut architecture at the Ellora Caves under the Rashtrakuta dynasty?',
    'options': [
      'Krishna I',
      'Dantidurga',
      'Both are associated with early Rashtrakuta rule',
      'Amoghavarsha',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the American civil rights leader known for the "I Have a Dream" speech?',
    'options': [
      'Malcolm X',
      'Martin Luther King Jr.',
      'Rosa Parks',
      'Frederick Douglass',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'History',
    'question':
        'The ancient trade route known as the "Grand Trunk Road" connects which regions?',
    'options': [
      'South India to Sri Lanka',
      'Bengal to Afghanistan (through northern India)',
      'Kerala to Gujarat',
      'Delhi to Mumbai',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the founder of the Sur Empire that briefly displaced the Mughals in India?',
    'options': [
      'Sher Shah Suri',
      'Islam Shah Suri',
      'Adil Shah Suri',
      'Ibrahim Shah Suri',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient Greek historian known as the "Father of History" is who?',
    'options': ['Thucydides', 'Herodotus', 'Plutarch', 'Xenophon'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which Indian freedom fighter was known for organizing the Chittagong armoury raid in 1930?',
    'options': [
      'Surya Sen',
      'Khudiram Bose',
      'Bagha Jatin',
      'Rash Behari Bose',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The fall of the Western Roman Empire is traditionally dated to which year?',
    'options': ['376 AD', '410 AD', '476 AD', '493 AD'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the queen of France executed during the French Revolution, known for the (possibly apocryphal) quote about cake?',
    'options': [
      'Catherine de Medici',
      'Marie Antoinette',
      'Josephine Bonaparte',
      'Anne of Austria',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which Indian state was the center of the Telangana Rebellion (1946-1951) against feudal landlords?',
    'options': [
      'Andhra Pradesh region (Telangana)',
      'Karnataka',
      'Maharashtra',
      'Odisha',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient Kingdom of Aksum, known for trade and later Christianity, was located in present-day which region?',
    'options': [
      'West Africa',
      'Ethiopia/Eritrea region',
      'North Africa (Egypt)',
      'Southern Africa',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the first European explorer to reach India by sea route in 1498?',
    'options': [
      'Christopher Columbus',
      'Vasco da Gama',
      'Ferdinand Magellan',
      'Bartolomeu Dias',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'History',
    'question':
        'The ancient Indian text "Arthashastra" on statecraft and economics is attributed to whom?',
    'options': [
      'Chanakya (Kautilya)',
      'Chandragupta Maurya',
      'Ashoka',
      'Bindusara',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question': 'Which war was ended by the Treaty of Westphalia in 1648?',
    'options': [
      'Hundred Years War',
      'Thirty Years War',
      'War of Spanish Succession',
      'Napoleonic Wars',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the last ruling monarch of the Hawaiian Kingdom before its overthrow in 1893?',
    'options': [
      'King Kalakaua',
      'Queen Liliuokalani',
      'King Kamehameha V',
      'Princess Kaiulani',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient city of Petra, carved into rock, is located in which present-day country?',
    'options': ['Egypt', 'Jordan', 'Israel', 'Syria'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'History',
    'question':
        'Which Indian leader was instrumental in drafting the Poona Pact of 1932 alongside Gandhi?',
    'options': [
      'Jawaharlal Nehru',
      'B.R. Ambedkar',
      'Sardar Patel',
      'Rajendra Prasad',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The Weimar Republic refers to the government of which country between the World Wars?',
    'options': ['France', 'Germany', 'Austria', 'Italy'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Who was the Inca emperor captured and later executed by Spanish conquistador Francisco Pizarro?',
    'options': ['Huayna Capac', 'Atahualpa', 'Huascar', 'Manco Inca'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'The ancient Indian university of Takshashila (Taxila) was located in present-day which country?',
    'options': ['India', 'Pakistan', 'Afghanistan', 'Nepal'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'History',
    'question':
        'Which country did Italy invade in 1935, drawing international condemnation before World War II?',
    'options': ['Libya', 'Ethiopia (Abyssinia)', 'Somalia', 'Albania'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= GEOGRAPHY (30) =================
  {
    'category': 'Geography',
    'question': 'Which Indian city is known for the Charminar monument?',
    'options': ['Bangalore', 'Hyderabad', 'Mysore', 'Chennai'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Fiji?',
    'options': ['Nadi', 'Suva', 'Lautoka', 'Labasa'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian river is known for the Jog Falls, one of India\'s highest waterfalls?',
    'options': ['Sharavathi', 'Kaveri', 'Krishna', 'Tungabhadra'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Papua New Guinea?',
    'options': ['Lae', 'Port Moresby', 'Mount Hagen', 'Madang'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is the administrative capital of Jammu and Kashmir during winter?',
    'options': ['Srinagar', 'Jammu', 'Leh', 'Gulmarg'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Costa Rica?',
    'options': ['San Jose', 'Limon', 'Alajuela', 'Cartago'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which mountain peak is the highest in North America?',
    'options': ['Mount Rainier', 'Denali', 'Mount Whitney', 'Mount Elbert'],
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
        'Which Indian state is known for the Loktak Lake, famous for its floating islands?',
    'options': ['Assam', 'Manipur', 'Meghalaya', 'Mizoram'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Ecuador?',
    'options': ['Guayaquil', 'Quito', 'Cuenca', 'Manta'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which desert lies partly in Botswana, Namibia, and South Africa?',
    'options': [
      'Namib Desert',
      'Kalahari Desert',
      'Sahara Desert',
      'Karoo Desert',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Guatemala?',
    'options': ['Antigua', 'Guatemala City', 'Quetzaltenango', 'Escuintla'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is famously known as the "Silicon Valley of India" alongside Bangalore for its IT hub status?',
    'options': ['Pune', 'Hyderabad', 'Gurugram', 'All three are major IT hubs'],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Honduras?',
    'options': ['San Pedro Sula', 'Tegucigalpa', 'La Ceiba', 'Choluteca'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which of these countries is landlocked and located in the Himalayas between India and China?',
    'options': ['Bhutan', 'Nepal', 'Both Bhutan and Nepal', 'Bangladesh'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of El Salvador?',
    'options': ['Santa Ana', 'San Salvador', 'San Miguel', 'Sonsonate'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian hill range is home to the famous Nilgiri Tahr, an endangered mountain goat?',
    'options': [
      'Western Ghats (Nilgiris)',
      'Eastern Ghats',
      'Aravalli Range',
      'Vindhya Range',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Paraguay?',
    'options': ['Ciudad del Este', 'Asuncion', 'Encarnacion', 'Concepcion'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which sea does the Suez Canal connect to the Red Sea?',
    'options': ['Black Sea', 'Mediterranean Sea', 'Caspian Sea', 'Arabian Sea'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Uruguay?',
    'options': ['Punta del Este', 'Montevideo', 'Salto', 'Maldonado'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is located near the Sunderbans and is a major port on the Hooghly river?',
    'options': ['Kolkata', 'Bhubaneswar', 'Puri', 'Digha'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Nicaragua?',
    'options': ['Leon', 'Managua', 'Granada', 'Masaya'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'Which African country is the source of the Blue Nile river?',
    'options': ['Sudan', 'Ethiopia', 'Uganda', 'Kenya'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Bolivia (constitutional capital)?',
    'options': ['La Paz', 'Sucre', 'Santa Cruz', 'Cochabamba'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian state shares its name with a famous style of miniature painting?',
    'options': [
      'Rajasthan (Rajasthani painting)',
      'Odisha (Pattachitra)',
      'Both have famous painting styles named after them',
      'Bihar (Madhubani)',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of the Dominican Republic?',
    'options': ['Santiago', 'Santo Domingo', 'La Romana', 'Puerto Plata'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which body of water separates the Indian mainland from the Andaman and Nicobar Islands?',
    'options': [
      'Arabian Sea',
      'Bay of Bengal',
      'Palk Strait',
      'Indian Ocean (general)',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Suriname?',
    'options': ['Paramaribo', 'Nieuw Nickerie', 'Albina', 'Moengo'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question':
        'Which Indian city is known as the "Manchester of the East" for its historical jute and textile industry?',
    'options': ['Kolkata', 'Kanpur', 'Ahmedabad', 'Surat'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Geography',
    'question': 'What is the capital of Guyana?',
    'options': ['New Amsterdam', 'Georgetown', 'Linden', 'Bartica'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= SPORTS (30) =================
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer is known for scoring a century on Test debut against England in 2018?',
    'options': [
      'Prithvi Shaw',
      'Shubman Gill',
      'Rishabh Pant',
      'Hanuma Vihari',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a football pass played directly to a teammate without touching the ground?',
    'options': ['Cross', 'Volley pass', 'Through ball', 'Long ball'],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian city hosts the annual Kolkata Derby football match between two historic clubs?',
    'options': [
      'Mohun Bagan vs East Bengal',
      'Mohun Bagan vs Mohammedan Sporting',
      'East Bengal vs Mohammedan Sporting',
      'All three rivalries exist in Kolkata football',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the highest level of amateur boxing weight category for men, above 91kg?',
    'options': [
      'Heavyweight',
      'Super Heavyweight',
      'Cruiserweight',
      'Light Heavyweight',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian javelin thrower broke the national record multiple times before Neeraj Chopra\'s rise?',
    'options': [
      'Rajinder Singh',
      'Davinder Singh Kang',
      'Both have held national javelin records',
      'Kishore Kumar Jena',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a tennis shot hit with a topspin that causes the ball to dip sharply?',
    'options': ['Slice', 'Topspin shot', 'Flat shot', 'Chip shot'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian state is traditionally considered the powerhouse of Kabaddi in domestic competitions?',
    'options': [
      'Punjab',
      'Haryana',
      'Maharashtra',
      'All three have strong Kabaddi traditions',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the closing ceremony tradition in the Olympics where the host city passes the flag to the next host?',
    'options': [
      'Handover ceremony',
      'Flag handover',
      'Both terms describe this tradition',
      'Torch relay',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer took a hat-trick in the 2019 Cricket World Cup?',
    'options': [
      'Jasprit Bumrah',
      'Mohammed Shami',
      'Kuldeep Yadav',
      'Yuzvendra Chahal',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a shot in table tennis where the ball is hit with a downward chopping motion for backspin?',
    'options': ['Loop', 'Chop/Push', 'Smash', 'Flick'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which country has won the most medals overall in Asian Games history?',
    'options': ['Japan', 'China', 'South Korea', 'India'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a wrestling hold where a wrestler traps the opponent\'s arm and body?',
    'options': [
      'Half nelson',
      'Full nelson',
      'Both are wrestling holds',
      'Chokehold',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian shooter won gold in the 10m Air Pistol event at the Tokyo Olympics Youth level or senior competitions, known for consistency?',
    'options': [
      'Manu Bhaker',
      'Heena Sidhu',
      'Both are prominent Indian pistol shooters',
      'Rahi Sarnobat',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the area outside the field of play in football where coaches stand?',
    'options': ['Technical area', 'Dugout', 'Both terms are used', 'Sideline'],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer is the only player to have scored a triple century in Test cricket for India?',
    'options': [
      'Virender Sehwag',
      'Karun Nair',
      'Both have scored Test triple centuries for India',
      'Rahul Dravid',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a football offside rule violation where an attacker is behind the last defender when the ball is played?',
    'options': ['Offside', 'Handball', 'Foul', 'Obstruction'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian sport is played with a wooden bat and ball similar to cricket but with different rules, popular in rural areas?',
    'options': ['Gilli-danda', 'Kanche', 'Pittu', 'Lattoo'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a chess strategy where a player sacrifices a piece for a positional advantage?',
    'options': ['Gambit', 'Fork', 'Pin', 'Skewer'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian badminton player won bronze at the 2020 Tokyo Olympics in the men\'s singles?',
    'options': [
      'Kidambi Srikanth',
      'B. Sai Praneeth',
      'Lakshya Sen',
      'H.S. Prannoy',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the highest score achievable on a single dart throw?',
    'options': ['20', '60 (triple 20)', '25', '50 (bullseye)'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which country is credited with the invention of the sport of squash?',
    'options': ['USA', 'England', 'France', 'Australia'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the Indian wrestling style practiced in traditional mud pits, distinct from Olympic freestyle?',
    'options': [
      'Kushti/Pehlwani',
      'Malla-yuddha',
      'Both terms refer to traditional Indian wrestling',
      'Freestyle wrestling',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian cricketer became the fastest to reach 5,000 runs in T20 internationals?',
    'options': [
      'Virat Kohli',
      'Rohit Sharma',
      'Suryakumar Yadav',
      'K.L. Rahul',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for the official distance of a standard Olympic-size swimming pool for competitive events?',
    'options': [
      '25 meters (short course)',
      '50 meters (long course)',
      'Both are used depending on competition type',
      '100 meters',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian city hosted the first National Games of independent India?',
    'options': ['New Delhi', 'Lucknow', 'Bombay (Mumbai)', 'Madras (Chennai)'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a serve in volleyball hit with a jumping motion for extra power?',
    'options': [
      'Float serve',
      'Jump serve',
      'Underhand serve',
      'Standing serve',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'Which Indian archer has won multiple World Cup medals and represented India at several Olympics?',
    'options': [
      'Deepika Kumari',
      'Bombayla Devi',
      'Both are accomplished Indian archers',
      'Jyothi Surekha Vennam',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a golf course\'s total expected strokes for a skilled player to complete all holes?',
    'options': ['Handicap', 'Par', 'Bogey average', 'Course rating'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question': 'Which country hosted the first Asian Games in 1951?',
    'options': ['Japan', 'India', 'China', 'Philippines'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Sports',
    'question':
        'What is the term for a basketball violation where a player holds the ball too long without dribbling, passing, or shooting?',
    'options': [
      'Traveling',
      'Double dribble',
      'Backcourt violation',
      'Three-second violation',
    ],
    'correctAnswerIndex': 3,
    'difficulty': 3,
    'coins': 20,
  },

  // ================= ENTERTAINMENT (30) =================
  {
    'category': 'Entertainment',
    'question':
        'Which Indian film director is known for "Pather Panchali" and pioneering Indian art cinema?',
    'options': ['Satyajit Ray', 'Ritwik Ghatak', 'Mrinal Sen', 'Shyam Benegal'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizarding shop that sells trick items in Diagon Alley, run by the Weasley twins?',
    'options': [
      'Zonko\'s',
      'Weasleys\' Wizard Wheezes',
      'Honeydukes',
      'Gambol and Japes',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which musician is known for founding the band Nirvana and the grunge movement of the 1990s?',
    'options': ['Eddie Vedder', 'Kurt Cobain', 'Chris Cornell', 'Layne Staley'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for his roles in parallel/art cinema films like "Ardh Satya" and "Nishant"?',
    'options': [
      'Naseeruddin Shah',
      'Om Puri',
      'Both are celebrated art-house actors',
      'Shabana Azmi',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional talking snowman-like creature in Disney\'s "Frozen" who wants to experience summer?',
    'options': ['Olaf', 'Sven', 'Marshmallow', 'Kristoff'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian singer is known for playback singing in regional Telugu and Tamil films alongside Bollywood?',
    'options': [
      'S.P. Balasubrahmanyam',
      'K.J. Yesudas',
      'Both were prolific across multiple Indian languages',
      'P. Susheela',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional secret agency that James Bond works for?',
    'options': ['CIA', 'MI6', 'FBI', 'Interpol'],
    'correctAnswerIndex': 1,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian classical dance form is associated with Manipur and features gentle, flowing movements?',
    'options': ['Kathakali', 'Manipuri', 'Sattriya', 'Mohiniyattam'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional theme park where robots malfunction in the 1973 film "Westworld"?',
    'options': [
      'Delos',
      'Westworld (the park itself)',
      'Both names apply, Delos is the company',
      'Fantasyland',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for his role as "Devdas" in multiple film adaptations across decades?',
    'options': [
      'Dilip Kumar',
      'Shah Rukh Khan',
      'Both played Devdas in separate adaptations',
      'K.L. Saigal',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizarding examination taken by fifth-year students in Harry Potter?',
    'options': [
      'N.E.W.T.s',
      'O.W.L.s',
      'Both are wizarding exams at different years',
      'House Cup exam',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question': 'Which musician is known as the "Godfather of Soul"?',
    'options': ['Ray Charles', 'James Brown', 'Otis Redding', 'Marvin Gaye'],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress is known for her performance in "Mother India", one of India\'s most acclaimed classic films?',
    'options': ['Nargis', 'Meena Kumari', 'Waheeda Rehman', 'Nutan'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional sea captain in Disney\'s "The Little Mermaid" who is Ariel\'s father?',
    'options': [
      'King Triton',
      'Sebastian (the crab, not king)',
      'Eric',
      'Flounder',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian music director composed the score for the film "Rockstar" featuring Ranbir Kapoor?',
    'options': ['A.R. Rahman', 'Amit Trivedi', 'Vishal-Shekhar', 'Pritam'],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional teenage wizard\'s owl companion in Harry Potter?',
    'options': ['Hedwig', 'Errol', 'Pigwidgeon', 'Fawkes (a phoenix, not owl)'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for his versatile roles in both comedy and serious drama, including "Vicky Donor" and "Piku"?',
    'options': [
      'Ayushmann Khurrana',
      'Rajkummar Rao',
      'Both are known for such versatile roles',
      'Kartik Aaryan',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional wizarding house famous for producing many dark wizards, including Voldemort, in Harry Potter?',
    'options': ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which musician is known for the hit album "Purple Rain" and its accompanying film?',
    'options': ['Michael Jackson', 'Prince', 'George Michael', 'David Bowie'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress won the National Film Award for her role in "Fire" and other art films by Deepa Mehta?',
    'options': [
      'Shabana Azmi',
      'Nandita Das',
      'Both worked with Deepa Mehta in acclaimed films',
      'Konkona Sen Sharma',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional sea monster from Scandinavian folklore, referenced in many movies including "Pirates of the Caribbean"?',
    'options': [
      'Leviathan',
      'Kraken',
      'Both are legendary sea monsters',
      'Cthulhu',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian director is known for the "Rockstar" and "Rangoon" films, often exploring musical and political themes?',
    'options': [
      'Imtiaz Ali',
      'Vishal Bhardwaj',
      'Anurag Kashyap',
      'Sanjay Leela Bhansali',
    ],
    'correctAnswerIndex': 1,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the popular British sitcom about a group of friends living in a flat, featuring Mr. Bean-style humor from Rowan Atkinson?',
    'options': ['Mr. Bean', 'Blackadder', 'Fawlty Towers', 'The Office UK'],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian musician is known for reviving folk and Sufi music for mainstream Bollywood audiences, notably with "Kailash Kher"?',
    'options': [
      'Kailash Kher himself is the folk-Sufi singer referenced',
      'Rahat Fateh Ali Khan',
      'Both are known for Sufi-influenced music',
      'Papon',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional prison island in the Alcatraz-inspired action film starring Sean Connery, "The Rock"?',
    'options': [
      'Alcatraz (the real name used in the film)',
      'The Rock (San Francisco Bay)',
      'Both names refer to the same island setting',
      'Rikers Island',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actress is known for her Cannes Film Festival red carpet appearances and Bollywood stardom in the 2000s?',
    'options': [
      'Aishwarya Rai Bachchan',
      'Sonam Kapoor',
      'Both are known for Cannes appearances',
      'Deepika Padukone',
    ],
    'correctAnswerIndex': 2,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional evil stepmother in Disney\'s "Cinderella"?',
    'options': [
      'Lady Tremaine',
      'Maleficent (from Sleeping Beauty, not Cinderella)',
      'The Evil Queen (from Snow White)',
      'Ursula',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 2,
    'coins': 15,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian composer is known for scoring the music for "Dil Chahta Hai", a film credited with modernizing Bollywood aesthetics?',
    'options': [
      'Shankar-Ehsaan-Loy',
      'A.R. Rahman',
      'Anu Malik',
      'Jatin-Lalit',
    ],
    'correctAnswerIndex': 0,
    'difficulty': 3,
    'coins': 20,
  },
  {
    'category': 'Entertainment',
    'question':
        'What is the name of the fictional talking cricket who serves as Pinocchio\'s conscience in Disney\'s film?',
    'options': ['Jiminy Cricket', 'Figaro', 'Cleo', 'Geppetto'],
    'correctAnswerIndex': 0,
    'difficulty': 1,
    'coins': 10,
  },
  {
    'category': 'Entertainment',
    'question':
        'Which Indian actor is known for playing the antagonist "Mogambo" in the film "Mr. India"?',
    'options': ['Anupam Kher', 'Amrish Puri', 'Kader Khan', 'Shakti Kapoor'],
    'correctAnswerIndex': 1,
    'difficulty': 2,
    'coins': 15,
  },
];
