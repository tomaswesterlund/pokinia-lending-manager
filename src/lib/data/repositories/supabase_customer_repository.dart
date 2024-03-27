import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/data/models/customer_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/customer_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCustomerRepository extends BaseRepository<CustomerDataModel>
    with CustomerRepository {
  SupabaseCustomerRepository(SupabaseClient supabaseClient)
      : super(supabaseClient, DataRepositories.customerRepository,
            TableNames.customers, (data) => CustomerDataModel.fromJson(data));

  @override
  Either<CustomError, List<CustomerDataModel>> getCustomers() {
    try {
      return Right(data);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Either<CustomError, CustomerDataModel> getCustomerById(String id) {
    try {
      var customer = data.firstWhere((element) => element.id == id);
      return Right(customer);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
