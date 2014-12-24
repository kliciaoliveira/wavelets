! ============================================================================
!         REPRESENTACAO DE FUNCAO BIDIMENSIONAL UTILIZANDO ONDALETAS
! ============================================================================
!            Autor          |   Versao-Data  |   Detalhes     
!         K.Oliveira          0.1-04/02/2012   
!         K.Oliveira          0.2-23/03/2012   Plotagem incorreta. Correcoes.
!         K.Oliveira          0.3-17/04/2012   Testes nas integrais desde o dia 23.
!         K.Oliveira          0.4-06/05/2012
!         K.Oliveira          0.5-23/06/2012
!         K.Oliveira          0.7-10/07/2012   Duvida Integral

!
! =========================================================================
!                          SOBRE O PROGRAMA
! =========================================================================
! Busca-se representar a funcao 
!                    x*x+x+y+1 no intervalo x=[0,2] e y=[0,2] 
! graficamente utilizando o gnuplot para plotagem e a teoria de ondaletas bidimensionais.
!
!
program wavelet
  implicit none
  real j,k1,k2,l,x,y, min_Interv, max_Interv, somaPai, somaMae, fcPai, fcMae, Fxy
  real k_min, k_max, j_min, j_max,cjk,phi
  integer sinal
  OPEN(UNIT=3, FILE='wavebi.dat', STATUS='UNKNOWN')
  x=-1.                       ! Do's de varredura x-y
  do while (x .le. 3.0)
     y=-1.
     do while (y .le. 3.0)
        j_min=-4.
        j_max=4.
        k_min=-4.
        k_max=4.
        Fxy=0.
        somaPai=0. ; fcPai=0.
        somaMae=0. ; fcMae=0.
        l=j_min
        j=0.
        k1=k_min
        do while (k1 .le. k_max)
           k2=-1.
           do while (k2 .le. k_max)
              call calculo_phiMai(x,y,l,k1,k2, phi)
              call calculo_integral_clk(l,k1,k2, cjk)
              fcPai=cjk*(phi**2)   
              somaPai=somaPai+fcPai
              k2=k2+1.
           enddo
           k1=k1+1.
        enddo
        Fxy=somaPai
        write(3,*)x,y,Fxy           
        write(*,*)x,y,Fxy           
100     format(f20.20, f20.20, f20.20)
        y=y+0.01
     enddo
     x=x+0.01
  enddo
end program wavelet
!
!**************************************************************************************
!                                    SUBROTINAS
!**************************************************************************************
!
!   =========================== CALCULO DA INTEGRAL DUPLA =======================
!
subroutine integral(inicialx,inicialy,finalx,finaly, res)
  real inicialx,inicialy,finalx,finaly,res,parcial1,parcial2
  res=0. ;parcial1=0. ;parcial2=0.

  parcial1 = ((finalx-inicialx)/2)*(finaly**2)  + &
       (((finalx**3)/3) - ((inicialx**3)/3) + ((finalx**2)/2) - ((inicialx**2)/2) + finalx - inicialx)*finaly
  parcial2 = ((finalx-inicialx)/2)*(inicialy**2)  + (((finalx**3)/3) - ((inicialx**3)/3) + &
       ((finalx**2)/2) - ((inicialx**2)/2) + finalx - inicialx)*inicialy

  res=parcial1-parcial2
  return
end subroutine integral
!
! ============================= SUBROTINAS PAI (PHI) =============================  ! Checadas OK
!
subroutine calculo_pai(x,y,l,k1,k2, fcPai)             ! RETORNA O SOMATORIO 
  real j,k1,k2, fcPai, x, y, l
  call calculo_phiMai(x,y,l,k1,k2, phi)
  if (phi .ne. 0) then
     call calculo_integral_clk(l,k1,k2, cjk)           !cjk OK
     cjk=cjk*phi
     fcPai=cjk*phi
  else
     fcPai=0.
  endif
  return
end subroutine calculo_pai

subroutine calculo_phiMai(x,y,l,k1,k2, phi_lk)
  real x,y,l,k1,k2, phi_lk, phiX,phiY
  call calculo_phi(x,l,k1,phiX)
  call calculo_phi(y,l,k2,phiY)
  phi_lk=phiX*phiY
  return
end subroutine calculo_phiMai

subroutine calculo_integral_clk(j,k1,k2, res)
  real inicialx,inicialy,finalx,finaly
  real j,k1,k2, res
  A=((2**(-j))*k1)        ! A e B sao intervalos da primeira integracao em x
  B=(2**(-j))*(k1+1) 

  C=((2**(-j))*k2)       ! C e D sao intervalos da segunda integracao em y
  D=(2**(-j))*(k2+1)

  !/// Hipotese de integral nula se A-B e C-D nao forem intersecoes com o intervalo de 
  !    representacao x E [0,2] e y E [0,2]

  ! Teste para a primeira integral em x
  if (A .lt. 0)inicialx=0.
  if (A .ge. 0 .and. A .lt. 2)inicialx=A

  if (A .ge. 2)rescalc=1; res=0.
  if (B .le. 0)rescalc=1; res=0.

  if (B .gt. 2)finalx=2.
  if (B .gt. 0 .and. B .le. 2)finalx=B

  ! Teste para a segunda integral em y
  if (C .lt. 0)inicialy=0.
  if (C .ge. 0 .and. C .lt. 2)inicialy=C

  if (C .ge. 2)rescalc=1;res=0.
  if (D .le. 0)rescalc=1;res=0.

  if (D .gt. 2)finaly=2.
  if (D .gt. 0 .and. D .le. 2)finaly=D

  ! \\\ Fim da Hipotese

  if (rescalc .ne. 1) then
     call integral(inicialx,inicialy,finalx,finaly, res)
  endif

  return
end subroutine calculo_integral_clk

subroutine calculo_phi(t,j,k, phi) ! SUBROTINA OK =D
  real j,k,phi,t
  A=((2**(-j))*k)
  C=(2**(-j))*(k+1) 
  D=2**(j*0.5)
  phi=0.0
  if (t .ge. a .and. t .le. C) phi=D
  return
end subroutine calculo_phi
