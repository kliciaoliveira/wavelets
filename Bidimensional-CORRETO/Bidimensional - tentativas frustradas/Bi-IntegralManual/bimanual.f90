! ------------------------------------------------------------------------------
!         REPRESENTACAO DE FUNCAO BIDIMENSIONAL UTILIZANDO ONDALETAS
! ------------------------------------------------------------------------------
!            Autor        |   Versao-Data  |   Detalhes     
!         K.Oliveira        1.1-30/08/2012   A integral sera feita teoricamente, considerando o somatorio 
!                                            do espaco a intervalos definidos. Nesse caso, 4 divisões em X e Y
!
! ------------------------------------------------------------------------------
!                          SOBRE O PROGRAMA
! ------------------------------------------------------------------------------
! Busca-se representar a funcao    x*x+x+y+1 no intervalo x=[0,2] e y=[0,2] 
! graficamente utilizando o gnuplot para plotagem e a teoria de ondaletas bidimensionais.
! A idéia no entanto é aproximar as integrais djk e clk a seus equivalentes numéricos con-
! siderando-se pequenos paralelepípedos de altura g(x,y), sendo g(x,y) o argumento da integral.
!
program wavelet
  implicit none
  real j,k1,k2,l,x,y, min_Interv, max_Interv, somaPai, somaMae, fcPai, fcMae, Fxy
  real min_k, max_k
  integer sinal
  OPEN(UNIT=3, FILE='wavebi.dat', STATUS='UNKNOWN')

  x=-.5                       ! Do's de varredura x-y
  do while (x .le. 2.5)
     y=-.5
     do while (y .le. 2.5)
!Intervalos j
        min_Interv=-4.    
        max_Interv=4.
!Intervalos de k1 e k2
        min_k=-2.
        max_k=2.
        if ((x .ge. -1. .and. x .le. 3.) .and. (y .ge. -1. .and. y .le. 3.)) then
           Fxy=0.
           somaPai=0. ; fcPai=0.
           somaMae=0. ; fcMae=0.
           l=min_Interv
           k1=min_k
           do while (k1 .le. max_k)
              k2=min_k
              do while (k2 .le. max_k)
                 call calculo_pai(x,y,l,k1,k2, fcPai)
                 somaPai=somaPai+fcPai
                 k2=k2+1.
              enddo
              k1=k1+1.
           enddo
           j=l
           do while (j .le. max_interv)
              k1=min_k
              do while (k1 .le. max_k)
                 k2=min_k
                 do while (k2 .le. max_k)
                    do sinal=1,3  ! |||| Sinal de ondaleta mae horizontal (1), vertical (2) e diagonal (3) ||||
                       call calculo_mae(sinal,x,y,j,k1,k2, fcMae) !Psi
                       somaMae=somaMae+fcMae
                    enddo
                    k2=k2+1.
                 enddo
                 k1=k1+1.
              enddo
              j=j+1.
           enddo
           Fxy=somaPai+somaMae
           write(3,*)x,y,Fxy           
!           write(*,*)x,y,Fxy
100        format(f20.20, f20.20, f20.20)
        else
           Fxy=0.
           write(3,*)x,y,Fxy
        endif
        y=y+0.1
     enddo
     x=x+0.1
  enddo
end program wavelet
!
!**************************************************************************************
!                                    SUBROTINAS
!**************************************************************************************
!   =========================== CALCULO DA INTEGRAL DUPLA =======================
!
subroutine integral(num_int,l,j,k1,k2, res)
  integer parts, num_int
  real g,res, res_p, pXi, j, k1, k2, l, func, phiX, phiY, psiX, psiY
  real x_aux, y_aux, div, area
  parts=128
! Para mudar o refinamento da integral, mudar o valor de "parts"
! "parts" deve ser exponencial de 2
  div=2./real(parts)
  area=div*div
  
  res=0.; phiX=0.; phiY=0.; psiX=0.; psiY=0.
  pXi=0.; x_aux=0.
  res_p=0.
  do while (x_aux .le. 2.)
     y_aux=0.
     do while (y_aux .le. 2.)
        func=(x_aux*x_aux + x_aux + y_aux + 1)
        res_p=func*area ! V=h*area
        res=res+res_p
        select case (num_int)
        case(0)
          call calculo_phi(x_aux,l,k1,phiX)
          call calculo_phi(y_aux,l,k2,phiY)
          pXi=phiX*phiY
       case (1)
          !Psi Horizontal
          call calculo_phi(x_aux,j,k1,phiX)
          call calculo_psi(y_aux,j,k2,psiY)
          pXi=phiX*psiY
       case (2)
          !Psi Vertical
          call calculo_psi(x_aux,j,k1,psiX)  
          call calculo_phi(y_aux,j,k2,phiY)
          pXi=psiX*phiY
       case (3)
          !Psi Diagonal
          call calculo_psi(x_aux,j,k1,psiX)
          call calculo_psi(y_aux,j,k2,psiY)
          pXi=psiX*psiY
        end select
        y_aux=y_aux+div
     enddo
     x_aux=x_aux+div
  enddo
  write(*,*)res, pXi
  res=res*pXi
  return
end subroutine integral
!
! ============================= SUBROTINAS PAI (PHI) =============================  ! Checadas OK
!
subroutine calculo_pai(x,y,l,k1,k2, fcPai)             ! RETORNA O SOMATORIO 
  real j,k1,k2, fcPai, x, y, l, cjk
  real phi, phiX,phiY
  integer num_int
  call calculo_phiMai(x,y,l,k1,k2, phi)
  if (phi .ne. 0) then
     num_int=0
     call integral(num_int,l,j,k1,k2, cjk)           !cjk OK
     fcPai=cjk*phi
     write(*,*)cjk
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
! ========================== SUBROTINAS MAE (PSI) ===============================
!
subroutine calculo_mae(sinal,x,y,j,k1,k2, fcMae)
  real j,x,y,k1,k2, djk, psi_Mi,l
  integer sinal, num_int
  external f
  call calculo_psiMi(sinal,x,y,j,k1,k2, psi_Mi)              !psiMi OK horizontal
  if (psi_Mi .ne. 0) then 
     num_int=sinal
     call integral(num_int,l,j,k1,k2, djk)           !cjk OK
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
!
