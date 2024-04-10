import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/presentation/themes/colors.dart';
import 'package:client.gogogo/presentation/themes/theme/app_theme.dart';

import '../../../themes/theme/custom_theme.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customTheme = AppTheme.customTheme;
    var theme = AppTheme.shoppingLightTheme;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img/png/bg_main.png',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          AppBar(
            surfaceTintColor: Colors.transparent,
            iconTheme: IconThemeData(color: theme.colorScheme.primary),
            backgroundColor: Colors.transparent,
            title: FxText.titleLarge('Términos y Condiciones',
                color: theme.colorScheme.primary),
          ),
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/img/png/logotipo_term.png',
                scale: 4.0,
              ),
              const SizedBox(
                height: 0,
              ),
              Expanded(
                child: Container(
                  color: theme.colorScheme.background,
                  child: FadedSlideAnimation(
                    beginOffset: const Offset(0.3, 0.3),
                    endOffset: const Offset(0, 0),
                    fadeCurve: Curves.easeInCubic,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '1. Descripción del Servicio:',
                          ),
                          subtitle: FxText.bodySmall(
                            "La plataforma logística Go-Go-Go.app es un servicio en línea que permite a los clientes encontrar y contratar servicios de transporte para sus mercancías. A través de la aplicación móvil o el sitio web, los clientes pueden acceder a una red de transportistas registrados y solicitar servicios de envío de carga.El operador de la plataforma es la empresa de capital ciento por ciento cubano ATHENDAT s.r.l., compañía que ofrece soluciones tecnológicas para potenciar los beneficios de otros negocios mediante plataformas digitales de gestión empresarial, comercio electrónico y operación logística. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '2. Registro y Cuenta de Usuario:',
                          ),
                          subtitle: FxText.bodySmall(
                            "Para utilizar Go-Go-Go.app, los clientes deben registrarse y crear una cuenta de usuario. Al registrarse, los clientes deben proporcionar información precisa y actualizada, incluyendo datos de contacto, detalles de la empresa (si aplica) y otra información necesaria para utilizar el servicio. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '3. Solicitud y Contratación de Servicios:',
                          ),
                          subtitle: FxText.bodySmall(
                            "Los clientes pueden enviar solicitudes para el transporte de carga a través de la plataforma. Al enviar una solicitud, el cliente deberá proporcionar detalles precisos sobre el tipo de carga, las dimensiones, el peso, las fechas y otras especificaciones relevantes. La plataforma conectará al cliente con los transportistas que puedan satisfacer sus necesidades. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '4. Responsabilidades del Cliente:',
                          ),
                          subtitle: FxText.bodySmall(
                            "El cliente es responsable de garantizar que la información proporcionada en la plataforma sea precisa y completa. Además, el cliente debe cumplir con las regulaciones y leyes aplicables en relación con la carga a transportar y debe asegurarse de tener los permisos y documentos necesarios. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '5. Tarifas y Pagos:',
                          ),
                          subtitle: FxText.bodySmall(
                            "Las tarifas de transporte se calcularán según la información proporcionada por el cliente. El cliente debe realizar el pago por adelantado para confirmar la reserva del servicio de transporte.  El monto pagado se retendrá y se abonará al transportista una vez completado el servicio. Los pagos se realizarán a través de métodos de pago seguros disponibles en la plataforma. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '6. Cancelaciones y Reembolsos:',
                          ),
                          subtitle: FxText.bodySmall(
                            "Si el cliente necesita cancelar un servicio de transporte, debe hacerlo de acuerdo con la política de cancelación de la plataforma . En caso de cancelación dentro de un plazo determinado, se aplicarán ciertas tarifas de cancelación. Los reembolsos se realizarán según lo establecido en la política de reembolsos de la plataforma. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '7. Privacidad y Protección de Datos:',
                          ),
                          subtitle: FxText.bodySmall(
                            "La plataforma protegerá la privacidad y los datos personales de los clientes de acuerdo con su política de privacidad. Los datos del cliente solo se utilizarán para fines relacionados con la prestación del servicio y no se compartirán con terceros sin el consentimiento del cliente, excepto cuando sea necesario para el cumplimiento de los servicios de transporte o petición judicial. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '8. Propiedad Intelectual:',
                          ),
                          subtitle: FxText.bodySmall(
                            "El cliente reconoce que todos los derechos de propiedad intelectual relacionados con la plataforma y su contenido son propiedad exclusiva de la empresa que opera la plataforma. Los clientes no pueden utilizar, copiar o distribuir ningún contenido de la plataforma sin autorización. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '9. Limitación de Responsabilidad:',
                          ),
                          subtitle: FxText.bodySmall(
                            "La empresa que opera la plataforma hará esfuerzos razonables para garantizar el correcto funcionamiento de la plataforma y la precisión de la información proporcionada. Sin embargo, no se responsabiliza por problemas técnicos, errores en los datos proporcionados por el cliente o el transportista, o cualquier pérdida o daño que pueda surgir del uso de la plataforma. ",
                          ),
                        ),
                        ListTile(
                          minLeadingWidth: 10,
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          leading: Icon(
                            Icons.circle,
                            size: 10,
                            color: theme.primaryColor,
                          ),
                          title: FxText.bodyLarge(
                            '10. Jurisdicción y Resolución de Disputas:',
                          ),
                          subtitle: FxText.bodySmall(
                            "Cualquier disputa que surja en relación con el uso de la plataforma estará sujeta a la jurisdicción de la Sala de lo Económico del Tribunal provincial de La Habana y será resuelta de acuerdo con las leyes cubanas. ",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
