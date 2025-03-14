import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class addForm extends StatefulWidget {
  const addForm({super.key});

  @override
  _addFormState createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  final _songNameController = TextEditingController();
  final _artistController = TextEditingController();
  final _genreController = TextEditingController();

  CollectionReference postCollection =
      FirebaseFirestore.instance.collection('Songs');

  void addSong() {
    postCollection.add({
      'songName': _songNameController.text,
      'artist': _artistController.text,
      'genre': _genreController.text,
    }).then((value) {
      Navigator.pop(context); 
    }).catchError((error) {
      print("Failed to add song: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มเพลงใหม่'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _songNameController,
              decoration: InputDecoration(labelText: 'ชื่อเพลง'),
            ),
            TextField(
              controller: _artistController,
              decoration: InputDecoration(labelText: 'นักร้อง'),
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'แนวเพลง'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addSong,
              child: Text('เพิ่มเพลง'),
            ),
          ],
        ),
      ),
    );
  }
}
