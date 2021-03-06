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
  real j,k1,k2,l,x,y, j_min, j_max, somaPai, somaMae, fcPai, fcMae, Fxy, k_min, k_max
  real psi_Mi, djk
  integer sinal
  OPEN(UNIT=3, FILE='wavebi.dat', STATUS='UNKNOWN')
  x=0.                       ! Do's de varredura x-y
  do while (x .le. 2.0)
     y=0.
     do while (y .le. 2.0)
        ! Variacao de j
        j_min=-3.
        j_max=3.
        ! Variacao de k
        k_min=-6.
        k_max=6.
        Fxy=0.
        somaMae=0. ; fcMae=0. ; djk=0.
        j=j_min
        do while (j .le. j_max)
           k1=k_min             
           do while (k1 .le. k_max)
              k2=k_min
              do while (k2 .le. k_max)
                 sinal=1  ! Sinal de ondaleta mae vertical (2)
                 call calculo_psiMi(sinal,x,y,j,k1,k2, psi_Mi)           ! psiMi OK horizontal
                 call calculo_integral_djk(sinal,j,k1,k2, psi_Mi, djk)   ! horizontal ok
                 fcMae=(psi_Mi**2)*djk
 !               if ((x .eq. 0.) .and. (y .eq. 0.) .and. (k2 .eq. 1)) write(*,*)j, k1, k2, psi_Mi, djk, (psi_Mi**2), fcMae
                 somaMae=somaMae+fcMae
                 k2=k2+1.
              enddo
              k1=k1+1.
           enddo
           j=j+1.
        enddo
        Fxy=somaMae
        write(3,*)x,y,Fxy           
100     format(f20.20, f20.20, f20.20)
        y=y+0.01
     enddo
     x=x+0.01
     write(3,*)" "
  enddo
end program wavelet
!
!
! **************************************************************************************
!                                    SUBROTINAS
! **************************************************************************************
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
!
! ========================== SUBROTINAS ===============================
!
subroutine calculo_mae(sinal,x,y,j,k1,k2, fcMae)
  real j,x,y,k1,k2, djk, psi_Mi
  integer sinal
  external f
  call calculo_psiMi(sinal,x,y,j,k1,k2, psi_Mi)              !psiMi OK horizontal

  if (psi_Mi .ne. 0) then 
     call calculo_integral_djk(sinal,j,k1,k2, psi_Mi, djk)   ! horizontal ok
  else
     djk=0.
  endif
  fcMae=djk*psi_Mi
  return
end subroutine calculo_mae
!
subroutine calculo_psiMi(sinal,x,y,j,k1,k2, psi_Mi )
  integer sinal
  real x,y,j,k1,k2,psi_Mi
  select case (sinal)
  case (1)
     !Psi Horizontal
     call calculo_phi(x,j,k1,phiX)
     call calculo_psi(y,j,k2,psiY)
     psi_Mi=phiX*psiY
  case (2)
     !Psi Vertical
     call calculo_psi(x,j,k1,psiX)  
     call calculo_phi(y,j,k2,phiY)
     psi_Mi=psiX*phiY

  case (3)
     !Psi Diagonal
     call calculo_psi(x,j,k1,psiX)
     call calculo_psi(y,j,k2,psiY)
     psi_Mi=psiX*psiY
  end select
  return
end subroutine calculo_psiMi
!
subroutine calculo_psi(t,j,k, psi) ! SUBROTINA OK =D
  real j,k
  A=((2**(-j))*k)
  B=(2**(-j))*(k+0.5) 
  C=(2**(-j))*(k+1) 
  D=2**(j*0.5)
  psi=0.0
  if (t .ge. a .and. t .lt. b) psi=d
  if (t .ge. b .and. t .lt. c) psi=-d
  return
end subroutine calculo_psi
!subroutine calculo_psiMi(sinal,x,y,j,k1,k2, psi_Mi )
  integer sinal
  real x,y,j,k1,k2,psi_Mi
  psi_Mi=0.; psiX=0.; psiY=0.
  select case (sinal)
  case (1)
     write(*,*)"rodou1"
  case (2)
     !Psi Vertical
     call calculo_psi(x,j,k1,psiX)  
     call calculo_phi(y,j,k2,phiY)
     psi_Mi=psiX*phiY
  case (3)
     write(*,*)"rodou3"
  end select
  return
