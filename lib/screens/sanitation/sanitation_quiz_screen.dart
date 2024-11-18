import 'package:flutter/material.dart';
import 'package:aqua_care/models/question_model.dart';

class SanitationQuizScreen extends StatefulWidget {
  final String category;

  const SanitationQuizScreen({required this.category, Key? key}) : super(key: key);

  @override
  _SanitationQuizScreenState createState() => _SanitationQuizScreenState();
}

class _SanitationQuizScreenState extends State<SanitationQuizScreen> {
  late List<Question> filteredQuestions;
  int score = 0;
  Map<int, int?> selectedAnswers = {};
  String motivationalQuote = "";

  final Map<int, String> quotes = {
    0: "Don't give up! Keep learning, and you'll get better each time.",
    1: "Good start! Keep trying, and you'll improve.",
    2: "Not bad! You’re on the right path to mastering sanitation knowledge.",
    3: "Nice work! You're learning a lot. Keep it up!",
    4: "Great job! You're just one step away from perfection.",
    5: "Excellent! You know a lot about sanitation. Keep up the great work!"
  };

  @override
  void initState() {
    super.initState();
    filteredQuestions = questions
        .where((question) => question.category == widget.category)
        .toList();
  }

  void calculateScore() {
    score = 0;
    for (var i = 0; i < filteredQuestions.length; i++) {
      if (selectedAnswers[i] == filteredQuestions[i].correctAnswerIndex) {
        score++;
      }
    }
    // Set the motivational quote based on the score
    motivationalQuote = quotes[score] ?? "Keep learning and improving!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false, // Extend the body behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes the AppBar transparent
        elevation: 0, // Removes shadow from the AppBar
        automaticallyImplyLeading: true, // Keeps the back button
        iconTheme: const IconThemeData(color: Colors.white), // Sets the back arrow color to white
      ),
      backgroundColor: Colors.teal,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredQuestions.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${index + 1}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      filteredQuestions[index].question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(filteredQuestions[index].options.length, (optionIndex) {
                      return RadioListTile(
                        title: Text(
                          filteredQuestions[index].options[optionIndex],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87, // Darker color for the answers
                            fontWeight: FontWeight.w500, // Optional: Add slight boldness
                          ),
                        ),
                        value: optionIndex,
                        activeColor: Colors.blueAccent,
                        groupValue: selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[index] = value;
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          calculateScore();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                "Quiz Completed",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "Your score is $score out of ${filteredQuestions.length}",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    motivationalQuote,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
