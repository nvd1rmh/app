import 'package:flutter/material.dart';
import '../theme.dart';

class ToolItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const ToolItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class ToolCategory {
  final String id;
  final String title;
  final String emoji;
  final Color color;
  final List<ToolItem> tools;
  const ToolCategory({
    required this.id,
    required this.title,
    required this.emoji,
    required this.color,
    required this.tools,
  });
}

final List<ToolCategory> toolCategories = [
  ToolCategory(
    id: 'resistor',
    title: 'مقاومت‌ها',
    emoji: '🎨',
    color: AppColors.orange,
    tools: const [
      ToolItem(id: 'res_color', title: 'محاسبه رنگ مقاومت', subtitle: '۴ باند — چپ به راست', icon: Icons.palette, color: AppColors.orange),
      ToolItem(id: 'res_to_color', title: 'مقدار ← رنگ مقاومت', subtitle: 'نزدیک‌ترین E24', icon: Icons.swap_horiz, color: AppColors.orange),
      ToolItem(id: 'res_smd', title: 'کد مقاومت SMD', subtitle: '۳/۴ رقمی · EIA-96 · R', icon: Icons.memory, color: AppColors.orange),
      ToolItem(id: 'res_series_parallel', title: 'سری و موازی مقاومت', subtitle: 'چند مقاومت', icon: Icons.account_tree, color: AppColors.orange),
      ToolItem(id: 'res_led', title: 'مقاومت محدودکننده LED', subtitle: 'Vin · Vf · If', icon: Icons.lightbulb_outline, color: AppColors.orange),
      ToolItem(id: 'res_zener', title: 'مقاومت سری زنر', subtitle: 'Vin · Vz · Iz', icon: Icons.bolt, color: AppColors.orange),
      ToolItem(id: 'res_e_series', title: 'نزدیک‌ترین E24', subtitle: 'مقاومت استاندارد', icon: Icons.near_me, color: AppColors.orange),
    ],
  ),
  ToolCategory(
    id: 'capacitor',
    title: 'خازن',
    emoji: '🟠',
    color: AppColors.purple,
    tools: const [
      ToolItem(id: 'cap_code', title: 'کد خازن سرامیکی', subtitle: '۱۰۴ · ۴R۷', icon: Icons.crop_square, color: AppColors.purple),
      ToolItem(id: 'cap_series_parallel', title: 'سری و موازی خازن', subtitle: 'چند خازن', icon: Icons.account_tree, color: AppColors.purple),
      ToolItem(id: 'cap_energy', title: 'انرژی خازن', subtitle: '½CV²', icon: Icons.battery_charging_full, color: AppColors.purple),
      ToolItem(id: 'rc_tau', title: 'ثابت زمانی RC', subtitle: 'τ = RC', icon: Icons.timer_outlined, color: AppColors.purple),
    ],
  ),
  ToolCategory(
    id: 'inductor',
    title: 'سلف',
    emoji: '🌀',
    color: AppColors.cyan,
    tools: const [
      ToolItem(id: 'ind_color', title: 'رنگ سلف', subtitle: '۳ باند', icon: Icons.waves, color: AppColors.cyan),
      ToolItem(id: 'ind_series_parallel', title: 'سری و موازی سلف', subtitle: 'چند سلف', icon: Icons.account_tree, color: AppColors.cyan),
      ToolItem(id: 'ind_energy', title: 'انرژی سلف', subtitle: '½LI²', icon: Icons.flash_on, color: AppColors.cyan),
    ],
  ),
  ToolCategory(
    id: 'circuit',
    title: 'محاسبات مدار',
    emoji: '⚡',
    color: AppColors.gold,
    tools: const [
      ToolItem(id: 'ohm', title: 'قانون اهم', subtitle: 'V = IR', icon: Icons.functions, color: AppColors.gold),
      ToolItem(id: 'power', title: 'محاسبه توان', subtitle: 'P = VI', icon: Icons.power, color: AppColors.gold),
      ToolItem(id: 'vdiv', title: 'تقسیم‌کننده ولتاژ', subtitle: 'ولتاژ خروجی', icon: Icons.call_split, color: AppColors.gold),
      ToolItem(id: 'reactance', title: 'راکتانس خازنی / سلفی', subtitle: 'Xc و XL', icon: Icons.waves, color: AppColors.gold),
      ToolItem(id: 'impedance', title: 'امپدانس RL/RC سری', subtitle: 'Z و فاز', icon: Icons.hub, color: AppColors.gold),
    ],
  ),
  ToolCategory(
    id: 'freq',
    title: 'فرکانس و فیلتر',
    emoji: '📶',
    color: AppColors.green,
    tools: const [
      ToolItem(id: 'lc_res', title: 'فرکانس تشدید LC', subtitle: 'مدار تشدید', icon: Icons.graphic_eq, color: AppColors.green),
      ToolItem(id: 'crystal', title: 'کریستال / اسیلاتور', subtitle: 'فرکانس · پریود · طول موج', icon: Icons.diamond_outlined, color: AppColors.green),
      ToolItem(id: 'filter_rc', title: 'فرکانس قطع فیلتر', subtitle: 'RC / RL', icon: Icons.filter_alt_outlined, color: AppColors.green),
      ToolItem(id: 'wavelength', title: 'طول موج / آنتن', subtitle: 'λ · λ/2 · λ/4', icon: Icons.settings_input_antenna, color: AppColors.green),
    ],
  ),
  ToolCategory(
    id: 'power',
    title: 'تغذیه و باتری',
    emoji: '💡',
    color: Color(0xFFFB923C),
    tools: const [
      ToolItem(id: 'ldo', title: 'دراپ رگولاتور', subtitle: 'تلفات توان', icon: Icons.vertical_align_bottom, color: Color(0xFFFB923C)),
      ToolItem(id: 'battery', title: 'عمر باتری', subtitle: 'ظرفیت و جریان', icon: Icons.battery_full, color: Color(0xFFFB923C)),
      ToolItem(id: 'pwm', title: 'PWM → ولتاژ', subtitle: 'ولتاژ متوسط', icon: Icons.timeline, color: Color(0xFFFB923C)),
    ],
  ),
  ToolCategory(
    id: 'semi',
    title: 'تراشه و ترانزیستور',
    emoji: '🔧',
    color: AppColors.cyan,
    tools: const [
      ToolItem(id: 'timer555', title: 'تایمر ۵۵۵', subtitle: 'Astable / Monostable', icon: Icons.timer, color: AppColors.cyan),
      ToolItem(id: 'opamp', title: 'گین آپ‌آمپ', subtitle: 'اینورتینگ / نان‌اینورتینگ', icon: Icons.hearing, color: AppColors.cyan),
    ],
  ),
  ToolCategory(
    id: 'datasheet',
    title: 'دیتاشیت قطعات',
    emoji: '📄',
    color: AppColors.blue,
    tools: const [
      ToolItem(id: 'datasheet', title: 'جستجوی دیتاشیت', subtitle: 'قطعات رایج', icon: Icons.description_outlined, color: AppColors.blue),
    ],
  ),
];
