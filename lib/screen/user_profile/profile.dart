import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/screen/change_password/change_password.dart';
import 'package:roaia/screen/edit_profile/edit_profile.dart';
import 'package:roaia/screen/user_profile/user_info_cubit.dart';

import '../../localization/localization_methods.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfileBody();
  }
}

class _ProfileBody extends StatelessWidget {
  _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserInfoCubit>(context);
    print(' token ref ${  CacheHelper.get(key: 'refreshToken')
    }');
        return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: BlocConsumer<UserInfoCubit, UserInfoStates>(
              listener: (context, state) {

              },
              builder: (context, state) {
                if (state is UserInfoLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xff2C67FF),
                    ),
                  );
                } else if (state is UserInfoFailedState) {
                  return Center(child: Text(state.msg));
                } else if (state is NetworkErrorState) {
                  return Center(child: Text('Network Error'));
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 110.w,
                          ),
                          Container(
                            width: 120.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffE5E5E5),
                                  spreadRadius: 12,
                                  blurRadius: 12,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                tr("profile_info", context),
                                style: TextStyle(fontFamily: "Nunito",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff5095FF)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Edit_Profile(
                                      firstName: "${cubit.userInfo!.firstName}",
                                      lastName: "${cubit.userInfo!.lastName}",
                                      userName: "${cubit.userInfo!.userName}",
                                      email: "${cubit.userInfo!.email}",
                                      imageUrl: "${cubit.userInfo!.imageUrl}",
                                      phoneNumber: '${cubit.userInfo!.phoneNumber}',
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset('assets/images/edit.png'))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage('${cubit.userInfo!.imageUrl}'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${cubit.userInfo!.firstName} ${cubit.userInfo!.lastName} ',
                        style: TextStyle(fontFamily: "Nunito",
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffF1F3F9),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text.rich(
                          TextSpan(
                              text: tr("user_name", context),
                              style: TextStyle(fontFamily: "Nunito",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '   \n    ${cubit.userInfo!.userName}',
                                  style: TextStyle(fontFamily: "Nunito",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff57534E)),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffF1F3F9),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text.rich(
                          TextSpan(
                              text: tr("Email", context),
                              style: TextStyle(fontFamily: "Nunito",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '   \n    ${cubit.userInfo!.email}',
                                  style: TextStyle(fontFamily: "Nunito",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff57534E)),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffF1F3F9),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text.rich(
                          TextSpan(
                              text:'   \n    PhoneNumber',
                              style: TextStyle(fontFamily: "Nunito",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text:cubit.userInfo!.phoneNumber ==null? ' \n    Phone Number not Entered yet ' : '   \n    ${cubit.userInfo!.phoneNumber}',
                                  style: TextStyle(fontFamily: "Nunito",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff57534E)),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xffF1F3F9),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: tr("Password", context),
                                  style: TextStyle(fontFamily: "Nunito",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '   \n    ********',
                                      style: TextStyle(fontFamily: "Nunito",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff57534E)),
                                    )
                                  ]),
                            ),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * .25,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color(0xffE6F2FF),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  )),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordScreen(),
                                      ));
                                },
                                child: Text(
                                  tr("change", context),
                                  style: TextStyle(fontFamily: "Nunito",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xff1363DF)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
