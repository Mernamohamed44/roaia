import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatelessWidget {
  const PinCodeField({Key? key, required this.controllerOTP, this.onChanged}) : super(key: key);
  final TextEditingController controllerOTP;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: PinCodeTextField(
          appContext: context,
           controller: controllerOTP ,
          enablePinAutofill: true,
          autoDismissKeyboard: true,
          enableActiveFill: true,
          errorTextDirection: TextDirection.ltr,
          //  validator: (value) => Validator.pinCode(value!),
          pastedTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          pinTheme: PinTheme(
              selectedColor: const Color(0xff1363DF),
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              inactiveColor: Colors.grey,
              activeColor: const Color(0xff1363DF),
              fieldWidth: 50,
              activeFillColor: Colors.white,
              selectedFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              disabledColor: Colors.white),
          length: 6,
          textStyle: const TextStyle(locale: Locale('en')),
          hintStyle: const TextStyle(locale: Locale('en')),
          cursorColor: const Color(0xff1363DF),
          keyboardType: TextInputType.number, onChanged: onChanged,
        ),
      ),
    );
  }
}
