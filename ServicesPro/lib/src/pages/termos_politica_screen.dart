import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class TermosPoliticaScreen extends StatelessWidget {
  const TermosPoliticaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Termos e Política',
          style: context.cusotomFontes.bold.copyWith(
            color: ColorsConstants.primaryColor,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorsConstants.azulColor,

        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: ColorsConstants.primaryColor),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Termos de uso.',
                  style: context.cusotomFontes.black.copyWith(
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: context.percentWidth(0.9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: TemaSistema().temaSistema(context)
                        ? Theme.of(context).colorScheme.surface
                        : ColorsConstants.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Aceitação dos Termos\nAo acessar, cadastrar-se ou utilizar a plataforma [NOME DO APLICATIVO], o usuário declara que leu, compreendeu e concorda integralmente com estes Termos de Uso e com a Política de Privacidade.\n\n2. Objetivo da Plataforma\nA plataforma tem como objetivo intermediar a conexão entre clientes e prestadores de serviços, facilitando a contratação, comunicação e acompanhamento de serviços, sem participar diretamente da execução das atividades contratadas.\n\n3. Cadastro e Responsabilidade das Informações\nO prestador de serviços compromete-se a:\nFornecer informações verdadeiras, completas e atualizadas;\nManter seus dados corretos durante todo o período de uso da plataforma;\nSer integralmente responsável pelos serviços ofertados e executados.\nO fornecimento de informações falsas poderá resultar em suspensão ou exclusão da conta, sem prejuízo de medidas legais cabíveis.\n\n4. Obrigações do Prestador de Serviços O prestador compromete-se a:\nCumprir prazos, condições e valores acordados com o cliente;\nAtuar com ética, boa-fé, profissionalismo e respeito;\nExecutar os serviços conforme descrito e aceito na plataforma.\n\n5. Descumprimento de Acordos e Medidas Legais\nEm caso de descumprimento contratual, abandono do serviço, fraude, má-fé ou qualquer conduta que cause prejuízo ao cliente, o prestador autoriza expressamente que seus dados cadastrais possam ser compartilhados com o cliente, exclusivamente para fins legais, incluindo, mas não se limitando a:\nRegistro de Boletim de Ocorrência;\nExercício do direito de defesa do consumidor;\nAdoção de medidas judiciais ou administrativas cabíveis.\nDados que poderão ser compartilhados:\nNome completo;\nCPF;\nEndereço;\nTelefone;\nOutras informações estritamente necessárias para fins legais.\nEsse compartilhamento ocorrerá apenas mediante solicitação formal do cliente, em conformidade com a Lei Geral de Proteção de Dados (Lei nº 13.709/2018 – LGPD).\n\n6. Limitação de Responsabilidade da Plataforma\nA plataforma não se responsabiliza por:\nQualidade, execução ou resultado dos serviços prestados;\nDanos materiais, morais ou financeiros decorrentes da relação entre cliente e prestador;\nAcordos realizados fora da plataforma.\nA responsabilidade é exclusiva das partes envolvidas.\n\n7. Suspensão e Cancelamento de Conta\nA plataforma reserva-se o direito de:\nSuspender ou encerrar contas que violem estes Termos;\nBloquear usuários envolvidos em denúncias, fraudes ou práticas ilegais;\nCooperar com autoridades sempre que solicitado.\n\n8. Proteção de Dados\nO tratamento de dados pessoais será realizado conforme a Política de Privacidade, respeitando os princípios da LGPD, incluindo finalidade, necessidade e segurança das informações.\n\n9. Alterações dos Termos\nEstes Termos podem ser atualizados a qualquer momento. O usuário será notificado, e o uso contínuo da plataforma após alterações implica concordância com a versão vigente.\n\n10. Foro\nFica eleito o foro da comarca de [CIDADE / ESTADO], para dirimir quaisquer dúvidas ou conflitos oriundos destes Termos, com renúncia a qualquer outro, por mais privilegiado que seja.',
                      style: context.cusotomFontes.regular.copyWith(
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'POLÍTICA DE PRIVACIDADE.',
                  style: context.cusotomFontes.black.copyWith(
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: context.percentWidth(0.9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: TemaSistema().temaSistema(context)
                        ? Theme.of(context).colorScheme.surface
                        : ColorsConstants.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Introdução\nA [NOME DO APLICATIVO] respeita a privacidade e a proteção dos dados pessoais de seus usuários. Esta Política de Privacidade descreve como coletamos,utilizamos, armazenamos e compartilhamos informações, em conformidade com a Lei Geral de Proteção de Dados Pessoais (LGPD – Lei nº 13.709/2018).Ao utilizar a plataforma, o usuário declara estar ciente e de acordo com esta Política.\n\n2. Dados Coletados\nPodemos coletar os seguintes dados pessoais, conforme a utilização da plataforma:\n\n2.1 Dados de Cadastro\nNome completo;\nCPF;\nEndereço;\nTelefone;\nE-mail;\nFoto de perfil;\nDados profissionais (categoria, serviços oferecidos, experiência).\n\n2.2 Dados de Uso\nHistórico de serviços;\nAvaliações e feedbacks;\nMensagens trocadas na plataforma;\nData e hora de acessos;\nInformações do dispositivo e do aplicativo.\n\n3. Finalidade do Tratamento dos Dados Pessoais\nOs dados coletados são utilizados para:\nCriar e gerenciar contas de usuários;\nIntermediar a relação entre clientes e prestadores de serviços;\nFacilitar comunicação entre as partes;\nGarantir segurança, prevenção a fraudes e melhoria da experiência;\nCumprir obrigações legais e regulatórias;\nPermitir o exercício regular de direitos em processos administrativos ou judiciais.\n\n4. Compartilhamento de Dados\nA plataforma não comercializa dados pessoais.Os dados poderão ser compartilhados somente nas seguintes situações:\n\n4.1 Entre Usuários da Plataforma\nPara viabilizar a contratação de serviços, determinados dados cadastrais do prestador poderão ser compartilhados com o cliente, tais como:\nNome completo;\nCategoria de serviço;\nAvaliações e feedbacks;\nOutras Informações básicas poderão ser exibidas entre clientes e prestadores para viabilizar a contratação do serviço.\n\n4.2 Cumprimento Legal e Medidas Judiciais\nEm caso de descumprimento de obrigações, fraude, má-fé ou prejuízo causado, determinados dados cadastrais do prestador poderão ser compartilhados com o cliente exclusivamente para fins legais, tais como:\nRegistro de Boletim de Ocorrência;\nExercício do direito de defesa;\nAdoção de medidas judiciais ou administrativas cabíveis.Esse compartilhamento ocorrerá mediante solicitação formal, respeitando os princípios da necessidade, finalidade e proporcionalidade, conforme a LGPD.\n\n4.3 Autoridades Públicas\nOs dados poderão ser compartilhados com autoridades competentes quando exigido por lei ou ordem judicial.\n\n5. Armazenamento e Segurança dos Dados\nAdotamos medidas técnicas e administrativas adequadas para proteger os dados pessoais contra acesso não autorizado, perda, alteração ou divulgação indevida.Os dados são armazenados apenas pelo tempo necessário para cumprir suas finalidades legais e operacionais.\n\n6. Direitos do Titular dos Dados\nO usuário, como titular dos dados, pode a qualquer momento solicitar:\nConfirmação da existência de tratamento;\nAcesso aos dados;\nCorreção de dados incompletos ou desatualizados;\nExclusão de dados, quando legalmente possível;\nPortabilidade dos dados;\nRevogação do consentimento.As solicitações poderão ser feitas por meio dos canais oficiais da plataforma.\n\n7. Consentimento\nAo se cadastrar e utilizar a plataforma, o usuário consente de forma livre, informada e inequívoca com o tratamento de seus dados pessoais, conforme descrito nesta Política.\n\n8. Exclusão de Dados\nO usuário poderá solicitar a exclusão de sua conta. Alguns dados poderão ser mantidos para cumprimento de obrigações legais, prevenção a fraudes ou exercício regular de direitos.\n\n9. Alterações desta Política\nEsta Política de Privacidade pode ser atualizada a qualquer momento. A versão mais recente estará sempre disponível na plataforma, e o uso contínuo implica concordância com as alterações.\n\n10. Contato\nEm caso de dúvidas, solicitações ou reclamações relacionadas à privacidade e proteção de dados, o usuário pode entrar em contato pelo canal:\n📧 [E-MAIL DE CONTATO]\n📞 [TELEFONE DE CONTATO]',
                      style: context.cusotomFontes.regular.copyWith(
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
