enum EnumToothCondition {
  Carries_Indicated_For_Filling,
  Carries_Indicated_For_Extraction,
  Root_Fragment,
  Missing_Due_To_Carries,
  Missing_Due_To_Other_Causes,
  Unerupted_Tooth,
  Impacted_Tooth,
  Gold_Crown,
  Jacket_Crown,
  Abutment_Tooth,
  Pontic,
  Inlay,
  Amalgam_Filling,
  Fixed_Bridge,
  Glass_Ionomer_Filling,
  Composite_Filling,
  Normal,
}
EnumToothCondition getToothCondition(String appointmentStatus) {
  switch (appointmentStatus) {
    case 'C':
      return EnumToothCondition.Carries_Indicated_For_Filling;

    case 'E':
      return EnumToothCondition.Carries_Indicated_For_Extraction;

    case 'RF':
      return EnumToothCondition.Root_Fragment;
    case 'M':
      return EnumToothCondition.Missing_Due_To_Carries;
    case 'MO':
      return EnumToothCondition.Missing_Due_To_Other_Causes;
    case 'Im':
      return EnumToothCondition.Impacted_Tooth;
    case 'G':
      return EnumToothCondition.Gold_Crown;
    case 'J':
      return EnumToothCondition.Jacket_Crown;
    case 'Ab':
      return EnumToothCondition.Abutment_Tooth;
    case 'P':
      return EnumToothCondition.Pontic;
    case 'I':
      return EnumToothCondition.Inlay;
    case 'Am':
      return EnumToothCondition.Amalgam_Filling;
    case 'Fb':
      return EnumToothCondition.Fixed_Bridge;
    case 'Gi':
      return EnumToothCondition.Glass_Ionomer_Filling;
    case 'Fi':
      return EnumToothCondition.Composite_Filling;

    default:
      return EnumToothCondition.Normal;
  }
}

extension Ext on EnumToothCondition {
  String get name {
    switch (this) {
      case EnumToothCondition.Carries_Indicated_For_Filling:
        return 'C';

      case EnumToothCondition.Carries_Indicated_For_Extraction:
        return 'E';

      case EnumToothCondition.Root_Fragment:
        return 'RF';

      case EnumToothCondition.Missing_Due_To_Carries:
        return 'M';
      case EnumToothCondition.Missing_Due_To_Other_Causes:
        return 'MO';
      case EnumToothCondition.Unerupted_Tooth:
        return 'U';
      case EnumToothCondition.Impacted_Tooth:
        return 'Im';
      case EnumToothCondition.Gold_Crown:
        return 'G';
      case EnumToothCondition.Jacket_Crown:
        return 'J';
      case EnumToothCondition.Abutment_Tooth:
        return 'Ab';
      case EnumToothCondition.Pontic:
        return 'P';
      case EnumToothCondition.Inlay:
        return 'I';
      case EnumToothCondition.Amalgam_Filling:
        return 'Am';
      case EnumToothCondition.Fixed_Bridge:
        return 'Fb';
      case EnumToothCondition.Glass_Ionomer_Filling:
        return 'Gi';
      case EnumToothCondition.Composite_Filling:
        return 'Fi';

      default:
        return 'Normal';
    }
  }
}
