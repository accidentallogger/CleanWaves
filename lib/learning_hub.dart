import 'package:beach_saver_test/ConfigColors.dart';
import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class LearningHub extends StatelessWidget {
  const LearningHub({super.key});

  void _openAIMascot(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AIMascotScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.backgroColor,
      appBar: AppBar(
        backgroundColor: appcolors.appBarColor,
        title: Center(
          child: const Text(
            "Learning Hub",
            style: TextStyle(
              color: appcolors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _openAIMascot(context),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: appcolors.buttonColor,
                child: const Icon(Icons.android, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _minimalButton("Quizzes", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizSection()),
                  );
                }),
                _minimalButton("Case Studies", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CourseSection()),
                  );
                }),
                _minimalButton("Modules", () {
                  // Navigate to modules screen
                }),
              ],
            ),
            const SizedBox(height: 20),
            _progressBar("Quizzes Completed", 0.6),
            _progressBar("Modules Completed", 0.8),
            _progressBar("Points Earned", 0.85),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Learning Activity",
                style: TextStyle(
                  color: appcolors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _historyTile(
                  "Quiz: Ocean Cleanup Basics",
                  "Completed 2 days ago",
                ),
                _historyTile("Module: Recycling 101", "Completed 4 days ago"),
                _historyTile(
                  "Case Study: Plastic Ban Impact",
                  "Completed 1 week ago",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _minimalButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: appcolors.buttonColor.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onTap,
      child: Text(text, style: const TextStyle(color: appcolors.textColor)),
    );
  }

  Widget _progressBar(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: appcolors.subtextcolor)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: appcolors.appBarColor,
          color: appcolors.buttonColor,
          minHeight: 8,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _historyTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appcolors.buttonColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: appcolors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: appcolors.subtextcolor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class QuizSection extends StatelessWidget {
  const QuizSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.backgroColor,
      appBar: AppBar(
        backgroundColor: appcolors.appBarColor,
        title: const Text("Quizzes"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/beachplace.jpg",
            ), // Add this asset to your project
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: 40,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 12,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appcolors.buttonColor.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Quiz ${index + 1} tapped')),
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 8),
                        child: Text(
                          "Quiz ${index + 1}",
                          style: const TextStyle(
                            color: appcolors.textColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.backgroColor,
      appBar: AppBar(
        backgroundColor: appcolors.appBarColor,
        title: const Text("Case Studies"),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            color: appcolors.appBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.asset(
                    "assets/placeholder.jpg", // Add this asset
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Case Study ${index + 1}: A detailed description of the study goes here...",
                    style: const TextStyle(color: appcolors.subtextcolor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appcolors.buttonColor,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              backgroundColor: appcolors.appBarColor,
                              title: const Text(
                                "AI Summary",
                                style: TextStyle(color: appcolors.textColor),
                              ),
                              content: const Text(
                                "This is where your AI summary appears.",
                                style: TextStyle(color: appcolors.subtextcolor),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                      color: appcolors.buttonColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          "Summarize with AI",
                          style: TextStyle(color: appcolors.textColor),
                        ),
                      ),
                      const SizedBox(width: 130),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appcolors.buttonColor,
                        ),
                        onPressed: () => {context: context},
                        child: Text(
                          "Read",
                          style: TextStyle(color: appcolors.textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AIMascotScreen extends StatefulWidget {
  const AIMascotScreen({super.key});

  @override
  State<AIMascotScreen> createState() => _AIMascotScreenState();
}

class _AIMascotScreenState extends State<AIMascotScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final FlutterTts _tts = FlutterTts();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({'sender': 'user', 'text': text.trim()});
    });

    // Simulated bot reply
    Future.delayed(const Duration(milliseconds: 500), () {
      final botReply = "You said: $text";
      setState(() {
        _messages.add({'sender': 'bot', 'text': botReply});
      });
    });
  }

  void _openVoiceDialog() {
    final stt.SpeechToText speech = stt.SpeechToText();
    bool isListening = false;
    String tempText = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: appcolors.appBarColor,
              title: const Text(
                "Voice Assistant",
                style: TextStyle(color: appcolors.textColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isListening ? Icons.mic : Icons.mic_none,
                    size: 50,
                    color: appcolors.buttonColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tempText.isEmpty ? "Listening..." : tempText,
                    style: const TextStyle(color: appcolors.subtextcolor),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    speech.stop();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(color: appcolors.buttonColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    speech
        .initialize(
          onStatus: (status) {
            if (status == "done" || status == "notListening") {
              speech.stop();
              if (tempText.trim().isNotEmpty) {
                Navigator.pop(context);
                _sendMessage(tempText);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No speech detected to send")),
                );
              }
            }
          },
          onError: (error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Speech error: ${error.errorMsg}")),
            );
          },
        )
        .then((available) {
          if (available) {
            isListening = true;
            speech.listen(
              onResult: (result) {
                tempText = result.recognizedWords;
                setState(() {}); // Refresh main screen if needed
              },
            );
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Speech recognition not available")),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.backgroColor,
      appBar: AppBar(
        backgroundColor: appcolors.secondarybgcolor,
        title: const Text("AI Mascot"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 40,
            backgroundColor: appcolors.buttonColor,
            child: const Icon(
              Icons.android,
              color: appcolors.textColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? appcolors.buttonColor.withOpacity(0.8)
                          : appcolors.chatbox,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['text']!,
                      style: const TextStyle(color: appcolors.textColor),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: appcolors.textColor),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: const TextStyle(color: appcolors.subtextcolor),
                      filled: true,
                      fillColor: appcolors.chatbox,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: appcolors.buttonColor),
                  onPressed: () {
                    final text = controller.text;
                    controller.clear();
                    _sendMessage(text);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: appcolors.buttonColor),
                  onPressed: _openVoiceDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
