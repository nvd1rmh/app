# فرنو یار (Farno Yar)

اپلیکیشن آفلاین ابزارهای الکترونیک — راست‌چین، فارسی، تم روشن/تیره

## تغییرات نسخه ۱.۱

- صفحه اصلی چندبخشی با هیرو «فرنو یار»
- منو: ابزارها · کانال · توسعه‌دهنده · راهنما
- تم روز/شب با دکمه خورشید/ماه (ذخیره می‌شود)
- رنگ مقاومت: باندها **چپ → راست** (استاندارد)
- همه ابزارهای ربات پیاده شده
- وابستگی سبک‌تر (بدون google_fonts / flutter_svg) برای APK کوچک‌تر

## ساخت APK کم‌حجم

```bash
cd farno_tools
flutter pub get
flutter build apk --release --split-per-abi
```

فایل‌ها:

```
build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

معمولاً هر ABI زیر ۱۵ مگ می‌آید. برای یک فایل واحد:

```bash
flutter build apk --release
```

اگر هنوز بزرگ بود:

```bash
flutter build apk --release --split-per-abi --target-platform android-arm64
```

## نام و آیکون

ببین: `CHANGE_NAME_AND_ICON.md`

## ساختار

- `lib/main.dart` — تم و اپ
- `lib/screens/home_screen.dart` — صفحه اول
- `lib/screens/tools_hub_screen.dart` — دسته‌بندی ابزارها
- `lib/screens/tools/` — هر ابزار
- `lib/utils/formatters.dart` — پارس واحد و رنگ‌ها
