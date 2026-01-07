mixin Rotas {
  //** Rotas gerais */
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String suporte = "/suporte";
  static const String chat = "/chat";
  static const String termosPolitica = "/termos/politica";
  static const String registerClientEmployee = "/register/client-employee";
  static const String receberCodigo = "/receber-codigo";
  static const String redefinirSenha = "/redefinir-senha";
  //** Rotas do cliente */
  static const String clientHome = "/client/home";
  static const String clientHistoricoServico = "/client/hisotrico-servico";
  static const String clientFinalizarServico = "/client/finalizar-servico";
  static const String clientPerfil = "/client/perfil";
  static const String clientCategoriasServicos = "/client/categoria-servicos";
  static const String clientPrestadoresCategorias =
      "/client/prestadores-categorias";
  //** Rotas do prestador */
  static const String employeeHome = "/employee/home";
  static const String employeeDetalhesServico = "/employee/detalhes-servico";
}
