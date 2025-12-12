class PricingRepository {
  final int footlongPrice;
  final int sixInchPrice;

  PricingRepository({required this.footlongPrice, required this.sixInchPrice});

  int totalPrice({required int quantity, required bool isFootlong}) {
    final int unit = isFootlong ? footlongPrice : sixInchPrice;
    return unit * quantity;
  }
}
