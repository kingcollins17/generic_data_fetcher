// import 'dart:convert';
import 'package:http/http.dart' as http;

///A function converts a given object of type [S] to type [T] (Source to Target)
typedef CustomConverter<T, S> = T Function(S source);

///
abstract class DataFetcher<T> {
  ///The converter is used to convert the source object to the target type
  factory DataFetcher({required CustomConverter<T, dynamic> converter}) =
      _DataFetcherImpl;

  ///Fetches the data from the restful api.
  ///
  ///Throws an exception if source data cannot be parsed to target data [T]
  Future<T> fetchData(String url);
}

///Default implementation for the data fetcher. A converter must be passed to a data fetcher.
///
///The converter is used to convert from the source type [dynamic] to the required type[T]
class _DataFetcherImpl<T> implements DataFetcher<T> {
  final CustomConverter<T, dynamic> converter;
  _DataFetcherImpl({required this.converter});

  @override
  Future<T> fetchData(String url) async {
    //make the network request
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    return converter(response.body);
  }
}
