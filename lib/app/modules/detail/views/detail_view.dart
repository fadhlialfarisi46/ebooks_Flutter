import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 100,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: controller.book.value.formats!.imageJpeg,
                          placeholder: (context, url) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      _buildTitle(context),
                      _buildAuthors(),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildDownloadCount(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildLanguages(context),
                      if (controller.book.value.bookshelves!.isNotEmpty)
                        _buildBookshelves(context),
                    ],
                  ),
                ),
              );
      }),
      floatingActionButton: _buildFAB(),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      controller.book.value.title ?? '',
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Text _buildAuthors() {
    return Text(
      controller.book.value.authors!.map((author) => author.name).join(', '),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLanguages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Subjects:',
        ),
        Text(
          controller.book.value.subjects!
              .map((subject) => "\"$subject\"")
              .join(', '),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildBookshelves(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Bookshelves:',
        ),
        Text(
          controller.book.value.bookshelves!
              .map((bookshelve) => "\"$bookshelve\"")
              .join(', '),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildDownloadCount(BuildContext context) {
    return Row(
      children: [
        const Text('Download Count: '),
        Text(
          controller.book.value.downloadCount.toString(),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () => controller.toggleFavorite(),
      child: Obx(() {
        final icon = controller.book.value.isFavorite
            ? Icons.favorite
            : Icons.favorite_border_rounded;
        return Icon(
          icon,
          color: Colors.red,
        );
      }),
    );
  }
}
