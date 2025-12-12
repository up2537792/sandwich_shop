import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final imageDir = Directory('assets/images');
  
  // Find uploaded images (jpg, webp, etc.)
  final uploadedFiles = imageDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.jpg') || 
                    f.path.endsWith('.webp') ||
                    f.path.endsWith('.jpeg'))
      .toList();

  if (uploadedFiles.isEmpty) {
    stdout.writeln('No uploaded images found (jpg/webp)');
    return;
  }

  // Mapping: uploaded files -> sandwich types
  // smz.jpg -> veggieDelight
  // smz1.webp -> chickenTeriyaki
  // smz2.jpg -> tunaMelt
  // smz3.jpg -> meatballMarinara
  final typeMapping = {
    'smz.jpg': 'veggieDelight',
    'smz1.webp': 'chickenTeriyaki',
    'smz2.jpg': 'tunaMelt',
    'smz3.jpg': 'meatballMarinara',
  };

  for (final file in uploadedFiles) {
    final fileName = file.path.split('\\').last;
    final sandwichType = typeMapping[fileName];
    
    if (sandwichType == null) {
      stdout.writeln('Skipping unmapped file: $fileName');
      continue;
    }

    try {
      // Read and decode the image
      final imageBytes = file.readAsBytesSync();
      img.Image? decodedImage;

      if (fileName.endsWith('.webp')) {
        decodedImage = img.decodeWebP(imageBytes);
      } else {
        decodedImage = img.decodeImage(imageBytes);
      }

      if (decodedImage == null) {
        stdout.writeln('Failed to decode: $fileName');
        continue;
      }

      // Resize to 800x600 if different
      if (decodedImage.width != 800 || decodedImage.height != 600) {
        decodedImage = img.copyResize(decodedImage, 
            width: 800, height: 600,
            interpolation: img.Interpolation.linear);
      }

      // Save as PNG for both footlong and six_inch
      final sizes = ['footlong', 'six_inch'];
      for (final size in sizes) {
        final outputPath = 'assets/images/${sandwichType}_$size.png';
        final png = img.encodePng(decodedImage);
        File(outputPath).writeAsBytesSync(png);
        stdout.writeln('Created: $outputPath');
      }

      // Delete the original uploaded file
      file.deleteSync();
      stdout.writeln('Deleted original: $fileName');
    } catch (e) {
      stdout.writeln('Error processing $fileName: $e');
    }
  }

  stdout.writeln('Image processing complete!');
}
