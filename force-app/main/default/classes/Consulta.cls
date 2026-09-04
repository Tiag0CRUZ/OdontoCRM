public class Consulta {

    public static Boolean existeConflito(
        Id dentistaId,
        Date dataConsulta,
        Time horaConsulta,
        Id consultaAtualId
    ) {

        if (dentistaId == null || dataConsulta == null || horaConsulta == null) {
            return false;
        }

        List<Consulta__c> consultas = [
            SELECT Id
            FROM Consulta__c
            WHERE Dentista__c = :dentistaId
            AND Data_da_Consulta__c = :dataConsulta
            AND Hora_da_Consulta__c = :horaConsulta
            AND Id != :consultaAtualId
            LIMIT 1
        ];

        return !consultas.isEmpty();
    }
}