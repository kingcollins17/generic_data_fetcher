import 'package:json_annotation/json_annotation.dart';

part 'data_models.g.dart';

@JsonSerializable()
class CustomData {
  final String message, status;
  CustomData(this.message, this.status);

  ///Construct from json
  factory CustomData.fromJson(Map<String, dynamic> json) =>
      _$CustomDataFromJson(json);

  ///Convert to json
  Map<String, dynamic> toJson() => _$CustomDataToJson(this);
}
