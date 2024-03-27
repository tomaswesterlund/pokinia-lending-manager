import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/domain/services/receipt_service.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/zero_interest/new_zero_interest_loan_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/pages/payments/new_zero_interest_loan_payment_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/zero_interest/zero_interest_loan_list_card_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> zeroInterestLoanWidgetViewModels = [
  ChangeNotifierProvider(
      create: (context) => NewZeroInterestLoanPageViewModel(
          GetIt.instance<ZeroInterestLoanService>())),
  ChangeNotifierProvider(
      create: (context) => NewZeroInterestLoanPaymentPageViewModel(
          GetIt.instance<LoanService>(),
          GetIt.instance<PaymentService>(),
          GetIt.instance<ReceiptService>())),
  ChangeNotifierProvider(
      create: (context) => ZeroInterestLoanListCardViewModel(
          GetIt.instance<ClientService>(),
          GetIt.instance<LoanService>(),
          GetIt.instance<ZeroInterestLoanService>())),
];
