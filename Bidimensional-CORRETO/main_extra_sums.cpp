// Reescrita do programa ondaletas bidimensional em Cplusplus
// função x2 + x + y +1

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;

/*           :::::::::: Funcoes ::::::::::             */

/* :  Funcao a ser representada   : */
double funcao (double x, double y)
{
	double res;
	res = x * x + x + y + 1;
	return res;
}

/* :   Funcao de calculo da integral numerica   : */
double integral( double inicialx, double finalx, double inicialy, double finaly )
{
    double res = 0;
    const int partes = 16;
    double x;
    double y;
    
    const double divisao_x = finalx - inicialx ;
    const double divisao_y = finaly - inicialy ;
    
    const double partex = divisao_x/partes ;
    const double partey = divisao_y/partes ;
    
    //    cout << inicialx << "  " << finalx << endl;
    for (x = inicialx; x <= finalx; x+=partex) {
        for (y =inicialy; y <= finaly; y+=partey) {
            double altura = funcao(x,y);
            double cubo = partex*partey*altura;
            //            cout << x << "  " << y << "  "<< " cubo: " <<  cubo << endl;
            res +=cubo;
        }
    }
//    cout << res << endl;
    return(res);
}

/* :::   Funcao de calculo do somatorio djk   ::: */
double calculos_djk (double j, int k1, int k2)
{
    double res2;
    /* ::   Gerando a matriz   :: 
	Os valores i, m e f equivalem aos limites iniciais, medios e finais dos dominios. Indices 1 sao atrelados a k1 e 
	indices 2 sao atrelados a k2.
	*/
    double i1 = pow(2,-j)* k1 ;	
    double i2 = pow(2,-j)* k2 ;
    double f1 = pow(2,-j)* ( k1 + 1 ) ;	
    double f2 = pow(2,-j)* ( k2 + 1 ) ;
    double m1 = pow(2,-j)* ( k1 + 0.5 ) ;
    double m2 = pow(2,-j)* ( k2 + 0.5 ) ;
    
    /* o valor da altura das funcoes caixa e 1/-1 */
    double wavelet_value = pow( 2,( j*0.5 ) );
    
    /* :: Integral horizontal = integral * phi (j,k1) * psi (j,k2) :: */
    double h1 = integral( i1 , f1 , i2 , m2 ) ;     /* Calculo da integral x no dominio phi e y no dominio psi */
    double h2 = integral( i1 , f1 , m2 , f2 ) ;     /* dominio x eh o mesmo, soh mudo y porque psi muda de sinal */
    double horizontal =  wavelet_value *  ( h1  - h2 ) ; /* psi muda de sinal ao longo do domínio*/
    
    /* :: Integral diagonal = integral * psi (j,k1) * psi (j,k2) :: */
    double d1 = integral( f1 , m1 , f2 , m2 ) ;
    double d2 = integral( m1 , f1 , m2 , f2 ) ;
    double d3 = integral( m1 , f1 , i2 , m2 ) ;
    double d4 = integral( i1 , m1 , m2 , f2 ) ;
    
    double diagonal = wavelet_value *  ( d1 + d2 - d3  - d4 ) ;
    
	/* :: Integral vertical = integral * psi (j,k1) * phi (j,k2) ::*/
	double v1 = integral( i1 , m1 , i2 , f2 );
	double v2 = integral( m2 , f2 , i2 , f2 );
	
    double vertical = wavelet_value *  (v1 - v2);

    //cout << h1 << " " << h2 << endl;
    
    res2 = ( horizontal + vertical + diagonal );
	
	//cout << wavelet_value << "  " << res2 << "  "<< endl;
	
    
    return(res2);
}


/*    :::::::::: Programa ::::::::::    */

