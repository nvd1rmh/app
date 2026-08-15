# ساخت Edge Function در Supabase (جایگزین workers.dev)

چون workers.dev ممکن است در ایران باز نباشد، اطلاع تلگرام از دامنه خود Supabase می‌رود.

## قدم‌به‌قدم

1. پروژه farno را در supabase.com باز کن
2. منوی چپ → **Edge Functions**
3. **Create a new function**
4. اسم تابع را دقیقاً بگذار: `telegram-order`
5. کد داخل فایل `supabase_edge_telegram_order.ts` را کامل کپی کن و جایگزین کد پیش‌فرض کن
6. **Deploy**
7. مهم: تنظیمات تابع → **Verify JWT** را **خاموش (OFF)** کن
8. آدرس نهایی این می‌شود:
   https://disnuzorcjfaultoqhkz.supabase.co/functions/v1/telegram-order

اپ از قبل همین آدرس را صدا می‌زند.
