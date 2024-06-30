import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ScrollController scrollController = ScrollController();
  final searchController = TextEditingController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMore();
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
          actions: [
            _buildNavFavBtn(),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                onSubmitted: (value) => controller.setSearchText(value),
                decoration: const InputDecoration(
                    labelText: 'search book...', border: OutlineInputBorder()),
              ),
            ),
            Expanded(
              child: Obx(() {
                // final controller.statusPage.value = controller.controller.statusPage.value;
                if (_isFirstLoad()) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (isErrorFirstLoad()) {
                  return _buildErrorWidget(
                      controller.statusPage.value.errorMessage ?? '');
                }
                return Obx(() {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.books.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.books.length) {
                        var book = controller.books[index];
                        return ListTile(
                          title: Text(book.title ?? ''),
                          subtitle: Text(book.authors!
                              .map((author) => author.name)
                              .join(', ')),
                          onTap: () {
                            controller.goToDetail(book.id ?? 0);
                          },
                        );
                      }
                      if (controller.statusPage.value.isEmpty) {
                        return const SizedBox();
                      }
                      if (controller.statusPage.value.isError) {
                        return _buildErrorWidget(
                            controller.statusPage.value.errorMessage ?? '');
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                });
              }),
            ),
          ],
        ));
  }

  bool _isFirstLoad() =>
      controller.statusPage.value.isLoading && controller.currentPage == 1;

  bool isErrorFirstLoad() =>
      controller.statusPage.value.isError && controller.currentPage == 1;

  Column _buildErrorWidget(String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorMessage),
        ElevatedButton(
          onPressed: () => controller.fetchData(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text(
            'Try again',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildNavFavBtn() {
    return IconButton(
        onPressed: () => controller.goToFavorites(),
        icon: const Icon(
          Icons.favorite,
          color: Colors.red,
        ));
  }
}
