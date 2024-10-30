import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the flutter_spinkit package
import 'package:google_generative_ai/google_generative_ai.dart';

class EducationalContentScreen extends StatefulWidget {
  final String topic; // The topic for which you want to fetch content

  EducationalContentScreen({required this.topic});

  @override
  _EducationalContentScreenState createState() => _EducationalContentScreenState();
}

class _EducationalContentScreenState extends State<EducationalContentScreen> {
  String? generatedContent;
  bool isLoading = false;
  bool showTopic = true; // State variable to manage topic visibility
  final TextEditingController _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchGeneratedContent(); // Fetch initial content based on the topic
  }

  // Method to generate text content using GenerativeModel
  Future<void> _fetchGeneratedContent({String? userPrompt}) async {
    setState(() {
      isLoading = true;
      showTopic = false; // Hide the topic when generating content
    });
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: 'AIzaSyCUizJp7InT5_vskn2xfOlMFFsvahH9Vas',
      );

      // Use the user prompt if provided, otherwise use the topic
      final prompt = userPrompt ?? 'Educational content on the topic: ${widget.topic}';

      // Generate content
      final response = await model.generateContent([Content.text(prompt)]);
      setState(() {
        generatedContent = response.text ?? 'No content received';
      });
    } catch (e) {
      setState(() {
        generatedContent = 'Error generating content: $e';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Method to handle user prompt submission
  void _onSubmitPrompt() {
    if (_promptController.text.isNotEmpty) {
      _fetchGeneratedContent(userPrompt: _promptController.text);
      _promptController.clear(); // Clear the input field after submission
    }
  }

  // Method to parse the generated content for bold formatting
  List<TextSpan> _parseContent(String content) {
    final List<TextSpan> spans = [];
    final RegExp boldRegex = RegExp(r'\*(.*?)\*');
    int lastIndex = 0;

    // Find all matches of the regex in the content
    for (final match in boldRegex.allMatches(content)) {
      // Add the text before the bold text
      if (lastIndex < match.start) {
        spans.add(TextSpan(text: content.substring(lastIndex, match.start)));
      }
      // Add the bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      lastIndex = match.end;
    }

    // Add any remaining text after the last match
    if (lastIndex < content.length) {
      spans.add(TextSpan(text: content.substring(lastIndex)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[300],
          ),
          child: AppBar(
            //customize appbar
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(8.0),
              ),
              constraints: BoxConstraints(
                maxWidth: screenSize.width * 0.5,
              ),
              alignment: Alignment.center,
              child: const Row(
                //customize prompt textfield
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.water,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'AquaBot',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              //Enable user to scroll the response
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: showTopic
                          ? Text(
                        widget.topic,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: isLoading
                            ? const Center(
                          child: SpinKitWave(
                            color: Colors.blue,
                            size: 50.0,
                          ),
                        )
                            : RichText(
                          text: TextSpan(
                            children: generatedContent != null
                                ? _parseContent(generatedContent!)
                                : [const TextSpan(text: 'No content available.')],
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              color: Colors.black,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _promptController,
                decoration: InputDecoration(
                  labelText: 'Message AquaBot',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _onSubmitPrompt,
                  ),
                ),
                onSubmitted: (_) => _onSubmitPrompt(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
