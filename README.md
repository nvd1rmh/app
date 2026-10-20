# فرنو الکترونیک V1.0.0

دستیار آفلاین الکترونیک — تم روز/شب — راست‌چین

## ساخت سریع

```bash
flutter create . --project-name farno_yar
# نام نمایشی Android روی «فرنو الکترونیک» تنظیم شده است
flutter pub get
dart run flutter_launcher_icons
flutter build apk --release --split-per-abi --tree-shake-icons --obfuscate --split-debug-info=build/symbols
```

جزئیات حجم: **BUILD_SIZE.md**

## امکانات

- خانهٔ تازه با دسترسی سریع به جعبه‌ابزار
- جست‌وجوی ابزارهای مهندسی الکترونیک
- نسخهٔ آفلاین، بدون ورود و سرویس سمت سرور
- بررسی آنلاین وضعیت نسخه از GitHub Pages در شروع برنامه

## کنترل نسخهٔ منتشرشده

فایل `app-status.json` را در ریشهٔ مخزن GitHub Pages با آدرس `https://nvd1rmh.github.io/FCoin/app-status.json` منتشر کن. برنامه در هر بار اجرا به اینترنت و پاسخ موفق این فایل نیاز دارد؛ در نبود اتصال یا فایل معتبر، وارد صفحهٔ اصلی نمی‌شود.

- توقف همهٔ نسخه‌ها: مقدار `enabled` را `false` کن.
- اجبار نصب نسخهٔ جدیدتر: مقدار `minimumVersion` را مثلاً `1.0.1` بگذار. نسخهٔ جدید برنامه نیز باید با همین نسخه در کد و `pubspec.yaml` ساخته شود.
- تم پیش‌فرض: روز
- نتایج محاسبه راست‌چین
- رنگ مقاومت چپ‌به‌راست (استاندارد)
