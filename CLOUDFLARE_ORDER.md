# اتصال سفارش به تلگرام از ایران (Cloudflare Worker)

چون `pythonanywhere` از ایران فیلتر است، اپ مستقیم POST نمی‌زند.
مسیر: **اپ → Worker کلادفلر → pythonanywhere → ربات → ادمین‌ها**

## قدم‌به‌قدم

1. برو [dash.cloudflare.com](https://dash.cloudflare.com) و وارد شو
2. از منو: **Workers & Pages** → **Create** → **Create Worker**
3. یک نام بگذار مثلاً `farno-order`
4. روی **Deploy** بزن
5. **Edit code** را باز کن، کل کد را پاک کن و محتوای فایل `cloudflare_worker_order.js` داخل این پروژه را بچسبان
6. **Save and Deploy**
7. آدرس نهایی شبیه این است:
   `https://farno-order.XXXX.workers.dev`
8. همان آدرس را در `lib/services/config.dart` روی `orderProxyUrl` بگذار

## تست سریع Worker

با هر ابزاری که POST می‌زند (یا از بیرون ایران):

```bash
curl -X POST https://farno-order.XXXX.workers.dev \
  -H "Content-Type: application/json" \
  -d '{"name":"تست","phone":"0912","note":"از اپ","items":[{"product":"دیود ساده","value":"1n4007","count":2}]}'
```

باید به تلگرام ادمین‌ها پیام برسد.

## نکته
Worker کلادفلر از خارج به pythonanywhere وصل می‌شود؛ کاربر داخل ایران فقط به workers.dev وصل می‌شود که معمولاً باز است.
