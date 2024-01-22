import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TargetPointPage extends StatefulWidget {
  const TargetPointPage({super.key});

  @override
  State<TargetPointPage> createState() => _TargetPointPageState();
}

class _TargetPointPageState extends State<TargetPointPage> {


Future<int> _getTotalWishPoints() async {
  User? user = FirebaseAuth.instance.currentUser;
  int totalPoints = 0;

  if (user != null) {
    QuerySnapshot wishesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('wishes')
        .get();

    for (var doc in wishesSnapshot.docs) {
      var data = doc.data();
      if (data is Map<String, dynamic>) {
        var points = data['points'];
        if (points is int) {
          totalPoints += points;
        } else if (points is double) {
          totalPoints += points.toInt(); // Konvertierung von double zu int
        }
      }
    }
  }

  return totalPoints;
}



Future<double> _getUserProgress() async {
  int userPoints = await _getUserPoints();
  int totalWishPoints = await _getTotalWishPoints();
  if (totalWishPoints == 0) {
    return 0.0; // Vermeidung der Division durch Null
  }
  return userPoints / totalWishPoints; // Gibt einen double-Wert zurück
}


  Future<int> _getUserPoints() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      return userData?['points'] ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          BackgroundScreen(Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: ContainerGlassFlex(
                  child: Center(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_sharp,
                                  size: 30,
                                )),
                            const SizedBox(
                              width: 50,
                            ),
                            Text('Target Point', style: kTextHeadLine5),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 200,
                                    child:
                                        Image.asset('assets/images/child.png')),
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Text('Your Points:',
                                      textAlign: TextAlign.center,
                                      style: kTextHeadLine2),
                                ),
                                FutureBuilder<int>(
                                  future: _getUserPoints(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError) {
                                      return Text('Fehler: ${snapshot.error}');
                                    }
                                    int points = snapshot.data ?? 0;
                                    return GlassContainerFixText(
                                      child: Text('**$points**',
                                          textAlign: TextAlign.center,
                                          style: kTextHeadLine2),
                                    );
                                  },
                                ),
                                Text(
                                    style: kTextHeadLine2,
                                    'keep an eye on your goals'),
                                const SizedBox(
                                  height: 70,
                                ),
                                FutureBuilder<double>(
                                  future: _getUserProgress(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError) {
                                      return Text('Fehler: ${snapshot.error}');
                                    }
                                    double progress = snapshot.data ?? 0.0;
                                    return CircularPercentIndicator(
                                      radius: 70.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: progress,
                                      center: Text(
                                        "${(progress * 100).toStringAsFixed(1)}%",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      footer: const Text(
                                        "Percent of target",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.green,
                                    );
                                  },
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ]),
              ))))
        ]));
  }
}
