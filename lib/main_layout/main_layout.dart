import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/styles/colors.dart';
import 'cubit/main_layout_cubit.dart';
import 'cubit/main_layout_state.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit()
        ..getCurrentUser()
        ..getAllUsers(),
      child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainLayoutCubit cubit = MainLayoutCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryLightColor,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: kPrimaryLightColor,
                ),
              ),
              body: cubit.screen[cubit.currentIndex]);
        },
      ),
    );
  }
}
