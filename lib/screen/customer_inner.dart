import 'dart:io';

import 'package:clothes/screen/customer_inner_buy.dart';
import 'package:flutter/material.dart';

import '../data/inner_model.dart';

class CustomerInner extends StatefulWidget {
  final InnerModel innerModel;

  const CustomerInner({Key? key, required this.innerModel}) : super(key: key);

  @override
  State<CustomerInner> createState() => _CustomerInnerState();
}

class _CustomerInnerState extends State<CustomerInner> {
  String? selectedColor; // 선택된 색상을 저장하기 위한 변수
  int customeramount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.innerModel.colors.isNotEmpty) {
      // 초기에 선택된 색상을 설정합니다.
      selectedColor = widget.innerModel.colors.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                widget.innerModel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: widget.innerModel.imagePath.isNotEmpty
                    ? Image.file(
                        File(widget.innerModel.imagePath),
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 40),
                  const Text(
                    'Price:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$${widget.innerModel.price}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.innerModel.content,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 40),
                  Text(
                    'Color:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedColor, // 드롭다운 버튼의 값으로 선택된 색상을 설정합니다.
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value; // 선택된 색상을 업데이트합니다.
                      });
                    },
                    items: widget.innerModel.colors
                        .map((color) => DropdownMenuItem<String>(
                              value: color,
                              child: Text(color),
                            ))
                        .toList(),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 40),
                  const Text(
                    'Amount:', // "수량"을 나타내는 텍스트
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.remove), // "-" 아이콘
                    onPressed: () {
                      setState(() {
                        // 수량을 감소시킵니다. 최소값에 도달하면 0으로 설정됩니다.
                        if (customeramount > 0) {
                          customeramount--; // customeramount를 감소시킵니다.
                        }
                      });
                    },
                  ),
                  Text(
                    '${customeramount}', // 현재 수량을 표시하는 텍스트
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add), // "+" 아이콘
                    onPressed: () {
                      setState(() {
                        // 수량을 증가시킵니다.
                        if (customeramount < widget.innerModel.amount) {
                          customeramount++; // customeramount를 증가시킵니다.
                        }
                      });
                    },
                  ),
                  Row(
                    children: [
                      const Text(
                        'Stock:', // "수량"을 나타내는 텍스트
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.innerModel.amount}', // 현재 수량을 표시하는 텍스트
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> CustomerInnerBuy())
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black, // 텍스트 색상을 흰색으로 설정
                  padding: EdgeInsets.symmetric(horizontal: 100), // 가로 여백 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  '구매하기',
                  style: TextStyle(fontSize: 16), // 버튼 텍스트의 폰트 크기 설정
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
