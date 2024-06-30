import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/forget_password/states.dart';
import 'package:roaia/screen/otp/OTP.dart';


import 'cubit.dart';

class Forget_Password_Screen extends StatelessWidget {
  const Forget_Password_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendCodeCubit(),
      child: _Forget_Password_Body(),
    );
  }
}

class _Forget_Password_Body extends StatelessWidget {
  _Forget_Password_Body();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SendCodeCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          tr("fpassword", context),
          style: const TextStyle(fontFamily: "Nunito",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff1363DF)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Email',
              style: const TextStyle(fontFamily: "Nunito",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff40444C),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: TextFormField(
                controller: cubit.emailController,
                decoration: const InputDecoration(
                    labelText: 'Username, email or phone number',
                    prefixIcon: Icon(
                      Icons.email,
                      size: 18,
                    ),
                    labelStyle: TextStyle(fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xff96A0B6)),
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            BlocConsumer<SendCodeCubit, SendCodeStates>(
              listener: (context, state) {
                if (state is SendCodeFailedState) {
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
                } else if (state is SendCodeSuccessState) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => OTP_Screen(
                        email: cubit.emailController.text,
                        navigateFromForget: true,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is SendCodeLoadingState) {
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
                      if (cubit.emailController.text.isNotEmpty) {
                        cubit.sendOtp(email: cubit.emailController.text);
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
    );
  }
}
