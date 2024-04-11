import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../data/inner_model.dart';
import '../menu/inner.dart';

class InnerNewDetailPage extends StatefulWidget {
  const InnerNewDetailPage({Key? key}) : super(key: key);

  @override
  State<InnerNewDetailPage> createState() => _InnerNewDetailPageState();
}

class _InnerNewDetailPageState extends State<InnerNewDetailPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  String _imagePath = '';
  List<String> _colors = [];
  int _amount = 0;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              if (_imagePath.isNotEmpty)
                Image.file(
                  File(_imagePath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),

              const Text('Title'),
              TextField(
                controller: _titleController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const Text('Price'),
              TextField(
                controller: _priceController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
              ),

              const Text('Content'),
              TextField(
                controller: _contentController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const Text('Colors'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _colors = value.split('\n').map((color) => color.trim()).toList();
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const Text('Amount'), // 새로운 레이블 추가
              TextField(
                controller: _amountController, // amount 입력 필드에 _amountController를 사용합니다.
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
              ),

              Wrap(
                children: _buildColorChips(),
              ),

              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  double? price = double.tryParse(_priceController.text);

                  if (price != null) {
                    _amount = int.tryParse(_amountController.text) ?? 0; // amount 값을 설정합니다.
                    InnerModel innerModel = InnerModel(
                      title: _titleController.text,
                      price: price,
                      content: _contentController.text,
                      imagePath: _imagePath,
                      colors: _colors,
                      amount: _amount,
                    );
                    await FirebaseFirestore.instance.collection('inner').doc(innerModel.title).set(innerModel.toJson());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Inner()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid price')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildColorChips() {
    return _colors.map((color) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ChoiceChip(
          label: Text(color),
          selected: _colors.contains(color),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                _colors.add(color);
              } else {
                _colors.remove(color);
              }
            });
          },
        ),
      );
    }).toList();
  }
}
