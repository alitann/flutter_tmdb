// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieServiceResponse _$MovieServiceResponseFromJson(
        Map<String, dynamic> json) =>
    MovieServiceResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$MovieServiceResponseToJson(
        MovieServiceResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
