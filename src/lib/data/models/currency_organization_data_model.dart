import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class CurrencyOrganizationDataModel extends BaseDataModel {
  final String organizationId;
  final String currencyId;

  CurrencyOrganizationDataModel({
    required super.id,
    required super.createdAt,
    required this.organizationId,
    required this.currencyId,
  });

  factory CurrencyOrganizationDataModel.fromJson(Map<String, dynamic> data) {
    return CurrencyOrganizationDataModel(
      id: data['id'].toString(),
      createdAt: data['created_at'].toString().toDate(),
      organizationId: data['organization_id'].toString(),
      currencyId: data['currency_id'].toString(),
    );
  }
}
