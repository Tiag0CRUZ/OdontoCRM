# 🦷 OdontoCRM

Sistema de gestão de clínica odontológica desenvolvido na plataforma Salesforce como projeto de portfólio para demonstração de conhecimentos em desenvolvimento Salesforce.

## 🚀 Sobre o projeto

O OdontoCRM foi desenvolvido para simular a gestão de uma de uma agenda de clínicas odontológicas, permitindo o gerenciamento de pacientes, dentistas e consultas.

O projeto utiliza recursos da plataforma Salesforce combinando desenvolvimento declarativo e programático.

#Funcionalidades

- Cadastro e gerenciamento de pacientes
- Cadastro e gerenciamento de dentistas
- Cadastro e gerenciamento de consultas
- Relacionamento entre Pacientes, Dentistas e Consultas
- Controle de data e horário das consultas
- Validação de conflitos de horário
- Agenda personalizada
- Interface desenvolvida com Lightning Web Components
- Controller Apex para consulta dos dados
- Testes automatizados em Apex
- Aplicativo personalizado utilizando Lightning App Builder

#Arquitetura


                    OdontoCRM
                        │
              ┌─────────┴─────────┐
              │                   │
          Lightning App      Lightning Page
              │                   │
              │             Agenda OdontoCRM
              │                   │
              │              LWC agendaConsultas
              │                   │
              │             AgendaController
              │                   │
        ┌─────┴──────┐            │
        │            │            │
    Paciente      Dentista     Consulta

