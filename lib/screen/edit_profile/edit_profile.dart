import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/screen/bottom_Navigation.dart';
import 'package:roaia/screen/edit_profile/cubit.dart';

import '../../localization/localization_methods.dart';
import 'states.dart';

class Edit_Profile extends StatelessWidget {
  const Edit_Profile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
  });

  final String firstName, lastName, userName, email, imageUrl, phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: EditProfileBody(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: email,
        imageUrl: imageUrl,
        phoneNumber: phoneNumber,
      ),
    );
  }
}

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
  });

  final String firstName, lastName, userName, email, imageUrl, phoneNumber;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);

    cubit.controllers.firstNameController.text = firstName;
    cubit.controllers.lastNameController.text = lastName;
    cubit.controllers.userNameController.text = userName;
    cubit.controllers.emailController.text = email;
    cubit.controllers.phoneController.text = phoneNumber;

    return Scaffold(
      body: Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: BlocBuilder<EditProfileCubit, EditProfileStates>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .10,
                        ),
                        Container(
                          width: 180,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffE5E5E5),
                                spreadRadius: 15,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              tr("edit_profile_info", context),
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff5095FF)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage('${imageUrl}'),
                        ),
                        cubit.profileImage != null
                            ? Container(
                                height: 200,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Image(
                                  image: FileImage(
                                    File(cubit.profileImage!.path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage('${imageUrl}'),
                              ),
                        Positioned(
                          top: 150,
                          left: 150,
                          child: GestureDetector(
                            onTap: cubit.chooseProfileImage,
                            child: CircleAvatar(
                              radius: 20,
                              child: Image.asset('assets/images/edit2.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          border: Border.all(color: Color(0xffF1F3F9)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("first", context),
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: cubit.controllers.firstNameController,
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  color: Color(0xff57534E),
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          border: Border.all(color: Color(0xffF1F3F9)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("last", context),
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: cubit.controllers.lastNameController,
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  color: Color(0xff57534E),
                                  fontSize: 20),
                              decoration: const InputDecoration(),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<EditProfileCubit, EditProfileStates>(
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              border: Border.all(color: Color(0xffF1F3F9)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              15.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr("username", context),
                                  style: const TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: cubit
                                      .controllers.userNameController,
                                  style: const TextStyle(
                                      fontFamily: "Nunito",
                                      color: Color(0xff57534E),
                                      fontSize: 20),
                                  decoration: const InputDecoration(),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffF1F3F9),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("mail", context),
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: cubit.controllers.emailController,
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  color: Color(0xff57534E),
                                  fontSize: 20),
                              decoration: const InputDecoration(),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          border: Border.all(color: Color(0xffF1F3F9)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: cubit.controllers.phoneController,
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  color: Color(0xff57534E),
                                  fontSize: 20),
                              decoration: const InputDecoration(),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<EditProfileCubit, EditProfileStates>(
                      listener: (context, state) {
                        if (state is EditProfileFailedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.msg),
                            ),
                          );
                        } else if (state is EditProfileNetworkErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Network Error"),
                            ),
                          );
                        } else if (state is EditProfileSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Profile Edited Successfully"),
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => NavigationBottom(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is EditProfileLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: const Color(0xff2C67FF),
                            ),
                          );
                        }
                        return Container(
                          width: MediaQuery.of(context).size.width * .90,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xff2C67FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              print("Submitting: ${cubit.controllers.userNameController.text}");
                              cubit.editProfile();
                            },
                            child: Text(
                              tr("save_changes", context),
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
