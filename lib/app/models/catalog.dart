import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog.g.dart';
part 'catalog.freezed.dart';

@freezed
abstract class CatalogModel with _$CatalogModel {
  const factory CatalogModel({
    required String aid,
    required List<VolumeModel> volumes,
  }) = _CatalogModel;

  const CatalogModel._();

  factory CatalogModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogModelFromJson(json);
}

@freezed
abstract class VolumeModel with _$VolumeModel {
  const factory VolumeModel({
    required String title,
    required String vid,
    required List<ChapterModel> chapters,
  }) = _VolumeModel;

  const VolumeModel._();

  factory VolumeModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeModelFromJson(json);
}

@freezed
abstract class ChapterModel with _$ChapterModel {
  const factory ChapterModel({required String title, required String cid}) =
      _ChapterModel;

  const ChapterModel._();

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
}
