
import '../data/model/address.model.dart';
import '../data/service/api.service.dart';

class SearchAddressUseCase {
  Future<List<AddressModel>> search(String query) async {
    return await ApiService.searchAddress(query);
  }
}