end subroutine calculo_psiMi
!
subroutine calculo_psi(t,j,k, psi) ! SUBROTINA OK =D
  real j,k
  psi=0.0
  A=((2**(-j))*k)
  B=(2**(-j))*(k+0.5) 
  C=(2**(-j))*(k+1) 
  D=2**(j*0.5)

  if (t .ge. a .and. t .lt. b) psi=d
  if (t .ge. b .and. t .lt. c) psi=-d
  return
end subroutine calculo_psi
!
subroutine calculo_phi(t,j,k, phi) ! SUBROTINA OK =D
  real j,k,phi,t
  A=((2**(-j))*k)
  C=(2**(-j))*(k+1) 
  D=2**(j*0.5)
  phi=0.0
  if (t .ge. a .and. t .le. C) phi=D
  return
end subroutine calculo_phi

subroutine calculo_integral_djk(sinal,j,k1,k2, psi_Mi, res)
  integer sinal
  real inicialx,finalx, inicialy,finaly, lim_psi1_3, lim_psi2_1, lim_psi2_2, lim_psi2_3
  real j,k1,k2, lim_psi_1, lim_psi_2, lim_psi_3, lim_phi_1, lim_phi_2, lim_psi1_1, lim_psi1_2
  res=0.;res1=0.; res2=0.; res3=0.;res4=0.
  rescalc1=0;rescalc2=0
  inicialx=0;finalx=0;inicialy=0;finaly=0

  select case (sinal)
  case (1)
     lim_phi_1=((2**(-j))*k1)
     lim_phi_2=(2**(-j))*(k1+1)

     lim_psi_1=((2**(-j))*k2)
     lim_psi_2=(2**(-j))*(k2+0.5)
     lim_psi_3=(2**(-j))*(k2+1)

     ! *** Calculo da primeira integral com psi de 2^(-j)k a 2^(-j)(k+1/2) e phi 2^(-j)k a 2^(-j)(k+1) ***
     ! ||| Limites da integral phi em relacao a x |||
     if (lim_phi_1 .lt. 0)inicialx=0.
     if (lim_phi_1 .ge. 0 .and. lim_phi_1 .lt. 2)inicialx=lim_phi_1
     if (lim_phi_1 .ge. 2)rescalc1=1;res1=0.

     if (lim_phi_2 .le. 0)rescalc1=1;res1=0.
     if (lim_phi_2 .gt. 2)finalx=2.
     if (lim_phi_2 .gt. 0 .and. lim_phi_2 .le. 2)finalx=lim_phi_2

     ! ||| Limites da integral psi em relacao a y |||
     if (lim_psi_1 .lt. 0)inicialy=0.
     if (lim_psi_1 .ge. 0 .and. lim_psi_1 .lt. 2)inicialy=lim_psi_1
     if (lim_psi_1 .ge. 2)rescalc1=1;res1=0.

     if (lim_psi_2 .lt. 0.)finaly=0.
     if (lim_psi_2 .gt. 2)finaly=2.
     if (lim_psi_2 .ge. 0 .and. lim_psi_2 .le. 2)finaly=lim_psi_2

     if (rescalc1 .ne. 1) then
        ! ||| Calculo da integral dupla |||
        call integral(inicialx,inicialy,finalx,finaly, res1)
     endif

     ! *** Para a segunda integral com psi de 2^(-j)(k+1/2) a 2^(-j)(k+1) e phi 2^(-j)k a 2^(-j)(k+1) ***
     inicialy=finaly

     if (lim_psi_3 .le. 0) rescalc2=1;res=0.
     if (lim_psi_3 .gt. 2) finaly=2.
     if (lim_psi_3 .gt. 0 .and. lim_psi_3 .le. 2) finaly=lim_psi_3

     if (rescalc2 .ne. 1) then
        ! ||| Calculo da integral dupla |||
         call integral(inicialx,inicialy,finalx,finaly, res2)
     endif
     res=psi_Mi*(res1+res2)

  case (2)
     write(*,*) "rodou caso 2"

  case (3)
     write(*,*) "rodou caso 3"

  end select

  djk=psi_Mi*res

  return
end subroutine calculo_integral_djk
