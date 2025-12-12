import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name getter returns human readable name', () {
      final s1 = Sandwich(type: SandwichType.veggieDelight, isFootlong: true, breadType: BreadType.white);
      final s2 = Sandwich(type: SandwichType.chickenTeriyaki, isFootlong: false, breadType: BreadType.wheat);

      expect(s1.name, 'Veggie Delight');
      expect(s2.name, 'Chicken Teriyaki');
    });

    test('image path uses enum name and size', () {
      final foot = Sandwich(type: SandwichType.tunaMelt, isFootlong: true, breadType: BreadType.wholemeal);
      final six = Sandwich(type: SandwichType.tunaMelt, isFootlong: false, breadType: BreadType.wholemeal);

      expect(foot.image, 'assets/images/${SandwichType.tunaMelt.name}_footlong.png');
      expect(six.image, 'assets/images/${SandwichType.tunaMelt.name}_six_inch.png');
    });
  });
}
