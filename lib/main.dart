
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizMasterApp());
}

class QuizMasterApp extends StatelessWidget {
  const QuizMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Master',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int answer;
  final String category;

  const QuizQuestion(
    this.question,
    this.options,
    this.answer,
    this.category,
  );
}

const List<QuizQuestion> questions = [
  QuizQuestion(
    'What is the capital of India?',
    ['Mumbai', 'Chennai', 'New Delhi', 'Kolkata'],
    2,
    'General Knowledge',
  ),
  QuizQuestion(
    'Which planet is called the Red Planet?',
    ['Earth', 'Mars', 'Venus', 'Jupiter'],
    1,
    'Science',
  ),
  QuizQuestion(
    'How many days are there in a leap year?',
    ['364', '365', '366', '367'],
    2,
    'General Knowledge',
  ),
  QuizQuestion(
    'Which is the largest ocean?',
    ['Indian', 'Atlantic', 'Pacific', 'Arctic'],
    2,
    'Geography',
  ),
  QuizQuestion(
    'What is 12 multiplied by 8?',
    ['86', '96', '88', '108'],
    1,
    'Mathematics',
  ),
  QuizQuestion(
    'Which is the national bird of India?',
    ['Parrot', 'Peacock', 'Eagle', 'Sparrow'],
    1,
    'General Knowledge',
  ),
  QuizQuestion(
    'Which gas do plants absorb?',
    ['Oxygen', 'Carbon dioxide', 'Hydrogen', 'Helium'],
    1,
    'Science',
  ),
  QuizQuestion(
    'How many sides does a hexagon have?',
    ['Five', 'Six', 'Seven', 'Eight'],
    1,
    'Mathematics',
  ),
  QuizQuestion(
    'Which animal is the fastest on land?',
    ['Lion', 'Horse', 'Cheetah', 'Tiger'],
    2,
    'Nature',
  ),
  QuizQuestion(
    'Which festival is called the Festival of Lights?',
    ['Pongal', 'Holi', 'Diwali', 'Onam'],
    2,
    'Culture',
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.psychology_alt,
                size: 120,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 25),
              const Text(
                'QUIZ MASTER',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Test your knowledge!\nAnswer questions and earn points.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'START QUIZ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int current = 0;
  int score = 0;
  int? selected;
  bool answered = false;

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selected = index;
      answered = true;

      if (index == questions[current].answer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (!answered) return;

    if (current < questions.length - 1) {
      setState(() {
        current++;
        selected = null;
        answered = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score: score),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[current];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FF),
      appBar: AppBar(
        title: const Text('Quiz Master'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                '⭐ $score',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${current + 1} of ${questions.length}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (current + 1) / questions.length,
                minHeight: 8,
                color: Colors.deepPurple,
                backgroundColor: Colors.deepPurple.shade100,
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.deepPurple,
                      Color(0xFF9575CD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.category,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.lightbulb,
                      size: 40,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Choose your answer:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ...List.generate(q.options.length, (index) {
                final correct = index == q.answer;
                final isSelected = index == selected;

                Color bg = Colors.white;
                Color border = Colors.deepPurple.shade100;
                IconData? icon;

                if (answered && correct) {
                  bg = Colors.green.shade100;
                  border = Colors.green;
                  icon = Icons.check_circle;
                } else if (answered && isSelected) {
                  bg = Colors.red.shade100;
                  border = Colors.red;
                  icon = Icons.cancel;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => selectAnswer(index),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: border,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.deepPurple.shade50,
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              q.options[index],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (icon != null)
                            Icon(icon, color: border),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              if (answered)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    selected == q.answer
                        ? 'Correct answer! Well done!'
                        : 'Correct answer: ${q.options[q.answer]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selected == q.answer
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              const SizedBox(height: 15),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: answered ? nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    current == questions.length - 1
                        ? 'FINISH QUIZ'
                        : 'NEXT QUESTION →',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;

  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final total = questions.length;
    final percent = (score / total * 100).round();

    final message = percent >= 80
        ? 'Excellent! You are a Quiz Champion!'
        : percent >= 50
            ? 'Good job! Keep learning!'
            : 'Keep practising. You can do it!';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FF),
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Icon(
                percent >= 80
                    ? Icons.emoji_events
                    : Icons.school,
                size: 100,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              const Text(
                'QUIZ COMPLETED!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$score / $total',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                '$percent% Correct Answers',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 19),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
