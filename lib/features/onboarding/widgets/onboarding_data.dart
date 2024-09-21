import '../../../common/images/images.dart';

class OnBoardingData{
  String image;
  String headText;
  String mainText;
  OnBoardingData({required this.image,required this.headText,required this.mainText});
}
List <OnBoardingData> onBoardingItems=[
  OnBoardingData(image: ImagesApp.secondOnboardingImage, headText: 'نجهز الطلبات فى وقت قصير', mainText: 'من خلال التطبق تسطيع طلب الطعام من اكبر المطاعم و يتم تجهيز الطلب و وصوله اليك فى وقت قصير'),
  OnBoardingData(image: ImagesApp.thirdOnboardingImage, headText: 'يتحرك المندوب الى مكانك', mainText: 'يتجه المندوب الى مكانك و يمكنك تتبع مسار المندوب حتى يصل اليك و معرفة الوقت الذى يحتاجة للوصل'),
  OnBoardingData(image: ImagesApp.firstOnboardingImage, headText: 'استلم طلبك من المندوب', mainText: 'يصلك طلبك الى المكانك الحالى او اى مكان اخر تريد ارسال الطلب اليه'),
];