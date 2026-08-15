/// مسیر عکس قطعات (Wikimedia — حجم کم)
class PartImages {
  static const Map<String, String> category = {
    'مقاومت': 'assets/parts/cat_resistor.jpg',
    'خازن': 'assets/parts/cat_capacitor.jpg',
    'سلف': 'assets/parts/cat_inductor.jpg',
    'دیود': 'assets/parts/cat_diode.jpg',
    'IC و نیمه‌هادی': 'assets/parts/cat_semi.jpg',
    'نمایشگر': 'assets/parts/cat_display.jpg',
    'فرکانس و حفاظتی': 'assets/parts/cat_protect.jpg',
    'کلید و اتصال': 'assets/parts/cat_semi.jpg',
    'برد و لحیم': 'assets/parts/cat_board.jpg',
  };

  static const Map<String, String> product = {
    'مقاومت DIP': 'assets/parts/p_res_dip.jpg',
    'مقاومت SMD': 'assets/parts/p_res_smd.jpg',
    'پتانسیومتر': 'assets/parts/p_res_dip.jpg',
    'ترمیستور': 'assets/parts/p_res_dip.jpg',
    'خازن الکترولیتی': 'assets/parts/p_cap_elec.jpg',
    'خازن SMD': 'assets/parts/p_cap_smd.jpg',
    'خازن سرامیکی و عدسی': 'assets/parts/p_cap_smd.jpg',
    'خازن پلی استر': 'assets/parts/p_cap_elec.jpg',
    'خازن متغیر': 'assets/parts/p_cap_elec.jpg',
    'سلف بشکه ای': 'assets/parts/p_inductor.jpg',
    'سلف مقاومتی': 'assets/parts/p_inductor.jpg',
    'سلف SMD': 'assets/parts/p_inductor.jpg',
    'سلف متغیر': 'assets/parts/p_inductor.jpg',
    'دیود ساده': 'assets/parts/p_diode.jpg',
    'پل دیود': 'assets/parts/p_diode.jpg',
    'دیود شاتکی': 'assets/parts/p_diode.jpg',
    'دیود زنر': 'assets/parts/p_diode.jpg',
    'آی سی-تراشه': 'assets/parts/p_ic.jpg',
    'میکروکنترلر': 'assets/parts/p_ic.jpg',
    'رگولاتور': 'assets/parts/p_ic.jpg',
    'ترانزیستور': 'assets/parts/p_transistor.jpg',
    'ترایاک': 'assets/parts/p_transistor.jpg',
    'LED': 'assets/parts/p_led.jpg',
    'سون سگمنت': 'assets/parts/p_led.jpg',
    'کریستال و اسیلاتور': 'assets/parts/cat_protect.jpg',
    'وریستور': 'assets/parts/p_res_dip.jpg',
    'فیوز': 'assets/parts/cat_protect.jpg',
    'رله': 'assets/parts/cat_semi.jpg',
    'فیبر مدارچاپی': 'assets/parts/p_pcb.jpg',
    'برد بورد': 'assets/parts/p_pcb.jpg',
    'سیم جامپر': 'assets/parts/p_pcb.jpg',
  };

  static String? forCategory(String name) => category[name];
  static String? forProduct(String name) => product[name] ?? category.values.first;
}
