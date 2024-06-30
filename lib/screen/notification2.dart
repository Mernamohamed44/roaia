import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roaia/localization/localization_methods.dart';

class Notification2_Screen extends StatelessWidget {
  const Notification2_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(
        vertical: 200.h
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xffC3DAFF),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            tr("no_notification", context),
            style: const TextStyle(fontFamily: "Nunito",
                fontWeight: FontWeight.w800,
                fontSize: 25,
                color: Color(0xff040508)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            tr("will_get_updates", context),
            style: const TextStyle(fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Color(0xff17191C)),
          ),
        ],
      ),
    );

  }
}
