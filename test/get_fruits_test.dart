import 'package:dartz/dartz.dart';
import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/services/networking/web_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockApiClient extends Mock implements WebApiClient {
  // WebApiClient _real;

  MockApiClient(http.Client httpClient) {
    // _real = WebApiClient(httpClient: httpClient);
    // when(loadAllFruits()).thenAnswer((_) => _real.loadAllFruits());
  }
}

// class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  http.Client client = MockClient();

  final mockQuoteApiClient = MockApiClient(client);

  // final webApiClient = WebApiClient(httpClient: client);

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
      final responseString =
          '{data: [{id: 6, name: Mango, vitamins: [{name: Vitamin B, value: 33}, {name: Vitamin K, value: 44}, {name: Vitamin B1, value: 77}], sales: [{month: January, value: 11}, {month: February, value: 22}, {month: March, value: 55}, {month: April, value: 77}]}]}';

      when(client.get(Uri.parse('http://e8111a28cbfb.ngrok.io/api/fruits')))
          .thenAnswer(
              (_) async => Future.value(http.Response(responseString, 200)));

      expect(() async => await mockQuoteApiClient.loadAllFruits(),
          isA<Either<String, List<Fruit>>>());
    });

    test('return Exception if http call error', () async {
      when(client.get(Uri.parse('http://e8111a28cbfb.ngrok.io/api/fruits')))
          .thenAnswer((_) async => Future.value(http.Response('Error', 202)));

      expect(() async => await mockQuoteApiClient.loadAllFruits(),
          throwsA(isException));
    });
  });
}
