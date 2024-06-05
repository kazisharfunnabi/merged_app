import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ModeSelectionScreen(),
    );
  }
}

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RedesignedButton(
              text: 'Practice',
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizScreen(mode: 'Practice'),
                  ),
                );
              },
            ),
            RedesignedButton(
              text: 'Timed',
              color: Colors.orange,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EnterNameScreen(),
                  ),
                );
              },
            ),
            RedesignedButton(
              text: 'Leaderboard',
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderboardScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RedesignedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const RedesignedButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: 200.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 5.0,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  EnterNameScreenState createState() => EnterNameScreenState();
}

class EnterNameScreenState extends State<EnterNameScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        mode: 'Timed',
                        name: _nameController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String mode;
  final String? name;
  const QuizScreen({super.key, required this.mode, this.name});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  SharedPreferences? sharedPreferences;
  int highestScore = 0;
  int quizNumber = 1;
  int questionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  late bool isTimedMode;

  int quizTimeInSeconds = 15 * 60; // 15 minutes in seconds
  int timeRemaining = 15 * 60; // Initially set to quiz time

  List<String> questions = [
    "Who won the FIFA World Cup in 2018?",
    "Which country has won the most FIFA World Cup titles?",
    "Who is known as the 'King of Football'?",
    "Which player has won the most Ballon d'Or awards?",
    "Where was the first FIFA World Cup held?",
    "Which club has won the most UEFA Champions League titles?",
    "Who is the all-time top scorer in the English Premier League?",
    "Which country hosted the 2014 FIFA World Cup?",
    "Who scored the 'Hand of God' goal in the 1986 World Cup?",
    "Which player is known as 'La Pulga' (The Flea)?",
    "Which national team is known as the 'Azzurri'?",
    "Who holds the record for most goals in a single World Cup tournament?",
    "Which country won the first FIFA Women's World Cup?",
    "Which club is known as 'The Red Devils'?",
    "Which country has produced the most Ballon d'Or winners?",
    "Who is the youngest player to ever play in a World Cup?",
    "Which manager has won the most UEFA Champions League titles?",
    "Which club is known for the famous 'You’ll Never Walk Alone' anthem?",
    "Which country is the only one to have appeared in every World Cup?",
    "Who is the all-time top scorer in World Cup history?",
    "Which country won the UEFA Euro 2020?",
    "Which player scored the fastest hat-trick in Premier League history?",
    "Who is the most capped international player of all time?",
    "Which club did Cristiano Ronaldo join in 2021?",
    "Who won the Golden Boot at the 2018 World Cup?",
    "Which player has the most assists in Premier League history?",
    "Which team is known as 'The Blues'?",
    "Who was the first African player to win the Ballon d'Or?",
    "Which country won the Copa America 2021?",
    "Who is known as the 'Black Panther' in football history?"
];

List<List<String>> options = [
    ["Germany", "Brazil", "France", "Argentina"],
    ["Germany", "Brazil", "Italy", "Argentina"],
    ["Diego Maradona", "Lionel Messi", "Pelé", "Cristiano Ronaldo"],
    ["Cristiano Ronaldo", "Lionel Messi", "Johan Cruyff", "Michel Platini"],
    ["France", "Uruguay", "Brazil", "Italy"],
    ["Real Madrid", "AC Milan", "Barcelona", "Bayern Munich"],
    ["Alan Shearer", "Wayne Rooney", "Sergio Agüero", "Thierry Henry"],
    ["South Africa", "Brazil", "Russia", "Germany"],
    ["Lionel Messi", "Zinedine Zidane", "Diego Maradona", "Pelé"],
    ["Neymar", "Lionel Messi", "Kylian Mbappé", "Sergio Agüero"],
    ["Brazil", "Argentina", "France", "Italy"],
    ["Gerd Müller", "Just Fontaine", "Miroslav Klose", "Ronaldo"],
    ["USA", "Norway", "Germany", "Brazil"],
    ["Liverpool", "Manchester United", "Arsenal", "Chelsea"],
    ["Germany", "Brazil", "Italy", "France"],
    ["Pelé", "Diego Maradona", "Lionel Messi", "Norman Whiteside"],
    ["Pep Guardiola", "Zinedine Zidane", "Carlo Ancelotti", "Alex Ferguson"],
    ["Barcelona", "Manchester United", "Liverpool", "Chelsea"],
    ["Germany", "Brazil", "Italy", "Argentina"],
    ["Ronaldo", "Miroslav Klose", "Just Fontaine", "Pelé"],
    ["Spain", "Italy", "England", "Portugal"],
    ["Cristiano Ronaldo", "Robbie Fowler", "Sadio Mané", "Sergio Agüero"],
    ["Gianluigi Buffon", "Cristiano Ronaldo", "Sergio Ramos", "Ahmed Hassan"],
    ["Manchester United", "Paris Saint-Germain", "Real Madrid", "Juventus"],
    ["Antoine Griezmann", "Harry Kane", "Romelu Lukaku", "Kylian Mbappé"],
    ["Ryan Giggs", "Frank Lampard", "Cesc Fàbregas", "Steven Gerrard"],
    ["Chelsea", "Manchester City", "Arsenal", "Everton"],
    ["George Weah", "Samuel Eto'o", "Roger Milla", "Didier Drogba"],
    ["Argentina", "Brazil", "Chile", "Uruguay"],
    ["Eusébio", "Pelé", "George Best", "Didier Drogba"]
];

