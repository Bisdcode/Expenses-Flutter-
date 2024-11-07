import 'package:flutter/material.dart';

//Chart bar é o componente que vai mostrar uma barra no grafico com o consumo semanal
class ChartBar extends StatelessWidget {
  // Como é um componente 'stateless', vai precisar de atributos de tipo 'final'
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Valor com dois digitos na casa decimal
        Container(
          height: 20, //definir altura fixa para as barras dos dias da semana
          child: FittedBox(
            //O fittedBox ajusta o tamanho de itens grandes (diminuindo a fonte), como uma compra de 100mil reais
            child: Text(
              // valor superior da barra
              '${value.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        SizedBox(height: 5), //espaçamento
        Container(
          height: 60,
          width: 10,
          child: Stack(
            //é um componente que permite voce colocar um componente em cima do outro
            //Aqui será feito toda a estrutura base da barra
            alignment: Alignment
                .bottomCenter, //ajusta a barra na posição de 'baixo para cima'
            children: [
              Container(
                // definir a estrutura da barra
                decoration: BoxDecoration(
                  //adicionando borda
                  border: Border.all(
                    color: Colors.grey, //cor da borda
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(
                      220, 220, 220, 1), //cor background 'interno' da barra
                  borderRadius: BorderRadius.circular(5), //arredondar borda
                ),
              ),
              FractionallySizedBox(
                //Caixa fracionada
                heightFactor: percentage, //o valor deve ser passado aqui
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        // Texto inferior com a incial do dia da semana
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
