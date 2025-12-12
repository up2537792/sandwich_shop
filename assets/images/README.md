This folder contains sandwich images used by the Sandwich Shop app.

## Required Image Files

The app expects exactly these 8 PNG images:

1. `veggieDelight_footlong.png` — Veggie Delight (footlong size)
2. `veggieDelight_six_inch.png` — Veggie Delight (6-inch size)
3. `chickenTeriyaki_footlong.png` — Chicken Teriyaki (footlong size)
4. `chickenTeriyaki_six_inch.png` — Chicken Teriyaki (6-inch size)
5. `tunaMelt_footlong.png` — Tuna Melt (footlong size)
6. `tunaMelt_six_inch.png` — Tuna Melt (6-inch size)
7. `meatballMarinara_footlong.png` — Meatball Marinara (footlong size)
8. `meatballMarinara_six_inch.png` — Meatball Marinara (6-inch size)

## How to Replace with Your Own Images

1. **Prepare your images:**
   - Each image should be in PNG format
   - Recommended size: 800×600 pixels (or smaller for faster loading)
   - Ensure filenames match exactly (case-sensitive on Linux/Mac)

2. **Replace the placeholder images:**
   - Delete the current placeholder PNG files in this folder
   - Copy your own PNG images into this folder
   - Make sure each file has one of the 8 exact filenames listed above

3. **Run the app:**
   ```powershell
   flutter pub get
   flutter run
   ```

## Current Status

The folder currently contains auto-generated placeholder images. Replace them with your own images by following the steps above.

**Note:** If the `generate_images.dart` script is still in `tools/`, you can delete it once you've added your own images:
```
tools/generate_images.dart  (can be deleted)
```
