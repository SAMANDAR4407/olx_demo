import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/car_api.dart';
import '../../core/car_model.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final api = CarApi();
  var list = <CarModel>[];
  var loading = false;
  var offset = 0;
  final controller = ScrollController();

  @override
  void initState() {
    loadData();
    controller.addListener(() {
      final position = controller.offset;
      final maxHeight = controller.position.maxScrollExtent;
      if (position / maxHeight >= 0.9) {
        if (loading || offset > 1000) return;
        loadData();
      }
    });
    super.initState();
  }

  Future<void> loadData() async {
    // print("loadData: $offset");
    loading = true;
    setState(() {});
    try {
      list.addAll(await api.cars(offset: offset));
      offset += 10;
    } catch (e) {
      // print("Xato: $e");
      //error
    }
    loading = false;
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OLX Cars'),
      ),
      body: Builder(
        builder: (context) {
          if (loading && list.isEmpty) {
            return const Center(child: CupertinoActivityIndicator(radius: 20));
          }
          return Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: controller,
                  thickness: 10,
                  thumbVisibility: true,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    controller: controller,
                    itemCount: list.length,
                    separatorBuilder: (_, i) => const Divider(),
                    itemBuilder: (_, i) {
                      final model = list[i];
                      return SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            model.photos.isEmpty
                                ? SizedBox(width: MediaQuery.of(context).size.width * 0.4,
                                    child: const Placeholder())
                                : CachedNetworkImage(
                              imageUrl: model.photos.first.link,
                              height: double.infinity,
                              width: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.title),
                                  SizedBox(
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Text(model.params[1].name),
                                        const Expanded(child: SizedBox()),
                                        Text("${model.params[1].value.value}"),
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
              loading
                  ? const Padding(
                    padding: EdgeInsets.all(15),
                    child: CupertinoActivityIndicator(radius: 10,),
                  )
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }
}
