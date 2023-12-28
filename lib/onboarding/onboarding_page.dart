import 'package:famibo/core/cutom_button_small.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

bool isAgree = false;
TextStyle pageInfoStyle = const TextStyle(fontSize: 16);
bool onTap = false;

class _OnboardingPageState extends State<OnboardingPage> {
  late int index;
 
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset('assets/images/logotext5.png', color: pageImageColor),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Information',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mit dieser App können Sie ihren Alltag Organisieren und Planen.'
                    'Setzen Sie sich Ziele und erreichen Sie diese mit ihrem Team.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/logotext5.png',
                  color: pageImageColor),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Erstellen Sie ihr eigens Team und laden Sie Freunde und Familie ein.'
                  ,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/logotext5.png',
                  color: pageImageColor),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Setzen Sie sich ihre eigenen Ziele um ihre Wünsche und Träume zu erreichen.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    PageModel(
        widget: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(width: 0.0, color: Colors.black),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Image.asset('assets/images/logotext5.png', color: pageImageColor),
        ),
         const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'AGB´S ACCESS',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Hiermit akzeptiere ich die AGB und Dateschnutzerklärung",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
      ]),
    ))
  ];
  void updateCheckbox(bool value) {
    setState(() {
      isAgree = value;
    });
  }

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: defaultSkipButtonColor,
      child: Row(
        children: [
          CustomButtonSmall(
            onTap: () {
              if (setIndex != null) {
                index = 3;
                setIndex(3);
              }
            },
            icon: Icons.skip_next,
            text: const Text('Skip'), 
          ),
        ],
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: defaultProceedButtonColor,
      child:  CustomButtonSmall(
        onTap: () {
          setState(() {
            if (isAgree == true) {
            Navigator.pushNamed(context, "/loginpage");
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Zustimmung AGBs'),
                  content: const Text('Um mit der Mobile App fort zufahren, müssen sie die Allgemeinengeschäftsbedingungen zustimmen.'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: const Text('Schließen')),
                  ],
                );
              }
           ); }
          });
        },
        icon: Icons.login,
        text: const Text('Sign up'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Onboarding(
            pages: onboardingPagesList,
            onPageChange: (int pageIndex) {
              setState(() {
                index = pageIndex;
              });
            },
            startPageIndex: 0,
            footerBuilder: (context, dragDistance, pagesLength, setIndex) {
              return DecoratedBox(
                  decoration: BoxDecoration(
                    color: background,
                    border: Border.all(
                      width: 0.0,
                      color: background,
                    ),
                  ),
                  child: ColoredBox(
                    color: background,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.green,
                                value: isAgree,
                                onChanged: (bool? value) {
                                  updateCheckbox(value ?? false);
                                },
                              ),
                              Text(
                                'Ich stimme zu',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isAgree ? Colors.green : Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomIndicator(
                                  netDragPercent: dragDistance,
                                  pagesLength: pagesLength,
                                  indicator: Indicator(
                                    indicatorDesign: IndicatorDesign.polygon(
                                      polygonDesign: PolygonDesign(
                                        polygon: DesignType.polygon_circle,
                                      ),
                                    ),
                                  ),
                                ),
                                index == pagesLength - 1
                                    ? _signupButton
                                    : _skipButton(setIndex: setIndex),
                              ]),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
