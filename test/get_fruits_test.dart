import 'package:dartz/dartz.dart';
import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockApiClient extends Mock implements WebApiClient {
  MockApiClient(http.Client httpClient) {
    WebApiClient _real = WebApiClient(httpClient: httpClient);
    when(loadAllFruits()).thenAnswer((_) async => await _real.loadAllFruits());
  }
}

void main() {
  http.Client client = MockClient();

  final mockQuoteApiClient = MockApiClient(client);

  Future<Either<String, List<Fruit>>> mockData(bool status) async {
    if (status) {
      return Right([
        Fruit(1, 'Apple', [
          Vitamins('Vitamin C', 12)
        ], [
          Data('January', 44),
        ], [
          Data('January', 44),
        ])
      ]);
    } else {
      return Left('Unable to fetch data from the REST API');
    }
  }

  group('assertion', () {
    test('should assert if null', () {
      expect(
        () => WebApiClient(httpClient: null),
        throwsA(isAssertionError),
      );
    });
  });

  group('loadAllFruits', () {
    test('return Fruit list if http call successfully', () async {
      // given
      when(mockQuoteApiClient.loadAllFruits())
          .thenAnswer((_) async => Future.value(mockData(true)));

      expect(await mockQuoteApiClient.loadAllFruits(),
          isA<Right<String, List<Fruit>>>());
    });

    test('return Exception if http call error', () async {
      // given
      when(mockQuoteApiClient.loadAllFruits())
          .thenAnswer((_) async => Future.value(mockData(false)));
      expect(await mockQuoteApiClient.loadAllFruits(),
          isA<Left<String, List<Fruit>>>());
    });
  });
}
