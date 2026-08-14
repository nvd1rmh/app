# تغییر اسم به «فرنو یار» + آیکون دلخواه

## ۱) اسم برنامه (روی گوشی)

بعد از اینکه دستور زیر رو زدی:

```bash
flutter create . --project-name farno_tools --org com.farno.tools
```

این فایل رو باز کن:

```
android/app/src/main/AndroidManifest.xml
```

دنبال این خط بگرد:

```xml
android:label="farno_tools"
```

و عوضش کن به:

```xml
android:label="فرنو یار"
```

ذخیره کن.

---

## ۲) آیکون برنامه (عکس خودت)

### قدم‌ها:

1. یک عکس مربعی خوب انتخاب کن (ترجیحاً **۱۰۲۴×۱۰۲۴** پیکسل، فرمت PNG)
2. اسمش رو بگذار: `icon.png`
3. بگذار داخل پوشه:
   ```
   farno_tools/assets/icon.png
   ```
   (پوشه `assets` از قبل هست)

4. تو Command Prompt این دو دستور رو بزن:

```bash
flutter pub get
```

```bash
dart run flutter_launcher_icons
```

5. بعد APK رو دوباره بساز:

```bash
flutter build apk --release
```

---

## نکات آیکون

- عکس بهتره پس‌زمینه شفاف یا ساده داشته باشه
- اندازه ایده‌آل: ۱۰۲۴×۱۰۲۴
- اگر عکس خیلی شلوغ باشه، روی گوشی کوچک دیده می‌شه
- رنگ پس‌زمینه آیکون تطبیقی (adaptive) روی اندروید: `#0B1220` (تیره مثل اپ)

---

## خلاصه دستورات نهایی (به ترتیب)

```bash
cd Desktop\farno_tools

flutter create . --project-name farno_tools --org com.farno.tools

# اسم رو تو AndroidManifest عوض کن → فرنو یار

# عکس icon.png رو تو assets بگذار

flutter pub get
dart run flutter_launcher_icons
flutter build apk --release
```

فایل APK:
```
build\app\outputs\flutter-apk\app-release.apk
```
