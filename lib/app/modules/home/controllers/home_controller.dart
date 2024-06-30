import 'package:ebooks/app/data/repository/book_repository.dart';
import 'package:get/get.dart';

import '../../../data/model/book.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<List<Book>> {
  final BookRepository bookRepository = BookRepository();
  var books = <Book>[].obs;
  var currentPage = 1;
  var query = '';
  var statusPage = RxStatus.loading().obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    statusPage.value = RxStatus.loading();

    if (currentPage == 1) {
      books.clear();
    }
    try {
      final bookList = await bookRepository.fetchBooks(currentPage, query);
      if (bookList != null) {
        if (currentPage == 1) {
          books.assignAll(bookList);
        } else {
          books.addAll(bookList);
        }
        if ((bookList.length == 32)) {
          statusPage.value = RxStatus.loadingMore();
          return;
        }
        statusPage.value = RxStatus.empty();
      }
    } catch (e) {
      statusPage.value = RxStatus.error(e.toString());
    }
  }

  void goToDetail(int id) {
    Get.toNamed(Routes.DETAIL, parameters: {'id': id.toString()});
  }

  void goToFavorites() {
    Get.toNamed(Routes.FAVORITE);
  }

  void loadMore() {
    if (statusPage.value.isLoadingMore == true) {
      currentPage++;
      fetchData();
    }
  }

  void setSearchText(String text) {
    query = text;
    currentPage = 1;
    fetchData();
  }
}
