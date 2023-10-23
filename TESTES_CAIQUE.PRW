#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

USER FUNCTION TESTES_CAIQUE ()

LOCAL cCarinhadoTI1 := "CAIQUE"
LOCAL cCarinhadoTI2 := "RAFAEL"
local cChefedoti    := "LEONARDO"

    IF (cCarinhadoTI1 = cCarinhadoTI2)
    MSGALERT( "NÃO PODEM HAVER 2 CARINHAS DO TI", "TESTES_CAIQUE" )

    elseif (cCarinhadoTI1 != cCarinhadoTI2)
    MSGALERT( "O CARINHA DO TI VERDADEIRO É O:"+ cCarinhadoTI1,"TESTES_CAIQUE"  )
    ENDIF
    
    if cCarinhadoTI1 != cChefedoti .or. cCarinhadoTI2 != cChefedoti
        MSGALERT( "O CHEFE DO TI É:"+cChefedoti, "TESTES_CAIQUE" )    
    ENDIF

return
        