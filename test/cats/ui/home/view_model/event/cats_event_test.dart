import 'package:catbreeds/cats/ui/home/view_model/event/cats_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatsEvent Test', () {
    test('FetchCats can be instantiated and is a CatsEvent', () {
      final event = FetchCats();

      expect(event, isA<CatsEvent>());
      expect(event, isA<FetchCats>());
    });

    test('SearchCats can be instantiated and is a CatsEvent', () {
      final event = SearchCats();

      expect(event, isA<CatsEvent>());
      expect(event, isA<SearchCats>());
    });
  });
}
