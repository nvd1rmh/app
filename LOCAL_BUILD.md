# ساخت پوشه android روی سیستم خودت (پیشنهادی)

اگر MagicCode مدام روی Gradle خطا می‌دهد، این روش مطمئن‌تر است:

## ۱) روی کامپیوترت Flutter نصب باشد

```bash
flutter doctor
```

## ۲) پروژه را از زیپ باز کن

```bash
unzip farno_yar_fix2.zip
cd farno_tools
```

اگر پوشه android خراب است، پاک کن و از نو بساز:

```bash
# ویندوز (CMD)
rmdir /s /q android
flutter create . --project-name farno_yar --org com.farno

# یا لینوکس / مک
rm -rf android
flutter create . --project-name farno_yar --org com.farno
```

## ۳) نام فارسی

فایل: `android/app/src/main/AndroidManifest.xml`

در تگ application این را بگذار:

```xml
android:label="فرنو یار"
```

## ۴) بیلد کم‌حجم روی سیستم خودت

```bash
flutter pub get
flutter build apk --release --split-per-abi --tree-shake-icons
```

خروجی:
`build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`

## ۵) اگر می‌خواهی همان پروژه را به MagicCode بدهی

بعد از `flutter create` و تغییر label، کل پوشه را دوباره zip کن و آپلود کن.
