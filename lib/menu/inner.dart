import 'dart:io';
import 'package:flutter/material.dart';
import '../data/inner_model.dart'; // InnerModel을 import합니다.
import '../screen/customer_inner.dart';
import '../screen/drawer_menu.dart';
import '../screen/inner_new_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inner extends StatefulWidget {
  const Inner({super.key});

  @override
  State<Inner> createState() => _InnerState();
}

class _InnerState extends State<Inner> {
  late List<InnerModel> innerModels;

  @override
  void initState() {
    super.initState();
    innerModels = []; // 데이터를 담을 리스트 초기화
    _fetchInnerData(); // Firestore에서 데이터 가져오기
  }

  // Firestore에서 데이터를 가져와서 innerModels에 저장하는 메서드
  Future<void> _fetchInnerData() async {
    final innerSnapshot = await FirebaseFirestore.instance.collection('inner').get();
    final List<InnerModel> fetchedInnerModels = innerSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return InnerModel.fromJson(data);
    }).toList();

    setState(() {
      innerModels = fetchedInnerModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inner'),
      ),
      drawer: DrawerMenu(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: innerModels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerInner(innerModel: innerModels[index])),
                //customer inner의 innerModel 객체를 만들고 innermodels 를 넣는다
              );
            },
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: innerModels[index].imagePath.isNotEmpty
                        ? Image.file(
                      File(innerModels[index].imagePath),
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          innerModels[index].title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${innerModels[index].price}',
                          style: const TextStyle(color: Colors.green),
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
            MaterialPageRoute(builder: (context) => const InnerNewDetailPage()),
          );

          // 새로운 데이터가 추가되면 리스트에 추가
          if (result != null) {
            setState(() {
              innerModels.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
