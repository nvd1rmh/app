# اتصال Supabase به فرنو یار (بدون کارت)

## ۱) ساخت پروژه
1. برو https://supabase.com و Sign up با ایمیل
2. New project بساز (منطقه نزدیک‌تر مثل Frankfurt اگر بود)
3. صبر کن تا پروژه Ready شود

## ۲) گرفتن کلیدها
Settings (چرخ‌دنده) → API:
- Project URL → همان `supabaseUrl`
- `anon` `public` key → همان `supabaseAnonKey`

## ۳) تنظیم Auth (مهم)
Authentication → Providers → Email:
- Enable Email = روشن
- **Confirm email را خاموش کن** (تا بدون ایمیل واقعی ثبت‌نام شود)
  چون ما از ایمیل مصنوعی `09xxxxxxxx@farno.users` استفاده می‌کنیم

## ۴) گذاشتن در اپ
فایل: `lib/services/config.dart`

```dart
static const String supabaseUrl = 'https://xxxxx.supabase.co';
static const String supabaseAnonKey = 'eyJhbGciOi...';
```

## ۵) بیلد
همان Codemagic / GitHub — نسخه الان `1.4.0+5` است تا روی گوشی آپدیت شود.

## تست
- ثبت‌نام با شماره جدید → باید وارد شود
- همان شماره دوباره → «قبلاً ثبت‌نام کرده»
- ورود با رمز درست روی گوشی دیگر → OK
