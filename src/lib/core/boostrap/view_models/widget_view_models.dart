import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/core/boostrap/view_models/client_widget_view_models.dart';
import 'package:pokinia_lending_manager/core/boostrap/view_models/zero_interest_loan_widget_view_models.dart';
import 'package:pokinia_lending_manager/domain/services/auth_service.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/organization/organization_settings_service.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/widgets/auth/google_sign_in_button_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/expected_pay_date_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/open_ended/open_ended_loan_list_card_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/remaining_principal_amount_row_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/show_deleted_clients_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/show_deleted_loan_statements_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/show_deleted_loans_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/show_deleted_payments_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/update_expected_interest_for_overdue_loan_statements_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/update_expected_interest_for_scheduled_loan_statements_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> widgetViewModels = [
  ...clientWidgetViewModels,
  ...zeroInterestLoanWidgetViewModels,

  ChangeNotifierProvider(
      create: (context) => ExpectedPayDateViewModel(
          GetIt.instance<LoanService>(),
          GetIt.instance<OpenEndedLoanService>(),
          GetIt.instance<ZeroInterestLoanService>())),
  ChangeNotifierProvider(
      create: (context) => RemainingPrincipalAmountRowViewModel(
            GetIt.instance<LoanService>(),
            GetIt.instance<OpenEndedLoanService>(),
            GetIt.instance<ZeroInterestLoanService>(),
          )),
  ChangeNotifierProvider(
      create: (context) =>
          ShowDeletedClientsViewModel(GetIt.instance<UserSettingsService>())),
  ChangeNotifierProvider(
      create: (context) =>
          ShowDeletedClientsViewModel(GetIt.instance<UserSettingsService>())),
  ChangeNotifierProvider(
      create: (context) =>
          ShowDeletedLoansViewModel(GetIt.instance<UserSettingsService>())),
  ChangeNotifierProvider(
      create: (context) => ShowDeletedLoanStatementsViewModel(
          GetIt.instance<UserSettingsService>())),
  ChangeNotifierProvider(
      create: (context) =>
          ShowDeletedPaymentsViewModel(GetIt.instance<UserSettingsService>())),
  ChangeNotifierProvider(
      create: (context) =>
          GoogleSignInButtonViewModel(GetIt.instance<AuthService>())),
  ChangeNotifierProvider(
      create: (context) => OpenEndedLoanListCardViewModel(
          GetIt.instance<ClientService>(),
          GetIt.instance<LoanService>(),
          GetIt.instance<OpenEndedLoanService>())),


  ChangeNotifierProvider(
      create: (context) =>
          UpdateExpectedInterestForOverdueLoanStatementsViewModel(
              GetIt.instance<OrganizationSettingsService>(),
              GetIt.instance<UserSettingsService>())),
  ChangeNotifierProvider(
      create: (context) =>
          UpdateExpectedInterestForScheduledLoanStatementsViewModel(
              GetIt.instance<OrganizationSettingsService>(),
              GetIt.instance<UserSettingsService>())),

];
