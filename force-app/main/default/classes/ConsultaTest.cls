@IsTest
public class ConsultaTest {

    @IsTest
    static void testaConflitoDeConsulta() {

        Dentista__c dentista = new Dentista__c(
            Name = 'Dentista Teste',
            cro__c = 'CRO123456',
            Telefone__c = '92999999999'
        );
        insert dentista;

        Paciente__c paciente = new Paciente__c(
            Name = 'Paciente Teste',
            Data_de_nascimento__c = Date.newInstance(1990, 1, 1),
            Sexo__c = 'Masculino',
            Telefone__c = '92988888888'
        );
        insert paciente;

        Consulta__c consulta1 = new Consulta__c(
            Name = 'Consulta Teste 1',
            Dentista__c = dentista.Id,
            Paciente__c = paciente.Id,
            Data_da_Consulta__c = Date.newInstance(2026, 9, 1),
            Hora_da_Consulta__c = Time.newInstance(14, 0, 0, 0),
            Tipo_de_Consulta__c = 'Avaliação',
            Status_da_Consulta__c = 'Confirmada'
        );
        insert consulta1;

        Consulta__c consulta2 = new Consulta__c(
            Name = 'Consulta Teste 2',
            Dentista__c = dentista.Id,
            Paciente__c = paciente.Id,
            Data_da_Consulta__c = Date.newInstance(2026, 9, 1),
            Hora_da_Consulta__c = Time.newInstance(14, 0, 0, 0),
            Tipo_de_Consulta__c = 'Avaliação',
            Status_da_Consulta__c = 'Confirmada'
        );
        insert consulta2;

        // Verificar o conflito
        Boolean conflito = Consulta.existeConflito(
            dentista.Id,
            Date.newInstance(2026, 9, 1),
            Time.newInstance(14, 0, 0, 0),
            consulta2.Id
        );

        System.assertEquals(
            true,
            conflito,
            'Deveria detectar conflito de horário.'
        );
    }
}