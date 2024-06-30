import 'package:get/get.dart';

import '../../../data/model/book.dart';
import '../../../data/repository/book_repository.dart';
import '../../../routes/app_pages.dart';

class FavoriteController extends GetxController {
  final BookRepository bookRepository = BookRepository();
  var books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      final bookList = await bookRepository.fetchFavorites();
      if (bookList != null) {
        books.assignAll(bookList);
      }
    } catch (e) {
      // assume never failed
    }
  }

  void goToDetail(int id) async {
    final selectedId = id;
    var isDelete = await Get.toNamed(
      Routes.DETAIL,
      parameters: {'id': id.toString()},
    );

    if (isDelete == true) {
      books.removeWhere((book) => book.id == selectedId);
    }
  }
}
