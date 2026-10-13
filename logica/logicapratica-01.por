programa {
  funcao inicio() {
    inteiro caixas = 40
    inteiro qntCaixas, paletes, sobra
    real pesoCaixa, pesoTotal, temperatura

    escreva("Qual é a quantidade de caixas produzidas? ")
    leia(qntCaixas)
    escreva("Qual é o peso de cada caixa (kg)? ")
    leia(pesoCaixa)
    escreva("Qual é a temperatura da câmara (°C)? ")
    leia(temperatura)

    pesoTotal = qntCaixas * pesoCaixa
    paletes = qntCaixas / caixas
    sobra = qntCaixas % caixas

    escreva("\nPeso total produzido: ", pesoTotal)
    escreva("\nPaletes completos: ", paletes)
    escreva("\nCaixas que sobraram: ", sobra, "\n")

    se(temperatura <= -18 e paletes >= 1) {
      escreva("\nCarregamento liberado")
    } senao {
      se(temperatura > -18) {
        escreva("\nCarregamento bloqueado! Motivo do bloqueio: câmara acima de −18°C ")
      } senao {
        escreva("\nCarregamento bloqueado! Motivo do bloqueio: nenhum palete completo")
      }
    }
  }
}
