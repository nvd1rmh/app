import 'package:flutter/material.dart';
import '../theme.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('راهنما'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 36),
        children: [
          _head(context, 'فرنو یار چیست؟'),
          _body(
            context,
            'فرنو یار یک اپلیکیشن کاملاً آفلاین برای محاسبات الکترونیک است. '
            'مقاومت، خازن، سلف، قانون اهم، تایمر ۵۵۵، دیتاشیت و ده‌ها ابزار دیگر را بدون اینترنت حساب می‌کند.\n\n'
            'فقط باز کردن لینک دیتاشیت، کانال و ربات تلگرام به اینترنت نیاز دارد.',
          ),
          _head(context, 'منوی اصلی'),
          _body(
            context,
            '• ابزارها — همه ماشین‌حساب‌های الکترونیک\n'
            '• خرید قطعه الکترونیکی — ورود مستقیم به ربات سفارش @FarnoElectronicBot\n'
            '• کانال ما — @FarnoElectronic\n'
            '• برنامه‌نویس — @nvdrl\n'
            '• راهنما — همین صفحه',
          ),
          _head(context, 'تم روز و شب'),
          _body(
            context,
            'دکمه خورشید/ماه در بالای صفحه اصلی، تم روشن و تیره را عوض می‌کند. '
            'انتخاب شما ذخیره می‌شود و دفعه بعد همان تم باز می‌شود.\n'
            'پیش‌فرض اپ: تم روز (روشن).',
          ),
          _head(context, 'رنگ مقاومت (مهم)'),
          _body(
            context,
            'باندهای رنگی از چپ به راست خوانده می‌شوند (استاندارد جهانی):\n\n'
            'رقم ۱  →  رقم ۲  →  ضریب  →  تلرانس\n\n'
            'تصویر مقاومت داخل اپ همیشه چپ‌به‌راست است تا با مقاومت واقعی یکی باشد. '
            'اگر قبلاً برعکس می‌دیدید، در این نسخه اصلاح شده است.',
          ),
          _head(context, 'واحدها و ورودی'),
          _body(
            context,
            'می‌توانی عدد را با پسوند بنویسی:\n\n'
            'مقاومت:  4.7k  ·  10M  ·  220\n'
            'خازن:  100nF  ·  10uF  ·  کد 104\n'
            'سلف:  10mH  ·  100uH\n'
            'فرکانس:  1MHz  ·  440Hz\n\n'
            'ارقام فارسی هم پذیرفته می‌شوند.',
          ),
          _head(context, 'SMD و کد خازن'),
          _body(
            context,
            'کد SMD مقاومت:\n'
            '• سه رقمی: 103 = 10 × 10³ = 10kΩ\n'
            '• چهار رقمی: 1002 = 100 × 10² = 10kΩ\n'
            '• فرم R: 4R7 = 4.7Ω\n'
            '• EIA-96: 01A = 100 × 1 = 100Ω\n\n'
            'کد خازن سرامیکی: 104 = 100nF  ·  473 = 47nF',
          ),
          _head(context, 'تایمر ۵۵۵'),
          _body(
            context,
            'Astable (نوسان‌ساز): با R1، R2 و C فرکانس و Duty Cycle حساب می‌شود.\n\n'
            'Monostable (تک‌پالس): با R و C عرض پالس محاسبه می‌شود.',
          ),
          _head(context, 'نتایج محاسبه'),
          _body(
            context,
            'همه نتایج راست‌چین و با واحد فارسی/استاندارد نمایش داده می‌شوند. '
            'اگر چیزی عجیب دیدی، واحد ورودی را دوباره چک کن.',
          ),
          _head(context, 'پشتیبانی و سفارش'),
          _body(
            context,
            'سفارش قطعه: @FarnoElectronicBot\n'
            'کانال: @FarnoElectronic\n'
            'برنامه‌نویس و پیشنهاد ابزار: @nvdrl',
          ),
        ],
      ),
    );
  }

  Widget _head(BuildContext context, String t) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(t, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.orange)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, String t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.cCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.cLine.withOpacity(0.6)),
      ),
      child: Text(
        t,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 13.5, height: 1.75, color: context.cText, fontWeight: FontWeight.w500),
      ),
    );
  }
}
