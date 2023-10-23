#include 'protheus.ch'
#include 'parmtype.ch'

user function VARIAVEL()
Local nNum := 66
Local lLogic := .T.
Local cCarac := "String"
Local dData := DATE()
Local aArray := {"Caique","Rafael","Leonardo"}
Local bBloco := {|| nValor := 2, MsgAlert( "O Numero é: " + cValToChar(nValor), )}

Alert(nNum)
Alert(lLogic)
Alert(cValToChar(cCarac))
Alert (dData)
Alert (aArray[1])
Eval(bBloco)

return
