enum OrganizationSettings {
  unknown;

  static OrganizationSettings fromName(String? name) {
    if (name == null || name.isEmpty) {
      return OrganizationSettings.unknown;
    }
    
    for (OrganizationSettings enumVariant in OrganizationSettings.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return OrganizationSettings.unknown;
  }
}