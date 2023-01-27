import 'package:equatable/equatable.dart';

class ModeModel extends Equatable {
  final String name;
  final int id;

  const ModeModel({
    required this.name,
    required this.id,
  });

  factory ModeModel.fromJson(Map<String, dynamic> json) => ModeModel(
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };

  @override
  List<Object?> get props => [id];
}
