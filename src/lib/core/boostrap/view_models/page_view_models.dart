import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/core/application_service.dart';
import 'package:pokinia_lending_manager/domain/services/auth_service.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/domain/services/receipt_service.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/pages/auth/sign_in_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/client/client_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/client/clients_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/client/new_client_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/loan_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/loans_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/open_ended/new_open_ended_loan_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/open_ended/open_ended_loan_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/zero_interest/zero_interest_loan_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan_statement/loan_statement_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/main_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/payments/new_open_ended_loan_payment_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/payments/payment_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> pageViewModels = [
  // Client Page View Model
  ChangeNotifierProvider(
      create: (context) => ClientPageViewModel(
          GetIt.instance<ClientService>(), GetIt.instance<LoanService>())),

  // Clients Page View Model
  ChangeNotifierProvider(
      create: (context) => ClientsPageViewModel(GetIt.instance<ClientService>(),
          GetIt.instance<UserSettingsService>())),

  // Loan Page View Model
  ChangeNotifierProvider(
      create: (context) => LoanPageViewModel(GetIt.instance<LoanService>())),

  // Loans Page View Model
  ChangeNotifierProvider(
      create: (context) => LoansPageViewModel(GetIt.instance<LoanService>())),

  // Loans Statement Page View Model
  ChangeNotifierProvider(
      create: (context) =>
          LoanStatementPageViewModel(GetIt.instance<PaymentService>())),

  // Main Page View Model
  ChangeNotifierProvider(
      create: (context) => MainPageViewModel(
          GetIt.instance<ApplicationService>(),
          GetIt.instance<UserSettingsService>())),

  // New Client Page View Model
  ChangeNotifierProvider(
      create: (context) => NewClientPageViewModel(
          GetIt.instance<ClientService>(),
          GetIt.instance<UserSettingsService>())),

  // NewOpenEndedLoanPageViewModel
  ChangeNotifierProvider(
      create: (context) => NewOpenEndedLoanPageViewModel(
          GetIt.instance<OpenEndedLoanService>())),

// NewOpenEndedLoanPaymentPageViewModel
  ChangeNotifierProvider(
      create: (context) => NewOpenEndedLoanPaymentPageViewModel(
          GetIt.instance<LoanStatementService>(),
          GetIt.instance<PaymentService>(),
          GetIt.instance<ReceiptService>())),

  // OpenEndedLoanPageViewModel
  ChangeNotifierProvider(
      create: (context) => OpenEndedLoanPageViewModel(
          clientService: GetIt.instance<ClientService>(),
          loanService: GetIt.instance<LoanService>(),
          openEndedLoanService: GetIt.instance<OpenEndedLoanService>(),
          loanStatementService: GetIt.instance<LoanStatementService>())),

  ChangeNotifierProvider(
      create: (context) => PaymentPageViewModel(
          GetIt.instance<PaymentService>(), GetIt.instance<ReceiptService>())),

  // SignInPageViewModel
  ChangeNotifierProvider(
      create: (context) => SignInPageViewModel(GetIt.instance<AuthService>())),

  // ZeroInterestLoanPageViewModel
  ChangeNotifierProvider(
      create: (context) => ZeroInterestLoanPageViewModel(
          GetIt.instance<ClientService>(),
          GetIt.instance<LoanService>(),
          GetIt.instance<PaymentService>(),
          GetIt.instance<ZeroInterestLoanService>())),
];
