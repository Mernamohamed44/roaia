import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/screen/bottom_Navigation.dart';
import 'package:roaia/screen/login/login.dart';


import 'cubit.dart';
import 'states.dart';

class RefreshTokenView extends StatelessWidget {
  const RefreshTokenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RefreshTokenCubit(),
      child: const _RefreshTokenBody(),
    );
  }
}

class _RefreshTokenBody extends StatelessWidget {
  const _RefreshTokenBody();

  @override
  Widget build(BuildContext context) {
    print('object11');
    var cubit=BlocProvider.of<RefreshTokenCubit>(context);
    cubit.getToken();
    print('object222');

    return Scaffold(
      body: Center(
        child: BlocConsumer<RefreshTokenCubit, RefreshTokenStates>(
          listener: (context, state) {
            if (state is RefreshTokenFailedState) {
              CacheHelper.removeData(key: "access_token");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (c) {
                    return Login_Screen();
                  },
                ),
                (route) => false,
              );
            } else if (state is RefreshTokenSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (c) {
                    return NavigationBottom();
                  },
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is RefreshTokenLoadingState) {
              return const CircularProgressIndicator();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
