import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../helping widget/appbar.dart';
import '../model.dart';

class UpdateUserData extends StatefulWidget {
  final String number;

  const UpdateUserData({Key? key, required this.number}) : super(key: key);

  @override
  State<UpdateUserData> createState() => _UpdateUserDataState();
}

class _UpdateUserDataState extends State<UpdateUserData> {
  Student? _student;
  List<Student> userList = [];

  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _message = TextEditingController();

  DatabaseReference dbRef =
  FirebaseDatabase.instance.ref().child("users");

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
        _name.text = _student?.userStructure?.name ?? '';
        _number.text = _student?.userStructure?.number ?? '';
        _age.text = _student?.userStructure?.age.toString() ?? '';
        _message.text = _student?.userStructure?.message ?? '';
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
      appBar: const MyAppBar(title: "Update User Details"),
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
                    labelText: 'User Name',
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
                    labelText: "User Number",
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
                    labelText: "User Age",
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
                    labelText: "User Description",
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
                      foregroundColor: Colors.black, backgroundColor: Colors.yellowAccent,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      Map<String, String> students = {
                        'name': _name.text,
                        'number': _number.text,
                        'age': _age.text,
                        'message': _message.text
                      };

                      dbRef.child(_student!.key!).update(students).then((value) => Navigator.pop(context));



                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Details updated"),
                      ));
                    },
                    child: const Text(
                      'Save Updated Data',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
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