// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:sv_craft/common/otp_botton.dart';

// import '../../../common/bottom_button_column.dart';

// final _codeController = TextEditingController();
// Future loginUser(String phone, BuildContext context) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   var user;
//   _auth.verifyPhoneNumber(
//     phoneNumber: phone,
//     timeout: const Duration(seconds: 60),
//     verificationCompleted: (PhoneAuthCredential credential) async {
//       Navigator.of(context).pop();

//       UserCredential result = await _auth.signInWithCredential(credential);

//       if (result.user != null) {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => BottomAppBar(
//                     // user: result.user,
//                     )));
//         user = result.user;
//       } else {
//         print("Error");
//       }

//       //This callback would gets called when verification is done auto maticlly
//     },
//     verificationFailed: (Exception exception) {
//       print(exception);
//     },
//     codeSent: (String verificationId, int? resendToken) {
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) {
//             return AlertDialog(
//               // title: const Text("Insert the code?"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: Get.size.height * 0.05,
//                         ),
//                         const Text(
//                           "OTP Authentication",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 24,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "An authentication code has been sent to\n(+00) 999 999 999",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.grey.withOpacity(0.8),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 35,
//                         ),
//                         OTPTextField(
//                           length: 6,
//                           width: MediaQuery.of(context).size.width,
//                           fieldWidth: 25,
//                           style: TextStyle(fontSize: 18),
//                           textFieldAlignment: MainAxisAlignment.spaceAround,
//                           fieldStyle: FieldStyle.underline,
//                           onCompleted: (pin) {
//                             print("Completed: " + pin);
//                           },
//                         ),
//                         SizedBox(
//                           height: Get.size.height * .06,
//                         ),
//                         OTPbutton(
//                           onTap: () async {
//                             // Get.toNamed("/bottombar");
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(builder: (context) => HomeScreen()),
//                             // );

//                             final code = _codeController.text.trim();
//                             AuthCredential credential =
//                                 PhoneAuthProvider.credential(
//                               verificationId: verificationId,
//                               smsCode: code,
//                             );

//                             UserCredential result =
//                                 await _auth.signInWithCredential(credential);

//                             if (result.user != null) {
//                               user = result.user;
//                               print('userrrrrrrrrrrrrrrrrrrrrrrrrrrr $user');
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const BottomAppBar(
//                                           // user: result.user,
//                                           )));
//                             } else {
//                               print("Error");
//                             }
//                           },
//                           buttonText: "CONFIRM",
//                           buttonIcon: Icons.arrow_right_alt_sharp,
//                         ),
//                         SizedBox(
//                           height: Get.size.height * .02,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               // actions: <Widget>[
//               //   FlatButton(
//               //     child: const Text("Confirm"),
//               //     textColor: Colors.white,
//               //     color: Colors.blue,
//               //     onPressed: () async {
//               //       // String comingSms = (await AltSmsAutofill().listenForSms)!;
//               //       // String aStr =
//               //       //     comingSms.replaceAll(new RegExp(r'[^0-9]'), '');
//               //       // String otp = aStr.substring(0, 6);

//               //       // final code = otp;
//               //       // print(comingSms);
//               //       final code = _codeController.text.trim();
//               //       AuthCredential credential = PhoneAuthProvider.credential(
//               //           verificationId: verificationId, smsCode: code);

//               //       UserCredential result =
//               //           await _auth.signInWithCredential(credential);

//               //       if (result.user != null) {
//               //         Navigator.push(
//               //             context,
//               //             MaterialPageRoute(
//               //                 builder: (context) => BottomAppBar(
//               //                     // user: result.user,
//               //                     )));
//               //       } else {
//               //         print("Error");
//               //       }
//               //     },
//               //   )
//               // ],
//             );
//           });
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {
//       print('Time Out');
//     },
//   );
// }
