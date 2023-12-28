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
          BackgroundScreen(
            ContainerGlassFlex(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Text(
                      'Allgemeine Geschäftsbedingungen für die Nutzung der [Family Board] App\n'
                      '1. Allgemeines\n'
                      'Mit der Nutzung der [Family Board] App erklären Sie sich mit den folgenden Allgemeinen'
                      'Geschäftsbedingungen (AGB) einverstanden. Bitte lesen Sie diese sorgfältig durch, bevor'
                      'Sie die App verwenden.\n'
                      '2. Lizenz und Nutzungsrechte\n'
                      '2.1 [Ihre App-Name] gewährt Ihnen eine persönliche, nicht übertragbare Lizenz zur Nutzung'
                      'der App gemäß diesen AGB.\n'
                      '2.2 Sie dürfen die App nur für legale Zwecke nutzen und stimmen zu, alle geltenden Gesetze'
                      'und Vorschriften einzuhalten.\n'
                      '3. Datenschut\n'
                      '3.1 [Family Board] respektiert Ihre Privatsphäre. Unsere Datenschutzrichtlinie beschreibt,'
                      'wie wir Informationen sammeln, verwenden und schützen, wenn Sie die App nutzen. Durch die Nutzung'
                      'der App stimmen Sie unserer Datenschutzrichtlinie zu.\n'
                      '4. Haftungsausschluss\n'
                      '4.1 Die Nutzung der App erfolgt auf eigenes Risiko. [Family Board] übernimmt keine Verantwortung'
                      'für Schäden, die durch die Nutzung der App entstehen.\n'
                      '5. Änderungen der AGB\n'
                      '5.1 [Family Board] behält sich das Recht vor, diese AGB jederzeit zu ändern. Änderungen werden'
                      'wirksam, sobald sie auf der App veröffentlicht werden.\n'
                      '6. Schlussbestimmungen\n'
                      '6.1 Diese AGB unterliegen den Gesetzen des [Deutschland]. Bei rechtlichen Auseinandersetzungen'
                      'ist der Gerichtsstand [Ihr Gerichtsstand].'
                      'Vielen Dank für die Nutzung der [Family Board] App!'),
                ),
              ),
            ))
        ],
      ),
    );
  }
}
