programa {
  inclua biblioteca Matematica
  funcao inicio() {
    real km, litro, preco, rendimento, custoDiesel, custoKm

    // Entrada
    escreva("Qual foi os km rodados? ")
    leia (km)
    escreva("Quantos litros foram consumidos? ")
    leia(litro)
    escreva("Qual é o preço do litro? R$")
    leia(preco)

    // Processamento
    rendimento = km / litro
    custoDiesel = litro * preco
    custoKm = custoDiesel / km

    rendimento = Matematica.arredondar(rendimento, 2)
    custoDiesel = Matematica.arredondar(custoDiesel, 2)
    custoKm = Matematica.arredondar(custoKm, 2)

    // Saída
    escreva("\nRendimento: ", rendimento, "km/l")
    escreva("\nCusto do Diesel: R$", custoDiesel)
    escreva("\nCusto por km: R$", custoKm)

    se(rendimento >= 0.8 e custoKm <= 9.00) {
      escreva("\n")
      escreva("Eficiente! ")
    } senao se(rendimento >= 0.6 e custoKm <= 9.00) {
      escreva("Aceitável! ")
    } senao {escreva("\nRevisar caminhão! ")}
  }
}