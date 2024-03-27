import 'package:get_it/get_it.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/client_list_drop_down_menu_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/loan_list/client_loan_list_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/loan_list/client_open_ended_loan_list_card_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/loan_list/client_zero_interest_loan_list_card_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> clientWidgetViewModels = [
  ChangeNotifierProvider(
      create: (context) => ClientOpenEndedLoanListCardViewModel(
          GetIt.instance<OpenEndedLoanService>())),
  ChangeNotifierProvider(
      create: (context) =>
          ClientListDropdownMenuViewModel(GetIt.instance<ClientService>())),
  ChangeNotifierProvider(
      create: (context) =>
          ClientLoanListViewModel(GetIt.instance<LoanService>())),
  ChangeNotifierProvider(
      create: (context) => ClientZeroInterestLoanListCardViewModel(
          GetIt.instance<LoanService>())),
];
