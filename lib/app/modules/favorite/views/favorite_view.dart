import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavoriteView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.books.isEmpty
          ? Center(
              child: Text(
              'Still Empty \n Try add your favorite book',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ))
          : ListView.builder(
              itemCount: controller.books.length,
              itemBuilder: (context, index) {
                var book = controller.books[index];
                return ListTile(
                  title: Text(book.title ?? ''),
                  subtitle: Text(
                      book.authors!.map((author) => author.name).join(', ')),
                  onTap: () {
                    controller.goToDetail(book.id ?? 0);
                  },
                );
              },
            )),
    );
  }
}
