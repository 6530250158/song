import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './addForm.dart';
import './updateForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int screenIndex = 0;

  final mobileScreens = [
    home(),
    search(),
    allsong(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 57, 40, 1),
        title: Center(
          child: Text(
            'Songs',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: mobileScreens[screenIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            screenIndex = 1;
          });

          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addForm()))
              .then((_) {
            setState(() {
              screenIndex = 0;
            });
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 64, 8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    screenIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: screenIndex == 0
                      ? Color.fromRGBO(18, 55, 42, 1)
                      : Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    screenIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: screenIndex == 1
                      ? Color.fromRGBO(18, 55, 42, 1)
                      : Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.widgets,
                  color: screenIndex == 2
                      ? Color.fromRGBO(18, 55, 42, 1)
                      : Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // ข้อมูลเพลง
  final List<Map<String, dynamic>> songs = [
    {
      'songName': 'Deco*27',
      'imageUrls': [
        'assets/image/moni.jpg',
        'assets/image/rabbit.jpg',
        'assets/image/sala.jpg',
      ],
    },
    {
      'songName': 'Vtuber',
      'imageUrls': [
        'assets/image/shiawase.jpg',
        'assets/image/rrr.jpg',
        'assets/image/Coun.jpg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0), 
        child: ListView.builder(
          itemCount: songs.length + 1, 
          itemBuilder: (context, index) {
            if (index == songs.length) {

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    iconColor: Colors.black.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => allsong(),
                      ),
                    );
                  },
                  child: Text(
                    'View All Songs',
                    style: TextStyle(color: const Color.fromARGB(255, 125, 63, 63)),
                  ),
                ),
              );
            }

            var song = songs[index];
            List<String> imageUrls = List<String>.from(song['imageUrls']);

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0), 
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => allsong(),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      imageUrls.isNotEmpty
                          ? CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayInterval: Duration(seconds: 3),
                              ),
                              items: imageUrls.map((imageUrl) {
                                return Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              }).toList(),
                            )
                          : Image.asset(
                              'assets/image/default.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        color: Colors.black.withOpacity(0.5),
                        child: Text(
                          song['songName'] ?? 'Unknown',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




class search extends StatelessWidget {
  const search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Search')],
        ),
      ),
    );
  }
}


class allsong extends StatefulWidget {
  const allsong({super.key});

  @override
  State<allsong> createState() => _allsongState();
}

class _allsongState extends State<allsong> {
  CollectionReference postCollection = FirebaseFirestore.instance.collection('Songs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Songs"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),  
          onPressed: () {
            Navigator.pop(context);  
          },
        ),
      ),
      body: StreamBuilder(
        stream: postCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var postIndex = snapshot.data!.docs[index];
                return Slidable(
                  startActionPane: ActionPane(motion: DrawerMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color.fromARGB(255, 44, 62, 54),
                      icon: Icons.share,
                      label: 'แชร์',
                    )
                  ]),
                  endActionPane: ActionPane(motion: StretchMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => updateForm(),
                            settings: RouteSettings(arguments: postIndex),
                          ),
                        );
                      },
                      backgroundColor: const Color.fromARGB(255, 16, 221, 236),
                      icon: Icons.edit,
                      label: 'แก้ไข',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        postCollection.doc(postIndex.id).delete();
                      },
                      backgroundColor: const Color.fromARGB(255, 255, 7, 7),
                      icon: Icons.delete,
                      label: 'ลบ',
                    ),
                  ]),
                  child: ListTile(
                    title: Text(postIndex['songName']),
                    subtitle: Text(postIndex['artist']),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
