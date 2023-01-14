/// Esta clase contendrá las variables globales de la aplicación, para este
/// proyecto solo utilizo esta clase por que no existen diferents entornos
/// (dev, qa, prod), solo hay un entorno.
/// De todas maneras para evitar repetir las urls en todo lados que se necesiten
/// se establecen aquí manualmente, y en caso de haber un ajuste solo se hace en
/// este archivo en no en todo lado.
class GlobalVars {
  static bool dev = false;

  static String appName = 'Bayteq Pokemón';

  static String protocol = dev ? 'http://' : 'https://';
  static String hots = dev ? 'pokeapi.co' : 'pokeapi.co';
  static String port = dev ? '' : '';
  static String apiEndpoint = '/api/v2';

  static String apiUrl = protocol + hots + port + apiEndpoint;
}
