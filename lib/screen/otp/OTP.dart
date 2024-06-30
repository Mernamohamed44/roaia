import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/forget_password/cubit.dart';
import 'package:roaia/screen/login/login.dart';
import 'package:roaia/screen/otp/components/pin_code_field.dart';
import 'package:roaia/screen/otp/states.dart';
import 'package:roaia/screen/reset_password/Reset_Password.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'cubit.dart';

class OTP_Screen extends StatelessWidget {
  const OTP_Screen({
    super.key,
    required this.email,
    this.navigateFromForget = false,
  });

  final String email;
  final bool navigateFromForget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpCubit(),
        ),
        BlocProvider(
          create: (context) => SendCodeCubit(),
        ),
      ],
      child: _OTP_Body(
        email: email,
        navigateFromForget: navigateFromForget,
      ),
    );
  }
}

class _OTP_Body extends StatefulWidget {
  _OTP_Body({required this.email, required this.navigateFromForget});

  final String email;
  final bool navigateFromForget;
  bool reSend = false;

  @override
  State<_OTP_Body> createState() => _OTP_BodyState();
}

class _OTP_BodyState extends State<_OTP_Body> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OtpCubit>(context);
    final forgetCubit = BlocProvider.of<SendCodeCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          tr("otp", context),
          style: const TextStyle(
              fontFamily: "Nunito",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff1363DF)),
        ),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    tr("authentication_code", context),
                    style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffABA9AB)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<OtpCubit, OtpStates>(
                  builder: (context, state) {
                    return PinCodeField(
                      controllerOTP: cubit.controllerOTP,
                      onChanged: (value) {
                        print("value:$value");
                        print("value_length:${value.length}");
                        value.length == 6 ? cubit.full() : cubit.unFull();
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<OtpCubit, OtpStates>(
                  listener: (context, state) {
                    if (state is OtpFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                    } else if (state is NetworkErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Network Error"),
                        ),
                      );
                    } else if (state is OtpSuccessState) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => widget.navigateFromForget
                              ? Reset_Password_Screen(
                                  email: widget.email,
                                )
                              : const Login_Screen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is OtpLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff2C67FF),
                        ),
                      );
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width * 90,
                      height: 44,
                      decoration: BoxDecoration(
                        color: cubit.isFull
                            ? const Color(0xff2C67FF)
                            : const Color(0xffE6F2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: cubit.isFull
                            ? () {
                                cubit.otp(
                                    email: widget.email,
                                    fullOtp: cubit.controllerOTP.text);
                              }
                            : () {
                              },
                        child: Text(
                          tr("verify", context),
                          style:  TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: cubit.isFull?Colors.white:Color(0xff5095FF)),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        !widget.reSend
                            ? Text(
                                tr("code_send", context),
                                style: const TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Color(0xff040508)),
                              )
                            : const SizedBox(),
                        widget.reSend
                            ? InkWell(
                                onTap: () {
                                  forgetCubit.sendOtp(email: widget.email);
                                  setState(() {
                                    widget.reSend = false;
                                  });
                                },
                                child: const Text(
                                  "resend",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Color(0xff1363DF)),
                                ),
                              )
                            : Countdown(
                                seconds: 120, // 2 minutes = 120 seconds
                                build: (BuildContext context, double time) {
                                  final minutes = (time / 60).floor();
                                  final seconds = (time % 60).floor();
                                  return Text(
                                    '$minutes:${seconds.toString().padLeft(2, '0')}',
                                    // format as MM:SS
                                    style: const TextStyle(
                                        color: Color(0xff1363DF), fontSize: 20),
                                  );
                                },
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  setState(() {
                                    widget.reSend = !widget.reSend;
                                  });
                                  print('Timer is done!');
                                },
                              ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
