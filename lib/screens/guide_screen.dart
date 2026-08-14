import 'package:flutter/material.dart';
import '../theme.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 راهنما'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _section(
            context,
            'فرنو یار چیست؟',
            'فرنو یار دستیار آفلاین محاسبات الکترونیک است. تمام ابزارها بدون اینترنت کار می‌کنند '
            '(به‌جز باز کردن لینک دیتاشیت و کانال تلگرام).',
          ),
          _section(
            context,
            'منوی اصلی',
            '• ابزارها — همه ماشین‌حساب‌های مقاومت، خازن، سلف، مدار، فرکانس، تغذیه و تراشه\n'
            '• کانال تلگرامی — @FarnoElectronic\n'
            '• توسعه‌دهنده — @nvdrl\n'
            '• راهنما — همین صفحه',
          ),
          _section(
            context,
            'تم روز / شب',
            'دکمه خورشید و ماه در گوشه بالا سمت راست صفحه اصلی، تم روشن و تیره را عوض می‌کند. '
            'انتخاب شما ذخیره می‌شود.',
          ),
          _section(
            context,
            'رنگ مقاومت',
            'باندها از چپ به راست خوانده می‌شوند (استاندارد بین‌المللی):\n'
            'رقم ۱ · رقم ۲ · ضریب · تلرانس\n'
            'نمایش تصویری مقاومت همیشه چپ‌به‌راست است تا با مقاومت واقعی یکی باشد.',
          ),
          _section(
            context,
            'واحدها',
            'می‌توانی با پسوند وارد کنی:\n'
            'مقاومت: 4.7k ، 10M ، 220\n'
            'خازن: 100nF ، 10uF ، 104 (کد)\n'
            'سلف: 10mH ، 100uH\n'
            'فرکانس: 1MHz ، 440Hz',
          ),
          _section(
            context,
            'SMD و کد خازن',
            'کد SMD: ۱۰۳ ، ۴۷۲ ، ۴R۷ ، ۰۱A (EIA-96)\n'
            'کد خازن سرامیکی: ۱۰۴ = ۱۰۰nF ، ۴۷۳ = ۴۷nF',
          ),
          _section(
            context,
            'تایمر ۵۵۵',
            'حالت Astable: فرکانس و Duty Cycle از R1، R2 و C\n'
            'حالت Monostable: عرض پالس از R و C',
          ),
          _section(
            context,
            'پشتیبانی',
            'برای پیشنهاد ابزار جدید یا گزارش باگ:\n@nvdrl\n\nکانال قطعات و اخبار:\n@FarnoElectronic',
          ),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title, String body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.cLine.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.orange,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(fontSize: 14, height: 1.65, color: context.cText),
          ),
        ],
      ),
    );
  }
}
