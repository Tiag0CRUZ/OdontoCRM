import { LightningElement, wire } from 'lwc';
import buscarConsultas from '@salesforce/apex/AgendaController.buscarConsultas';

export default class AgendaConsultas extends LightningElement {

    consultas = [];
    erro;

    @wire(buscarConsultas)
    resultadoConsultas({ data, error }) {

        if (data) {
            this.consultas = data;
            this.erro = undefined;

            console.log('Consultas carregadas:', data);

        } else if (error) {
            this.consultas = [];
            this.erro = error;

            console.error('Erro ao buscar consultas:', error);
        }
    }
}