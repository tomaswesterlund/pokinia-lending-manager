import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_client_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_loan_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_loan_statement_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_open_ended_loan_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_payment_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_user_settings_repository.dart';
import 'package:pokinia_lending_manager/data/repositories/supabase_zero_interest_loan_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationService {
  final supabase = Supabase.instance.client;

  States _state = States.loading;
  States get state => _state;

  ApplicationService() {
    loadRepositories();
  }

  final Map<String, bool> _repositoryListenersLoaded = {
    DataRepositories.clientRepository.value: false,
    DataRepositories.loanRepository.value: false,
    DataRepositories.loanStatementRepository.value: false,
    DataRepositories.openEndedLoanRepository.value: false,
    DataRepositories.paymentRepository.value: false,
    DataRepositories.userSettingsRepository.value: false,
    DataRepositories.zeroInterestLoansRepository.value: false,
  };

  Future loadRepositories() async {
    // Repositories
    GetIt.instance<SupabaseClientRepository>()
        .startListener(onRepositoryLoaded);

    GetIt.instance<SupabaseLoanRepository>().startListener(onRepositoryLoaded);

    GetIt.instance<SupabaseLoanStatementRepository>()
        .startListener(onRepositoryLoaded);

    GetIt.instance<SupabaseOpenEndedLoanRepository>()
        .startListener(onRepositoryLoaded);

    GetIt.instance<SupabasePaymentRepository>()
        .startListener(onRepositoryLoaded);

    GetIt.instance<SupabaseUserSettingsRepository>()
        .startListener(onRepositoryLoaded);

    GetIt.instance<SupabaseZeroInterestLoanRepository>()
        .startListener(onRepositoryLoaded);
  }

  void onRepositoryLoaded(String source) async {
    _repositoryListenersLoaded[source] = true;

    if (_repositoryListenersLoaded.values.every((loaded) => loaded)) {
      _state = States.ready;
    }
  }
}
