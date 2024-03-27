import 'package:get_it/get_it.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

bootstrapRepositories() async {
  GetIt.instance.registerSingleton<SupabaseClientRepository>(
      SupabaseClientRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseCurrencyOrganizationRepository>(
      SupabaseCurrencyOrganizationRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseCurrencyRepository>(
      SupabaseCurrencyRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseCustomerRepository>(
      SupabaseCustomerRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseLoanRepository>(
      SupabaseLoanRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseLoanStatementRepository>(
      SupabaseLoanStatementRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseOpenEndedLoanRepository>(
      SupabaseOpenEndedLoanRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseOrganizationRepository>(
      SupabaseOrganizationRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseOrganizationSettingsRepository>(
      SupabaseOrganizationSettingsRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabasePaymentRepository>(
      SupabasePaymentRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseUserSettingsRepository>(
      SupabaseUserSettingsRepository(GetIt.instance<SupabaseClient>()));

  GetIt.instance.registerSingleton<SupabaseZeroInterestLoanRepository>(
      SupabaseZeroInterestLoanRepository(GetIt.instance<SupabaseClient>()));

  // Storage
  GetIt.instance.registerSingleton<SupabaseStorage>(
      SupabaseStorage(GetIt.instance<SupabaseClient>()));
}
