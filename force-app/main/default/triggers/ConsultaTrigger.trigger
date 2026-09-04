trigger ConsultaTrigger on Consulta__c (before insert, before update) {

    Set<Id> dentistaIds = new Set<Id>();
    Set<Date> datas = new Set<Date>();

    for (Consulta__c consulta : Trigger.new) {

        if (
            consulta.Dentista__c != null &&
            consulta.Data_da_Consulta__c != null &&
            consulta.Hora_da_Consulta__c != null
        ) {
            dentistaIds.add(consulta.Dentista__c);
            datas.add(consulta.Data_da_Consulta__c);
        }
    }

    if (dentistaIds.isEmpty() || datas.isEmpty()) {
        return;
    }

    List<Consulta__c> consultasExistentes = [
        SELECT Id,
               Dentista__c,
               Data_da_Consulta__c,
               Hora_da_Consulta__c
        FROM Consulta__c
        WHERE Dentista__c IN :dentistaIds
        AND Data_da_Consulta__c IN :datas
    ];

    Map<String, Consulta__c> consultasPorHorario = new Map<String, Consulta__c>();

    for (Consulta__c existente : consultasExistentes) {

        String chave =
            String.valueOf(existente.Dentista__c) +
            '-' +
            String.valueOf(existente.Data_da_Consulta__c) +
            '-' +
            String.valueOf(existente.Hora_da_Consulta__c);

        consultasPorHorario.put(chave, existente);
    }

    for (Consulta__c consulta : Trigger.new) {

        if (
            consulta.Dentista__c == null ||
            consulta.Data_da_Consulta__c == null ||
            consulta.Hora_da_Consulta__c == null
        ) {
            continue;
        }

        String chave =
            String.valueOf(consulta.Dentista__c) +
            '-' +
            String.valueOf(consulta.Data_da_Consulta__c) +
            '-' +
            String.valueOf(consulta.Hora_da_Consulta__c);

        if (consultasPorHorario.containsKey(chave)) {

            Consulta__c existente = consultasPorHorario.get(chave);

            // No update, não bloquear o próprio registro
            if (existente.Id != consulta.Id) {

                consulta.addError(
                    'Conflito de horário: este dentista já possui uma consulta neste horário.'
                );
            }
        }
    }
}