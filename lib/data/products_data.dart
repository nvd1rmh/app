/// مدل قطعه — عکس ترجیحاً از سرور (imageUrl)
class ProductInfo {
  final String id;
  final String name;
  final String prompt;
  final String exampleCount;
  /// نام فایل محلی قدیمی (اختیاری)
  final String imageFile;
  /// لینک عکس روی Supabase Storage یا هر CDN
  final String? imageUrl;
  final String? price;

  const ProductInfo({
    required this.id,
    required this.name,
    required this.prompt,
    required this.exampleCount,
    this.imageFile = '',
    this.imageUrl,
    this.price,
  });

  bool get hasNetworkImage =>
      imageUrl != null && imageUrl!.startsWith('http');

  String get assetPath =>
      imageFile.isEmpty ? '' : 'assets/parts/$imageFile';
}

/// لیست پشتیبان اگر سرور خالی/قطع باشد
const List<ProductInfo> allProducts = [
  ProductInfo(
    id: 'res_dip',
    name: 'مقاومت DIP',
    prompt: '🔸مقدار مقاومت را وارد کنید.\n⬅️ مثال: 220 اهم',
    exampleCount: '100 عدد',
    imageFile: 'res_dip.jpg',
  ),
  ProductInfo(
    id: 'res_smd',
    name: 'مقاومت SMD',
    prompt: '🔸مقدار مقاومت را وارد کنید.\n⬅️ مثال: 220 اهم',
    exampleCount: '100 عدد',
    imageFile: 'res_smd.jpg',
  ),
  ProductInfo(
    id: 'potentiometer',
    name: 'پتانسیومتر',
    prompt: '🔸مقدار پتانسیومتر را وارد کنید.\n⬅️ مثال: 5 کیلواهم',
    exampleCount: '50 عدد',
    imageFile: 'potentiometer.jpg',
  ),
  ProductInfo(
    id: 'thermistor',
    name: 'ترمیستور',
    prompt: '🔸مقدار ترمیستور را وارد کنید.\n⬅️ مثال: 10 کیلواهم',
    exampleCount: '50 عدد',
    imageFile: 'thermistor.jpg',
  ),
  ProductInfo(
    id: 'cap_elec',
    name: 'خازن الکترولیتی',
    prompt: '🔸ظرفیت را وارد کنید.\n⬅️ مثال: 47 میکروفاراد 25 ولت',
    exampleCount: '50 عدد',
    imageFile: 'cap_elec.jpg',
  ),
  ProductInfo(
    id: 'cap_smd',
    name: 'خازن SMD',
    prompt: '🔸ظرفیت را وارد کنید.\n⬅️ مثال: 100 نانوفاراد',
    exampleCount: '100 عدد',
    imageFile: 'cap_smd.jpg',
  ),
  ProductInfo(
    id: 'cap_ceramic',
    name: 'خازن سرامیکی و عدسی',
    prompt: '🔸ظرفیت را وارد کنید.\n⬅️ مثال: 15 پیکوفاراد',
    exampleCount: '100 عدد',
    imageFile: 'cap_ceramic.jpg',
  ),
  ProductInfo(
    id: 'cap_polyester',
    name: 'خازن پلی استر',
    prompt: '🔸ظرفیت را وارد کنید.\n⬅️ مثال: 100 نانوفاراد 250 ولت',
    exampleCount: '20 عدد',
    imageFile: 'cap_polyester.jpg',
  ),
  ProductInfo(
    id: 'cap_variable',
    name: 'خازن متغیر',
    prompt: '🔸نوع خازن متغیر را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'cap_variable.jpg',
  ),
  ProductInfo(
    id: 'ind_barrel',
    name: 'سلف بشکه ای',
    prompt: '🔸مقدار سلف را وارد کنید.\n⬅️ مثال: 220 میکروهانری',
    exampleCount: '20 عدد',
    imageFile: 'ind_barrel.jpg',
  ),
  ProductInfo(
    id: 'ind_resistive',
    name: 'سلف مقاومتی',
    prompt: '🔸مقدار سلف را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'ind_resistive.jpg',
  ),
  ProductInfo(
    id: 'ind_smd',
    name: 'سلف SMD',
    prompt: '🔸مقدار سلف SMD را وارد کنید.',
    exampleCount: '50 عدد',
    imageFile: 'ind_smd.jpg',
  ),
  ProductInfo(
    id: 'ind_variable',
    name: 'سلف متغیر',
    prompt: '🔸نوع سلف متغیر را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'ind_variable.jpg',
  ),
  ProductInfo(
    id: 'diode_simple',
    name: 'دیود ساده',
    prompt: '🔸نوع دیود را وارد کنید.\n⬅️ مثال: 1n4007',
    exampleCount: '50 عدد',
    imageFile: 'diode_simple.jpg',
  ),
  ProductInfo(
    id: 'diode_bridge',
    name: 'پل دیود',
    prompt: '🔸نوع پل دیود را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'diode_bridge.jpg',
  ),
  ProductInfo(
    id: 'diode_schottky',
    name: 'دیود شاتکی',
    prompt: '🔸نوع دیود شاتکی را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'diode_schottky.jpg',
  ),
  ProductInfo(
    id: 'diode_zener',
    name: 'دیود زنر',
    prompt: '🔸نوع دیود زنر را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'diode_zener.jpg',
  ),
  ProductInfo(
    id: 'ic_chip',
    name: 'آی سی-تراشه',
    prompt: '🔸نوع تراشه را وارد کنید.\n⬅️ مثال: NE555',
    exampleCount: '10 عدد',
    imageFile: 'ic_chip.jpg',
  ),
  ProductInfo(
    id: 'microcontroller',
    name: 'میکروکنترلر',
    prompt: '🔸نوع میکروکنترلر را وارد کنید.',
    exampleCount: '2 عدد',
    imageFile: 'microcontroller.jpg',
  ),
  ProductInfo(
    id: 'regulator',
    name: 'رگولاتور',
    prompt: '🔸نوع رگولاتور را وارد کنید.\n⬅️ مثال: 7812',
    exampleCount: '10 عدد',
    imageFile: 'regulator.jpg',
  ),
  ProductInfo(
    id: 'transistor',
    name: 'ترانزیستور',
    prompt: '🔸نوع ترانزیستور را وارد کنید.\n⬅️ مثال: BC547',
    exampleCount: '20 عدد',
    imageFile: 'transistor.jpg',
  ),
  ProductInfo(
    id: 'triac',
    name: 'ترایاک',
    prompt: '🔸نوع ترایاک را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'triac.jpg',
  ),
  ProductInfo(
    id: 'led',
    name: 'LED',
    prompt: '🔸نوع LED را وارد کنید.\n⬅️ مثال: قرمز 5mm',
    exampleCount: '50 عدد',
    imageFile: 'led.jpg',
  ),
  ProductInfo(
    id: 'seven_segment',
    name: 'سون سگمنت',
    prompt: '🔸نوع سون سگمنت را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'seven_segment.jpg',
  ),
  ProductInfo(
    id: 'lcd',
    name: 'LCD',
    prompt: '🔸نوع LCD را وارد کنید.\n⬅️ مثال: 16x2 کاراکتری',
    exampleCount: '5 عدد',
    imageFile: 'lcd.jpg',
  ),
  ProductInfo(
    id: 'crystal',
    name: 'کریستال و اسیلاتور',
    prompt: '🔸نوع کریستال را وارد کنید.\n⬅️ مثال: 16MHz',
    exampleCount: '10 عدد',
    imageFile: 'crystal.jpg',
  ),
  ProductInfo(
    id: 'varistor',
    name: 'وریستور',
    prompt: '🔸نوع وریستور را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'varistor.jpg',
  ),
  ProductInfo(
    id: 'fuse',
    name: 'فیوز',
    prompt: '🔸نوع فیوز را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'fuse.jpg',
  ),
  ProductInfo(
    id: 'relay',
    name: 'رله',
    prompt: '🔸نوع رله را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'relay.jpg',
  ),
  ProductInfo(
    id: 'pin_header',
    name: 'پین هدر',
    prompt: '🔸نوع پین هدر را وارد کنید.',
    exampleCount: '20 عدد',
    imageFile: 'pin_header.jpg',
  ),
  ProductInfo(
    id: 'socket',
    name: 'سوکت',
    prompt: '🔸نوع سوکت را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'socket.jpg',
  ),
  ProductInfo(
    id: 'wire_ferrule',
    name: 'سرسیم و وایرشو',
    prompt: '🔸نوع سرسیم را وارد کنید.',
    exampleCount: '100 عدد',
    imageFile: 'wire_ferrule.jpg',
  ),
  ProductInfo(
    id: 'tact_switch',
    name: 'تک سوییچ',
    prompt: '🔸نوع تک سوییچ را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'tact_switch.jpg',
  ),
  ProductInfo(
    id: 'dip_switch',
    name: 'دیپ سوییچ',
    prompt: '🔸نوع دیپ سوییچ را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'dip_switch.jpg',
  ),
  ProductInfo(
    id: 'micro_switch',
    name: 'میکرو سوییچ',
    prompt: '🔸نوع میکرو سوییچ را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'micro_switch.jpg',
  ),
  ProductInfo(
    id: 'rocker_switch',
    name: 'کلید راکر',
    prompt: '🔸نوع کلید راکر را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'rocker_switch.jpg',
  ),
  ProductInfo(
    id: 'terminal',
    name: 'ترمینال',
    prompt: '🔸نوع ترمینال را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'terminal.jpg',
  ),
  ProductInfo(
    id: 'buzzer',
    name: 'بازر و بلندگو',
    prompt: '🔸نوع بازر/بلندگو را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'buzzer.jpg',
  ),
  ProductInfo(
    id: 'pcb',
    name: 'فیبر مدارچاپی',
    prompt: '🔸نوع فیبر را وارد کنید.',
    exampleCount: '5 عدد',
    imageFile: 'pcb.jpg',
  ),
  ProductInfo(
    id: 'breadboard',
    name: 'برد بورد',
    prompt: '🔸نوع برد بورد را وارد کنید.',
    exampleCount: '5 عدد',
    imageFile: 'breadboard.jpg',
  ),
  ProductInfo(
    id: 'jumper',
    name: 'سیم جامپر',
    prompt: '🔸نوع سیم جامپر را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'jumper.jpg',
  ),
  ProductInfo(
    id: 'heatsink',
    name: 'هیت سینک',
    prompt: '🔸نوع هیت سینک را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'heatsink.jpg',
  ),
  ProductInfo(
    id: 'solder_wire',
    name: 'سیم لحیم',
    prompt: '🔸نوع سیم لحیم را وارد کنید.',
    exampleCount: '5 عدد',
    imageFile: 'solder_wire.jpg',
  ),
  ProductInfo(
    id: 'solder_flux',
    name: 'روغن لحیم',
    prompt: '🔸نوع روغن لحیم را وارد کنید.',
    exampleCount: '10 عدد',
    imageFile: 'solder_flux.jpg',
  ),
  ProductInfo(
    id: 'lcd',
    name: 'LCD',
    prompt: '🔸نوع LCD را وارد کنید.\n⬅️ مثال: 16x2',
    exampleCount: '5 عدد',
    imageFile: 'lcd.jpg',
  ),
];

Map<String, ProductInfo> get productsCatalog =>
    {for (final p in allProducts) p.name: p};
