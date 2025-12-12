import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final files = {
    'assets/images/veggieDelight_footlong.png': _SandwichType.veggie,
    'assets/images/veggieDelight_six_inch.png': _SandwichType.veggie,
    'assets/images/chickenTeriyaki_footlong.png': _SandwichType.chicken,
    'assets/images/chickenTeriyaki_six_inch.png': _SandwichType.chicken,
    'assets/images/tunaMelt_footlong.png': _SandwichType.tuna,
    'assets/images/tunaMelt_six_inch.png': _SandwichType.tuna,
    'assets/images/meatballMarinara_footlong.png': _SandwichType.meatball,
    'assets/images/meatballMarinara_six_inch.png': _SandwichType.meatball,
  };

  for (final entry in files.entries) {
    final path = entry.key;
    final type = entry.value;
    final image = _generateSandwich(type, path.contains('footlong'));
    final png = img.encodePng(image);
    final file = File(path);
    if (!file.parent.existsSync()) file.parent.createSync(recursive: true);
    file.writeAsBytesSync(png);
    stdout.writeln('Wrote: $path');
  }
}

enum _SandwichType { veggie, chicken, tuna, meatball }

img.Image _generateSandwich(_SandwichType type, bool isFootlong) {
  final w = 800;
  final h = 600;
  final image = img.Image(w, h);

  // Background (gradient-ish with two-tone)
  img.fill(image, img.getColor(245, 245, 240));

  // Plate shadow and plate
  img.fillCircle(image, 400, 350, 250, img.getColor(230, 230, 225));
  img.drawCircle(image, 400, 350, 250, img.getColor(180, 180, 175));

  // Sandwich position
  final sandwichLeft = 180;
  final sandwichRight = 620;
  final sandwichTop = 240;
  final sandwichBottom = 430;
  final breadHeight = 20;

  // Bottom bread (darker, with texture)
  _drawBread(image, sandwichLeft, sandwichBottom - breadHeight, sandwichRight,
      sandwichBottom, false);

  // Fillings
  var fillY = sandwichTop + breadHeight;
  switch (type) {
    case _SandwichType.veggie:
      // Lettuce
      _drawLettuce(image, sandwichLeft + 5, fillY, sandwichRight - 5, fillY + 15);
      fillY += 18;
      // Tomato slices
      _drawTomato(image, sandwichLeft + 10, fillY, sandwichRight - 10, fillY + 25);
      fillY += 28;
      // Cheese
      _drawCheese(image, sandwichLeft + 5, fillY, sandwichRight - 5, fillY + 12);
      break;
    case _SandwichType.chicken:
      // Teriyaki chicken
      _drawChicken(image, sandwichLeft + 10, fillY, sandwichRight - 10, fillY + 35);
      fillY += 38;
      // Lettuce
      _drawLettuce(image, sandwichLeft + 5, fillY, sandwichRight - 5, fillY + 15);
      fillY += 18;
      // Onions
      _drawOnions(image, sandwichLeft + 10, fillY, sandwichRight - 10, fillY + 10);
      break;
    case _SandwichType.tuna:
      // Tuna salad
      _drawTuna(image, sandwichLeft + 10, fillY, sandwichRight - 10, fillY + 30);
      fillY += 33;
      // Cheese
      _drawCheese(image, sandwichLeft + 5, fillY, sandwichRight - 5, fillY + 12);
      fillY += 15;
      // Lettuce
      _drawLettuce(image, sandwichLeft + 5, fillY, sandwichRight - 5, fillY + 12);
      break;
    case _SandwichType.meatball:
      // Sauce base
      img.fillRect(image, sandwichLeft + 10, fillY, sandwichRight - 10,
          fillY + 8, img.getColor(220, 60, 40));
      fillY += 8;
      // Meatballs
      _drawMeatballs(image, sandwichLeft + 20, fillY, sandwichRight - 20, fillY + 28);
      fillY += 31;
      // More sauce
      img.fillRect(image, sandwichLeft + 10, fillY, sandwichRight - 10,
          fillY + 8, img.getColor(220, 60, 40));
      fillY += 8;
      // Cheese
      _drawCheese(image, sandwichLeft + 5, fillY, sandwichRight - 5, fillY + 12);
      break;
  }

  // Top bread
  _drawBread(image, sandwichLeft, sandwichTop, sandwichRight,
      sandwichTop + breadHeight, true);

  // Label at bottom
  final label = isFootlong ? 'Footlong' : '6" Sub';
  img.drawString(image, img.arial_24, w ~/ 2 - 40, h - 30, label,
      color: img.getColor(80, 80, 80));

  return image;
}

