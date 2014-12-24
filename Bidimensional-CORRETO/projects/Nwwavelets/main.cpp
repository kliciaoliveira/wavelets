// Reescrita do programa ondaletas bidimensional em Cplusplus

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

//Funcoes
double integral( double inicialx, double finalx, double inicialy, double finaly )
{
  double res;
  
  double parcial1 = ((finalx-inicialx)/2)*(finaly*finaly) + (((finalx*finalx*finalx)/3) - ((inicialx*inicialx*inicialx)/3) + ((finalx*finalx)/2) - ((inicialx*inicialx)/2) + finalx - inicialx)*finaly;
  double parcial2 = ((finalx -inicialx)/2)*(inicialy*inicialy)  + (((finalx*finalx*finalx)/3) - ((inicialx*inicialx*inicialx)/3) + ((finalx*finalx)/2) - ((inicialx*inicialx)/2) + finalx - inicialx)*inicialy;
  
  res = parcial1 - parcial2;
  
  return(res);
}
double calculoPhi( double x , double y, double phi,  double cjk , double l , int k1 , int k2 )
{
  
//   cout << "rodou calculoPhi" << endl ;
  
  double coefcjk = 0 ;
  double Fxy = 0 ;
  double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
  double b = pow(2,-l)* ( k1 + 1 ) ;
  double c = pow(2,-l)* k2 ;
  double d = pow(2,-l)* ( k2 + 1 ) ;

  int k1_m = floor(x / pow(2,-l)) ;        //VERFIFICAR !! x corresponde a qual par k1 k2 (quadrante)
  int k2_m = floor(y / pow(2,-l)) ;
  
	
  coefcjk  = cjk * phi * phi ;
  if ( (x >= a && x <=  b) && (y >= c && y <= d) ){
    Fxy = coefcjk * phi *phi;		
  }
  
  return(0);
}
double calculoMae()
{
  cout << "Calculo_mae chamada" << endl;
  return(0);
}

//Programa
int main (int argc, char **argv)
{
  cout << "mainhasrun" << endl;
  ofstream myfile;
  myfile.open("wave.dat");
  
  // ---- Variaveis globais ----
  //Variaveis de entrada
  const double inicio_x = 0.1 ;   //Inicio da representacao
  const double inicio_y = 0.1 ;
  const double fim_x = 3 ;
  const double fim_y = 3;
  const double dom_inf_x = 0 ;   //Inicio do dominio
  const double dom_inf_y = 0 ;
  const double dom_sup_x = 2 ;
  const double dom_sup_y = 2 ;
  const double increment = 0.1 ; //Incremento da representacao
  const double l = 1 ;           // Determinacao de l - passo da varredura
  
  //Variaveis auxiliares de entrada
  int elementos_somaFxy = ceil(dom_sup_x/increment);
  
  //Variaveis de saida
  double Fxy = 0;
  double somaFxy [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
  
  int min_k1 = dom_inf_x * pow(2,l) ;     // Determinacao dos limites do dominio em relacao a k1 e k2
  int min_k2 = dom_inf_y * pow(2,l) ;
  int max_k1 = (dom_sup_x - pow(2,-l))/ pow(2,-l) ;
  int max_k2 = (dom_sup_y - pow(2,-l))/ pow(2,-l) ;
//   int elementos_cjk = max_k1 + 1;
  int comprimento_dominio = (abs(inicio_x)+abs(fim_x)) / pow(2,-l) ;
  int elementos_cjk = comprimento_dominio * comprimento_dominio ;
  //cout << comprimento_dominio << "  " << elementos_cjk << endl;
  double coefcjk [elementos_cjk] [elementos_cjk] ;
  
  int i = 1;
  for(double x = inicio_x ; x <= fim_x ; x += increment){	//--Valores de x e y para tomar da matriz
    for(double y = inicio_y ; y <= fim_y ; y += increment){
      somaFxy [i] = 0;
      for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
	for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
	  double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
	  double b = pow(2,-l)* ( k1 + 1 ) ;
	  double c = pow(2,-l)* k2 ;
	  double d = pow(2,-l)* ( k2 + 1 ) ;
	  double phi = pow(2,(l*0.5));
	  double cjk = integral( a , b , c , d ) ;     //Calculo da integral
	  Fxy = calculoPhi(x , y, phi, cjk , l, k1 , k2) ;
	  somaFxy [i] += Fxy ;

	}
      }
       cout << "  " << x << "  " << y << "     " << somaFxy [i] << endl;
      myfile << x << "   " << y << "     " << somaFxy [i] << endl;
      i++;
    }
  }
  myfile.close();
  return 0;
}
