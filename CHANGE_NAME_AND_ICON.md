# نام «فرنو یار» و آیکون

## نام روی گوشی (فارسی دقیق)

بعد از `flutter create .` این کارها را انجام بده:

### AndroidManifest.xml
مسیر: `android/app/src/main/AndroidManifest.xml`

```xml
android:label="فرنو یار"
```

داخل تگ `<application ...>`.

### strings.xml (اگر وجود دارد)
`android/app/src/main/res/values/strings.xml`:

```xml
<string name="app_name">فرنو یار</string>
```

## آیکون

فایل آماده: `assets/icon.png` (طرح تراشه نارنجی روی زمینه تیره)

جایگزین حرفه‌ای:

1. تصویر مربع PNG شفاف ۱۰۲۴×۱۰۲۴ بساز
2. جایگزین `assets/icon.png`
3. اجرا:

```bash
dart run flutter_launcher_icons
```

اگر پکیج پیدا نشد:

```bash
flutter pub get
dart run flutter_launcher_icons:main
```

سپس دوباره APK بساز.
