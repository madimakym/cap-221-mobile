// ignore_for_file: prefer_typing_uninitialized_variables
String country = "sn";
late String newToken;
late String clientId;
var currentUser;
var existArticle;
var totalArticle = 0;
late int finalVersionInt;
String currentVersion = "";
String currentBuildNumber = "";
var contacts;
String baciType = "Banque Atlantique";
String orabankType = "Orabank";

const monthList = [
  "",
  "janvier",
  "février",
  "mars",
  "avril",
  "mais",
  "juin",
  "juillet",
  "août",
  "septembre",
  "octobre",
  "novembre",
  "décembre"
];

// String wpay = "http://localhost:8001";
String wpay = "https://api.cap221.com";
String gateway = "https://www.blog.cap221.com";
String notification = "https://notifications.wizall.com";

bool get isTestAPI {
  return wpay.contains("testwpay");
}

String get wpayToken {
  if (isTestAPI) {
    return "Bearer pc4whtJwmZOZ8cx2Ul81EwuDiu6pAS";
  } else {
    return "Bearer '6i-?n>`)arax(,3_ez[C>Nkbz9pR[";
  }
}

String get gatewayToken {
  if (isTestAPI) {
    return "Token 7b1c927e1b0c77efe6a4a1e5c4924303a7193efc";
  } else {
    return "Token 7b1c927e1b0c77efe6a4a1e5c4924303a7193efc";
  }
}

String get notificationToken {
  if (isTestAPI) {
    return "Basic YWRtaW46cGFzc2VyMTIzNA==";
  } else {
    return "Basic YWRtaW46cGFzc2VyMTIzNA==";
  }
}

String currentToken = "";

List offers = [];

// final List countriesItems = [
//   {"title": "Burkina Faso", "value": "bf", "image": "bf.png"},
//   {"title": "Côte d'ivoire", "value": "ci", "image": "ci.png"},
//   {"title": "Mali", "value": "ml", "image": "ml.png"},
//   {"title": "Sénégal", "value": "sn", "image": "sn.png"}
// ];

final dynamic countriesItems = {
  "bf": {
    "title": "Burkina Faso",
    "value": "bf",
    "image": "bf.png",
    "code": "+226"
  },
  "ci": {
    "title": "Côte d'ivoire",
    "value": "ci",
    "image": "ci.png",
    "code": "+225"
  },
  "ml": {
    "title": "Mali",
    "value": "ml",
    "image": "ml.png",
    "code": "+223",
  },
  "sn": {
    "title": "Sénégal",
    "value": "sn",
    "image": "sn.png",
    "code": "+221",
  }
};

final List genderItem = [
  {"title": "Homme", "value": "bf", "image": "bf.png", "code": "+226"},
  {"title": "Femmee", "value": "ci", "image": "ci.png", "code": "+225"},
];

final List regionItem = [
  {"title": "Dakar", "value": "Dakar"},
  {"title": "Diourbel", "value": "Diourbel"},
  {"title": "Fatick", "value": "Fatick"},
  {"title": "Kaffrine", "value": "Kaffrine"},
  {"title": "Kaolack", "value": "Kaolack"},
  {"title": "Kédougou", "value": "Kédougou"},
  {"title": "Kolda", "value": "Kolda"},
  {"title": "Louga", "value": "Louga"},
  {"title": "Matam", "value": "Matam"},
  {"title": "Sédhiou", "value": "Sédhiou"},
  {"title": "St Louis", "value": "St Louis"},
  {"title": "Tambacounda", "value": "Tambacounda"},
  {"title": "Thiès", "value": "Thiès"},
  {"title": "Ziguinchor", "value": "Ziguinchor"},
];

final List secteurItem = [
  {"title": "administratif-secretariat", "value": "administratif-secretariat"},
  {"title": "aeronautique", "value": "aeronautique"},
  {
    "title": "agriculture-agroalimentaire",
    "value": "agriculture-agroalimentaire"
  },
  {"title": "art et artisanat", "value": "art et artisanat"},
  {"title": "audiovisuel", "value": "audiovisuel"},
  {"title": "automobile-moto", "value": "automobile-moto"},
  {"title": "banque-finance-assurances", "value": "banque-finance-assurances"},
  {"title": "chimie-biologie", "value": "chimie-biologie"},
  {"title": "commerce-vente", "value": "commerce-vente"},
  {"title": "communication", "value": "communication"},
  {"title": "comptabilite-gestion", "value": "comptabilite-gestion"},
  {"title": "creation", "value": "creation"},
  {"title": "culture", "value": "culture"},
  {"title": "distributeur", "value": "distributeur"},
  {"title": "enseignement-orientation", "value": "enseignement-orientation"},
  {"title": "esthetique-beaute", "value": "esthetique-beaute"},
  {"title": "hotellerie-restauration", "value": "hotellerie-restauration"},
  {"title": "humanitaire", "value": "humanitaire"},
  {"title": "immobilier", "value": "immobilier"},
  {"title": "industrie", "value": "industrie"},
  {
    "title": "informatique-internet-multimedia",
    "value": "informatique-internet-multimedia"
  },
  {"title": "journalisme", "value": "journalisme"},
  {"title": "justice-droit", "value": "justice-droit"},
  {"title": "livre et edition", "value": "livre et edition"},
  {"title": "mode", "value": "mode"},
  {"title": "musique", "value": "musique"},
  {
    "title": "nature, environnement et developpement durable",
    "value": "nature, environnement et developpement durable"
  },
  {"title": "psychologue", "value": "psychologue"},
  {"title": "publicite-marketing", "value": "publicite-marketing"},
  {"title": "ressources humaines", "value": "ressources humaines"},
  {"title": "sante et paramedical", "value": "sante et paramedical"},
  {"title": "secteur animalier", "value": "secteur animalier"},
  {"title": "social", "value": "social"},
  {"title": "sport", "value": "sport"},
  {"title": "tourisme", "value": "tourisme"},
  {"title": "transport et logistique", "value": "transport et logistique"},
  {
    "title": "urbanisme-architecture-btp",
    "value": "urbanisme-architecture-btp"
  },
  {"title": "vigne-vin", "value": "vigne-vin"}
];

final List countriesTransfer = [
  {"title": "Burkina Faso", "value": "bf", "image": "bf.png", "code": "+226"},
  {"title": "Côte d'ivoire", "value": "ci", "image": "ci.png", "code": "+225"},
  {"title": "Mali", "value": "ml", "image": "ml.png", "code": "+223"},
  {"title": "Sénégal", "value": "sn", "image": "sn.png", "code": "+221"}
];

final List motifs = [
  {"title": "Assistance familiale", "value": "Assistance familiale"},
  {"title": "Frais médicaux", "value": "Frais médicaux"},
  {"title": "Frais scolaires", "value": "Frais scolaires"},
  {"title": "Oeuvre et Don", "value": "Oeuvre et Don"}
];
