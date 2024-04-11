import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../data/outer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDetailPage extends StatefulWidget {
  final OuterModel outerModel;

  const EditDetailPage({super.key, required this.outerModel});

  @override
  State<EditDetailPage> createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _contentController;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.outerModel.title);
    _priceController = TextEditingController(text: widget.outerModel.price.toString());
    _contentController = TextEditingController(text: widget.outerModel.content);
    _imagePath = widget.outerModel.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              if (_imagePath.isNotEmpty)
                Image.file(
                  File(_imagePath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              Text('Title'),
              TextField(
                controller: _titleController,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Price'),
              TextField(
                controller: _priceController,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
              ),
              Text('Content'),
              TextField(
                controller: _contentController,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: _updateData, // 수정된 데이터를 Firestore에 업데이트
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  // Firestore 문서 업데이트 메서드
  Future<void> _updateData() async {
    double? price = double.tryParse(_priceController.text);
    if (price != null) {
      OuterModel updatedModel = OuterModel(
        title: _titleController.text,
        price: price,
        content: _contentController.text,
        imagePath: _imagePath,
      );
      // Firestore 문서 업데이트
      await FirebaseFirestore.instance
          .collection('outer')
          .doc(widget.outerModel.title)
          .update(updatedModel.toJson());

      // 업데이트 완료 후 이전 화면으로 이동
      Navigator.pop(context);
    }
  }
}
