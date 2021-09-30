import '../../../core/network/inetwork_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_service_response.g.dart';

@JsonSerializable()
class MovieServiceResponse extends INetworkModel {
  int? page;
  List<Movie>? results;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'total_results')
  int? totalResults;

  MovieServiceResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  factory MovieServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieServiceResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MovieServiceResponseToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    MovieServiceResponse.fromJson(json);
  }
}