void _drawBread(img.Image image, int left, int top, int right, int bottom,
    bool isTop) {
  final breadColor = img.getColor(210, 160, 100);
  final crustColor = img.getColor(180, 130, 70);
  img.fillRect(image, left, top, right, bottom, breadColor);
  img.drawRect(image, left, top, right, bottom, crustColor);

  // Seeds (if top)
  if (isTop) {
    for (int x = left + 20; x < right - 20; x += 40) {
      img.fillCircle(image, x, top + 7, 2, img.getColor(100, 80, 50));
    }
  }
}

void _drawLettuce(img.Image image, int left, int top, int right, int bottom) {
  img.fillRect(image, left, top, right, bottom, img.getColor(76, 175, 80));
  img.drawRect(image, left, top, right, bottom, img.getColor(56, 142, 60));
}

void _drawTomato(
    img.Image image, int left, int top, int right, int bottom) {
  final red = img.getColor(230, 80, 60);
  final darkRed = img.getColor(192, 57, 43);
  // Two tomato slices
  img.fillCircle(image, left + 40, top + 12, 12, red);
  img.drawCircle(image, left + 40, top + 12, 12, darkRed);
  img.fillCircle(image, right - 40, top + 12, 12, red);
  img.drawCircle(image, right - 40, top + 12, 12, darkRed);
}

void _drawCheese(img.Image image, int left, int top, int right, int bottom) {
  final cheeseColor = img.getColor(255, 215, 100);
  img.fillRect(image, left, top, right, bottom, cheeseColor);
  img.drawRect(image, left, top, right, bottom, img.getColor(220, 180, 50));
}

void _drawChicken(img.Image image, int left, int top, int right, int bottom) {
  final chickenColor = img.getColor(222, 160, 100);
  img.fillRect(image, left, top, right, bottom, chickenColor);
  // Grid lines for chicken texture
  for (int x = left + 30; x < right - 30; x += 60) {
    img.drawLine(image, x, top, x, bottom, img.getColor(180, 120, 60));
  }
}

void _drawOnions(img.Image image, int left, int top, int right, int bottom) {
  img.fillRect(image, left, top, right, bottom, img.getColor(220, 200, 150));
}

void _drawTuna(img.Image image, int left, int top, int right, int bottom) {
  img.fillRect(image, left, top, right, bottom, img.getColor(150, 150, 140));
  // Texture
  for (int y = top; y < bottom; y += 5) {
    img.drawLine(image, left + 5, y, right - 5, y, img.getColor(100, 100, 90));
  }
}

void _drawMeatballs(img.Image image, int left, int top, int right, int bottom) {
  final meatColor = img.getColor(150, 80, 50);
  final darkMeat = img.getColor(100, 50, 30);
  // 3 meatballs
  img.fillCircle(image, left + 40, top + 12, 10, meatColor);
  img.drawCircle(image, left + 40, top + 12, 10, darkMeat);
  img.fillCircle(image, left + 100, top + 14, 10, meatColor);
  img.drawCircle(image, left + 100, top + 14, 10, darkMeat);
  img.fillCircle(image, right - 40, top + 12, 10, meatColor);
  img.drawCircle(image, right - 40, top + 12, 10, darkMeat);
}
