import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/add_contact/add_contact_cubit.dart';
import 'package:roaia/screen/bottom_Navigation.dart';

class  AddContactScreen extends StatelessWidget {
  const  AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AddContactCubit(),
        child: const AddContactBody());
  }
}

class AddContactBody extends StatefulWidget {
  const AddContactBody({super.key});

  @override
  State<AddContactBody> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactBody> {
  File? image;
  final imagePicker = ImagePicker();

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    var cubit=BlocProvider.of<AddContactCubit>(context);
    // cubit.addContact();
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
            tr("add_contact", context),
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
                  height: 50,
                ),
                Text(
                  tr("name", context),
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
                  controller: cubit.nameController,
                  decoration: InputDecoration(
                      labelText: tr("enter_contact_name", context),
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
                  tr("age", context),
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
                  controller: cubit.ageController,
                  decoration: InputDecoration(
                      labelText: tr("enter_contact_age", context),
                      prefixIcon: const Icon(Icons.account_circle),
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
                  tr("relation", context),
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
                  controller: cubit.relationController,
                  decoration: InputDecoration(
                      labelText: tr("enter_relation", context),
                      prefixIcon: const Icon(Icons.account_circle),
                      labelStyle: const TextStyle(fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color(0xff96A0B6)),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 40,
                ),
                // InkWell(
                //   onTap: () {
                //     TakeImage();
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           SizedBox(
                //             width: 20,
                //             child: Divider(
                //               thickness: 1.5,
                //               height: 0,
                //               color: Colors.black,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 20,
                //             child: VerticalDivider(
                //               thickness: 1.5,
                //               width: 0,
                //               color: Colors.black,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 20,
                //           ),
                //           SizedBox(
                //             height: 20,
                //             child: VerticalDivider(
                //               thickness: 1.5,
                //               width: 0,
                //               color: Colors.black,
                //             ),
                //           ),
                //           SizedBox(
                //             width: 20,
                //             child: Divider(
                //               thickness: 1.5,
                //               height: 0,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * .78,
                //         height: 48,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               tr("take_photo", context),
                //               style: const TextStyle(fontFamily: "Nunito",
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: 16,
                //                   color: Color(0xff585858)),
                //             ),
                //             Image.asset('assets/images/camera.png')
                //           ],
                //         ),
                //       ),
                //       const Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           SizedBox(
                //             width: 20,
                //             child: Divider(
                //               thickness: 1.5,
                //               height: 0,
                //               color: Colors.black,
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 1.5),
                //             child: SizedBox(
                //               height: 20,
                //               child: VerticalDivider(
                //                 thickness: 1.5,
                //                 width: 0,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             height: 20,
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 1.5),
                //             child: SizedBox(
                //               height: 20,
                //               child: VerticalDivider(
                //                 thickness: 1.5,
                //                 width: 0,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 1.5),
                //             child: SizedBox(
                //               width: 20,
                //               child: Divider(
                //                 thickness: 1.5,
                //                 height: 0,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                InkWell(
                  onTap: () {
                    cubit.chooseProfileImage();
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
                              style: const TextStyle(fontFamily: "Nunito",
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
                  height: 35,
                ),
                BlocConsumer<AddContactCubit, AddContactStates>(
                  listener: (context, state) {
                    if (state is AddContactFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                    } else if (state is AddContactNetworkErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Network Error"),
                        ),
                      );
                    }  else if (state is AddContactSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Add Contact Success'),
                        ),
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const NavigationBottom(),
                        ),
                            (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddContactLoadingState) {
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
                          cubit.addContact();
                        },
                        child: Text(
                          'ADD',
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
