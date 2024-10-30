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
        style: TextStyle(fontWeight: FontWeight.bold),
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
        preferredSize: Size.fromHeight(56.0), // Set height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[300], // Set background color of the AppBar
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make the AppBar background transparent
            elevation: 0, // Remove shadow
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding
              decoration: BoxDecoration(
                color: Colors.blue[600], // Set a background color for the title container
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              constraints: BoxConstraints(
                maxWidth: screenSize.width * 0.5, // Set a maximum width for the title container relative to screen size
              ),
              alignment: Alignment.center, // Center the title text
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Minimize the Row width
                children: [
                  Icon(
                    Icons.water,
                    color: Colors.white, // Set the icon color to white
                  ),
                  SizedBox(width: 8.0), // Add space between the icon and text
                  Text(
                    'AquaBot',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
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
            colors: [Colors.blue[300]!, Colors.blue[50]!], // Adjust the colors as needed
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
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
                          fontSize: screenSize.width * 0.06, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : SizedBox.shrink(),
                    ),
                    SizedBox(height: 16.0),
                    Center( // Center the content container
                      child: Container(
                        width: 400, // Set your desired fixed width here
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
                            ? Center(
                          child: SpinKitWave(
                            color: Colors.blue,
                            size: 50.0, // Adjust the size as needed
                          ),
                        )
                            : RichText(
                          text: TextSpan(
                            children: generatedContent != null
                                ? _parseContent(generatedContent!)
                                : [TextSpan(text: 'No content available.')],
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04, // Responsive font size
                              color: Colors.black,
                              height: 1.5,
                            ), // Default text style
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
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
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
