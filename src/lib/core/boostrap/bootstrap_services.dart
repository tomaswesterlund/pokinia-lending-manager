import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/core/application_service.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_client_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_currency_organization_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_currency_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_customer_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_loan_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_loan_statement_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_open_ended_loan_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_organization_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_organization_settings_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_payment_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_storage.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_user_settings_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_zero_interest_loan_repository.dart';
import 'package:pokinia_lending_manager/domain/services/auth_service.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/currency_service.dart';
import 'package:pokinia_lending_manager/domain/services/customer_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/organization/organization_service.dart';
import 'package:pokinia_lending_manager/domain/services/organization/organization_settings_service.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/domain/services/receipt_service.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bootstrapServices() async {
  GetIt.instance.registerSingleton<ApplicationService>(ApplicationService());

  GetIt.instance.registerSingleton<AuthService>(AuthService());

  GetIt.instance.registerSingleton<ClientService>(
      ClientService(GetIt.instance<SupabaseClientRepository>()));

  GetIt.instance.registerSingleton<CurrencyService>(CurrencyService(
      GetIt.instance<SupabaseCurrencyRepository>(),
      GetIt.instance<SupabaseCurrencyOrganizationRepository>()));

  GetIt.instance.registerSingleton<CustomerService>(
      CustomerService(GetIt.instance<SupabaseCustomerRepository>()));

  GetIt.instance.registerSingleton<LoanService>(
      LoanService(GetIt.instance<SupabaseLoanRepository>()));

  GetIt.instance.registerSingleton<LoanStatementService>(
      LoanStatementService(GetIt.instance<SupabaseLoanStatementRepository>()));

  GetIt.instance.registerSingleton<OpenEndedLoanService>(
      OpenEndedLoanService(GetIt.instance<SupabaseOpenEndedLoanRepository>()));

  GetIt.instance.registerSingleton<OrganizationService>(
      OrganizationService(GetIt.instance<SupabaseOrganizationRepository>()));

  GetIt.instance.registerSingleton<OrganizationSettingsService>(
      OrganizationSettingsService(
          GetIt.instance<SupabaseOrganizationSettingsRepository>()));

  GetIt.instance.registerSingleton<PaymentService>(
      PaymentService(GetIt.instance<SupabasePaymentRepository>()));

  GetIt.instance.registerSingleton<ReceiptService>(
      ReceiptService(GetIt.instance<SupabaseStorage>()));

  GetIt.instance.registerSingleton<UserSettingsService>(UserSettingsService(
      GetIt.instance<SupabaseClient>(),
      GetIt.instance<SupabaseUserSettingsRepository>()));

  GetIt.instance.registerSingleton<ZeroInterestLoanService>(
      ZeroInterestLoanService(
          GetIt.instance<SupabaseZeroInterestLoanRepository>()));
}
