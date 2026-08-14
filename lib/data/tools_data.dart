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
    this.subtitle = '',
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
    color: AppTheme.accent,
    tools: const [
      ToolItem(id: 'res_color', title: 'محاسبه رنگ مقاومت', subtitle: 'از رنگ به مقدار', icon: Icons.palette_outlined, color: AppTheme.accent),
      ToolItem(id: 'res_to_color', title: 'مقدار ← رنگ مقاومت', subtitle: 'از اهم به رنگ استاندارد', icon: Icons.invert_colors, color: AppTheme.accent),
      ToolItem(id: 'res_series_parallel', title: 'سری و موازی مقاومت', subtitle: 'محاسبه معادل', icon: Icons.account_tree_outlined, color: AppTheme.accent),
      ToolItem(id: 'res_smd', title: 'محاسبه مقاومت SMD', subtitle: 'کد ۳ یا ۴ رقمی و EIA-96', icon: Icons.memory, color: AppTheme.accent),
      ToolItem(id: 'res_e_series', title: 'نزدیک‌ترین E-series', subtitle: 'E24 / E12', icon: Icons.near_me, color: AppTheme.accent),
      ToolItem(id: 'res_led', title: 'مقاومت محدودکننده LED', subtitle: 'سری و موازی', icon: Icons.lightbulb_outline, color: AppTheme.accent),
      ToolItem(id: 'res_zener', title: 'مقاومت سری زنر', subtitle: 'رگولاتور زنر', icon: Icons.bolt, color: AppTheme.accent),
    ],
  ),
  ToolCategory(
    id: 'capacitor',
    title: 'خازن',
    emoji: '🔵',
    color: AppTheme.accent2,
    tools: const [
      ToolItem(id: 'cap_code', title: 'محاسبه کد خازن', subtitle: 'سرامیکی / عدسی', icon: Icons.circle_outlined, color: AppTheme.accent2),
      ToolItem(id: 'cap_series_parallel', title: 'سری و موازی خازن', subtitle: 'محاسبه معادل', icon: Icons.account_tree_outlined, color: AppTheme.accent2),
      ToolItem(id: 'cap_energy', title: 'انرژی خازن', subtitle: '½CV²', icon: Icons.battery_charging_full, color: AppTheme.accent2),
      ToolItem(id: 'cap_rc', title: 'ثابت زمانی RC', subtitle: 'τ = RC', icon: Icons.timer_outlined, color: AppTheme.accent2),
    ],
  ),
  ToolCategory(
    id: 'inductor',
    title: 'سلف',
    emoji: '🌀',
    color: AppTheme.purple,
    tools: const [
      ToolItem(id: 'ind_color', title: 'محاسبه رنگ سلف', subtitle: 'از رنگ به مقدار', icon: Icons.loop, color: AppTheme.purple),
      ToolItem(id: 'ind_series_parallel', title: 'سری و موازی سلف', subtitle: 'محاسبه معادل', icon: Icons.account_tree_outlined, color: AppTheme.purple),
      ToolItem(id: 'ind_energy', title: 'انرژی سلف', subtitle: '½LI²', icon: Icons.flash_on, color: AppTheme.purple),
    ],
  ),
  ToolCategory(
    id: 'circuit',
    title: 'محاسبات فرمولی مدار',
    emoji: '⚡',
    color: AppTheme.gold,
    tools: const [
      ToolItem(id: 'ohm', title: 'قانون اهم', subtitle: 'V = IR', icon: Icons.functions, color: AppTheme.gold),
      ToolItem(id: 'power', title: 'محاسبه توان', subtitle: 'P = VI', icon: Icons.power, color: AppTheme.gold),
      ToolItem(id: 'vdiv', title: 'تقسیم‌کننده ولتاژ', subtitle: 'ولتاژ خروجی', icon: Icons.call_split, color: AppTheme.gold),
      ToolItem(id: 'reactance', title: 'راکتانس خازنی / سلفی', subtitle: 'Xc و XL', icon: Icons.waves, color: AppTheme.gold),
      ToolItem(id: 'impedance', title: 'امپدانس مدار', subtitle: 'سری و موازی', icon: Icons.hub, color: AppTheme.gold),
    ],
  ),
  ToolCategory(
    id: 'freq',
    title: 'فرکانس و فیلتر',
    emoji: '📶',
    color: AppTheme.success,
    tools: const [
      ToolItem(id: 'lc_res', title: 'فرکانس تشدید LC', subtitle: 'مدار تشدید', icon: Icons.graphic_eq, color: AppTheme.success),
      ToolItem(id: 'crystal', title: 'کریستال / اسیلاتور', subtitle: 'فرکانس، پریود، طول موج', icon: Icons.diamond_outlined, color: AppTheme.success),
      ToolItem(id: 'filter_rc', title: 'فرکانس قطع فیلتر', subtitle: 'RC / RL', icon: Icons.filter_alt_outlined, color: AppTheme.success),
      ToolItem(id: 'wavelength', title: 'طول موج / آنتن', subtitle: 'λ ، λ/2 ، λ/4', icon: Icons.settings_input_antenna, color: AppTheme.success),
    ],
  ),
  ToolCategory(
    id: 'power',
    title: 'تغذیه و باتری',
    emoji: '💡',
    color: const Color(0xFFFB923C),
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
    color: const Color(0xFF22D3EE),
    tools: const [
      ToolItem(id: 'timer555', title: 'تایمر ۵۵۵', subtitle: 'Astable / Monostable', icon: Icons.timer, color: Color(0xFF22D3EE)),
      ToolItem(id: 'opamp', title: 'گین آپ‌آمپ', subtitle: 'اینورتینگ / نان‌اینورتینگ', icon: Icons.hearing, color: Color(0xFF22D3EE)),
    ],
  ),
  ToolCategory(
    id: 'datasheet',
    title: 'دیتاشیت قطعات',
    emoji: '📄',
    color: AppTheme.muted,
    tools: const [
      ToolItem(id: 'datasheet', title: 'جستجوی دیتاشیت', subtitle: 'قطعات رایج', icon: Icons.description_outlined, color: AppTheme.muted),
    ],
  ),
];
