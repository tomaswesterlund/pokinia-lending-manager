import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/client/client_list_dropdown_menu_component.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/overlays.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/client.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class NewLoanPageOld extends StatefulWidget {
  final Client? selectedClient;

  const NewLoanPageOld({super.key, this.selectedClient});

  @override
  State<NewLoanPageOld> createState() => _NewLoanPageOldState();
}

class _NewLoanPageOldState extends State<NewLoanPageOld> {
  final Logger _logger = getLogger('NewLoanPage');

  DateTime _startDate = DateTime.now();
  late LoanService _loanService;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _loanPrincipalAmountController =
      TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  OverlayEntry? _loadingOverlay;
  bool _isProcessing = false;
  Client? _selectedClient;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedClient = widget.selectedClient;
    });
  }

  Future<bool> createLoan() async {
    if (!_formKey.currentState!.validate()) {
      return false; // Validation failed
    }

    setOnProcessing(true);
    
    try {
      var response = await _loanService.createLoan(
        clientId: _selectedClient!.id,
        initialPrincipalAmount:
            double.parse(_loanPrincipalAmountController.text),
        initialInterestRate: double.parse(_interestRateController.text),
        startDate: _startDate,
        paymentPeriod: 'monthly',
      );

      // Check the response status code for success
      return response.statusCode == 200;
    } catch (e) {
      _logger.e(e.toString());
      return false;
    } finally {
      setOnProcessing(false);
    }
  }

  void _addLoan() async {
    bool isSuccess = await createLoan();

    if (isSuccess) {
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong ...")),
        );
      }
    }
  }

  void onClientSelected(Client? client) {
    _selectedClient = client;
  }

  void setOnProcessing(bool newValue) {
    setState(() {
      _isProcessing = newValue;

      if (_isProcessing) {
        _loadingOverlay = createLoadingOverlay(context);
        Overlay.of(context).insert(_loadingOverlay!);
      } else {
        _loadingOverlay?.remove();
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _loanService = Provider.of<LoanService>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _getHeaderWidget(),
          _getClientDropDownWidget(),
          _getPrincipalAmountWidget(),
          _getInterestRateWidget(),
          _getExpectedPayDateWidget(),
          _getPaymentPeriodWidget(),
          _getAddLoanButtonWidget()
        ],
      ),
    );
  }

  Widget _getHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderFourText(text: "Add loan"),
          IconButton(
              disabledColor: Colors.grey,
              onPressed: _isProcessing ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _getClientDropDownWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: ClientListDropdownMenu(
        selectedClient: widget.selectedClient,
        // enabled: !_isProcessing,
        onClientSelected: onClientSelected,
        controller: _clientController,
      ),
    );
  }

  Widget _getPrincipalAmountWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          enabled: !_isProcessing,
          labelText: "Principal amount",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Principal amount can't be empty";
            }

            if (value.isNotNumeric()) {
              return "Principal amount must be a number";
            }
            return null;
          },
          controller: _loanPrincipalAmountController),
    );
  }

  Widget _getInterestRateWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          enabled: !_isProcessing,
          labelText: "Interest rate",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Interest rate can't be empty";
            }

            if (value.isNotNumericOrFloating()) {
              return "Interest rate must be a number";
            }
            return null;
          },
          controller: _interestRateController),
    );
  }

  Widget _getExpectedPayDateWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ParagraphOneText(
              text: 'First expected payment date', fontWeight: FontWeight.bold),
          Row(
            children: [
              IconButton(
                  onPressed: _isProcessing ? null : () => _selectDate(context),
                  icon: const Icon(Icons.calendar_month)),
              ParagraphOneText(text: _startDate.toFormattedDate()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getPaymentPeriodWidget() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ParagraphOneText(text: 'Payment period', fontWeight: FontWeight.bold),
          ParagraphOneText(text: 'Monthly')
        ],
      ),
    );
  }

  Widget _getAddLoanButtonWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: MyCtaButton(
        text: "Add loan",
        isProcessing: _isProcessing,
        onPressed: _isProcessing ? null : _addLoan,
      ),
    );
  }
}
