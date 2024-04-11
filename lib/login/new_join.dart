import 'package:clothes/login/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/user_model.dart';

class NewJoin extends StatefulWidget {
  @override
  _NewJoinState createState() => _NewJoinState();
}

class _NewJoinState extends State<NewJoin> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join membership'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ID 입력 필드
              const Text('ID'),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  hintText: 'Enter your ID',
                ),
              ),
              const SizedBox(height: 20),
              // 비밀번호 입력 필드
              const Text('Password'),
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 20),
              // 이름 입력 필드
              const Text('Name'),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              const SizedBox(height: 20),
              // 전화번호 입력 필드
              const Text('Phone Number'),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                ),
              ),
              const SizedBox(height: 20),
              // 회원 가입 버튼
              ElevatedButton(
                onPressed: () async {
                  // 사용자 정보 모델을 생성하여 toJson 메서드로 JSON 형식으로 변환 후 Firestore에 저장
                  UserModel userModel = UserModel(
                    id: _idController.text,
                    password: _pwController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                  );

                  // Firestore에 문서 덮어쓰기 (set 함수 사용)
                  await FirebaseFirestore.instance.collection('users').doc(userModel.id).set(userModel.toJson());

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );

                  // 저장 완료 메시지 출력
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User information saved')),
                  );

                },
                child: const Text('Join'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
