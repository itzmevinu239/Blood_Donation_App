import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}); // Changed 'super.key' to 'Key? key'

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donorBlood');

  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Blood Donation App'),
        centerTitle: true,
        backgroundColor: const Color(0xFFA00B00),
      ),
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 192, 192, 192),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.purpleAccent[100],
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 58, 44),
                          Color(0xFFA00B00),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color:  Color(0xFFA00B00),
                            borderRadius:  BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          height: 80,
                          width: 80,
                          child: Center(
                            child: Text(
                              donorSnap['group'],
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              donorSnap['name'],
                              style: const TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              donorSnap['phone'].toString(),
                              style: const TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/update',
                                    arguments: {
                                      'name': donorSnap['name'],
                                      'phone': donorSnap['phone'].toString(),
                                      'group': donorSnap['group'],
                                      'id': donorSnap.id,
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteDonor(donorSnap.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: const Color(0xFFA00B00),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
