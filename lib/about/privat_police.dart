import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/text_style_page.dart';
import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:flutter/material.dart';

class PrivatPolicePage extends StatelessWidget {
  const PrivatPolicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,46.0,0,0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text( 'Datenschutzerklärung', style: kTextHeadLine5,),
                ],
              ),
            ),
            const HoneycombBackground(
             child: Padding(
                padding: EdgeInsets.fromLTRB(0,54,0,0),
                child: ContainerGlassFlex(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Text('Datenschutzerklärung für [Family Board]\n'
                          'Zuletzt aktualisiert am [23.11.2023]\n'
                          'Diese Datenschutzerklärung erklärt, wie\n[Family Board] Informationen sammelt, '
                          'verwendet und weitergibt, und gilt für alle Benutzer der '
                          '[iOS/Android/anderen] Versionen unserer App. '
                          'Welche Informationen sammeln wir?\n'
                          'Personenbezogene Informationen:\n '
                          'Wenn Sie sich für [Family Board] registrieren oder ein Benutzerkonto erstellen, '
                          'sammeln wir möglicherweise personenbezogene Informationen wie Ihren Namen, '
                          'Ihre E-Mail-Adresse und andere Informationen, die Sie uns zur Verfügung stellen.\n '
                          'Nutzungsdaten:\n '
                          'Wir sammeln Informationen darüber, wie Sie auf unsere App zugreifen und sie verwenden. '
                          'Dazu gehören Ihr Gerätetyp, Betriebssystem, IP-Adresse, eindeutige Gerätekennungen und '
                          'andere Diagnosedaten. '
                          'Wie verwenden wir die gesammelten Informationen? '
                          'Wir verwenden die gesammelten Informationen, um:\n '
                          'Ihnen die Dienste unserer App bereitzustellen und deren Leistung zu verbessern. '
                          'Ihre Anfragen zu bearbeiten und auf Ihre Kommentare oder Anfragen zu antworten. '
                          'Mit Ihnen zu kommunizieren und Ihnen relevante Updates und Informationen über '
                          '[Family Board] zu senden. '
                          'Die Sicherheit unserer App zu gewährleisten und Missbrauch zu verhindern. '
                          'Wie schützen wir Ihre Informationen? '
                          'Die Sicherheit Ihrer persönlichen Informationen ist uns wichtig. '
                          'Wir ergreifen angemessene Maßnahmen, um sicherzustellen, '
                          'dass Ihre Daten sicher sind, einschließlich der Verwendung '
                          'von Verschlüsselungstechnologien und sicherer Server. '
                          'Offenlegung von Informationen:\n '
                          'Wir geben Ihre persönlichen Informationen nicht ohne Ihre Zustimmung weiter, '
                          'es sei denn, dies ist gesetzlich vorgeschrieben oder zur Durchsetzung unserer '
                          'Nutzungsbedingungen erforderlich. '
                          'Änderungen dieser Datenschutzerklärung: '
                          'Diese Datenschutzerklärung kann von Zeit zu Zeit aktualisiert werden, '
                          'um Änderungen unserer Praktiken oder für andere betriebliche, rechtliche '
                          'oder behördliche Gründe widerzuspiegeln. '
                          'Kontakt:\n '
                          'Bei Fragen zur Datenschutzerklärung können Sie uns unter [Kontakt-E-Mail] erreichen. '
                         ),
                    ),
                  ),
                ),
              ), 
            )
          ],
        ));
  }
}
