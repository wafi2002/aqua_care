// lib/models/question_model.dart
class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String category; // Add category field

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
  });
}

// Sample questions list with categories
List<Question> questions = [

  //General knowledge question
  Question(
    question: "Why is sanitation important?",
    options: ["Prevents disease", "Saves water", "Reduces waste", "All of the above"],
    correctAnswerIndex: 3,
    category: "General Knowledge",
  ),
  Question(
    question: "What is the main purpose of sanitation systems?",
    options: ["To improve cleanliness", "To prevent the spread of diseases", "To save water", "To control pests"],
    correctAnswerIndex: 1,
    category: "General Knowledge",
  ),
  Question(
    question: "Which of the following is NOT a benefit of proper sanitation?",
    options: ["Improves public health", "Reduces pollution", "Increases spread of disease", "Enhances quality of life"],
    correctAnswerIndex: 2,
    category: "General Knowledge",
  ),

  Question(
    question: "Which organization is primarily involved in promoting global sanitation efforts?",
    options: ["UNICEF", "WHO", "NASA", "UNESCO"],
    correctAnswerIndex: 1,
    category: "General Knowledge",
  ),

  Question(
    question: "What percentage of the world's population lacks access to adequate sanitation?",
    options: ["10%", "20%", "40%", "30%"],
    correctAnswerIndex: 2,
    category: "General Knowledge",
  ),

  //Health benefits
  Question(
    question: "What is the main benefit of proper sanitation?",
    options: ["Improved aesthetics", "Prevention of disease", "Water conservation", "Reduced pollution"],
    correctAnswerIndex: 1,
    category: "Health Benefits",
  ),
  Question(
    question: "How does proper sanitation impact community health?",
    options: ["Increases disease spread", "Reduces disease transmission", "Lowers immunity", "Has no effect"],
    correctAnswerIndex: 1,
    category: "Health Benefits",
  ),

  Question(
    question: "Which of the following diseases is commonly associated with poor sanitation?",
    options: ["Diabetes", "Malaria", "Cholera", "Asthma"],
    correctAnswerIndex: 2,
    category: "Health Benefits",
  ),

  Question(
    question: "Proper handwashing can prevent the spread of which types of illnesses?",
    options: ["Heart diseases", "Respiratory and gastrointestinal infections", "Bone fractures", "Skin allergies"],
    correctAnswerIndex: 1,
    category: "Health Benefits",
  ),

  Question(
    question: "Why is safe drinking water essential to health?",
    options: ["It boosts intelligence", "It prevents waterborne diseases", "It cures infections", "It increases appetite"],
    correctAnswerIndex: 1,
    category: "Health Benefits",
  ),

  //Water purification
  Question(
    question: "What is one method of water purification?",
    options: ["Boiling", "Freezing", "Filtering", "Condensation"],
    correctAnswerIndex: 0,
    category: "Water Purification",
  ),

  Question(
    question: "Which household chemical can be used in small amounts to purify water?",
    options: ["Vinegar", "Bleach", "Baking soda", "Sugar"],
    correctAnswerIndex: 1,
    category: "Water Purification",
  ),

  Question(
    question: "Which water purification method removes bacteria and viruses effectively?",
    options: ["Boiling", "Freezing", "Condensing", "Salting"],
    correctAnswerIndex: 0,
    category: "Water Purification",
  ),

  Question(
    question: "What type of filter is commonly used for purifying drinking water?",
    options: ["Sand filter", "Oil filter", "Gas filter", "Ink filter"],
    correctAnswerIndex: 0,
    category: "Water Purification",
  ),

  Question(
    question: "Which water purification process involves passing water through a semi-permeable membrane?",
    options: ["Distillation", "Filtration", "Reverse osmosis", "Evaporation"],
    correctAnswerIndex: 2,
    category: "Water Purification",
  ),

];
