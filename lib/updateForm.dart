import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class updateForm extends StatefulWidget {
  @override
  _updateFormState createState() => _updateFormState();
}

class _updateFormState extends State<updateForm> {
  final _songNameController = TextEditingController();
  final _artistController = TextEditingController();
  final _genreController = TextEditingController();
  late final String docId;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;
    _songNameController.text = args['songName'];
    _artistController.text = args['artist'];
    _genreController.text = args['genre'];
    docId = args.id;
    super.didChangeDependencies();
  }

  CollectionReference postCollection =
      FirebaseFirestore.instance.collection('Songs');

  void updateSong() {
    postCollection.doc(docId).update({
      'songName': _songNameController.text,
      'artist': _artistController.text,
      'genre': _genreController.text,
    }).then((value) {
      Navigator.pop(context); // กลับไปยังหน้าหลัก
    }).catchError((error) {
      print("Failed to update song: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขเพลง'),
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
              onPressed: updateSong,
              child: Text('บันทึกการเปลี่ยนแปลง'),
            ),
          ],
        ),
      ),
    );
  }
}
