import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Portfolio/aboutme.dart';
import 'Portfolio/educationPage.dart';
import 'Portfolio/workExperience.dart';
import 'Portfolio/skills.dart';
import 'Portfolio/projects.dart';
import 'Portfolio/blog.dart'; // Import the new Blog page
// ignore: depend_on_referenced_packages
import 'package:fin/Calculator/CalculatorScreen.dart';
import 'package:fin/QUIZ/QuizScreen.dart';
import 'package:fin/Weather/Weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _checkLoginStatus();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    setState(() {
      if (theme == 'dark') {
        _themeMode = ThemeMode.dark;
      } else if (theme == 'light') {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
    });
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    setState(() {
      _isLoggedIn = isLoggedIn ?? false;
    });
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        prefs.setString('theme', 'dark');
      } else {
        _themeMode = ThemeMode.light;
        prefs.setString('theme', 'light');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: _isLoggedIn ? '/main' : '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) =>
            FirstScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
        '/aboutMe': (context) => AboutMe(),
        '/education': (context) => EducationPage(),
        '/workexperience': (context) => WorkExpPage(),
        '/skills': (context) => Skills(),
        '/project': (context) => project(),
        '/calculator': (context) => CalculatorScreen(),
        '/quiz': (context) => const ModeSelectionScreen(),
        '/weather': (context) => WeatherWidget(),
        '/blog': (context) => BlogPage(), // Add the new Blog route
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formKey.currentState!.validate()) {
      // Save login status to shared preferences
      prefs.setBool('isLoggedIn', true);

      // Navigate to the main application
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color.fromARGB(255, 64, 122, 177),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 64, 122, 177),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  FirstScreen({required this.toggleTheme, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Portfolio",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/drawer.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                "App List",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Calculator'),
              onTap: () {
                Navigator.pushNamed(context, '/calculator');
              },
            ),
            ListTile(
              leading: Icon(Icons.quiz_outlined),
              title: Text('QUIZ'),
              onTap: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
            ListTile(
              leading: Icon(Icons.sunny_snowing),
              title: Text('Weather'),
              onTap: () {
                Navigator.pushNamed(context, '/weather');
              },
            ),
            ListTile(
              leading: Icon(Icons.developer_mode_sharp),
              title: Text('My Portfolio'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/profile.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                "Kazi Sharfunnabi",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "A Tech Enthusiast",
                style: TextStyle(
                  fontFamily: 'Caveat Brush',
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: <Widget>[
                  _buildGridTile(
                    context,
                    icon: Icons.face_outlined,
                    title: "About Me",
                    gradientColors: [Color.fromARGB(255, 78, 35, 32), const Color.fromARGB(255, 161, 99, 120)],
                    route: '/aboutMe',
                  ),
                  _buildGridTile(
                    context,
                    icon: Icons.school_outlined,
                    title: "My Education",
                    gradientColors: [Color.fromARGB(255, 155, 132, 207), const Color.fromARGB(255, 124, 94, 84)],
                    route: '/education',
                  ),
                  _buildGridTile(
                    context,
                    icon: Icons.work_outline,
                    title: "Experience",
                    gradientColors: [const Color.fromARGB(255, 86, 192, 89), const Color.fromARGB(255, 109, 133, 83)],
                    route: '/workexperience',
                  ),
                  _buildGridTile(
                    context,
                    icon: Icons.code_outlined,
                    title: "My Skills",
                    gradientColors: [const Color.fromARGB(255, 216, 91, 238), const Color.fromARGB(255, 112, 96, 156)],
                    route: '/skills',
                  ),
                  _buildGridTile(
                    context,
                    icon: Icons.dashboard_outlined,
                    title: "My Project",
                    gradientColors: [Colors.teal, Colors.tealAccent],
                    route: '/project',
                  ),
                  _buildGridTile(
                    context,
                    icon: Icons.book_outlined, // Icon for the Blog
                    title: "Blog",
                    gradientColors: [Colors.blue, Colors.lightBlueAccent],
                    route: '/blog',
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.lightBlue,
                    iconSize: 40,
                    onPressed: twitter_url,
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.github),
                    color: Colors.white,
                    iconSize: 40,
                    onPressed: github_url,
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    color: Colors.indigoAccent,
                    iconSize: 43,
                    onPressed: linked_in_url,
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.quora),
                    color: Colors.red,
                    iconSize: 43,
                    onPressed: quora_url,
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.medium),
                    color: Colors.white,
                    iconSize: 43,
                    onPressed: medium_url,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridTile(BuildContext context,
      {required IconData icon,
      required String title,
      required List<Color> gradientColors,
      required String route}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(20.0),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Comfortaa",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

linked_in_url() async {
  const url = 'https://www.linkedin.com/in/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

twitter_url() async {
  const url = 'https://x.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

github_url() async {
  const url = 'https://github.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

quora_url() async {
  const url = 'https://www.quora.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

medium_url() async {
  const url = 'https://medium.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
