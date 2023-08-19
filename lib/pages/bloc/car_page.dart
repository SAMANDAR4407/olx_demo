import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_demo/pages/bloc/bloc/car_bloc.dart';

import '../../core/car_api.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final bloc = CarBloc(CarApi());
  final controller = ScrollController();

  @override
  void initState() {
    bloc.add(LoadDataEvent());
    controller.addListener(() {
      final position = controller.offset;
      final maxExtent = controller.position.maxScrollExtent;
      if (position / maxExtent > 0.9) {
        bloc.add(LoadDataEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc)],
      child: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('OLX Cars'),
            ),
            body: Builder(
              builder: (context) {
                if (state.status == EnumStatus.loading &&
                    state.list.isEmpty) {
                  return const Center(
                      child: CupertinoActivityIndicator(radius: 20));
                }
                return Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        controller: controller,
                        thickness: 10,
                        thumbVisibility: true,
                        child: ListView.separated(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          controller: controller,
                          itemCount: state.list.length,
                          separatorBuilder: (_, i) => const Divider(),
                          itemBuilder: (_, i) {
                            final model = state.list[i];
                            return SizedBox(
                              height: 150,
                              child: Row(
                                children: [
                                  model.photos.isEmpty
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: const Placeholder())
                                      : CachedNetworkImage(
                                          imageUrl: model.photos.first.link,
                                          height: double.infinity,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          fit: BoxFit.cover,
                                        ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(model.title),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 20,
                                          child: Row(
                                            children: [
                                              Text(model.params[1].name),
                                              const Expanded(
                                                  child: SizedBox()),
                                              Text(
                                                  "${model.params[1].value.value}"),
                                            ],
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        Text("${model.lastRefreshTime}"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    state.status == EnumStatus.loading
                        ? const Padding(
                            padding: EdgeInsets.all(15),
                            child: CupertinoActivityIndicator(
                              radius: 10,
                            ),
                          )
                        : const SizedBox()
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
