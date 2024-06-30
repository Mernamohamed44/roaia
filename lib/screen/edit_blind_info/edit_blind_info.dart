import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roaia/localization/localization_methods.dart';
import 'package:roaia/screen/bottom_Navigation.dart';
import 'package:roaia/screen/edit_blind_info/edit_blind_info_cubit.dart';
import 'package:roaia/screen/edit_profile/cubit.dart';

class EditBlindInfo extends StatelessWidget {
  const EditBlindInfo(
      {super.key,
      required this.Diseases,
      required this.BlindName,
      required this.BlindAge,
      required this.BlindGender});
  final BlindName, BlindAge, BlindGender, Diseases;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditBlindInfoCubit(),
        child: EditBlindInfoBody(
          BlindAge: BlindAge,
          BlindGender: BlindGender,
          BlindName: BlindName,
          Diseases: Diseases,
        ));
  }
}

class EditBlindInfoBody extends StatefulWidget {
  const EditBlindInfoBody(
      {super.key,
      required this.Diseases,
      required this.BlindName,
      required this.BlindAge,
      required this.BlindGender});
  final BlindName, BlindAge, BlindGender;
  final List Diseases;
  @override
  State<EditBlindInfoBody> createState() => _EditBlindInfoBodyState();
}

class _EditBlindInfoBodyState extends State<EditBlindInfoBody> {
  int itemCount = 1;
  List<TextEditingController> controllers = [];
  List<TextEditingController> emptyControllers = [];
  String? man;
  @override
  void initState() {
    controllers =
        widget.Diseases.map((string) => TextEditingController(text: string))
            .toList();
    man = widget.BlindGender;
    emptyControllers.add(TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewTextField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditBlindInfoCubit>(context);
    cubit.blindNameController.text = widget.BlindName;
    cubit.blindAgeController.text = widget.BlindAge;
    // man = widget.BlindGender;

    // cubit.blindDiseasesController.text = widget.Diseases;
    // print("dess: ${widget.Diseases}");
    return Form(
      key: cubit.formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            tr("patient_info", context),
            style: const TextStyle(
                fontFamily: "Nunito",
                color: Color(0xff1363DF),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<EditBlindInfoCubit, EditBlindInfoStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    Text(
                      tr("name", context),
                      style: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xff40444C)),
                    ),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: cubit.blindNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: tr("eblind_name", context),
                          hintStyle: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffD6D3D1)),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Text(
                      tr("age", context),
                      style: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xff40444C)),
                    ),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: cubit.blindAgeController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: tr("eblind_age", context),
                          hintStyle: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffD6D3D1)),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Builder(builder: (context) {
                      return Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xff1363DF)),
                            ),
                            child: RadioListTile(
                                title: Text(
                                  tr("female", context),
                                  style: const TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: "Female",
                                groupValue: man,
                                onChanged: (val) {
                                  setState(() {
                                    man = val!;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xff1363DF)),
                            ),
                            child: RadioListTile(
                                title: Text(
                                  tr("male", context),
                                  style: const TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: "Male",
                                groupValue: man,
                                onChanged: (val) {
                                  setState(() {
                                    man = val!;
                                  });
                                }),
                          ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    Text(
                      tr("enter_diseases", context),
                      style: const TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xff40444C)),
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    controllers.isEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .75,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: emptyControllers.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                controller:
                                                    emptyControllers[index],
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xffE9F2FF),
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          flex: 4,
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: index == 0
                                                ? () {
                                                    setState(() {
                                                      emptyControllers.add(
                                                          TextEditingController());
                                                    });
                                                    ;
                                                    print(emptyControllers
                                                        .length);
                                                  }
                                                : () {
                                                    setState(() {
                                                      emptyControllers
                                                          .removeAt(index);
                                                    });
                                                  },
                                            icon: index == 0
                                                ? Icon(
                                                    Icons.add_circle_outline,
                                                    color: Color(0xff1363DF),
                                                    size: 35,
                                                  )
                                                : Icon(Icons.cancel_outlined,
                                                    color: Colors.red,
                                                    size: 35),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .05,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 8.0),
                              //   child: InkWell(
                              //     onTap: () {
                              //       _addNewTextField();
                              //     },
                              //     child: const CircleAvatar(
                              //       radius: 17,
                              //       backgroundColor: Colors.black,
                              //       child: CircleAvatar(
                              //         radius: 15,
                              //         backgroundColor: Colors.white,
                              //         child: Icon(
                              //           Icons.add,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .75,
                                child: Builder(builder: (context) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controllers.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  controller:
                                                      controllers[index],
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xffE9F2FF),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            flex: 4,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: index == 0
                                                  ? () {
                                                      _addNewTextField();
                                                    }
                                                  : () {
                                                      setState(() {
                                                        controllers
                                                            .removeAt(index);
                                                      });
                                                    },
                                              child: index == 0
                                                  ? Icon(
                                                      Icons
                                                          .add_circle_outline,
                                                      color:
                                                          Color(0xff1363DF),
                                                      size: 35,
                                                    )
                                                  : Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.red,
                                                      size: 35),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .05,
                              ),
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
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
                                  tr("take_photo", context),
                                  style: const TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xff585858)),
                                ),
                                Image.asset('assets/images/camera.png')
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    BlocConsumer<EditBlindInfoCubit, EditBlindInfoStates>(
                      listener: (context, state) {
                        if (state is EditBlindFailedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.msg),
                            ),
                          );
                        } else if (state is EditBlindNetworkErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Network Error"),
                            ),
                          );
                        } else if (state is EditBlindSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Blind Information Modified Successfully"),
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => NavigationBottom(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is EditBlindLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else
                          return Container(
                            width: 360,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xff2C67FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: controllers.isEmpty
                                  ? () {
                                      List<String> stringsList =
                                          emptyControllers
                                              .map((controller) =>
                                                  controller.text)
                                              .toList();
                                      print(stringsList);
                                      cubit.EditBlindInfo(
                                          Diseases: stringsList, gender: man!);
                                    }
                                  : () {
                                      print('ss: ${widget.Diseases}');
                                      print('ss: ${controllers[0].text}');
                                      controllers.forEach((controller) {
                                        print(controller
                                            .text); // Print each text value from the controllers
                                      });
                                      List<String> stringsList = controllers
                                          .map((controller) => controller.text)
                                          .toList();
                                      print(stringsList);
                                      cubit.EditBlindInfo(
                                          Diseases: stringsList, gender: man!);
                                    },
                              child: Text(
                                tr("save", context),
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
