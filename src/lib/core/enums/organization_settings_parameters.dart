enum OrganizationSettingsParameters {
  calculateExpectedInterestAmountForOverdueLoans('CEIAFL_OVERDUE'),
  calculateExpectedInterestAmountForScheduledLoans('CEIAFL_SCHEDULED');

  final String value;
  const OrganizationSettingsParameters(this.value);
}
