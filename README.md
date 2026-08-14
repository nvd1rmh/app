# فرنو یار

دستیار آفلاین الکترونیک — تم روز/شب — راست‌چین

## ساخت سریع

```bash
flutter create . --project-name farno_yar
# نام نمایشی را طبق CHANGE_NAME_AND_ICON.md به «فرنو یار» تغییر بده
flutter pub get
dart run flutter_launcher_icons
flutter build apk --release --split-per-abi --tree-shake-icons --obfuscate --split-debug-info=build/symbols
```

جزئیات حجم: **BUILD_SIZE.md**

## امکانات

- صفحه اول چندبخشی با هیرو «فرنو یار»
- ابزارها · خرید قطعه · کانال · برنامه‌نویس · راهنما
- تم پیش‌فرض: روز
- نتایج محاسبه راست‌چین
- رنگ مقاومت چپ‌به‌راست (استاندارد)
