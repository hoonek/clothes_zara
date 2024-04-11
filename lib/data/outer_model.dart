class OuterModel {
  final String title; // 제목
  final double price; // 가격 (수정: double로 변경)
  final String content; // 내용
  final String imagePath; // 이미지 경로

  // 생성자
OuterModel({
    required this.title,
    required this.price,
    required this.content,
    required this.imagePath,
  });

  // toJson 메서드를 사용하여 객체를 JSON 형식으로 변환
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'content': content,
      'imagePath': imagePath, // imagepath 대신 imagePath를 사용해야 합니다.
    };
  }

  // fromJson 팩토리 메서드를 사용하여 JSON을 객체로 변환
  factory OuterModel.fromJson(Map<String, dynamic> json) {
    return OuterModel(
      title: json['title'] ?? '', // 널 값을 문자열로 처리
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0, // 문자열을 double로 변환하거나 적절한 기본값 사용
      content: json['content'] ?? '', // 널 값을 문자열로 처리
      imagePath: json['imagePath'] ?? '', // 널 값을 문자열로 처리
    );
  }
}
