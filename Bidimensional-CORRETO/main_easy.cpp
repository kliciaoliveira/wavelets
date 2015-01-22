/* 
*/

#include <iostream>
#include <cmath>
#include <fstream>
#include <string>
#include <sstream>
using namespace std;

// ###### Funcoes ######

// Funcao que define o output com nome 
std::string make_output_filename(size_t index) {
   std::ostringstream ss;
   ss << "output_" << index << ".dat";
   return ss.str();
}


// ##### Programa #####
int main (int argc, char **argv)
{
    ofstream myfile;
    ofstream myfile2;
    myfile.open("wave.dat");
    myfile2.open("wavediff.dat");
    
    // ---- Variaveis globais ----
    //Variaveis de entrada
	
    const double inicio_x = -1 ;   //Inicio da representacao
    const double inicio_y = -1 ;
    const double fim_x = 10 ;
    const double fim_y = 5;
    const double dom_inf_x = 0 ;   //Inicio do dominio
    const double dom_inf_y = 0 ;
    const double dom_sup_x = 9 ;
    const double dom_sup_y = 3 ;
    const double increment = 0.1 ; //Incremento da representacao
	
	// Determinacao dos coeficientes
    const double l = 0 ;           // Determinacao de l - passo da varredura
    const double j_max = 1;		   //Determinacao de j_max
	
	double cjk = 0.1;
	double djk = 0.1;
    
    //Variaveis auxiliares de entrada
	
    int elementos_somaFxy = ceil((abs(inicio_x)+abs(fim_x))/increment);
    
    //Variaveis de saida
	
    double Fxy = 0;
    double somaFxy [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    double somaDjk [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    
    int min_k1 = dom_inf_x * pow(2,l) ;     // Determinacao dos limites do dominio em relacao a k1 e k2
    int min_k2 = dom_inf_y * pow(2,l) ;
    int max_k1 = (dom_sup_x - pow(2,-l))/ pow(2,-l) ;
    int max_k2 = (dom_sup_y - pow(2,-l))/ pow(2,-l) ;
    int elementos_cjk = max_k1 + 1;
    double coefcjk [elementos_cjk] [elementos_cjk] ;
    
    int i = 0;
    for(double x = inicio_x ; x <= fim_x ; x += increment){	//--Valores de x e y para tomar da matriz
        for(double y = inicio_y ; y <= fim_y ; y += increment){
            somaFxy [i] = 0;
            somaDjk [i] = 0;
            for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                    double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
                    double b = pow(2,-l)* ( k1 + 1 ) ;
                    double c = pow(2,-l)* k2 ;
                    double d = pow(2,-l)* ( k2 + 1 ) ;
                    double phi = pow(2,(l*0.5));
                    int k1_m = floor(x / pow(2,-l)) ;        //VERFIFICAR !! x corresponde a qual par k1 k2 (quadrante)
                    int k2_m = floor(y / pow(2,-l)) ;
                    Fxy = 0;
                    coefcjk [k1_m][k2_m] = cjk * phi * phi ;
                    if ( (x >= a && x <=  b) && (y >= c && y <= d) ){
                        Fxy = coefcjk[k1_m][k2_m] * phi *phi;
                    }
                    somaFxy [i] += Fxy ;
                }
            }
            // *** introdução do somatorio djk (comentar secao para usar somente o primeiro somatorio)
            for (double j=l; j<=j_max; j++) {
                for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                    for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
						double psi_h = phi * 
                        double soma_mae = ( psi_h ) + ( psi_v ) + ( psi_d );
                    }
                }
            }
            // ***
            //cout << "  " << x << "  " << y << "     " << i << "   " << somaFxy [i] << endl;
            double diff = 0;
            if ((x > dom_inf_x && x < dom_sup_x) && (y > dom_inf_y && y < dom_sup_y)) {
                diff = ((x*x + x + y + 1) - somaFxy [i] );
            }
            myfile2 << x << "        " << y << "        " <<  diff << endl;
            myfile << x << "        " << y << "        " << somaFxy [i] + somaDjk[i] << endl;
            cout << somaDjk [i] << endl;
            i++;
			
			/*
			for (size_t output_file_number=0;)  {
			  FILE *file = fopen(make_output_filename(output_file_number).c_str(), "w");
			  
			  fclose(file);
			}
			*/
			
			
			
        }
    }
    myfile.close();
    myfile2.close();
    return 0;
}
