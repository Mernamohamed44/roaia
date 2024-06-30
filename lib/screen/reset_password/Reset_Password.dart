import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/login/login.dart';
import 'package:roaia/screen/reset_password/cubit.dart';
import 'package:roaia/screen/reset_password/states.dart';


class Reset_Password_Screen extends StatelessWidget {
  const Reset_Password_Screen({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Reset_Password_Body(
        email: email,
      ),
    );
  }
}

class Reset_Password_Body extends StatelessWidget {
  Reset_Password_Body({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    final cubit = ResetPasswordCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          tr("rest_password", context),
          style: const TextStyle(fontFamily: "Nunito",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff1363DF)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  tr("create_strong", context),
                  style: const TextStyle(fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xffABA9AB)),
                ),
              ),
              const SizedBox(
                height: 40,
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
              BlocBuilder<ResetPasswordCubit, ResetPasswordStates>(
                builder: (context, state) {
                  return TextFormField(
                    obscureText: cubit.isObscure,
                    controller: cubit.passwordController,
                    decoration: InputDecoration(
                        labelText: tr("epassword", context),
                        suffixIcon: IconButton(
                          icon: cubit.isObscure
                              ? const Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off),
                          onPressed: cubit.changeVisibility,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        labelStyle: const TextStyle(fontFamily: "Nunito",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Color(0xff96A0B6)),
                        border: const OutlineInputBorder()),
                  );
                },
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                tr("confirm_password", context),
                style: const TextStyle(fontFamily: "Nunito",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff40444C),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<ResetPasswordCubit, ResetPasswordStates>(
                builder: (context, state) {
                  return TextFormField(
                    obscureText: cubit.isObscureConfirm,
                    controller: cubit.rePasswordController,
                    decoration: InputDecoration(
                        labelText: tr("re_epassword", context),
                        suffixIcon: IconButton(
                          icon: cubit.isObscureConfirm
                              ? const Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off),
                          onPressed: cubit.changeVisibilityConfirm,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        labelStyle: const TextStyle(fontFamily: "Nunito",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Color(0xff96A0B6)),
                        border: const OutlineInputBorder()),
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
              BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
                listener: (context, state) {
                  if (state is ResetPasswordFailedState) {
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
                  } else if (state is ResetPasswordSuccessState) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const Login_Screen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ResetPasswordLoadingState) {
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
                        if (cubit.passwordController.text ==
                            cubit.rePasswordController.text) {
                          cubit.resetPassword(email);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password not match"),
                            ),
                          );
                        }
                      },
                      child: Text(
                        tr("rpassword", context),
                        style: const TextStyle(fontFamily: "Nunito",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
