! ============================================================================
!         REPRESENTACAO DE FUNCAO BIDIMENSIONAL UTILIZANDO ONDALETAS
! ============================================================================
!            Autor          |   Versao-Data  |   Detalhes     
!        K.Oliveira            1.0-25/02/2013  Fxy influenciada por j>>, Fxy>>
!
! =========================================================================
!                          SOBRE O PROGRAMA
! =========================================================================
! Busca-se representar a funcao 
!                    x*x+x+y+1 no intervalo x=[0,2] e y=[0,2] 
! graficamente utilizando o gnuplot para plotagem e a teoria de ondaletas bidimensionais.
! Eliminamos a contribuicao do somatorio correspondente a ondaleta mae e mantemos somente 
! o somatorio da ondaleta pai vertical.
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
                 sinal=2  ! Sinal de ondaleta mae vertical (2)
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
! ========================== SUBROTINAS MAE (PSI) ===============================
!
subroutine calculo_psiMi(sinal,x,y,j,k1,k2, psi_Mi )
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
!
subroutine calculo_integral_djk(sinal,j,k1,k2, psi_Mi, res)
  integer sinal
  real inicialx,finalx, inicialy,finaly, lim_psi1_3, lim_psi2_1, lim_psi2_2, lim_psi2_3
  real j,k1,k2, lim_psi_1, lim_psi_2, lim_psi_3, lim_phi_1, lim_phi_2, lim_psi1_1, lim_psi1_2
  res=0.;res1=0.; res2=0.; res3=0.;res4=0.
  rescalc1=0;rescalc2=0
  inicialx=0;finalx=0;inicialy=0;finaly=0

  select case (sinal)
  case (1)
     write(*,*)"rodou integral caso 1"
  case (2)
     lim_phi_1=((2**(-j))*k2)
     lim_phi_2=(2**(-j))*(k2+1)

     lim_psi_1=((2**(-j))*k1)
     lim_psi_2=(2**(-j))*(k1+0.5)
     lim_psi_3=(2**(-j))*(k1+1)

     ! *** Calculo da primeira integral com psi de 2^(-j)k a 2^(-j)(k+1/2) e phi 2^(-j)k a 2^(-j)(k+1) ***
     ! NOTA: A ordem da integracao se inverte
     ! ||| Limites da integral phi em relacao a Y |||
     if (lim_phi_1 .lt. 0)inicialy=0.
     if (lim_phi_1 .ge. 0 .and. lim_phi_1 .lt. 2)inicialy=lim_phi_1
     if (lim_phi_1 .ge. 2)rescalc1=1;res1=0.

     if (lim_phi_2 .le. 0)rescalc1=1;res1=0.
     if (lim_phi_2 .gt. 2)finaly=2.
     if (lim_phi_2 .gt. 0 .and. lim_phi_2 .le. 2)finaly=lim_phi_2

     ! ||| Limites da integral psi em relacao a X |||
     if (lim_psi_1 .lt. 0)inicialx=0.
     if (lim_psi_1 .ge. 0 .and. lim_psi_1 .lt. 2)inicialx=lim_psi_1
     if (lim_psi_1 .ge. 2)rescalc1=1;res1=0.

     if (lim_psi_2 .lt. 0.)finalx=0.
     if (lim_psi_2 .gt. 2)finalx=2.
     if (lim_psi_2 .ge. 0 .and. lim_psi_2 .le. 2)finalx=lim_psi_2

     if (rescalc1 .ne. 1) then
        ! ||| Calculo da integral dupla |||
        call integral(inicialx,inicialy,finalx,finaly, res1)
     endif

     ! *** Para a segunda integral com psi de 2^(-j)(k+1/2) a 2^(-j)(k+1) e phi 2^(-j)k a 2^(-j)(k+1) ***
     ! NOTA: Somente os limites de psi mudam. Integracao em x.
     inicialx=finalx

     if (lim_psi_3 .le. 0)rescalc2=2;res2=0.
     if (lim_psi_3 .gt. 2)finaly=2.
     if (lim_psi_3 .gt. 0 .and. lim_psi_3 .le. 2)finaly=lim_psi_3

     if (rescalc2 .ne. 1) then
        ! ||| Calculo da integral dupla |||
        call integral(inicialx,inicialy,finalx,finaly, res2)
     endif
     res=res1+res2
!     write(*,*)res
  case (3)
     write(*,*)"rodou integral caso 3"
  end select

  return
end subroutine calculo_integral_djk
