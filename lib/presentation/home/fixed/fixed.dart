
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/cubit/fixed_cubit/fixed_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_fixed.dart';

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
    return SingleChildScrollView(
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
                      customList(state),
                      customType('Plots', context),
                      customList(state),
                      customType('Commercials', context),
                      customList(state),
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
          // Center(
          //   child: ElevatedButton(
          //       onPressed: () {
          //         BlocProvider.of<FixedCubit>(context).fetchProperties();
          //       },
          //       child: const Text('Testing')),
          // )
        ],
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

  customList(FixedSuccess state) => SizedBox(
        height: 300.0,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: state.uploadModel.length,
          itemBuilder: (BuildContext context, int index) {
            final value = state.uploadModel[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.fixedDetails, arguments: value.thumbnail);
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
}
