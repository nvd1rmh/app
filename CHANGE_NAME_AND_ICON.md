# نام اپ و آیکون

## نام نمایشی: فرنو یار

### اندروید

1. فایل:
   `android/app/src/main/AndroidManifest.xml`

   در `<application>`:

   ```xml
   android:label="فرنو یار"
   ```

2. اگر از `android/app/src/main/res/values/strings.xml` استفاده می‌کنی:

   ```xml
   <string name="app_name">فرنو یار</string>
   ```

3. در `pubspec.yaml` الان `name: farno_yar` است (شناسه پکیج داخلی؛ برای کاربر دیده نمی‌شود).

### آیکون (خودت طراحی کن)

اندازه پیشنهادی:

- **۱۰۲۴×۱۰۲۴** پیکسل PNG شفاف (بهترین)
- یا حداقل **۵۱۲×۵۱۲**

ایده طراحی:

- پس‌زمینه تیره (#0A0E17)
- نماد مدار / مقاومت / تراشه با نارنجی (#F97316)
- متن کوچک «فرنو» اختیاری

مراحل:

1. فایل را بگذار: `assets/icon.png`
2. اجرا کن:

```bash
flutter pub get
dart run flutter_launcher_icons
```

3. دوباره APK بساز.

`flutter_launcher_icons` در `pubspec.yaml` از قبل تنظیم شده است.
