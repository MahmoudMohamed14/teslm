import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter/material.dart';

bool? isDark=Save.getdata(key: 'isDark');
int shippingPrice=15;
int totalPrice=0;
String? balances=Save.getdata(key: 'balance');
String? customerId=Save.getdata(key: 'customerId');
PageController pageController = PageController(
  initialPage: 3,
);
String? token;
int price=0;
String ?language=Save.getdata(key: 'lang')??'ar';
ThemeData lightMode=ThemeData(
    fontFamily: language=='en'? 'fonten':'fontTop',
    primarySwatch: mainColor,
    primaryColor:mainColor
);
ThemeData darkMode=ThemeData(
  fontFamily: language=='en'? 'fonten':'fontTop',
  primaryColor: Colors.grey,
  brightness: Brightness.dark,
  hintColor: Colors.white,
  dividerColor: Colors.black12,
  appBarTheme: const AppBarTheme(
    color: Colors.black54,
  ),);
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> itemsAr=[
  Item(headerValue: 'من نحن؟',
    expandedValue: 'نحن منصّة رقميّة تتيح للعملاء طلب الطعام او الشراب او الهديا وغيرها من الخدمات.',),
  Item(headerValue: 'كيف يتم التسجيل في تسلم؟',
    expandedValue: 'بعد تحميل التطبيق يمكنك التسجيل باستخدام رقم الهاتف فقط.',),
  Item(headerValue: 'هل يقوم التطبيق بحفظ بياناتي وقائمة الاتصال الخاصة بي؟',
    expandedValue: 'بالتاكيد يتم استخدام بيانات المستخدمين لغرض إنشاء حساب على تسلم فقط. كما يطلب إذن تحديد الموقع على الخريطة.',),
  Item(headerValue: 'أين يمكنني استخدام تطبيق تسلم؟',
    expandedValue: 'تغطي مناطق عمل التطبيق في الوقت الحالي مدينتيّ الرياض جدة و مكة، ويتم العمل على خطة توسع لتغطية مناطق أكثر حول المملكة.',),
  Item(headerValue: 'هل يوجد حد أدنى للطلبات؟',
    expandedValue: 'يتم تحديد الحد الأدنى للطلب بحسب الخدمات المطلوبة، وتعرض تفاصيل الحد الأدنى لكل منها على التطبيق عند الطلب.',),
  Item(headerValue: 'هل يمكنني إنشاء أكثر من طلب في نفس الوقت؟',
    expandedValue: 'تم تصميم تطبيق تسلم و تنفيذة بشكل يؤمن احتياجات العملاء ويضعها بين أيديهم بمنتهى السهولة. لذلك فقد تم أخذ حاجة العميل لطلب ثلاث خدمات فى نفس الوقت.',),
  Item(headerValue: 'هل يمكنني التعديل أو إضافة أصناف أخرى بعد إتمام عمليّة طلب التوصيل؟',
    expandedValue: 'لا يمكن إضافة أو تعديل الطلب بعد تأكيد الطلب وقبوله من قبل المتجر أو المطعم.',),
  Item(headerValue: 'هل يمكنني تغيير نقطة الوصول أثناء الرحلة؟',
    expandedValue: 'متاح لك تغيير الوجهة في أي وقت أثناء الرحلة قبل أن يقوم الممثل بتأكيد إنهاء الطلب.',),
  Item(headerValue: 'هل يمكنني التوقف في عدة محطات أثناء الرحلة الواحدة؟',
    expandedValue: 'من الممكن التوجه إلى عدة محطات بالاتفاق مع المندوب قبل اتمام الرحلة كاملة.',),
  Item(headerValue: 'هل يمكنني تغيير نقطة الوصول أثناء الرحلة؟',
    expandedValue: 'يمكن تغيير الوجهة في أي وقت أثناء الرحلة قبل أن يقوم الممثل بتأكيد إنهاء الطلب.',),
  Item(headerValue: 'متى يجب التواصل مع فريق الدعم؟',
    expandedValue: 'يهتم فريق الدعم بكافة الأسئلة والاستفسارات الخاصة بالعملاء في أي وقت. إلا أنه هنالك بعض الحالات الخاصة التي نأمل العملاء التواصل مع فريق الدعم في حال حدوثها كي نتمكن من ضمان جودة الخدمات المقدمة وتضم هذه الحالات: في حال قام الممثل بطلب الموقع عبر وسيلة خارج التطبيق في حال تأخر الطلب في حال حدوث خطأ في الطلب',),
  Item(headerValue: 'كيف يمكنني متابعة حالة الطلب الخاص بي؟',
    expandedValue: 'تم تنفيذ التطبيق بشكل يسمح للعملاء متابعة كافة مراحل الطلب، كما يمكن الاستفسار من فريق الدعم في أي وقت وعلى مدار الساعة.',),
  Item(headerValue: 'ما هو الوقت المتوقع لوصول طلبي؟',
    expandedValue: 'يعتمد الوقت المتوقع لوصول الطلب على المسافة بين الفرع الذي تم الطلب منه وبين موقع التوصيل. لذلك يتراوح الوقت المتوقع لاستلام الطلب بين ٢٠ دقيقة حتى ٣٠ دقيقة.',),
  Item(headerValue: 'ماهي وسائل الدفع المعتمدة في تسلم؟',
    expandedValue: 'يتم قبول وسائل الدفع التالية على تسلم:البطاقات الائتمانيّة ماستر كارد وفيزا او مدى التابعة لأحد البنوك السعودية او Apple Pay',),
  Item(headerValue: 'لم تتمكن من إيجاد إجابة سؤالك؟',
    expandedValue: 'يرجى مرسلتنا على الايميل teslmlog@gmail.com وسنقوم بالرد عليه في أقرب وقت ممكن.',),
  Item(headerValue: 'ما هو رقم خدمه العملاء للتواصل؟',
    expandedValue: 'يرجى التواصل معنا على الرقم 54460 سيتم الرد عليكم.',),
];
List<Item> itemsEn=[
  Item(headerValue: 'What is Teslm?',
    expandedValue: 'We are a digital platform that allows customers to order food, drinks, gifts, and other services.',),
  Item(headerValue: 'How to sign up?',
    expandedValue: 'And after downloading the app, you can register using your phone number only.',),
  Item(headerValue: 'Does the app save my data and my contact list?',
    expandedValue: 'And that is certainly done to use user data for the purpose of creating an account to receive orders only. It also requests permission to determine location on the map.',),
  Item(headerValue: 'Where can I use the Taslm app?',
    expandedValue: 'The coverage areas of the app currently include the cities of Riyadh, Jeddah, and Makkah, and there are plans to expand coverage to more regions around the Saudi Arabian Kingdom.',),
  Item(headerValue: 'Is there a minimum order value?',
    expandedValue: 'The minimum order is determined based on the requested services, and the details of the minimum for each one are displayed on the app when placing the order.',),
  Item(headerValue: 'Can I create more than one order at the same time?',
    expandedValue: 'The Teslm app has been designed and implemented in a way that secures the customers needs and places them in their hands with the utmost ease. Therefore, the customers need to order three services at the same time has been taken into account.',),
  Item(headerValue: 'Can I modify or add other items after completing the delivery order process?',
    expandedValue: 'No, you cannot add or modify the order after confirming the order and it being accepted by the store or restaurant.',),
  Item(headerValue: 'Can I change the delivery location during the trip?',
    expandedValue: 'You can change the destination at any time during the trip before the representative confirms the completion of the order.',),
  Item(headerValue: 'Can I stop at multiple locations during the same trip?',
    expandedValue: 'It is possible to go to multiple locations by agreeing with the representative before completing the entire trip.',),
  Item(headerValue: 'Can I change or add to my delivery order after placing it?',
    expandedValue: 'You can change the destination at any time during the trip before the representative confirms the completion of the order.',),
  Item(headerValue: 'When to contact Customer Support?',
    expandedValue: 'Our Customer Support team is available to attend to our customers’ needs and to attend to any of their inquiries. However, to ensure a seamless experience, we encourage customers to contact Customer Support in the following cases: If the Representative asks for their location If their order/ride is late If something is wrong with their order',),
  Item(headerValue: 'How can I track the status of my order?',
    expandedValue: 'The application has been implemented in a way that allows customers to follow up on all stages of the order. Customers can also inquire with the support team at any time and around the clock.',),
  Item(headerValue: 'What is the expected delivery time for my order?',
    expandedValue: 'The expected delivery time for the order depends on the distance between the branch the order was placed from and the delivery location. Therefore, the expected time to receive the order ranges between 20 minutes to 30 minutes.',),
  Item(headerValue: 'What are the approved payment methods in Teslm?',
    expandedValue: 'The following payment methods are accepted on Teslm: credit cards Mastercard and Visa, or Mada cards affiliated with one of the Saudi banks, or Apple Pay.',),
  Item(headerValue: 'Were you unable to find the answer to your question?',
    expandedValue: 'Please send us an email to teslmlog@gmail.com and we will respond to it as soon as possible.',),
  Item(headerValue: 'What is the customer service number to contact?',
    expandedValue: 'Please contact us on the number 54460, and we will respond to you.',),
];
