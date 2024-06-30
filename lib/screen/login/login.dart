import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/bottom_Navigation.dart';
import 'package:roaia/screen/forget_password/Forget_Password.dart';
import 'package:roaia/screen/login/states.dart';
import 'package:roaia/screen/otp/OTP.dart';
import 'package:roaia/screen/sign_up/sign_Up.dart';


import 'cubit.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    style: const TextStyle(fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xff1363DF)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  tr("login", context),
                  style: const TextStyle(fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xff1363DF)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  tr("mail", context),
                  style: const TextStyle(fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(

                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: cubit.emailController,
                   validator: cubit.validateEmail,
                  decoration: InputDecoration(
                      labelText: 'Username, email or phone number',
                      labelStyle: const TextStyle(fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tr("password", context),
                  style: const TextStyle(fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: cubit.isObscure,
                      controller: cubit.passwordController,
                      validator: cubit.validatePassword,
                      decoration: InputDecoration(
                          labelText: tr("epassword", context),
                          suffixIcon: IconButton(
                            icon: cubit.isObscure
                                ? const Icon(Icons.visibility_outlined)
                                : Icon(Icons.visibility_off),
                            onPressed: cubit.changeVisibility,
                          ),
                          labelStyle: const TextStyle(fontFamily: "Nunito",
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xff96A0B6)),
                          border: const OutlineInputBorder()),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Forget_Password_Screen(),
                    ));
                  },
                  child: Text(
                    tr("forget", context),
                    style: const TextStyle(fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff5095FF)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocConsumer<LoginCubit, LoginStates>(
                  listener: (context, state) {
                    if (state is LoginFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                    } else if (state is NetworkErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Network Error"),
                        ),
                      );
                    } else if (state is NotVerifyState) {
                      cubit.sendOtp();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTP_Screen(
                          email: cubit.emailController.text,
                        ),
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please verify your email address!"),
                        ),
                      );
                    } else if (state is LoginSuccessState) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const NavigationBottom(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
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
                          cubit.login();
                        },
                        child: Text(
                          tr("Login", context),
                          style: const TextStyle(fontFamily: "Nunito",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/google.png',
                        scale: 0.8,
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'assets/images/facebook.png',
                        color: Colors.blue,
                        scale: 0.7,
                      ),
                    ),
                    Container(
                      child: Image.asset('assets/images/twitter.png', scale: 1),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr("have", context),
                      style: const TextStyle(fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff626C83)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Sign_Up_Screen(),
                        ));
                      },
                      child: Text(
                        tr("account", context),
                        style: const TextStyle(fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color(0xff007AFF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
