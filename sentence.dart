class Sentence {
  // Fields
  final int id;
  final String content;
  final String type;

  // Constructor
  Sentence({
    required this.id,
    required this.content,
    required this.type,
  });

  // I don't know what a factory is but here it is anyway
  factory Sentence.fromJson(Map<String, dynamic> json) {
    return Sentence(
      id: json['id'] as int,
      content: json['content'] as String,
      type: json['type'] as String,
    );
  }
}
