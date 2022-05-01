import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/cubit/fixed_cubit/fixed_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_fixed.dart';
import 'package:peak_property/services/models/upload_model.dart';

class Fixed extends StatefulWidget {
  const Fixed({Key? key}) : super(key: key);

  @override
  State<Fixed> createState() => _FixedState();
}

class _FixedState extends State<Fixed> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FixedCubit>(context).fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      displacement: 60,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            BlocConsumer<FixedCubit, FixedState>(
                bloc: BlocProvider.of<FixedCubit>(context),
                builder: (context, state) {
                  if (state is FixedLoading) {
                    return Center(child: getCircularProgress());
                  } else if (state is FixedSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customType('Homes', context),
                        customList(state.homes),
                        customType('Plots', context),
                        customList(state.plot),
                        customType('Commercials', context),
                        customList(state.commercial),
                        const SizedBox(height: 80),
                      ],
                    );
                  } else {
                    return const Text('Something went wrong');
                  }
                },
                listener: (context, state) {
                  if (state is FixedUnSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.msg.toString())));
                  }
                }),
          ],
        ),
      ),
    );
  }

  customType(String s, BuildContext context) => Container(
        margin: const EdgeInsets.only(
          left: MyApp.kDefaultPadding,
          bottom: MyApp.kDefaultPadding,
        ),
        child: Text(
          s,
          style: Theme.of(context).textTheme.headline4,
        ),
      );

  customList(List<UploadModel> model) => SizedBox(
        height: 300.0,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: model.isEmpty ? 1 : model.length,
          itemBuilder: (BuildContext context, int index) {
            if (model.isEmpty) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/cloud.png'),
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        'Not Available at this moment',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
              );
            }

            final value = model[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.fixedDetails, arguments: value);
              },
              child: CustomFixed(
                  image: value.thumbnail.toString(),
                  city: value.city.toString(),
                  startPrice: value.startPrice.toString(),
                  endPrice: value.endPrice.toString(),
                  title: value.title.toString()),
            );
          },
        ),
      );

  Future<void> _onRefresh() {
    Completer<void> completer = Completer<void>();
     Timer(const Duration(seconds: 3), () {
      BlocProvider.of<FixedCubit>(context).fetchProperties();
      completer.complete();
    });
    return completer.future;
  }
}
