import 'package:crypto_app/features/joke/domain/entities/joke_entity.dart';

class JokeModel extends JokeEntity {
  const JokeModel({
    required super.id,
    required super.type,
    required super.setup,
    required super.punchline,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) {
     return JokeModel(id: json['id'].toString(), type: json['type'], 
     setup: json['setup'],
     punchline: json['punchline'],
     
     );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'setup': setup, 'punchline': punchline};
  }
}