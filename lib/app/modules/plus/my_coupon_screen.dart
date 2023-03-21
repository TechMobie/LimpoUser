// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:linpo_user/components/button/button.dart';
// import 'package:linpo_user/helper/utils/math_utils.dart';
// import 'package:linpo_user/schemata/color_schema.dart';
// import 'package:linpo_user/schemata/text_style.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../components/common_class.dart';

// class MyCouponScreen extends StatelessWidget {
//   const MyCouponScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorSchema.whiteColor,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(
//               left: getSize(20), right: getSize(20), top: getSize(50)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonHeader(
//                 title: AppLocalizations.of(context)!.myCoupons,
//               ),
//               SizedBox(
//                 height: getSize(50),
//               ),
//               Text(
//                 AppLocalizations.of(context)!.noCoupons,
//                 style: const TextStyle()
//                     .semibold16
//                     .textColor(ColorSchema.blackColor),
//               ),
//               SizedBox(
//                 height: getSize(20),
//               ),
//               CommonAppButton(
//                   text: AppLocalizations.of(context)!.discount,
//                   onTap: () {
//                     showDialog(
//                         barrierDismissible: true,
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           titlePadding: const EdgeInsets.all(10),
//                           contentPadding: EdgeInsets.only(
//                             bottom: getSize(20),
//                           ),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                           insetPadding:
//                           const EdgeInsets.symmetric(horizontal: 40),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Container(
//                                 width: double.infinity,
//                                 padding: EdgeInsets.only(
//                                     left: getSize(20), right: getSize(20)),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     color: Colors.white),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       AppLocalizations.of(context)!
//                                           .shareIdea,
//                                       textAlign: TextAlign.start,
//                                       style: const TextStyle()
//                                           .medium12
//                                           .textColor(
//                                           ColorSchema.grey54Color),
//                                     ),
//                                     SizedBox(
//                                       height: getSize(10),
//                                     ),
//                                     Text(
//                                       AppLocalizations.of(context)!
//                                           .yourCode,
//                                       style: const TextStyle()
//                                           .medium12
//                                           .textColor(
//                                           ColorSchema.grey54Color),
//                                       textAlign: TextAlign.start,
//                                     ),
//                                     SizedBox(
//                                       height: getSize(25),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.back();
//                                       },
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             AppLocalizations.of(context)!
//                                                 .copyCode,
//                                             style: const TextStyle()
//                                                 .semibold16
//                                                 .textColor(ColorSchema
//                                                 .lightBlueColor),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ));
//                   },
//                   color: ColorSchema.lightBlueColor,
//                   width: getSize(200),
//                   style: const TextStyle()
//                       .normal16
//                       .textColor(ColorSchema.whiteColor),
//                   borderRadius: 5),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

