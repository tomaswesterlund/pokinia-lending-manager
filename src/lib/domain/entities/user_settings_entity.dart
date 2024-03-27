import 'package:pokinia_lending_manager/data/models/user_settings_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class UserSettingsEntity extends BaseEntity {
  final String userId;
  final String selectedOrganzationId;
  final bool showDeletedClients;
  final bool showDeletedLoans;
  final bool showDeletedLoanStatements;
  final bool showDeletedPayments;

  UserSettingsEntity({
    required super.id,
    required super.createdAt,
    required this.userId,
    required this.selectedOrganzationId,
    required this.showDeletedClients,
    required this.showDeletedLoans,
    required this.showDeletedLoanStatements,
    required this.showDeletedPayments,
  });

  factory UserSettingsEntity.fromDataModel(UserSettingsDataModel dataModel) {
    return UserSettingsEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      userId: dataModel.userId,
      selectedOrganzationId: dataModel.selectedOrganzationId,
      showDeletedClients: dataModel.showDeletedClients,
      showDeletedLoans: dataModel.showDeletedLoans,
      showDeletedLoanStatements: dataModel.showDeletedLoanStatements,
      showDeletedPayments: dataModel.showDeletedPayments,
    );
  }
}
