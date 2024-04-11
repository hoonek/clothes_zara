import 'package:clothes/screen/homescreen.dart';
import 'package:flutter/material.dart';
import '../data/outer_model.dart';
import '../screen/drawer_menu.dart';
import '../screen/outer_edit_detail_page.dart';
import '../screen/outer_new_detail_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class Outer extends StatefulWidget {
  const Outer({Key? key}) : super(key: key);

  @override
  State<Outer> createState() => _OuterState();
}

class _OuterState extends State<Outer> {
  late List<OuterModel> outerModels;

  @override
  void initState() {
    super.initState();
    outerModels = []; // 데이터를 담을 리스트 초기화
    _fetchOuterData(); // Firestore에서 데이터 가져오기
  }

  // Firestore에서 데이터를 가져와서 outerModels에 저장하는 메서드
  //이해 잘 안감
  Future<void> _fetchOuterData() async {
    final outerSnapshot = await FirebaseFirestore.instance.collection('outer').get();
    final List<OuterModel> fetchedOuterModels = outerSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return OuterModel.fromJson(data);
    }).toList();

    setState(() {
      outerModels = fetchedOuterModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outer'),
      ),
      drawer: DrawerMenu(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: outerModels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final updatedOuterModel = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditDetailPage(outerModel: outerModels[index])),
              );

              if (updatedOuterModel != null) {
                setState(() {
                  outerModels[index] = updatedOuterModel;
                });
              }
            },
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: outerModels[index].imagePath.isNotEmpty
                        ? Image.file(
                            File(outerModels[index].imagePath),
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          outerModels[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${outerModels[index].price}',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OuterNewDetailPage()),
          );

          // 새로운 데이터가 추가되면 리스트에 추가
          if (result != null) {
            setState(() {
              outerModels.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
