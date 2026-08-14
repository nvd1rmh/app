# کاهش حجم APK از ۵۰ مگ به زیر ۱۵ مگ

اگر با **MagicCode** یا Android Studio می‌سازی و حجم ۵۰ مگ می‌شود،
احتمالاً **Universal APK** (همه معماری‌ها با هم) می‌سازی.

## دستور صحیح (مهم)

```bash
flutter clean
flutter pub get
flutter build apk --release --split-per-abi --tree-shake-icons --obfuscate --split-debug-info=build/symbols
```

خروجی:

```
build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk   ← معمولاً ۸–۱۲ مگ
build/app/outputs/flutter-apk/app-arm64-v8a-release.apk     ← معمولاً ۸–۱۲ مگ
```

برای گوشی‌های جدید **arm64** را نصب کن.

فقط یک معماری:

```bash
flutter build apk --release --target-platform android-arm64 --tree-shake-icons --obfuscate --split-debug-info=build/symbols
```

## تنظیم Gradle (حتماً)

فایل: `android/app/build.gradle` یا `build.gradle.kts`

### Groovy (`build.gradle`)

```gradle
android {
    defaultConfig {
        ndk {
            abiFilters 'arm64-v8a', 'armeabi-v7a'
        }
    }
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    packagingOptions {
        jniLibs {
            useLegacyPackaging = true
        }
        resources {
            excludes += [
                'META-INF/*.kotlin_module',
                'META-INF/*.version',
                'META-INF/AL2.0',
                'META-INF/LGPL2.1',
                'META-INF/LICENSE*',
                'META-INF/NOTICE*',
                'META-INF/DEPENDENCIES'
            ]
        }
    }
}
```

### Kotlin DSL (`build.gradle.kts`)

```kotlin
android {
    defaultConfig {
        ndk {
            abiFilters += listOf("arm64-v8a", "armeabi-v7a")
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
        resources {
            excludes += setOf(
                "META-INF/*.kotlin_module",
                "META-INF/*.version",
                "META-INF/AL2.0",
                "META-INF/LGPL2.1",
                "META-INF/LICENSE*",
                "META-INF/NOTICE*",
                "META-INF/DEPENDENCIES"
            )
        }
    }
}
```

## چرا ۵۰ مگ می‌شود؟

| علت | راه حل |
|-----|--------|
| یک APK برای همه CPUها | `--split-per-abi` |
| Debug build | حتماً `--release` |
| بدون minify | `minifyEnabled true` |
| فونت/آیکون کامل | `--tree-shake-icons` |
| وابستگی اضافه | فقط shared_preferences + url_launcher |

## نام نمایشی فارسی «فرنو یار»

### 1) `android/app/src/main/AndroidManifest.xml`

```xml
<application
    android:label="فرنو یار"
    ...>
```

### 2) اگر `strings.xml` داری:

```xml
<string name="app_name">فرنو یار</string>
```

و در Manifest: `android:label="@string/app_name"`

### 3) بعد از `flutter create .` این‌ها را دوباره ست کن (create ممکن است برگرداند).

## آیکون

1. فایل `assets/icon.png` همین پروژه را نگه دار یا با طراحی خودت عوض کن (۱۰۲۴×۱۰۲۴ بهتر است).
2. اجرا:

```bash
flutter pub get
dart run flutter_launcher_icons
```

اگر خطا داد، در `pubspec.yaml` مسیر `image_path: assets/icon.png` را چک کن.

## MagicCode

در تنظیمات بیلد MagicCode اگر گزینه **Split APK / ABI** هست روشن کن.
اگر فقط یک APK Universal می‌دهد، فایل `app-arm64-v8a-release.apk` را از خروجی split استفاده کن، نه فایل universal.
