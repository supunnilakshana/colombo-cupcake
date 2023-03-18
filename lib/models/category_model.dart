import 'dart:convert';

class CategoryModel {
  final String? id;
  final String name;
  CategoryModel({
    this.id,
    required this.name,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      name: map['name'] as String,
    );
  }
  factory CategoryModel.fromMapsub(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
