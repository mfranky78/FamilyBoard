import 'package:famibo/core/wabenstruktur_screen.dart';
import 'package:famibo/features_1/my_profile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:famibo/core/custom_glasscontainer_flex.dart';
import 'package:famibo/core/custom_glasscontainer_text.dart';
import 'package:famibo/core/text_style_page.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // UserStateNotifier
    final userState = ref.watch(userStateNotifierProvider);

    ref.read(userStateNotifierProvider.notifier).loadUserData();

    return Scaffold(
        body: Stack(children: [
      HoneycombBackground(
       child: ContainerGlassFlex(
         child: Column(children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               IconButton(
                   onPressed: () {
                     Navigator.of(context).pop();
                   },
                   icon: const Icon(
                     Icons.arrow_back_sharp,
                     size: 30,
                   )),
               Text('My Profile', style: kTextHeadLine5),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.pushNamed(context, "/myprofilesetting");
                   },
                   child: const Icon(Icons.settings),
                 ),
               )
             ],
           ),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Center(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   SizedBox(
                     height: 200,
                     width: 250,
                     child: userState.imageUrl != null &&
                             userState.imageUrl!.isNotEmpty
                         ? Image.network(userState.imageUrl!,
                             fit: BoxFit.cover)
                         : Image.asset('assets/images/dogchild.png'),
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   Text('Du bist angemeldet:', style: kTextHeadLine6),
                   const SizedBox(
                     height: 40,
                   ),
                   GlassContainerFixText(
                       child:
                           Text('${userState.name}', style: kTextHeadLine4)),
                   GlassContainerFixText(
                       child: Text('${userState.email}',
                           style: kTextHeadLine4)),
                   //  GlassContainerFixText(child: Text('Team: $team')),
                 ],
               ),
             ),
           ),
         ]),
       ),
      )
    ]));
  }
}
