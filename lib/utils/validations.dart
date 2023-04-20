
class Validations {
  String? validateEmail(value) {
    if (value.isEmpty) return 'Email requis!';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!nameExp.hasMatch(value)) {
      return 'Veuillez renseigner une adresse email valide!';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) return 'Numéro de téléphone réquis!';
    return null;
  }

  String? validateInput(value) {
    if ((value == null) || (value.isEmpty)) return 'Champs réquis!';
    return null;
  }

  String? validateInputWoyofalAmount(value) {
    if ((value == null) || (value.isEmpty)) return 'Champs réquis!';
    if ((int.parse(value) < 1000))
      return 'Le rechargement Woyofal est à 1000 Frcfa minimum!';
    return null;
  }

  String? validateInputAmountAirtime(value) {
    if ((value == null) || (value.isEmpty)) return 'Champs réquis!';
    if (int.parse(value) < 100)
      return 'Vous devez recharger au moins 100 Fcfa!';
    return null;
  }

  String? validateInputContact(value) {
    if ((value == null) || (value.isEmpty)) return 'Champs réquis!';
    RegExp regex = RegExp(r'[a-zA-Z]');
    if (regex.hasMatch(value)) {
      reloadContact(value);
    }
    return null;
  }

  reloadContact(value) async {
    // contacts = await ContactsService.getContacts(query: value);
  }

  String? validateInputSenEau(value) {
    if ((value == null) || (value.isEmpty)) {
      return 'Reference du client réquis!';
    }
    if ((value.length > 12) || (value.length < 12)) {
      return 'Veuillez renseigner un numéro de référence valide!';
    }
    return null;
  }

  String? validateInputSenelec(value) {
    if ((value == null) || (value.isEmpty)) {
      return 'Reference du client réquis!';
    }
    if ((value.length > 11) || (value.length < 11)) {
      return 'Veuillez renseigner un numéro de référence valide!';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Mot de passe réquis!';
    return null;
  }
}
