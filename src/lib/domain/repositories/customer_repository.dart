import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/data/models/customer_data_model.dart';

mixin CustomerRepository {
  addListener(Function() onChangesNotifyListeners);

  Either<CustomError, List<CustomerDataModel>> getCustomers();

  Either<CustomError, CustomerDataModel> getCustomerById(String id);
}
