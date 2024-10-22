
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
late  WebViewController controller ;
  @override
  Widget build(BuildContext context) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // Check if the page has finished loading the thank you page URL
            if (url.contains("https://example.com/thankyou")) {
              print('Page finished loading: $url');
              Uri uri = Uri.parse(url);

              // Extract query parameters from the URL
              String? statusParam = uri.queryParameters['status'];
              String? messageParam = uri.queryParameters['message'];
              if(statusParam == 'paid'){
                OrderCubit.get(context).successPayment(context);
                OrderCubit.get(context);
              }else{
               OrderCubit.get(context).emitPaymentMessageError();
                OrderCubit.get(context).paymentMessageError=messageParam;
                Navigator.pop(context);
              }
              OrderCubit.get(context).paymentUrl=null;
             // Close the WebView screen
            }
          },
          onHttpError: (HttpResponseError error) {},
          
        ),
      )
      ..loadRequest(Uri.parse(OrderCubit.get(context).paymentUrl??''));
    return Scaffold(
      //appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
