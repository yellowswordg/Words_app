// import 'package:flutter/material.dart';
// import 'package:words_app/constants/constants.dart';
// import 'package:words_app/components/reusable_main_button.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/providers/collections_provider.dart';

// class CreateBoxCollections extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String textTitleCollection;
//     return Consumer<Collections>(builder: (context, providerData, child) {
//       return Scaffold(
//         resizeToAvoidBottomPadding: true,
//         body: Container(
//           color: Colors.white,
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Name Your Collection",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                         top: 10.0,
//                       ),
//                     ),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                     ),
//                     autofocus: true,
//                     onChanged: (value) {
//                       textTitleCollection = value;
//                     },
//                   ),
//                 ),
//                 Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: ReusableMainButton(
//                       backgroundColor: kMainColorBlue,
//                       titleText: 'Add',
//                       textColor: Colors.white,
//                       onPressed: () {
//                         providerData.addNewCollection(textTitleCollection);
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
