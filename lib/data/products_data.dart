/// کاتالوگ قطعات — هم‌تراز ربات + LCD
/// عکس‌ها: assets/parts/<imageFile>
class ProductInfo {
  final String id;
  final String name;
  final String prompt;
  final String exampleCount;
  final String imageFile;
  final String? price;

  const ProductInfo({
    required this.id,
    required this.name,
    required this.prompt,
    required this.exampleCount,
    required this.imageFile,
    this.price,
  });

  String get assetPath => 'assets/parts/$imageFile';
}

/// لیست کامل قطعات (بدون منوبندی)
const List<ProductInfo> allProducts = [
  ProductInfo(
    id: 'res_dip',
    name: 'مقاومت DIP',
    prompt: '🔸مقدار مقاومت خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 220 اهم)',
    exampleCount: '100 عدد',
    imageFile: 'res_dip.jpg',
  ),
  ProductInfo(
    id: 'res_smd',
    name: 'مقاومت SMD',
    prompt: '🔸مقدار مقاومت خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 220 اهم)',
    exampleCount: '100 عدد',
    imageFile: 'res_smd.jpg',
  ),
  ProductInfo(
    id: 'potentiometer',
    name: 'پتانسیومتر',
    prompt: '🔸مقدار پتانسیومتر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 5 کیلواهم)',
    exampleCount: '50 عدد',
    imageFile: 'potentiometer.jpg',
  ),
  ProductInfo(
    id: 'thermistor',
    name: 'ترمیستور',
    prompt: '🔸مقدار ترمیستور خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 10 کیلواهم)',
    exampleCount: '50 عدد',
    imageFile: 'thermistor.jpg',
  ),
  ProductInfo(
    id: 'cap_elec',
    name: 'خازن الکترولیتی',
    prompt: '🔸ظرفیت خازن مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 47 میکروفاراد 25 ولت)',
    exampleCount: '50 عدد',
    imageFile: 'cap_elec.jpg',
  ),
  ProductInfo(
    id: 'cap_smd',
    name: 'خازن SMD',
    prompt: '🔸ظرفیت خازن مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 330 میکروفاراد 6.3 ولت)',
    exampleCount: '100 عدد',
    imageFile: 'cap_smd.jpg',
  ),
  ProductInfo(
    id: 'cap_ceramic',
    name: 'خازن سرامیکی و عدسی',
    prompt: '🔸ظرفیت خازن مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 15 پیکوفاراد)',
    exampleCount: '100 عدد',
    imageFile: 'cap_ceramic.jpg',
  ),
  ProductInfo(
    id: 'cap_polyester',
    name: 'خازن پلی استر',
    prompt: '🔸ظرفیت خازن مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 100 نانوفاراد 250 ولت)',
    exampleCount: '20 عدد',
    imageFile: 'cap_polyester.jpg',
  ),
  ProductInfo(
    id: 'cap_variable',
    name: 'خازن متغیر',
    prompt: '🔸نوع خازن مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '20 عدد',
    imageFile: 'cap_variable.jpg',
  ),
  ProductInfo(
    id: 'ind_barrel',
    name: 'سلف بشکه ای',
    prompt: '🔸مقدار سلف مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 220 میکروهانری 5 آمپر)',
    exampleCount: '20 عدد',
    imageFile: 'ind_barrel.jpg',
  ),
  ProductInfo(
    id: 'ind_resistive',
    name: 'سلف مقاومتی',
    prompt: '🔸مقدار سلف مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 100 میکروهانری 0.75 وات)',
    exampleCount: '20 عدد',
    imageFile: 'ind_resistive.jpg',
  ),
  ProductInfo(
    id: 'ind_smd',
    name: 'سلف SMD',
    prompt: '🔸مقدار سلف مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 100 میکروهانری)',
    exampleCount: '50 عدد',
    imageFile: 'ind_smd.jpg',
  ),
  ProductInfo(
    id: 'ind_variable',
    name: 'سلف متغیر',
    prompt: '🔸نوع سلف مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '20 عدد',
    imageFile: 'ind_variable.jpg',
  ),
  ProductInfo(
    id: 'diode_simple',
    name: 'دیود ساده',
    prompt: '🔸نوع دیود خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 1n4007)',
    exampleCount: '50 عدد',
    imageFile: 'diode_simple.jpg',
  ),
  ProductInfo(
    id: 'diode_bridge',
    name: 'پل دیود',
    prompt: '🔸نوع پل دیود خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 1000 ولت 4 آمپر تخت)',
    exampleCount: '20 عدد',
    imageFile: 'diode_bridge.jpg',
  ),
  ProductInfo(
    id: 'diode_schottky',
    name: 'دیود شاتکی',
    prompt: '🔸نوع دیود شاتکی خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 1n5852)',
    exampleCount: '20 عدد',
    imageFile: 'diode_schottky.jpg',
  ),
  ProductInfo(
    id: 'diode_zener',
    name: 'دیود زنر',
    prompt: '🔸نوع دیود زنر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : 9 ولت 0.5 آمپر)',
    exampleCount: '20 عدد',
    imageFile: 'diode_zener.jpg',
  ),
  ProductInfo(
    id: 'ic_chip',
    name: 'آی سی-تراشه',
    prompt: '🔸نوع تراشه خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : تراشه NE555)',
    exampleCount: '10 عدد',
    imageFile: 'ic_chip.jpg',
  ),
  ProductInfo(
    id: 'microcontroller',
    name: 'میکروکنترلر',
    prompt: '🔸نوع میکروکنترلر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : میکروکنترلر ATMEGA8)',
    exampleCount: '2 عدد',
    imageFile: 'microcontroller.jpg',
  ),
  ProductInfo(
    id: 'regulator',
    name: 'رگولاتور',
    prompt: '🔸نوع رگولاتور خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : رگولاتور 12 ولت 7812)',
    exampleCount: '10 عدد',
    imageFile: 'regulator.jpg',
  ),
  ProductInfo(
    id: 'transistor',
    name: 'ترانزیستور',
    prompt: '🔸نوع ترانزیستور خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : BC547)',
    exampleCount: '20 عدد',
    imageFile: 'transistor.jpg',
  ),
  ProductInfo(
    id: 'triac',
    name: 'ترایاک',
    prompt: '🔸نوع ترایاک خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : BT136)',
    exampleCount: '10 عدد',
    imageFile: 'triac.jpg',
  ),
  ProductInfo(
    id: 'led',
    name: 'LED',
    prompt: '🔸نوع LED مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : LED قرمز 5mm)',
    exampleCount: '50 عدد',
    imageFile: 'led.jpg',
  ),
  ProductInfo(
    id: 'seven_segment',
    name: 'سون سگمنت',
    prompt: '🔸نوع سون سگمنت مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : سون سگمنت تکی آند مشترک)',
    exampleCount: '10 عدد',
    imageFile: 'seven_segment.jpg',
  ),
  ProductInfo(
    id: 'lcd',
    name: 'LCD',
    prompt: '🔸نوع LCD مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : LCD 16x2 کاراکتری آبی)',
    exampleCount: '5 عدد',
    imageFile: 'lcd.jpg',
  ),
  ProductInfo(
    id: 'crystal',
    name: 'کریستال و اسیلاتور',
    prompt: '🔸نوع کریستال / اسیلاتور را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : کریستال 16 مگاهرتز)',
    exampleCount: '10 عدد',
    imageFile: 'crystal.jpg',
  ),
  ProductInfo(
    id: 'varistor',
    name: 'وریستور',
    prompt: '🔸نوع وریستور مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '10 عدد',
    imageFile: 'varistor.jpg',
  ),
  ProductInfo(
    id: 'fuse',
    name: 'فیوز',
    prompt: '🔸نوع فیوز مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : فیوز شیشه ای 125 ولت 1 آمپری 6*30)',
    exampleCount: '10 عدد',
    imageFile: 'fuse.jpg',
  ),
  ProductInfo(
    id: 'relay',
    name: 'رله',
    prompt: '🔸نوع رله مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : رله 5 ولت تک کنتاکت)',
    exampleCount: '10 عدد',
    imageFile: 'relay.jpg',
  ),
  ProductInfo(
    id: 'pin_header',
    name: 'پین هدر',
    prompt: '🔸نوع پین هدر مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '20 عدد',
    imageFile: 'pin_header.jpg',
  ),
  ProductInfo(
    id: 'socket',
    name: 'سوکت',
    prompt: '🔸نوع سوکت مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '10 عدد',
    imageFile: 'socket.jpg',
  ),
  ProductInfo(
    id: 'wire_ferrule',
    name: 'سرسیم و وایرشو',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : سرسیم گرد روکش دار آبی)',
    exampleCount: '100 عدد',
    imageFile: 'wire_ferrule.jpg',
  ),
  ProductInfo(
    id: 'tact_switch',
    name: 'تک سوییچ',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : تک سوییچ 12*12*7.3mm)',
    exampleCount: '10 عدد',
    imageFile: 'tact_switch.jpg',
  ),
  ProductInfo(
    id: 'dip_switch',
    name: 'دیپ سوییچ',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : دیپ سوییچ 3 تایی DIP)',
    exampleCount: '10 عدد',
    imageFile: 'dip_switch.jpg',
  ),
  ProductInfo(
    id: 'micro_switch',
    name: 'میکرو سوییچ',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : میکروسوییچ 250V AC 3A اهرم دار)',
    exampleCount: '10 عدد',
    imageFile: 'micro_switch.jpg',
  ),
  ProductInfo(
    id: 'rocker_switch',
    name: 'کلید راکر',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : کلید راکر دو حالته دو پین)',
    exampleCount: '10 عدد',
    imageFile: 'rocker_switch.jpg',
  ),
  ProductInfo(
    id: 'terminal',
    name: 'ترمینال',
    prompt: '🔸نوع ترمینال مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : ترمینال پیچی دوپین)',
    exampleCount: '10 عدد',
    imageFile: 'terminal.jpg',
  ),
  ProductInfo(
    id: 'buzzer',
    name: 'بازر و بلندگو',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : بازر یکپارچه 12 ولت)',
    exampleCount: '10 عدد',
    imageFile: 'buzzer.jpg',
  ),
  ProductInfo(
    id: 'pcb',
    name: 'فیبر مدارچاپی',
    prompt: '🔸نوع مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : فیبر 15*20 فایبرگلاس یک رو)',
    exampleCount: '5 عدد',
    imageFile: 'pcb.jpg',
  ),
  ProductInfo(
    id: 'breadboard',
    name: 'برد بورد',
    prompt: '🔸نوع برد بورد مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : برد بورد ساده 10*55*165)',
    exampleCount: '5 عدد',
    imageFile: 'breadboard.jpg',
  ),
  ProductInfo(
    id: 'jumper',
    name: 'سیم جامپر',
    prompt: '🔸نوع سیم جامپر مورد نظر خود را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : سیم جامپر نر به نر 20سانت 40رشته)',
    exampleCount: '10 عدد',
    imageFile: 'jumper.jpg',
  ),
  ProductInfo(
    id: 'heatsink',
    name: 'هیت سینک',
    prompt: '🔸نوع هیت سینک مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '10 عدد',
    imageFile: 'heatsink.jpg',
  ),
  ProductInfo(
    id: 'solder_wire',
    name: 'سیم لحیم',
    prompt: '🔸نوع سیم لحیم مورد نظر را برای ثبت سفارش ارسال کنید.',
    exampleCount: '5 عدد',
    imageFile: 'solder_wire.jpg',
  ),
  ProductInfo(
    id: 'solder_flux',
    name: 'روغن لحیم',
    prompt: '🔸نوع روغن لحیم مورد نظر را برای ثبت سفارش ارسال کنید.\n\n⬅️(برای مثال : روغن لحیم 10گرمی)',
    exampleCount: '10 عدد',
    imageFile: 'solder_flux.jpg',
  ),
];

/// برای سازگاری قدیمی
Map<String, ProductInfo> get productsCatalog =>
    {for (final p in allProducts) p.name: p};
