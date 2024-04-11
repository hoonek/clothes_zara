class InnerModel {
  final String title; // 제목
  final double price; // 가격 (수정: double로 변경)
  final String content; // 내용
  final String imagePath; // 이미지 경로
  final List<String> colors; // 추가: 색상 목록
  int amount;

  // 생성자
  InnerModel({
    required this.title,
    required this.price,
    required this.content,
    required this.imagePath,
    required this.colors,
    required this.amount,// 생성자에 colors 속성 추가
  });

  // toJson 메서드를 사용하여 객체를 JSON 형식으로 변환
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'content': content,
      'imagePath': imagePath,
      'colors': colors,
      'amount': amount,// toJson 메서드에 colors 속성 추가
    };
  }

  factory InnerModel.fromJson(Map<String, dynamic> json) {
    return InnerModel(
      title: json['title'] ?? '', // 널 값을 문자열로 처리
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0, // 문자열을 double로 변환하거나 적절한 기본값 사용
      content: json['content'] ?? '', // 널 값을 문자열로 처리
      imagePath: json['imagePath'] ?? '', // 널 값을 문자열로 처리
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [], // colors 추가 및 널 값을 처리
      amount: json['amount'] != null ? int.parse(json['amount'].toString()) : 0,
    );
  }

}
