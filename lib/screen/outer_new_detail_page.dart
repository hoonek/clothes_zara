import 'dart:io'; // 파일 시스템에 접근하기 위한 라이브러리
import 'package:clothes/data/outer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../menu/outer.dart'; // 이미지를 가져오기 위한 라이브러리

// 제품을 추가하는 화면 위젯
class OuterNewDetailPage extends StatefulWidget {
  const OuterNewDetailPage({Key? key}) : super(key: key);

  @override
  State<OuterNewDetailPage> createState() => _OuterNewDetailPageState();
}

class _OuterNewDetailPageState extends State<OuterNewDetailPage> {
  TextEditingController _titleController = TextEditingController(); // 제목 입력 필드 컨트롤러
  TextEditingController _priceController = TextEditingController(); // 가격 입력 필드 컨트롤러
  TextEditingController _contentController = TextEditingController(); // 내용 입력 필드 컨트롤러
  String _imagePath = ''; // 선택된 이미지의 경로

  // 갤러리에서 이미지를 선택하는 메서드
  Future<void> _pickImage() async {
    final picker = ImagePicker(); // 이미지 피커 객체 생성
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path; // 선택된 이미지의 경로 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'), // 앱바 제목
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'), // 이미지 선택 버튼
              ),
              if (_imagePath.isNotEmpty)
                Image.file(
                  File(_imagePath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ), // 선택된 이미지 미리보기

              Text('Title'), // 제목 입력 레이블
              TextField(
                controller: _titleController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ), // 제목 입력 필드

              const Text('Price'), // 가격 입력 레이블
              TextField(
                controller: _priceController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number, // 숫자 키패드 활성화
              ), // 가격 입력 필드

              const Text('Content'), // 내용 입력 레이블
              TextField(
                controller: _contentController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ), // 내용 입력 필드

              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  double? price = double.tryParse(_priceController.text); // 가격 문자열을 double로 변환

                  if (price != null) {
                    // 가격 변환 성공 시 제품 정보 객체 생성
                    OuterModel outerModel = OuterModel(
                      title: _titleController.text,
                      price: price,
                      content: _contentController.text,
                      imagePath: _imagePath,
                    );
                    await FirebaseFirestore.instance.collection('outer').doc(outerModel.title).set(outerModel.toJson());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Outer()),
                    ); // 저장 완료 메시지 출력
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item saved')),
                  ); // 저장 버튼
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
