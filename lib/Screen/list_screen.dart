import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screen/updating_screen.dart';

import '../helping widget/appbar.dart';
import 'UserDetail_Screen.dart';
import 'adding_screen.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<Map<dynamic, dynamic>> _usersData = [];

  void UpdatedUsersList(dynamic data) {
    if (data != null) {
      setState(() {
        _usersData.clear();
        data.forEach((key, value) {
          _usersData.add(value);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
    usersRef.onValue.listen((event) {
      final data = event.snapshot.value;
      UpdatedUsersList(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "User List"),
      backgroundColor: const Color(0xFF9da2ad),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _usersData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return  UserDetail(_usersData[index]['number']);
                          },
                        ));
                      },
                      child: ListTile(
                        tileColor: const Color(0xFF5DC1F2),
                        title: Text("${_usersData[index]["name"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        trailing: SizedBox(
                          width: 80, // set a specific width for the container
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const UpdateUserData();
                                    },
                                  ));
                                },
                                child: const Icon(Icons.edit),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () {

                                    _deleteUser(_usersData[index]["number"]);
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return const UserDetail();
                                    //   },
                                    // ));
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Do something when the button is pressed
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddingUsers();
            },
          ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
  void _deleteUser(String key) {
    DatabaseReference usersRef =
    FirebaseDatabase.instance.ref("users/$key");
    usersRef.remove().then((_) =>
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User added successfully!'),
            backgroundColor: Colors.red,
    ))
    );

  }

}