List<String> correctAnswers = [
    "France",
    "Brazil",
    "Pelé",
    "Lionel Messi",
    "Uruguay",
    "Real Madrid",
    "Alan Shearer",
    "Brazil",
    "Diego Maradona",
    "Lionel Messi",
    "Italy",
    "Just Fontaine",
    "USA",
    "Manchester United",
    "Germany",
    "Norman Whiteside",
    "Carlo Ancelotti",
    "Liverpool",
    "Brazil",
    "Miroslav Klose",
    "Italy",
    "Sadio Mané",
    "Ahmed Hassan",
    "Manchester United",
    "Harry Kane",
    "Ryan Giggs",
    "Chelsea",
    "George Weah",
    "Argentina",
    "Eusébio"
];

  List<String> selectedAnswers = [];

  void shuffleQuestionsAndOptions() {
    List<int> indices = List<int>.generate(questions.length, (index) => index);
    indices.shuffle();

    List<String> shuffledQuestions = [];
    List<List<String>> shuffledOptions = [];
    List<String> shuffledCorrectAnswers = [];

    for (var index in indices) {
      shuffledQuestions.add(questions[index]);
      shuffledOptions.add(options[index]);
      shuffledCorrectAnswers.add(correctAnswers[index]);
    }

    setState(() {
      questions = shuffledQuestions;
      options = shuffledOptions;
      correctAnswers = shuffledCorrectAnswers;
    });
  }

  @override
  void initState() {
    super.initState();
    isTimedMode = widget.mode == 'Timed';
    loadHighestScore();
    shuffleQuestionsAndOptions();

    if (isTimedMode) {
      startTimer();
    }
  }

  Future<void> loadHighestScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = sharedPreferences?.getInt('highestScore') ?? 0;
    });
  }

  void updateHighestScore(int newScore) async {
    if (newScore > highestScore) {
      setState(() {
        highestScore = newScore;
      });
      await sharedPreferences?.setInt('highestScore', newScore);
    }
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timeRemaining > 0 && mounted) {
        setState(() {
          timeRemaining--;
        });
        startTimer();
      } else if (timeRemaining == 0) {
        endQuiz();
      }
    });
  }

  void answerQuestion(String selectedAnswer) {
    if (!isAnswered) {
      setState(() {
        selectedAnswers.add(selectedAnswer);
        isAnswered = true;
      });

      if (selectedAnswer == correctAnswers[questionIndex]) {
        score++;
      }

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          questionIndex++;
          isAnswered = false;
        });

        if (questionIndex >= questions.length) {
          endQuiz();
        }
      });
    }
  }

  void endQuiz() {
    if (isTimedMode) {
      saveScoreToLeaderboard();
    }
    updateHighestScore(score);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          score: score,
          highestScore: highestScore,
          isTimedMode: isTimedMode,
        ),
      ),
    );
  }

  Future<void> saveScoreToLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> leaderboard = prefs.getStringList('leaderboard') ?? [];
    leaderboard.add('${widget.name}: $score');
    await prefs.setStringList('leaderboard', leaderboard);
  }

  String get timeFormatted {
    int minutes = timeRemaining ~/ 60;
    int seconds = timeRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (questionIndex >= questions.length) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == 'Practice' ? 'Practice Quiz' : 'Timed Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTimedMode)
              Text(
                'Time Remaining: $timeFormatted',
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            const SizedBox(height: 20),
            Text(
              'Question ${questionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              questions[questionIndex],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Column(
              children: options[questionIndex].map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAnswered
                          ? (option == correctAnswers[questionIndex]
                              ? Colors.green
                              : (selectedAnswers.contains(option)
                                  ? Colors.red
                                  : Colors.blue))
                          : Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (isAnswered &&
                            option == correctAnswers[questionIndex])
                          const Icon(Icons.check, color: Colors.white),
                        if (isAnswered &&
                            selectedAnswers.contains(option) &&
                            option != correctAnswers[questionIndex])
                          const Icon(Icons.close, color: Colors.white),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (isAnswered)
              Text(
                selectedAnswers.last == correctAnswers[questionIndex]
                    ? 'Correct!'
                    : 'Incorrect! The correct answer is: ${correctAnswers[questionIndex]}',
                style: TextStyle(
                  fontSize: 18,
                  color: selectedAnswers.last == correctAnswers[questionIndex]
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int highestScore;
  final bool isTimedMode;

  const QuizResultScreen({
    Key? key,
    required this.score,
    required this.highestScore,
    required this.isTimedMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Score: $score',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Highest Score: $highestScore',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ModeSelectionScreen(),
                  ),
                );
              },
              child: const Text('Go to Home'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Share.share(
                  'I scored $score on the quiz! Can you beat my score?',
                );
              },
              child: const Text('Share your Score'),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  Future<List<String>> loadLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('leaderboard') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder<List<String>>(
        future: loadLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading leaderboard'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No scores yet. Be the first to take the quiz!'),
            );
          } else {
            List<String> leaderboard = snapshot.data!;
            return ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  title: Text(
                    leaderboard[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