int main (int argc, char **argv)
{
    ofstream myfile;
    ofstream myfile2;
	ofstream myfile3;
    myfile.open("wave_allsums.dat");
    myfile2.open("wave_allsums_diff.dat");
	myfile3.open("coeficientes.txt");
    
    /* ---- Variaveis globais ---- */
    /* Variaveis de entrada */
    const double inicio_x = -1 ;   /*Inicio da representacao */
    const double inicio_y = -1 ;
    const double fim_x = 3 ;
    const double fim_y = 3;
    const double dom_inf_x = 0 ;   /* Inicio do dominio */
    const double dom_inf_y = 0 ;
    const double dom_sup_x = 2 ;
    const double dom_sup_y = 2 ;
    const double increment = 0.1 ; /* Incremento da representacao */
    const double l = 1 ;           /* Determinacao de l - passo da varredura */
    const double j_max = 3;
	
	/* Mensagem de erro para j menor que l*/
	if( j_max < l)
	{
		cout << "ERRO: J eh menor que L. Ajuste os valores." << endl;
		exit(0);
	}
    
    /* Variaveis auxiliares de entrada */
    int elementos_somaFxy = ceil((abs(inicio_x)+abs(fim_x))/increment);
    
    /* Variaveis de saida */
    double Fxy = 0;
    double somaFxy [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    double somaDjk [(elementos_somaFxy +1)*(elementos_somaFxy+1)];
    
    int min_k1 = dom_inf_x * pow(2,l) ;     /* Determinacao dos limites do dominio em relacao a k1 e k2 */
    int min_k2 = dom_inf_y * pow(2,l) ;
    int max_k1 = (dom_sup_x - pow(2,-l))/ pow(2,-l) ;
    int max_k2 = (dom_sup_y - pow(2,-l))/ pow(2,-l) ;
    int elementos_cjk = max_k1 + 1;
    double coefcjk [elementos_cjk] [elementos_cjk] ;
    
    int i = 0;
    for(double x = inicio_x ; x <= fim_x ; x += increment){	/* --Valores de x e y para tomar da matriz */
        for(double y = inicio_y ; y <= fim_y ; y += increment){
            somaFxy [i] = 0;
            somaDjk [i] = 0;
            for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                    double a = pow(2,-l)* k1 ;      		/* --Gerando a matriz */
                    double b = pow(2,-l)* ( k1 + 1 ) ;
                    double c = pow(2,-l)* k2 ;
                    double d = pow(2,-l)* ( k2 + 1 ) ;
                    double phi = pow(2,(l*0.5));
                    double cjk = integral( a , b , c , d ) ;     /* Calculo do coeficiente cjk */
                    int k1_m = floor(x / pow(2,-l)) ;        /* x corresponde a qual par k1 k2 (quadrante) */
                    int k2_m = floor(y / pow(2,-l)) ;
                    Fxy = 0;
                    coefcjk [k1_m][k2_m] = cjk * phi * phi ;
                    if ( (x >= a && x <=  b) && (y >= c && y <= d) ){
                        Fxy = coefcjk[k1_m][k2_m] * phi *phi;
                    }
                    somaFxy [i] += Fxy ;
                }
            }
            /* :: introdução do somatorio djk :: */
            for( double j=l; j<=j_max; j++) {
                for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                    for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                        double djk_soma = calculos_djk(j, k1, k2);
						double phi = pow(2,(j*0.5));
                        somaDjk [i] += ( djk_soma );
						//somaDjk [i] += (  djk_soma );
                        // cout << djk_soma << "  " << i << endl;
                    }
					
                }
            }
			/* Calculo da diferenca entre o modelo gerado e o ideal */
            double diff = 0;
            if ((x > dom_inf_x && x < dom_sup_x) && (y > dom_inf_y && y < dom_sup_y)) {
                diff = (funcao(x,y) - somaFxy [i] );
            }
			/* Escrita do resultado e diferenca nos arquivos .dat*/
            myfile2 << x << "        " << y << "        " <<  diff << endl;
            myfile << x << "        " << y << "        " << somaFxy [i] + somaDjk[i] << endl;
            i++;
        }
    }
    myfile.close();
    myfile2.close();
	myfile3.close();
    return 0;
}
