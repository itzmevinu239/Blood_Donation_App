import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donorBlood');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Donors'),
        backgroundColor: const Color(0xFFA00B00),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Donor Name'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone Number'),
              ),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                label: Text('Select Blood Group'),
              ),
              items: bloodGroup
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (valu) {
                selectedGroup = valu;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  addDonor();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFA00B00)),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
