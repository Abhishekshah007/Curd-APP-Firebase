import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user_app/model.dart';
import '../helping widget/appbar.dart';

class AddingUsers extends StatefulWidget {
  const AddingUsers({super.key});

  @override
  State<AddingUsers> createState() => _AddingUsersState();
}

class _AddingUsersState extends State<AddingUsers> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _message = TextEditingController();

  //
  DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    usersRef.keepSynced(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Add user"),
      backgroundColor: const Color(0xFF9da2ad),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                  controller: _name,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Text('User Name'),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w200, color: Colors.red),
                    filled: true,
                    fillColor: Color(0xFF5DC1F2),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                  controller: _number,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Text("User Number"),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w200, color: Colors.red),
                    filled: true,
                    fillColor: Color(0xFF5DC1F2),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                  controller: _age,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Text("User Age"),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w200, color: Colors.red),
                    filled: true,
                    fillColor: Color(0xFF5DC1F2),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                  controller: _message,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Text("User Description"),
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.red),
                    filled: true,
                    fillColor: Color(0xFF5DC1F2),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      saveUserData();
                    },
                    child: const Text(
                      'Save User',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
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

  void saveUserData() {
    String name = _name.text;
    String number = _number.text;
    int age = int.parse(_age.text);
    String message = _message.text;

    Map<String, dynamic> user = {
      "name": name,
      "number": number,
      "age": age,
      "message": message,
    };

    // Save data to Firebase Realtime Database
    usersRef.push().set(user).then((_) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _name.clear();
      _number.clear();
      _age.clear();
      _message.clear();
    });
  }
}
