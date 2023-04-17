
import 'package:flutter/material.dart';
import 'package:user_app/Screen/updating_screen.dart';

import '../helping widget/appbar.dart';

class UserDetail extends StatefulWidget {
  final String number;
  UserDetail(this.number, {Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'User Detail'),
      backgroundColor: const Color(0xFF9DA2AD),
      body: Padding(
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
              children:  [
                const UserDetailTile(
                  title: 'Name',
                  subtitle: 'Jhon Doe',
                ),
                const UserDetailTile(
                  title: 'Number',
                  subtitle: 'XX-xxx-xxx-x',
                ),
                const UserDetailTile(
                  title: 'Age',
                  subtitle: '29',
                ),
                const UserDetailTile(
                  title: 'Message',
                  subtitle: 'Lorem epsum asddd oioia iunna knd',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const UpdateUserData();
                      },));
                      // Handle button press
                    },
                    child: const Text(
                      'Update User',
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

class UserDetailTile extends StatelessWidget {
  const UserDetailTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
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
        subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
