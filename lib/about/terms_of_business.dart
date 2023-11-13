import 'package:famibo/core/backround_screen.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:flutter/material.dart';

class TermsOfBusiness extends StatelessWidget {
  const TermsOfBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Business'),
      ),
      body: const Stack(
        children: [
          BackroundScreen(
            ContainerGlassFlex(
              child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                      'Allgemeine Geschäftsbedingungen für die Nutzung der [Ihre App-Name] App'
                      '1. Allgemeines'
                      'Mit der Nutzung der [Ihre App-Name] App erklären Sie sich mit den folgenden Allgemeinen'
                      'Geschäftsbedingungen (AGB) einverstanden. Bitte lesen Sie diese sorgfältig durch, bevor'
                      'Sie die App verwenden.'
                      '2. Lizenz und Nutzungsrechte'
                      '2.1 [Ihre App-Name] gewährt Ihnen eine persönliche, nicht übertragbare Lizenz zur Nutzung'
                      'der App gemäß diesen AGB.'
                      '2.2 Sie dürfen die App nur für legale Zwecke nutzen und stimmen zu, alle geltenden Gesetze'
                      'und Vorschriften einzuhalten.'
                      '3. Datenschut'
                      '3.1 [Ihre App-Name] respektiert Ihre Privatsphäre. Unsere Datenschutzrichtlinie beschreibt,'
                      'wie wir Informationen sammeln, verwenden und schützen, wenn Sie die App nutzen. Durch die Nutzung'
                      'der App stimmen Sie unserer Datenschutzrichtlinie zu.'
                      '4. Haftungsausschluss'
                      '4.1 Die Nutzung der App erfolgt auf eigenes Risiko. [Ihre App-Name] übernimmt keine Verantwortung'
                      'für Schäden, die durch die Nutzung der App entstehen.'
                      '5. Änderungen der AGB'
                      '5.1 [Ihre App-Name] behält sich das Recht vor, diese AGB jederzeit zu ändern. Änderungen werden'
                      'wirksam, sobald sie auf der App veröffentlicht werden.'
                      '6. Schlussbestimmungen'
                      '6.1 Diese AGB unterliegen den Gesetzen des [Ihr Landes]. Bei rechtlichen Auseinandersetzungen'
                      'ist der Gerichtsstand [Ihr Gerichtsstand].'
                      'Vielen Dank für die Nutzung der [Ihre App-Name] App!'),
                )
              ],
                        ),
            ))
        ],
      ),
    );
  }
}
