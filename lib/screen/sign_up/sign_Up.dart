import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/login/login.dart';
import 'package:roaia/screen/otp/OTP.dart';
import 'package:roaia/screen/sign_up/states.dart';

import 'cubit.dart';

class Sign_Up_Screen extends StatelessWidget {
  const Sign_Up_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: _Sign_Up_Bdy(),
    );
  }
}

class _Sign_Up_Bdy extends StatefulWidget {
  const _Sign_Up_Bdy();

  @override
  State<_Sign_Up_Bdy> createState() => __Sign_Up_BdyState();
}

class __Sign_Up_BdyState extends State<_Sign_Up_Bdy> {
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: Text(
                    tr("Roaia", context),
                    style: const TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xff1363DF)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  tr("create", context),
                  style: const TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xff1363DF)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  tr("first", context),
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, // Enables continuous validation

                  controller: cubit.controllers.firstNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'First Name Field Required ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: tr("ename", context),
                      labelStyle: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tr("last", context),
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, // Enables continuous validation

                  controller: cubit.controllers.lastNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Last Name Field Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: tr("ename", context),
                      labelStyle: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tr("username", context),
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, // Enables continuous validation

                  controller: cubit.controllers.userNameController,
                  validator: (value) {
                    String usernameRegex = r'^[a-zA-Z0-9_-]+$';
                    RegExp regex = RegExp(usernameRegex);
                    if (!regex.hasMatch(value!)) {
                      return 'Username can only contain letters or digits';
                    } else if (value.isEmpty) {
                      return 'User Name Field Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: ' Enter User name',
                      //labelText: tr("eusername", context),
                      labelStyle: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tr("mail", context),
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cubit.controllers.emailController,
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, // Enables continuous validation
                  validator: cubit.validateEmail,
                  decoration: const InputDecoration(
                    errorMaxLines: 2,
                      labelText: 'email',
                      prefixIcon: Icon(Icons.email),
                      labelStyle: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tr("password", context),
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: cubit.controllers.passwordController,
                      validator: cubit.validatePassword,
                      autovalidateMode: AutovalidateMode
                          .onUserInteraction, // Enables continuous validation
                      obscureText: cubit.isObscure,
                      decoration: InputDecoration(
                          errorMaxLines: 2,
                          labelText: tr("cpass", context),
                          suffixIcon: IconButton(
                            icon: cubit.isObscure
                                ? const Icon(Icons.visibility_outlined)
                                : Icon(Icons.visibility_off),
                            onPressed: cubit.changeVisibility,
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          labelStyle: const TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xff96A0B6)),
                          border: const OutlineInputBorder()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tr("id", context),
                  style: const TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .70,
                          // height: 48,
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction, // Enables continuous validation
                            controller: cubit.barcode.isEmpty?cubit.glassesId:TextEditingController(text: cubit.barcode),
                            validator: cubit.validateGuid,
                            decoration: InputDecoration(
                                labelText: 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX',
                                labelStyle: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Color(0xff96A0B6)),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .205555,
                          child: InkWell(
                              onTap: () {
                                cubit.scanBarcode();
                              },
                              child: Image.asset(
                                'assets/images/id.png',
                                scale: .93,
                              )),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    cubit.chooseLicenseImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            child: Divider(
                              thickness: 1.5,
                              height: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              thickness: 1.5,
                              width: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              thickness: 1.5,
                              width: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: Divider(
                              thickness: 1.5,
                              height: 0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .78,
                        height: 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("upload_photo", context),
                              style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff585858)),
                            ),
                            Image.asset('assets/images/gallery.png')
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 20,
                            child: Divider(
                              thickness: 1.5,
                              height: 0,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.5),
                            child: SizedBox(
                              height: 20,
                              child: VerticalDivider(
                                thickness: 1.5,
                                width: 0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.5),
                            child: SizedBox(
                              height: 20,
                              child: VerticalDivider(
                                thickness: 1.5,
                                width: 0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.5),
                            child: SizedBox(
                              width: 20,
                              child: Divider(
                                thickness: 1.5,
                                height: 0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: agree,
                        onChanged: (val) {
                          setState(() {
                            agree = val!;
                          });
                        }),
                    Row(
                      children: [
                        Text(
                          tr("agree", context),
                          style: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          tr("conditions", context),
                          style: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff006FE8)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocConsumer<RegisterCubit, RegisterStates>(
                  listener: (context, state) {
                    if (state is RegisterFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                    } else if (state is RegisterNetworkErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Network Error"),
                        ),
                      );
                    } else if (state is RegisterSuccessState) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OTP_Screen(
                            email: cubit.controllers.emailController.text),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoadingState) {
                      print('object');
                      return Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xff2C67FF),
                        ),
                      );
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width * 90,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xff2C67FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (!agree) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "You must agree to the terms and conditions"),
                              ),
                            );
                          }
                          // else if (cubit.imageFileCropper == null) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text("choose your photo"),
                          //     ),
                          //   );
                          // }
                          else {
                            cubit.register();
                          }
                        },
                        child: Text(
                          tr("sign up", context),
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
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr("already", context),
                      style: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xff626C83)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Login_Screen(),
                        ));
                      },
                      child: Text(
                        tr("Login", context),
                        style: const TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xff007AFF)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
