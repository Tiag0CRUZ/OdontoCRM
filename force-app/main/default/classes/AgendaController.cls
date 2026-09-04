public with sharing class AgendaController {

    public class ConsultaAgenda {

        @AuraEnabled public Id id;
        @AuraEnabled public String nome;
        @AuraEnabled public String dentista;
        @AuraEnabled public String paciente;
        @AuraEnabled public String data;
        @AuraEnabled public String horario;
        @AuraEnabled public String tipo;
        @AuraEnabled public String status;

        public ConsultaAgenda(Consulta__c consulta) {

            id = consulta.Id;
            nome = consulta.Name;

            dentista = consulta.Dentista__r != null
                ? consulta.Dentista__r.Name
                : '';

            paciente = consulta.Paciente__r != null
                ? consulta.Paciente__r.Name
                : '';

            data = consulta.Data_da_Consulta__c != null
                ? consulta.Data_da_Consulta__c.format()
                : '';

            if (consulta.Hora_da_Consulta__c != null) {

                String horas = String.valueOf(
                    consulta.Hora_da_Consulta__c.hour()
                );

                String minutos = String.valueOf(
                    consulta.Hora_da_Consulta__c.minute()
                );

                if (horas.length() == 1) {
                    horas = '0' + horas;
                }

                if (minutos.length() == 1) {
                    minutos = '0' + minutos;
                }

                horario = horas + ':' + minutos;

            } else {

                horario = '';
            }

            tipo = consulta.Tipo_de_Consulta__c;
            status = consulta.Status_da_Consulta__c;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<ConsultaAgenda> buscarConsultas() {

        List<Consulta__c> consultas = [
            SELECT
                Id,
                Name,
                Dentista__r.Name,
                Paciente__r.Name,
                Data_da_Consulta__c,
                Hora_da_Consulta__c,
                Tipo_de_Consulta__c,
                Status_da_Consulta__c
            FROM Consulta__c
            ORDER BY Data_da_Consulta__c ASC,
                     Hora_da_Consulta__c ASC
        ];

        List<ConsultaAgenda> resultado =
            new List<ConsultaAgenda>();

        for (Consulta__c consulta : consultas) {
            resultado.add(
                new ConsultaAgenda(consulta)
            );
        }

        return resultado;
    }
}