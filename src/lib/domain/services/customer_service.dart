import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/customer_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/customer_repository.dart';

class CustomerService {
  final CustomerRepository _customerRepository;

  CustomerService(this._customerRepository);

  Either<CustomError, List<CustomerEntity>> getCustomers() {
    try {
      var customersDataModel = _customerRepository.getCustomers().right;
      var entityList = customersDataModel
          .map((e) => CustomerEntity.fromDataModel(e))
          .toList();

      return Right(entityList);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  Either<CustomError, CustomerEntity> getCustomerById(String id) {
    try {
      var customerDataModel = _customerRepository.getCustomerById(id).right;
      var entity = CustomerEntity.fromDataModel(customerDataModel);

      return Right(entity);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
