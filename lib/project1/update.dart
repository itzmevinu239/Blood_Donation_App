import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donorBlood');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void uDateDonor(docId) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup,
    };
    donor.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroup = args['group'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Donors'),
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
              value: selectedGroup,
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
                  uDateDonor(docId);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFA00B00)),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
