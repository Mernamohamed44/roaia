import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roaia/screen/add_contact/add_contact.dart';
import 'package:roaia/screen/all_Contacts/contacts_cubit.dart';


class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: ContactsBody(),
    );
  }
}

class ContactsBody extends StatelessWidget {
  const ContactsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ContactsCubit>(context);
    cubit.getContactData();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<ContactsCubit, GetContactsStates>(
          builder: (context, state) {
            if (state is GetContactsLoadingState) {
              return Center(child: CircularProgressIndicator(
                  color: const Color(0xff2C67FF)
              ));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .30,
                      ),
                      Container(
                        width: 113,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffE5E5E5),
                              spreadRadius: 15,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Contacts",
                            style: const TextStyle(fontFamily: "Nunito",
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff5095FF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddContactScreen(),
                              ));
                        },
                        child: Image.asset('assets/images/image6.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.contactsList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xff2323230A))),
                          child: ListTile(
                            leading: Image.network(
                                cubit.contactsList[index].imageUrl!),
                            title: Text(
                              "${cubit.contactsList[index].fullName}",
                              style: const TextStyle(fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.contactsList[index].relation!,
                                  style: const TextStyle(fontFamily: "Nunito",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '${cubit.contactsList[index].age}',
                                  style: const TextStyle(fontFamily: "Nunito",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.edit_rounded),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
