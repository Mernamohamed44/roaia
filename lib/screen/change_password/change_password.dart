import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/change_password/change_password_cubit.dart';
import 'package:roaia/screen/sign_up/cubit.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: ChangePasswordBody(),
    );
  }
}

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ChangePasswordCubit.get(context);

    return Form(
      key: cubit.formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            tr("change_password", context),
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
                  height: 10,
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
                  tr("old_password", context),
                  style: const TextStyle(fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    return TextFormField(
                      validator: cubit.validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: cubit.isObscure,
                      controller: cubit.currentPasswordController,
                      decoration: InputDecoration(
                          errorMaxLines: 2,

                          labelText: tr("enter_old_password", context),
                          prefixIcon: const Icon(Icons.lock),
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
                  height: 35,
                ),
                Text(
                  tr("new_password", context),
                  style: const TextStyle(fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff40444C),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    return TextFormField(
                      validator:cubit.validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      controller: cubit.newPasswordController,
                      obscureText: cubit.isObscureConfirm,
                      decoration: InputDecoration(
                          errorMaxLines: 2,

                          suffixIcon: IconButton(
                            icon: cubit.isObscureConfirm
                                ? const Icon(Icons.visibility_outlined)
                                : Icon(Icons.visibility_off),
                            onPressed: cubit.changeVisibilityConfirm,
                          ),
                          labelText: tr("enter_new_password", context),
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
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    return TextFormField(
                      validator: cubit.validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      controller: cubit.confirmPasswordController,
                      obscureText: cubit.isObscureNewPass,
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                          suffixIcon: IconButton(
                        icon: cubit.isObscureNewPass
                            ? const Icon(Icons.visibility_outlined)
                            : Icon(Icons.visibility_off),
                        onPressed: cubit.changeVisibilityNewPass,
                      ),
                          labelText: tr("re_epassword", context),
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
                BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordFailedState) {
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
                    } else if (state is ChangePasswordSuccessState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password Changed Successfully"),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 90,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xff2C67FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () {
                          cubit.changePassword();
                        },
                        child: Text(
                          tr("change_password", context),
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
      ),
    );
  }
}
