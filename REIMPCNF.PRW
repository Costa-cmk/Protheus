#INCLUDE "RWMAKE.CH"   
#INCLUDE "MNT.CH"               
#INCLUDE "Protheus.ch"
// Função responsável por emitir a segunda via do comprovante de venda futura
User Function REIMPCNF(Cfilant,cCodVenda, cDataVenda)
    Local cMsgErro := ""
    Local LoadVendaFutura := (Cfilant,cCodVenda, cDataVenda)
    Local cConteudoComprovante := ""
    Local cCondIni             := ""//tag abertura para texto condensado
    Local cCondFim             := ""//tag fechamento para texto condensado
    Local nLarCup              := 47
    Local cLinha := Replicate("-",nLarCup)
    
    // Carrega a venda futura com base no código e na data fornecidos
    If ! LoadVendaFutura
        cMsgErro := "Erro ao carregar a venda futura."
    EndIf
    
        // Aqui você pode realizar as ações necessárias para emitir a segunda via do comprovante,
        // como construir o conteúdo do comprovante em uma string (cConteudoComprovante).
        // Comando para abrir a tabela SM0 "Cadastro de empresas"
        OpenSm0(Cfilant,.T.)
        //Verifica se a dados 
        if ! LoadVendaFutura
            /*SetPrinterMode(1, 1, .T.)*/
            cConteudoComprovante += cCondIni + PADC(AllTrim(SM0->M0_NOMECOM), nLarCup) + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + PADC(AllTrim(SM0->M0_ENDCOB), nLarCup) + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + PADC("CNPJ:" + AllTrim(SM0->M0_CGC) + Space(2) + "IE:" + AllTrim(SM0->M0_INSC) + Space(2) + "IM:" + AllTrim(SM0->M0_INSCM), nLarCup) + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + PADC("CNPJ:" + AllTrim(SM0->M0_CGC) + Space(2) + "IE:" + AllTrim(SM0->M0_INSC) + Space(2) + "IM:" + AllTrim(SM0->M0_INSCM), nLarCup) + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + cLinha + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + "     SAC: (11)2109-9199 ::: SAC@COPEL.COM.BR" + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + "              TELEVENDAS: 08000133433" + cCondFim + Chr(10)
            cConteudoComprovante += cCondIni + cLinha + cCondFim + Chr(10)    
            cConteudoComprovante+= 'Codigo         Descricao'+Chr(13)+Chr(10)
            cConteudoComprovante:= cConteudoComprovante+'Qtd             VlrUnit                 VlrTot  '+Chr(13)+Chr(10)
            cConteudoComprovante:= cConteudoComprovante+'------------------------------------------------'+Chr(13)+Chr(10)
        endif
        // Inicializa a impressora
       /* If !StartPrinter("MP-4200 TH")
            cMsgErro := "Erro ao iniciar a impressora."
        EndIf
        */
        // Envia o conteúdo do comprovante para a impressora
       If !WritePrinter(cConteudoComprovante)
            cMsgErro := "Erro ao enviar o comprovante para a impressora."
       EndIf
    
        // Finaliza a impressora
        EndPrinter()
        
    
Return cMsgErro
