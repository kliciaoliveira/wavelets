! ============================================================================
!         VERIFICACAO DO CALCULO DA INTEGRAL DUPLA
! ============================================================================
!       Autor       |      Versao-Data  |   Detalhes     
!    K.Oliveira        1.0-23/03/2012     Testada e funcionando.
!
!
! =========================================================================
!               SOBRE O PROGRAMA
! =========================================================================
! Resolvemos analiticamente a integral dupla da funcao dxdy
!            x^2 + x + y + 1
! Parametros de entrada:
! inicialx - limite inicial em relacao a x
! finalx   - limite final em relacao a x
! finaly   - limite final em relacao a y
! inicialy - limite inicial em relacao a y
!
! Parametro de saida:
! res      - resultado da integracao
!
program integral
  implicit none

  real inicialx,inicialy,finalx,finaly,parcial1,parcial2,res


  write(*,*)"Entre com os limites de integracao inicial e final em x"
  read(*,*)inicialx,finalx

  write(*,*)"Entre com os limites de integracao inicial e final em y"
  read(*,*)inicialy,finaly

  res=0. ;parcial1=0. ;parcial2=0.
  parcial1 = ((finalx-inicialx)/2)*(finaly**2)  + &
       (((finalx**3)/3) - ((inicialx**3)/3) + ((finalx**2)/2) - ((inicialx**2)/2) + finalx - inicialx)*finaly
  parcial2 = ((finalx-inicialx)/2)*(inicialy**2)  + (((finalx**3)/3) - ((inicialx**3)/3) + &
       ((finalx**2)/2) - ((inicialx**2)/2) + finalx - inicialx)*inicialy

  res=parcial1-parcial2

 write(*,*)"O resultado da integracao eh ", res

end program integral
