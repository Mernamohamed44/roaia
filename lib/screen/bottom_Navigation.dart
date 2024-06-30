import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/all_Contacts/all_Contacts.dart';
import 'package:roaia/screen/home_screen/home.dart';
import 'package:roaia/screen/notifications/notification.dart';


import 'refresh_token/refresh_token/view.dart';
import 'user_profile/profile.dart';
import 'user_profile/user_info_cubit.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int currentIndex = 0;

  List Screen = [
    HomeScreen(),
    ContactsScreen(),
    NotificationScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserInfoCubit(),
        child: Builder(
          builder: (context) {
            var cubit = BlocProvider.of<UserInfoCubit>(context);
            cubit.userInfoData();
            return BlocConsumer<UserInfoCubit, UserInfoStates>(
              listener: (context,state){
                if (state is UnAuthorizedState) {
                  print(' token ref ${  CacheHelper.get(key: 'refreshToken')
                  }');
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return RefreshTokenView();
                  }));
                }
              },
              builder: (context,state) {
                return Scaffold(
                  body: Screen[currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: currentIndex,
                    selectedItemColor: Color(0xff5095FF),
                    unselectedItemColor: Colors.grey,
                    items: [
                      BottomNavigationBarItem(
                        activeIcon: Image.asset('assets/images/routing (2).png'),
                        icon: Image.asset('assets/images/routing.png'),
                        label: tr("location", context),
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Image.asset('assets/images/profile-2user (1).png'),
                          icon: Image.asset('assets/images/profile-2user.png'),
                          label: 'Contacts'),
                      BottomNavigationBarItem(
                        activeIcon: Image.asset('assets/images/notification-bing (2).png'),
                          icon: Image.asset('assets/images/notification-bing (1).png'),
                          label: tr("notification", context)),
                      BottomNavigationBarItem(
                        icon:CircleAvatar(
                radius: 15,
                backgroundImage: cubit.userInfo?.imageUrl != null
                ? NetworkImage(cubit.userInfo!.imageUrl!)
                    : null,
                child: cubit.userInfo?.imageUrl == null
                ? CircleAvatar()
                    : null,
                ),
                        label: tr("profile", context),
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                );
              },
            );
          }
        ));
  }
}
