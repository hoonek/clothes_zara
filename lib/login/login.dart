import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'new_join.dart';
import '../data/user_model.dart';
import '../screen/homescreen.dart'; // UserModel 모델 클래스를 import

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  bool _isLoginEnabled = false;

  @override
  void initState() {
    super.initState();
    _idController.addListener(_updateLoginState);
    _pwController.addListener(_updateLoginState);
  }

  @override
  void dispose() {
    _idController.removeListener(_updateLoginState);
    _pwController.removeListener(_updateLoginState);
    super.dispose();
  }

  void _updateLoginState() {
    setState(() {
      _isLoginEnabled = _idController.text.isNotEmpty && _pwController.text.isNotEmpty;
    });
  }

  void _showEmptyFieldDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력 필요'),
          content: const Text('모든 항목을 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  /*
  void _login() async {
    String id = _idController.text;
    String pw = _pwController.text;

    if (id.isNotEmpty && pw.isNotEmpty) {
      // Firestore에서 입력한 ID와 일치하는 문서를 찾습니다.
      final qs = await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).get();
      // 파이어스토어에서 도큐먼트 덩어리를 가져온거지

      if (qs.docs.isNotEmpty) {
        // ID에 해당하는 문서가 존재할 경우
        UserModel userData = UserModel.fromJson(qs.docs.first.data());

        if (userData.password == pw) {
          // Password가 일치할 경우 로그인 성공
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(ID: id, PW: pw),
            ),
          );
        } else {
          // Password가 일치하지 않을 경우
          _showErrorDialog('Password does not match');
        }
      } else {
        // ID에 해당하는 문서가 존재하지 않을 경우
        _showErrorDialog('User not found');
      }
    } else {
      // ID 또는 Password가 입력되지 않았을 경우
      _showEmptyFieldDialog();
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZARA Login'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10), // 공간 추가
          Row(
            children: [
              const SizedBox(width: 25), // 여백 추가
              const Text('ID'),
              const SizedBox(width: 50), // 여백 추가
              Expanded(
                child: TextField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'Enter your ID'),
                ),
              ),
              const SizedBox(width: 16), // 여백 추가
            ],
          ),

          Row(
            children: [
              const SizedBox(width: 16), // 여백 추가
              const Text('Password'),
              const SizedBox(width: 10), // 여백 추가
              Expanded(
                child: TextField(
                  controller: _pwController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Enter your Password'),
                ),
              ),
              const SizedBox(width: 16), // 여백 추가
            ],
          ),
          SizedBox(height: 20), // 공간 추가

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){ //_login,
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(ID: '', PW: '',)),
                    );
                  },
                  child: const Text('Login'),
                  ),
              const SizedBox(width: 10), // 여백 추가
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewJoin()),
                  );
                },
                child: const Text('New Join'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
