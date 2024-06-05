import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blog",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white, // Set text color to white for better contrast
          ),
        ),
        backgroundColor: Colors
            .black, // Change the AppBar background to black for better contrast
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How Flutter came?",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Welcome!",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase. Flutter was first announced in 2015 at the Dart developer summit. It was initially known as 'Sky' and could run on the Android operating system.",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "In 2017, during the Google I/O conference, Flutter was officially released as an open-source project. This release marked a significant milestone as it allowed developers worldwide to contribute to the framework and use it for building high-quality, natively compiled applications.",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "One of the key features of Flutter is its use of the Dart programming language, also developed by Google. Dart provides a robust framework for building fast and efficient applications, with a focus on frontend development. Flutter's architecture includes a reactive framework, which allows developers to create dynamic interfaces that respond to changes in real-time.",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Flutter 1.0 was released on December 4, 2018, at the Flutter Live event. This release was the first 'stable' version of the framework, and it included a variety of new features and improvements based on feedback from the developer community. Since then, Flutter has seen continuous updates and enhancements, with a growing ecosystem of packages and plugins that extend its capabilities.",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "In 2019, Flutter 1.5 was released at the Google I/O conference, introducing support for web applications. This made Flutter a true cross-platform framework, allowing developers to build web, mobile, and desktop applications from a single codebase. Subsequent releases have continued to expand Flutter's functionality and performance, making it one of the most popular frameworks for cross-platform development.",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Today, Flutter is used by developers and organizations around the world to build a wide range of applications. Its popularity is driven by its fast development cycle, expressive and flexible UI, and the ability to create high-performance applications that run on multiple platforms with a single codebase.",
                style: TextStyle(
                  fontFamily: 'Sniglet',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
