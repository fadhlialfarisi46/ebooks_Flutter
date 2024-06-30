import 'package:ebooks/app/data/model/book.dart';
import 'package:ebooks/app/data/repository/book_repository.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final BookRepository bookRepository = BookRepository();
  var book = Book().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final params = Get.parameters;
    final id = int.tryParse(params['id']!) ?? 0;
    _getDetailBook(id);
  }

  void _getDetailBook(int id) async {
    _setLoading(true);
    try {
      final detailBook = await bookRepository.getDetailBook(id);
      if (detailBook != null) {
        book.value = detailBook;
      }
    } catch (e) {
      // assume never failed
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool newValue) {
    isLoading.value = newValue;
  }

  void toggleFavorite() async {
    final isFavorite = book.value.isFavorite;
    book.update((val) {
      val?.isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await bookRepository.removeFavorite(book.value);
      Get.back(result: true);
      return;
    }
    await bookRepository.addFavorite(book.value);
  }
}
