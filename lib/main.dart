import 'dart:convert';
import 'dart:typed_data';
import 'src/data_fetcher.dart';
import 'src/data_models.dart';

const exampleUrl = 'https://dog.ceo/api/breed/image/random';

void main() async {
  // try {
  ///To fetch a string
  final stringFetcher =
      DataFetcher<String>(converter: (source) => source.toString());

  ///Fetches and converts source to [String]
  String stringData = await stringFetcher.fetchData(exampleUrl);
  print(stringData);

  final intFetcher = DataFetcher<int>(
    converter: (source) => int.parse(source.toString()),
  );

  ///Fetches an integer. Throws an exception if the source cannot be parsed as integer
  int intData = await intFetcher.fetchData(exampleUrl);
  print(intData);

  ///For fetching a [CustomData] object
  final customDataFetcher = DataFetcher<CustomData>(
    converter: (source) => CustomData.fromJson(json.decode(source.toString())),
  );

  ///Fetches custom data and throws an exception if source cannot be parsed
  CustomData customData = await customDataFetcher.fetchData(exampleUrl);
  print(customData);

  ///For fetching a list of [CustomData] objects
  final customDataListFetcher = DataFetcher<List<CustomData>>(
      converter: (source) => (json.decode(source) as List)
          .map((e) => CustomData.fromJson(e))
          .toList());

  ///Fetches and converts source to a list of [CustomData] objects using the
  ///converter passed to its constructor above
  List<CustomData> dataList = await customDataListFetcher.fetchData(exampleUrl);
  print(dataList);

  ///For fetching bytes
  final bytesDataFetcher = DataFetcher<Uint8List>(
    converter: (source) => Uint8List.fromList(source.toString().codeUnits),
  );

  Uint8List bytes = await bytesDataFetcher.fetchData(exampleUrl);
  print(bytes);
  // } catch (e) {
  //   //catch all errors and  print them out to console
  //   print(e);
  // }
}
