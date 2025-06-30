import 'package:flutter/material.dart';

class LearningHub extends StatelessWidget {
  const LearningHub({super.key});

  void _openAIMascot(BuildContext context) {
    // Replace this with actual AI Mascot screen navigation
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("AI Mascot", style: TextStyle(color: Colors.white)),
        content: const Text(
          "This is where your AI mascot chat opens.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text("Learning Hub"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () => _openAIMascot(context),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(
                    Icons.android,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 50),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QuizSection()),
                      );
                    },
                    child: const Text(
                      "Quizzes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute:builder(_)=>CourseSection);
                  },
                  child: const Text(
                    "Case Studies",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSection extends StatefulWidget{
  const CourseSection ({super.key});
  @override
  State<CourseSection> createState() => _CourseSection();
} 

class _CourseSection extends State<CourseSection>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Courses")),
    body: Padding(padding: const EdgeInsets.all(8)),

    );
  } 
}
class QuizSection extends StatefulWidget {
  const QuizSection({super.key});
  @override
  State<QuizSection> createState() => _QuizSection();
}

class _QuizSection extends State<QuizSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quizzes")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: 40,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 200,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Quiz ${index + 1} tapped'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Text(
                  "Quiz ${index + 1}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
