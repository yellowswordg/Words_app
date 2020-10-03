import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/entities/collection_entity.dart';

class Collection extends Equatable {
  final String id;
  final String title;
  final String language;
  final bool isEditingBtns;
  final bool isEditingMode;
  final bool isSelected;

  Collection(
      {this.title,
      this.language,
      String id,
      this.isEditingBtns = false,
      this.isEditingMode = false,
      this.isSelected = false})
      : this.id = id ?? Uuid().v4();
  //id for DB

  @override
  List<Object> get props => [id, title, language, isEditingBtns, isEditingMode];

  @override
  String toString() => '''UserEntity{
    id: $id,
    title: $title,
    language: $language,
    isEditingBtns: $isEditingBtns,
    isEditingMode: $isEditingMode,
    isSelected: $isSelected
  }''';

  factory Collection.fromEntity(CollectionEntity entity) {
    return Collection(
      id: entity.id,
      title: entity.title,
      language: entity.language,
      isEditingBtns: false,
      isEditingMode: false,
      isSelected: false,
    );
  }
  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      title: title,
      language: language,
    );
  }

  Collection copyWith({
    String id,
    String title,
    String language,
    bool isEditingBtns,
    bool isEditingMode,
    bool isSelected,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      isEditingBtns: isEditingBtns ?? this.isEditingBtns,
      isEditingMode: isEditingMode ?? this.isEditingMode,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}