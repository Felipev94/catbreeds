import 'package:catbreeds/cats/ui/cat_detail/view_model/event/cat_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatDetailEvent Test', () {
    test('FetchCatDetail can be instantiated and holds catId', () {
      final event = FetchCatDetail('abys');

      expect(event, isA<CatDetailEvent>());
      expect(event, isA<FetchCatDetail>());
      expect(event.catId, equals('abys'));
    });

    test('RetryCatDetail can be instantiated and holds catId', () {
      final event = RetryCatDetail('beng');

      expect(event, isA<CatDetailEvent>());
      expect(event, isA<RetryCatDetail>());
      expect(event.catId, equals('beng'));
    });
  });
}
