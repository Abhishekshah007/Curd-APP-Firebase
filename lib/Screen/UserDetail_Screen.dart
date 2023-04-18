import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screen/updating_screen.dart';
import 'package:user_app/model.dart';

import '../helping widget/appbar.dart';

class UserDetail extends StatefulWidget {
  final String number;

  const UserDetail(this.number, {Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  Student? _student;
  List<Student> userList = [];

  void retrieveStudentData() {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
    usersRef.orderByChild('number').equalTo(widget.number).onChildAdded.listen((event) {
      Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
      UserStructure userStructure = UserStructure(
        data['name'],
        data['number'],
        data['age'],
        data['message'],
      );
      Student student = Student(key: event.snapshot.key!, userStructure: userStructure);
      setState(() {
        _student = student;
      });
    });
  }


  @override
  void initState() {
    super.initState();
    retrieveStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'User Detail'),
      backgroundColor: const Color(0xFF9DA2AD),
      body: _student == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF5DC1F2),
          elevation: 5,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(50),
              bottomEnd: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                UserDetailTile(
                  title: 'Name',
                  userStructure: _student!.userStructure!,
                ),
                UserDetailTile(
                  title: 'Number',
                  userStructure: _student!.userStructure!,
                ),
                UserDetailTile(
                  title: 'Age',
                  userStructure: _student!.userStructure!,
                ),
                UserDetailTile(
                  title: 'Message',
                  userStructure: _student!.userStructure!,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellowAccent,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUserData(
                            number: _student?.userStructure?.number ?? '',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Update User',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDetailTile extends StatelessWidget {
  const UserDetailTile({
    Key? key,
    required this.title,
    required this.userStructure,
  }) : super(key: key);

  final String title;
  final UserStructure userStructure;

  @override
  Widget build(BuildContext context) {
    String? subtitle;
    switch (title) {
      case 'Name':
        subtitle = userStructure.name;
        break;
      case 'Number':
        subtitle = userStructure.number;
        break;
      case 'Age':
        subtitle = userStructure.age.toString();
        break;
      case 'Message':
        subtitle = userStructure.message;
        break;
      default:
        break;
    }
    return ListTile(
      tileColor: const Color(0xFF5DC1F2),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}


