import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roaia/core/helpers/cache_helper.dart';
import 'package:roaia/screen/delete_account_screen/delete_acc_cubit.dart';
import 'package:roaia/screen/login/login.dart';

class DeleteAccScreen extends StatelessWidget {
  const DeleteAccScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccCubit(),
      child: DeleteAccBody(),
    );
  }
}

class DeleteAccBody extends StatelessWidget {
  const DeleteAccBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DeleteAccCubit>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/images/close-circle.png')),
            50.verticalSpace,
            Text(
              'Delete account',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito'),
            ),
            18.verticalSpace,
            Text(
              'You are about to delete all of the data in your Roaia account. Are you absolutely positive ? There is no option to undo. ',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Nunito',
                  color: Color(0xff6E6B6F)),
            ),
            14.verticalSpace,
            BlocConsumer<DeleteAccCubit, DeleteAccState>(
              builder: (context, state) {
                if(state is DeleteAccLoadingState){
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  width: MediaQuery.of(context).size.width * 90,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffE20018),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      cubit.deleteAcc();
                    },
                    child: Text(
                      'Delete ${CacheHelper.get(key: 'userName')} account',
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                );
              }, listener: (BuildContext context, DeleteAccState state) {
                if(state is DeleteAccSuccessState){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Account Deleted Successfully"),
                      ),
                      );
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return Login_Screen();
                  }));
                }
                else if( state is DeleteAccFailState){
                  SnackBar(
                    content: Text(state.msg),
              );
                }
            },
            ),
            24.verticalSpace,
            Container(
              width: MediaQuery.of(context).size.width * 90,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDEDEDE)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancle',
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
