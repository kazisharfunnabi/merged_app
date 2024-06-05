// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class project extends StatelessWidget {
  const project({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY PROJECTS",
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
                image: AssetImage("images/workexperience.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 400,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.black,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 0, 20),
                          child: ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.python,
                              size: 100,
                              color: Colors.lightBlueAccent,
                            ),
                            title: Text('eduAlgo\n',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sniglet',
                                    fontSize: 20)),
                            subtitle: Text(
                                'A simple python package having '
                                'modules of different algorithms to be used in '
                                'educational purposes.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Comfortaa",
                                )),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.greenAccent,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const TextButton(
                                onPressed: edualgo,
                                child: Text('View Project',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Comfortaa",
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 400,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.black,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 0, 20),
                          child: ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.robot,
                              size: 80,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Robotics Project\n',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sniglet',
                                    fontSize: 20)),
                            subtitle: Text(
                              'Designed a Line Follower Bot and '
                              'a Bluetooth Controlled Bot using Arduino.',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.greenAccent,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const TextButton(
                                onPressed: robotics,
                                child: Text('View Project',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Comfortaa",
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
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

// ignore: duplicate_ignore
edualgo() async {
  const url = 'https://edualgo.github.io/documentation/';
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

greenhouse() async {
  const url =
      'https://github.com/MinhajAbedin/My-First-Portfolio.git';
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

frontline() async {
  const url = 'https://github.com/MinhajAbedin/leader-board-css3.git';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

algorithmic() async {
  const url = 'https://github.com/MinhajAbedin/leader-board-css3.git';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

survival() async {
  const url = 'https://github.com/MinhajAbedin/leader-board-css3.git';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

codingmas() async {
  const url = 'https://github.com/MinhajAbedin/leader-board-css3.git';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

cat() async {
  const url = 'https://github.com/MinhajAbedin/leader-board-css3.git';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

robotics() async {
  const url = 'https://github.com/MinhajAbedin/leader-board-css3.git';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
