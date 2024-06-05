import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkExpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Work Experience",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroText(),
              SizedBox(height: 20),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.terminal,
                title: "Orama Digital Design",
                subtitle:
                    "(Social Media Post Designer)\n[Aug 2022 - present]",
                description:
                    "My roles and responsibilities for this position are:\n"
                    "=> Creating engaging and interactive posts",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Text(
      "My work experience includes working for startups, communities, and evolving with innovative business and marketing strategies.",
      style: TextStyle(
        fontSize: 18,
        fontFamily: "Comfortaa",
        color: Colors.white,
        letterSpacing: 1.5,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildExperienceCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required String description}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(icon, color: Colors.deepPurple, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Sniglet',
                      fontSize: 24,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 16,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
