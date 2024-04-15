import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';

import '../errors/product_errors.dart';
import '../../domain/domain.dart';
import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({
    required this.accessToken,
  }) : dio = Dio(BaseOptions(baseUrl: Environment.apiUrl, headers: {
          'Authorization': 'Bearer $accessToken',
        }));

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final resp = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(resp.data);
      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final resp = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];

    for (var product in resp.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<Product> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
