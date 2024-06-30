import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roaia/core/helpers/app_constance.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/bottom_Navigation.dart';
import 'package:roaia/screen/notification2.dart';
import 'package:roaia/screen/notifications/notifications_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(),
      child: NotificationBody(),
    );
  }
}

class NotificationBody extends StatelessWidget {
  NotificationBody({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NotificationsCubit>(context);
    cubit.getNotifications();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .35,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffE5E5E5),
                    spreadRadius: 15,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  tr("notification", context),
                  style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff5095FF)),
                ),
              ),
            ),
          ),
          BlocConsumer<NotificationsCubit, NotificationsStates>(
            builder: (context, state) {
              if (state is NotificationsLoadingState) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  child: const CircularProgressIndicator(),
                );
              } else if (state is NotificationsFailedState) {
                print(state.msg);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                  child: const Center(
                    child: Text(
                        'glassesId is not found, or no notifications found'),
                  ),
                );
              } else if (state is DeleteNotificationsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (cubit.notificationsList.isEmpty) {
                return const Notification2_Screen();
              }

              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.notificationsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10.h, left: 10.w),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                color: cubit
                                    .notificationsTypeColor(
                                        type: cubit.notificationsList[index]
                                                .type ??
                                            '')!
                                    .withOpacity(.4),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xff2323230A))),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.notifications_outlined,
                                          color: cubit.notificationsTypeIconColor(
                                              type: cubit.notificationsList[index]
                                                      .type ??
                                                  '')),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          softWrap: true,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          "${cubit.notificationsList[index].title} : ${cubit.notificationsList[index].body} ",
                                          style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(AppConstance.dateFormat.format(DateTime.parse(cubit.notificationsList[index].createdAt!)),
                                 style:  TextStyle( fontFamily: "Nunito",
                                     fontWeight: FontWeight.w500,
                                     color: Colors.black,
                                     fontSize: 12), ),
                                  Text(AppConstance.timeFormat.format(DateTime.parse(cubit.notificationsList[index].createdAt!)),
                                    style: const TextStyle( fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xff2C67FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Notifications',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: Colors.black,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              content: Text(
                                'Are you sure to delete?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.sp,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "cancel",
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                TextButton(
                                  onPressed: () {
                                    cubit.DeleteNotifications();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationBottom(),
                                    ));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xff1363DF),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      'delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        tr("delete_all", context),
                        style: const TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
            listener: (BuildContext context, NotificationsStates state) {
              if (state is DeleteNotificationsSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Notifications Deleted Successfully"),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
