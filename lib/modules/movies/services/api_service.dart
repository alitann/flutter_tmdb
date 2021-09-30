import 'package:dio/dio.dart';
import '../../../core/constants/application_constants.dart';
import '../models/movie.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApplicationConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        contentType: 'application/json');

    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET(ApplicationConstants.discoverPath +
      ApplicationConstants.apiKeyParameter +
      ApplicationConstants.apiKey)
  Future<List<Movie>> getMovies(@Query("page") int pageNumber);
}
