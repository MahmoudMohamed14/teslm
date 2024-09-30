import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/features/home/controller/home_cubit.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/home_body.dart';
import '../widget/loading_shimmer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CarouselController controller = CarouselController();
        return StatefulBuilder(
          builder: (context, setState) => Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(200.0),
              child: appBar(context, true),
            ),
            body: (HomeCubit.get(context).providerData !=
                        null //&&HomeCubit.get(context).offersData != null
                    &&
                    HomeCubit.get(context).categoryData != null)
                ? homeBody(scrollController, controller, context)
                : loadingMainPage(scrollController, context),
          ),
        );
      },
    );
  }
}
