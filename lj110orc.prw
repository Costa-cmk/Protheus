#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'   
#INCLUDE "TBICONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ LJ110ORC ³ Autor ³Alexandre Venancio     ³ Data ³18/05/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina para preenchimento de orçamentos em loja.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function LJ110ORC()

Local nOpc			:= 0
Private cUnidade		:= ""            
Private aList		:= {}
Private naVista 	:= 0
Private naPrazo 	:= 0
Private cCliente    := space(80)
Private cEmail	 	:= space(50)
Private cDDD		:= space(3)
Private cTelefone	:= space(10) 
Private cVendedor	:= space(25)

SetPrvt("oDlg1","oBmp1","oGrp1","oSay1","oSay2","oSay3","oGet1","oGet2","oGet3","oGet4","oGrp2","oBrw1","oSay9","oBtn3")
SetPrvt("oSay4","oSay5","oGet5","oGet6","oGrp4","oSay6","oSay7","oSay8","oGet7","oBtn1","oBtn2","oList","oSay10","oBtn4")

//PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01" MODULO "FAT" TABLES "SB1"

cUnidade := Posicione("SZT",2,xFilial("SZT")+CFILANT,"ZT_UNIDNEG")
 
Aadd(aList,{'','',0,0,0})  

oDlg1      := MSDialog():New( 095,232,701,924,"Orçamento Conforto",,,.F.,,,,,,.T.,,,.T. )

	If empty(cUnidade) .Or. cUnidade $ "CO/IN"
		oBmp1      := TBitmap():New( 008,008,060,040,,"copel-grande.png",.F.,oDlg1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
    Else
    	oBmp1      := TBitmap():New( 008,008,060,040,,"classe-a-grande.png",.F.,oDlg1,,,.F.,.T.,,"",.T.,,.T.,,.F. )
    EndIF
    
oGrp1      := TGroup():New( 008,076,048,336,"Dados do Cliente",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 020,084,{||"Cliente:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oGet1      := TGet():New( 020,108,{|u| If(PCount()>0,cCliente:=u,cCliente)},oGrp1,220,006,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

	oSay2      := TSay():New( 034,084,{||"Email:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oGet2      := TGet():New( 034,108,{|u| If(PCount()>0,cEmail:=u,cEmail)},oGrp1,112,006,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

	oSay3      := TSay():New( 034,224,{||"Tel.:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
	oGet3      := TGet():New( 034,238,{|u| If(PCount()>0,cDDD:=u,cDDD)},oGrp1,026,006,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet4      := TGet():New( 034,266,{|u| If(PCount()>0,cTelefone:=u,cTelefone)},oGrp1,060,006,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

oGrp2      := TGroup():New( 056,008,212,336,"Orçamento",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )          
	
	
   	oList := TCBrowse():New( 068 , 016, 315, 130,, {'Produto','Descrição','Qtd','Preço Unit.','Total'},{80,100,30,50,50},;
                            oGrp2,,,,{|| },{||editcol()},,,,,  ,,.F.,,.T.,,.F.,,, )

    oList:SetArray(aList)
	oList:bLine := {||{aList[oList:nAt,01],;
                        aList[oList:nAt,02],;
                        TRANSFORM(aList[oList:nAt,03],"@R 999"),; 
                        TRANSFORM(aList[oList:nAt,04],"@E 999,999.99"),;
                        TRANSFORM(aList[oList:nAt,05],"@E 999,999.99")}}
	
	oSay9      := TSay():New( 202,180,{||"TOTAL"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,080,008)
	
	oBtn3      := TButton():New( 060,140,"+",oDlg1,{||Adiclin()},037,008,,,,.T.,,"",,,,.F. )
	oBtn4      := TButton():New( 060,200,"-",oDlg1,{||Exclin()},037,008,,,,.T.,,"",,,,.F. )
                        
oGrp3      := TGroup():New( 220,008,272,168,"Condição de Pagamento",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay4      := TSay():New( 234,048,{||"À Vista"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
    oGet5      := TGet():New( 234,080,{|u| If(PCount()>0,naVista:=u,naVista)},oGrp3,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
    
	oSay5      := TSay():New( 254,048,{||"À Prazo"},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
	oGet6      := TGet():New( 254,080,{|u| If(PCount()>0,naPrazo:=u,naPrazo)},oGrp3,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
    
oGrp4      := TGroup():New( 220,176,272,336,"Validade",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay6      := TSay():New( 236,196,{||"Orçamento Válido"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
	oSay7      := TSay():New( 236,260,{||cvaltochar(dDataBase+5)},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

	oSay8      := TSay():New( 254,196,{||"Vendedor"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oGet7      := TGet():New( 254,260,{|u| If(PCount()>0,cVendedor:=u,cVendedor)},oGrp4,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

oBtn1      := TButton():New( 280,104,"Confirmar",oDlg1,{||oDlg1:end(nOpc:=1)},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 280,184,"Sair",oDlg1,{||oDlg1:end(nOpc:=0)},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.) 

If nOpc == 1 
	OrcClasA()
EndIF
                        
//Reset Environment

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJ110ORC  ºAutor  ³Microsiga           º Data ³  05/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function editcol()

Local aArea := GetArea()
          
ConPad1(,,,"SB1",,,.F.)  
aList[oList:nAt,1] := SB1->B1_COD
aList[oList:nAt,2] := SB1->B1_DESC                                                              

/*If cUnidade != "CA"*/
	aList[oList:nAt,4] := Posicione("DA1",1,xFilial("DA1")+'001'+aList[oList:nAt,1],"DA1_PRCVEN")
/*Else
	aList[oList:nAt,4] := Posicione("DA1",1,xFilial("DA1")+'002'+aList[oList:nAt,1],"DA1_PRCVEN")
EndIf*/

aList[oList:nAt,5] := aList[oList:nAt,4]

oList:refresh()
oDlg1:refresh()

While aList[oList:nAt,03] < 1
	lEditCell(aList,oList,'@E 999',3)
EndDo

aList[oList:nAt,5] := aList[oList:nAt,4] * aList[oList:nAt,3] 
 
CondPg()
                                                             
oList:refresh()
oDlg1:refresh()

RestArea(aArea)

Return                  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJ110ORC  ºAutor  ³Microsiga           º Data ³  05/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CondPg()

Local aArea 	:= GetArea()
Local nX		:= 0
Local nSoma     := 0

For nX := 1 to len(aList)	
	nSoma += aList[nX,05]
Next nX

//naVista := nSoma - (nSoma*0.05)
//naPrazo := nSoma / 12
 
oSay9:setText("")
//oSay10:setText("")
oSay9:setText("R$ "+Transform(nSoma,"@E 999,999.99"))
//oSay10:setText("12 parcelas de R$ "+Transform(naPrazo,"@E 999,999.99"))*/

RestArea(aArea)

Return                                

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJ110ORC  ºAutor  ³Microsiga           º Data ³  05/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Adiclin()

Aadd(aList,{'','',0,0,0})
ASIZE(aList,LEN(aList))

    oList:SetArray(aList)
	oList:bLine := {||{aList[oList:nAt,01],;
                        aList[oList:nAt,02],;
                        TRANSFORM(aList[oList:nAt,03],"@R 999"),; 
                        TRANSFORM(aList[oList:nAt,04],"@E 999,999.99"),;
                        TRANSFORM(aList[oList:nAt,05],"@E 999,999.99")}}
	oList:refresh()
	oDlg1:refresh() 
	oList:nAt := len(aList)
	editcol()              
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJ108NFTR ºAutor  ³Alexandre           º Data ³  05/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Exclui a linha marcada no grid                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Exclin()

ADEL(aList,oList:nAt)     
ASIZE(aList,LEN(aList)-1)

If len(aList) < 1
	Aadd(aList,{'','',0,0,0})
EndIf
    oList:nAt:=1
    oList:SetArray(aList)
	oList:bLine := {||{aList[oList:nAt,01],;
                        aList[oList:nAt,02],;
                        TRANSFORM(aList[oList:nAt,03],"@R 999"),; 
                        TRANSFORM(aList[oList:nAt,04],"@E 999,999.99"),;
                        TRANSFORM(aList[oList:nAt,05],"@E 999,999.99")}}

 						 
oList:refresh()
oDlg1:refresh()
	          
Return                                                                

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJ110ORC  ºAutor  ³Microsiga           º Data ³  05/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function OrcClasA()

Local cHtml 
Local cPasta 	:= GetTempPath()
Local cArquivo 	:= "relatorio_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + ".html"
Local cEndereco := Capital(ALLTRIM(FWSM0Util():GetSM0Data()[15][2]))
Local cBairro 	:= Capital(ALLTRIM(FWSM0Util():GetSM0Data()[17][2]))
Local cTelemp	:= ALLTRIM(FWSM0Util():GetSM0Data()[7][2])
Local nCep		:= TRANSFORM(FWSM0Util():GetSM0Data()[20][2],"@R 99999-999")
Local ntotal	:= 0
Local nX 		:= 0
/*
cHtml := "<html>
cHtml += "<body text='#000000' leftmargin='10' topmargin='10' marginwidth='0' marginheight='0' bgcolor='#FFFFFF'>
cHtml += "<table width='700' cellspacing='0' cellpadding='0' height='180' border='1'>
cHtml += "  <tr> 
cHtml += "    <td width='480' height='155' bordercolor='#000000'> 
	if CFILANT == "45"
	CpyS2T(GetSrvProfString("StartPath","")+"classe-a-grande.png",GetTempPath(),.F.,.F.)
	cHtml += "      <p align='center'><img src='"+GetTempPath()+"\classe-a-grande.png' width='380' height='155'></p>
	else
	CpyS2T(GetSrvProfString("StartPath","")+"copel-grande.png",GetTempPath(),.F.,.F.)
	cHtml += "      <p align='center'><img src='"+GetTempPath()+"\copel-grande.png' width='380' height='155'></p>
	Endif
cHtml += "    </td>
cHtml += "    <td rowspan='2' height='120' bgcolor='#000000' width='220'> 
cHtml += "      <div align='center'><font size='4' face='Verdana, Arial, Helvetica, sans-serif' color='#FFFFFF'>TELEVENDAS</font><font size='3' face='Verdana, Arial, Helvetica, sans-serif' color='#FFFFFF'><br>
cHtml += "        <font size='+3'>"+cTelefone+"</font></font></div>
cHtml += "    </td>
cHtml += "  </tr>
cHtml += "  <tr> 
cHtml += "    <td width='480' height='25' bordercolor='#000000'>     

//Endereço da Loja
cHtml += "      <div align='center'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'>"+cEndereco+" - "+cBairro +" - "+nCep+"</font> 
cHtml += "      </div>
cHtml += "    </td>
cHtml += "  </tr>
cHtml += "</table>
cHtml += "<br>
cHtml += "<table width='700' border='1' cellspacing='0' cellpadding='0' height='20' bordercolor='#000000' bgcolor='#000000'>
cHtml += "  <tr align='left' valign='middle' bordercolor='#FFFFFF' bgcolor='#FFFFFF'> 
cHtml += "    <td height='20' bgcolor='#FFFFFF' bordercolor='#000000'>
cHtml += "      <div align='center'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'><b><i><font color='#000000'>2&ordf; 
cHtml += "        a 6&ordf; das 08h30 as 20h00 ::: S&aacute;bado das 08h30 as 19h00 ::: 
cHtml += "        Domingo das 10h30 as 19h00</font></i></b></font></div>
cHtml += "    </td>
cHtml += "  </tr>
cHtml += "</table>
cHtml += "<br>
cHtml += "<table width='700' border='0' cellspacing='0' cellpadding='0'>
cHtml += "  <tr valign='middle'>       
                                                                       
//Cliente
cHtml += "    <td height='30' width='454'><font size='1' face='Verdana, Arial, Helvetica, sans-serif'>Cliente: "+alltrim(upper(cCliente))
cHtml += "      </font></td>
//Telefone
cHtml += "    <td height='30' width='226'><font size='1' face='Verdana, Arial, Helvetica, sans-serif'>Tel.:"+alltrim(cDDD)+"-"+alltrim(cTelefone)+"</font></td>
cHtml += "  </tr>
//Email
cHtml += "  <tr valign='middle'> 
cHtml += "    <td height='30' colspan='2'><font size='1' face='Verdana, Arial, Helvetica, sans-serif'>e-mail: "+alltrim(cEmail)+"</font></td>"
cHtml += "  </tr>
cHtml += "</table>


cHtml += "<br>
cHtml += "<table width='700' border='1' cellspacing='0' cellpadding='0' height='40' bordercolor='#000000'>
cHtml += "  <tr align='left' valign='middle'> 
cHtml += "    <td height='15' width='50'> 
cHtml += "      <div align='center'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'>QTD</font></div>
cHtml += "    </td>
cHtml += "    <td height='15' width='480'> 
cHtml += "      <div align='center'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'>Descri&ccedil;&atilde;o 
cHtml += "        do Produto</font></div>
cHtml += "    </td>
cHtml += "    <td height='15' width='150'> 
cHtml += "      <div align='center'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'>Valor 
cHtml += "        Total </font></div>
cHtml += "    </td>
cHtml += "  </tr>

For nX := 1 to len(aList)
	cHtml += "  <tr align='left' valign='middle'>
	//Qtd
	cHtml += "    <td height='25' width='50'>"+cvaltochar(aList[nX,03])+"</td>
	//Descricao
	cHtml += "    <td height='25' width='480'>"+alltrim(aList[nX,02])+"</td>"  // &nbsp;
	//Valor Total
	cHtml += "    <td height='25' width='150'>"+"R$"+TRANSFORM(aList[nX,05],"@E 999,999.99")+"</td>
	cHtml += "  </tr>
Next nX	
cHtml += "</table>

cHtml += "<table width='700' border='0' height='25'>
cHtml += "  <tr> 
cHtml += "    <td width='50' height='25'> 
cHtml += "      <div align='right'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'></font></div>
cHtml += "    </td>
cHtml += "    <td width='480' height='25' bgcolor='#FFFFFF'> 
cHtml += "      <div align='right'><font size='2' face='Verdana, Arial, Helvetica, sans-serif'><b>TOTAL</b></font> 
cHtml += "      </div>
cHtml += "    </td>

//Total
cHtml += "    <td width='150' height='25' bgcolor='#CCCCCC'>&nbsp;</td>
cHtml += "  </tr>

cHtml += "</table>

cHtml += "<br>
cHtml += "<table width='400' border='0' cellspacing='0' cellpadding='0' height='120'>
cHtml += "  <tr valign='middle'> 
cHtml += "    <td height='110' width='170' bgcolor='#CCCCCC' rowspan='3'> 
cHtml += "      <div align='center'><font size='2' color='#000000'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><b>TUDO 
cHtml += "        EM 12 VEZES<br>
cHtml += "        <br>
cHtml += "        SEM JUROS NO<br>
cHtml += "        <br>
cHtml += "        CART&Atilde;O DE CR&Eacute;DITO</b></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='110' rowspan='3' width='10'>&nbsp;</td>
cHtml += "    <td height='49' width='123' bgcolor='#FFFFFF' bordercolor='#000000'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'><b><i>Entregamos 
cHtml += "        em<br>
cHtml += "        todo o Brasil*</i></b></font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='49' width='2' bgcolor='#000000'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'></font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='49' width='123' bgcolor='#FFFFFF'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'><i>Atendimento<br>
cHtml += "        Personalizado</i> </font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='110' width='2' rowspan='3' bgcolor='#FFFFFF'>&nbsp;</td>
cHtml += "  </tr>
cHtml += "  <tr valign='middle'> 
cHtml += "    <td height='2' width='55' bgcolor='#FFFFFF' bordercolor='#000000'>&nbsp;</td>
cHtml += "    <td height='2' width='2' bgcolor='#FFFFFF'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'></font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='2' width='55' bgcolor='#FFFFFF' bordercolor='#000000'>&nbsp;</td>
cHtml += "  </tr>
cHtml += "  <tr valign='middle'> 
cHtml += "    <td height='49' width='123' bgcolor='#FFFFFF' bordercolor='#FFFFFF'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'><i>Maior 
cHtml += "        variedade<br>
cHtml += "        de marcas</i></font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='49' width='2' bgcolor='#000000'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'></font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "    <td height='49' width='123' bgcolor='#FFFFFF'> 
cHtml += "      <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif'><font face='Verdana, Arial, Helvetica, sans-serif'><font size='2'><font size='2'><font color='#000000'><b><i>Linhas<br>
cHtml += "        Exclusivas</i></b></font></font></font></font></font></div>
cHtml += "    </td>
cHtml += "  </tr>
cHtml += "</table>

//cHtml += "<div id='Layer1' style='position:absolute; left:223px; top:556px; width:248px; height:28px; z-index:1'> 
cHtml += "  <table width='230' border='0' height='21'>
cHtml += "    <tr> 
cHtml += "      <td height='15'> 
cHtml += "        <div align='right'><font size='1' face='Verdana, Arial, Helvetica, sans-serif'><b>*</b> 
cHtml += "          Consulte pre&ccedil;os</font></div>
cHtml += "      </td>
cHtml += "    </tr>
cHtml += "  </table>
//cHtml += "</div>

//cHtml += "<div id='lojas' style='position:absolute; left:471px; top:434px; width:248px; height:107px; z-index:1'> 
cHtml += "  <table width='230' border='1' height='120' cellpadding='0' cellspacing='0' bordercolor='#000000' bgcolor='#000000'>

//Telefone da Loja
cHtml += "    <tr> 
cHtml += "      <td width='65' height='30' bgcolor='#FFFFFF'> 
cHtml += "        <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif' size='1'><font color='#000000'>Telefone<br>
cHtml += "          da Loja</font></font></div>
cHtml += "      </td>
cHtml += "      <td width='155' height='30' bgcolor='#FFFFFF'> 
cHtml += "        <div align='center'></div>
cHtml += "      </td>
cHtml += "    </tr>

//Validade
cHtml += "    <tr> 
cHtml += "      <td width='65' height='30' bgcolor='#FFFFFF'> 
cHtml += "        <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif' size='1'><font color='#000000'>Validade 
cHtml += "          do or&ccedil;amento</font></font></div>
cHtml += "      </td>
cHtml += "      <td width='165' height='40' bgcolor='#FFFFFF'> 
cHtml += "        <div align='center'>"+cvaltochar(dDataBase+5)+"</div>
cHtml += "      </td>
cHtml += "    </tr>

//Vendedor
cHtml += "    <tr> 
cHtml += "      <td width='65' height='30' bgcolor='#FFFFFF'> 
cHtml += "        <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif' size='1'><font color='#000000'>Vendedor</font></font></div>
cHtml += "      </td>
cHtml += "      <td width='155' height='30' bgcolor='#FFFFFF'> 
cHtml += "        <div align='center'><font face='Verdana, Arial, Helvetica, sans-serif' size='1'>"+cVendedor+"</font></div>
cHtml += "      </td>
cHtml += "    </tr>
cHtml += "  </table>
//cHtml += "</div>
cHtml += "</body>
cHtml += "</html>
*/

cHtml := "<!DOCTYPE html>"
cHtml += "<html lang='pt-BR'>"
cHtml += "<head>"
cHtml += "<meta charset='UTF-8'>"
cHtml += "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
cHtml += "<title>Orcamento Copel</title>"
cHtml += "<style>"
cHtml += "body {"
cHtml += "    background-color: white;"
cHtml += "    font-family: Arial, sans-serif;"
cHtml += "    font-size: 25px;"
cHtml += "}"
cHtml += "table {"
cHtml += "    border-collapse: collapse;"
cHtml += "    width: 100vw;"
cHtml += "    max-width: 21cm; /* Tamanho da página A4 */"
cHtml += "}"
cHtml += "th, td {"
cHtml += "    border: 1px solid #dddddd;"
cHtml += "    text-align: left;"
cHtml += "    padding: 8px;"
cHtml += "}"
cHtml += "tr:nth-child(even) {"
cHtml += "    background-color: #f2f2f2;"
cHtml += "}"
cHtml += "h1, p {"
cHtml += "    color: black;"
cHtml += "}"
cHtml += "h1 {"
cHtml += "    font-family: Verdana, sans-serif;"
cHtml += "}"
cHtml += ".contact-info p {"
cHtml += "    font-size: 25px;"
cHtml += "}"
cHtml += ".contact-info .phone {"
cHtml += "    color: black;"
cHtml += "    font-size: 25px;"
cHtml += "}"
cHtml += ".logo img {"
cHtml += "    max-width: 100%;"
cHtml += "    height: auto;"
cHtml += "}"
cHtml += "</style>"
cHtml += "</head>"
cHtml += "<body>"

cHtml += "<table>"
cHtml += "<tr>"
cHtml += "<td colspan='2' class='logo'>"

// Logo
if CFILANT == "45"
    CpyS2T(GetSrvProfString("StartPath","")+"classe-a-grande.png",GetTempPath(),.F.,.F.)
    cHtml += "<p align='left'><img src='"+GetTempPath()+"\classe-a-grande.png'></p>"
else
    CpyS2T(GetSrvProfString("StartPath","")+"copel-grande.png",GetTempPath(),.F.,.F.)
    cHtml += "<p align='left'><img src='"+GetTempPath()+"\copel-grande.png'></p>"
endif
cHtml += "</td>"
cHtml += "<td class='contact-info'>"

// Informações de contato
cHtml += "<p>TELEVENDAS: <span class='phone'>" + cTelemp + "</span></p>"
cHtml += "<p>" + cEndereco + ", " + cBairro + " - " + nCep + "</p>"
cHtml += "</td>"
cHtml += "</tr>"

// Cabeçalho
cHtml += "<tr>"
cHtml += "<td colspan='3'>"
cHtml += "<h1>Orcamento</h1>"
cHtml += "</td>"
cHtml += "</tr>"

// Informações do cliente
cHtml += "<tr>"
cHtml += "<td colspan='3'>"
cHtml += "<section class='client-info'>"
cHtml += "<p>Cliente: <span>" + cCliente + "</span></p>"
cHtml += "<p>Tel.: <span>(" + cDDD + ") " + cTelefone + "</span></p>"
cHtml += "<p>e-mail: <span>" + cEmail + "</span></p>"
cHtml += "</section>"
cHtml += "</td>"
cHtml += "</tr>"

// Lista de produtos
cHtml += "<tr>"
cHtml += "<td colspan='3'>"
cHtml += "<section class='product-list'>"
cHtml += "<table>"
cHtml += "<thead>"
cHtml += "<tr>"
cHtml += "<th>Qtd</th>"
cHtml += "<th>Descricao do Produto</th>"
cHtml += "<th>Valor Total</th>"
cHtml += "</tr>"
cHtml += "</thead>"
cHtml += "<tbody>"

For nX := 1 to len(aList)
    cHtml += "<tr>"
    cHtml += "<td>" + cvaltochar(aList[nX,03]) + "</td>"
    cHtml += "<td>" + alltrim(aList[nX,02]) + "</td>"
    cHtml += "<td>R$ " + TRANSFORM(aList[nX,05], "@E 999,999.99") + "</td>"
    cHtml += "</tr>"
Next nX

cHtml += "</tbody>"
cHtml += "</table>"
cHtml += "</section>"
cHtml += "</td>"
cHtml += "</tr>"

// Total
For nX := 1 to len(aList)
    cValor := cValToChar(aList[nX,05])
    ntotal += Val(cValor)
Next nX

cHtml += "<tr>"
cHtml += "<td colspan='3'>"
cHtml += "<section class='total'>"
cHtml += "<p>TOTAL: R$ " + TRANSFORM(ntotal, "@E 999,999.99") + "</p>"
cHtml += "</section>"
cHtml += "</td>"
cHtml += "</tr>"

cHtml += "</table>"
cHtml += "</body>"
cHtml += "</html>"



MemoWrite(cPasta + cArquivo, cHtml)
ShellExecute("OPEN", cArquivo, "", cPasta, 1)

Return
