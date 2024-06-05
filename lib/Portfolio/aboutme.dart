import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ABOUT ME",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/aboutus.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("images/profile.jpg"),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Who Am I?",
                  style: TextStyle(
                    fontFamily: 'Sniglet',
                    fontSize: 37,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "Kazi Sharfunnabi",
                  style: TextStyle(
                    fontFamily: 'Sniglet',
                    fontSize: 24, // Increased font size
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "I am a tech enthusiast, learner, and adventurous person who has fascination for designning. "
                  "Imagination brings change and paves the way to develop something amazing and interesting. "
                  "I want to develop sustainable products that can solve people's problems.",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "What Am I?",
                  style: TextStyle(
                    fontFamily: 'Sniglet',
                    fontSize: 37,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "I am a student, a learner, a developer, and a designer. I am also a traveller and mentor. "
                  "I believe in wisdom.",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "My Hobbies",
                  style: TextStyle(
                    fontFamily: 'Sniglet',
                    fontSize: 37,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: const <Widget>[
                    HobbyIcon(
                        icon: FontAwesomeIcons.music, color: Colors.pinkAccent),
                    HobbyIcon(
                        icon: FontAwesomeIcons.playCircle,
                        color: Colors.yellowAccent),
                    HobbyIcon(
                        icon: FontAwesomeIcons.gamepad,
                        color: Colors.purpleAccent),
                    HobbyIcon(
                        icon: FontAwesomeIcons.feather,
                        color: Colors.greenAccent),
                    HobbyIcon(
                        icon: FontAwesomeIcons.tableTennis,
                        color: Colors.blueAccent),
                    HobbyIcon(
                        icon: FontAwesomeIcons.bug, color: Colors.redAccent),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "My Goals In Life",
                  style: TextStyle(
                    fontFamily: 'Sniglet',
                    fontSize: 37,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "My goal is to solve everyday problems of people using technology. "
                  "I also want to encourage new generations.",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
                width: 260,
                child: Divider(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HobbyIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const HobbyIcon({required this.icon, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon),
      color: color,
      iconSize: 40,
      onPressed: () {},
    );
  }
}
