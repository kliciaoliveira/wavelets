/* Reescrita do programa ondaletas bidimensional em Cplusplus
 com o modelo acamadado
*/


#include <iostream>
#include <cmath>
#include <fstream>
#include <vector>
#include <sstream>
#include <string>
using namespace std;

/*
	Funcao cálculo da Integral
*/

double integral( double inicialx, double finalx, double inicialy, double finaly, vector<vector<double> > matrix )
{
//double integral( double inicialx, double finalx, double inicialy, double finaly)
//    {
//    cout << "integral"<< endl;
    double res = 0 ;
    const int partes = 2 ;
//    double soma = 0;
 
    int x_matriz = floor(inicialx) ;
    int y_matriz = floor(inicialy) ;
    
    double divisao_x = finalx - inicialx ;
    double divisao_y = finaly - inicialy ;
    
    double partex = divisao_x/partes ;
    double partey = divisao_y/partes ;

    
	//    cout << inicialx << "  " << finalx << endl;
	//if (matrix[x_m][y_m] != matrix [x_a][y_a]){
		for (double x = inicialx; x < finalx; x+=partex) {
			for (double y =inicialy; y < finaly; y+=partey) {

				double altura = matrix[x_matriz][y_matriz];
				//cout << x_matriz << "  " << y_matriz << "  " << altura << endl;
				double cubo = partex*partey*altura;
				res +=cubo;
			}
		}
		//}
//    cout << res << endl;
    return(res);
}

/* 
	Início do programa
*/

//Programa
int main (int argc, char **argv)
{
//    cout << "mainhasrun" << endl;
    ofstream myfile;
    ofstream myfile2;
    myfile.open("wave_m1.dat");
    myfile2.open("wavediff_m1.dat");
    
    // ---- Variaveis globais ----
    //Variaveis de entrada
    const double inicio_x = 0 ;   //Inicio da representacao
    const double inicio_y = 0 ;
    const double fim_x = 160 ;
    const double fim_y = 80;
    const double dom_inf_x = 0 ;   //Inicio do dominio = escala da imagem (157x80)
    const double dom_inf_y = 0 ;
    const double dom_sup_x = 10 ;
    const double dom_sup_y = 80 ;
    const double incremento_x = 20 ; //Incremento da representacao
	const double incremento_y = 10 ; //Incremento da representacao
    const double l = 1 ;           // Determinacao de l - passo da varredura
    
    //Variaveis auxiliares de entrada
//    int elementos_somaFxy = (ceil((abs(inicio_x)+abs(fim_x))/increment)*ceil((abs(inicio_y)+abs(fim_y))/increment));
    
    //Variaveis de saida
    double Fxy = 0 ;
    double somaFxy ;

    unsigned int min_k1 = dom_inf_x * pow(2,l) ;     // Determinacao dos limites do dominio em relacao a k1 e k2
    unsigned int min_k2 = dom_inf_y * pow(2,l) ;
    int max_k1 = (dom_sup_x - pow(2,-l))/ pow(2,-l) ;
    int max_k2 = (dom_sup_y - pow(2,-l))/ pow(2,-l) ;
//    int elementos_cjk = max_k1 + 1;

    
    /* você não sabe quantas linhas e colunas o programa precisará ler,
     * pois isso depende do arquivo, então um vetor é a forma correta
     * de acessar as coisas. já que ele pode crescer inifnitamente.
     *
     * matrix[0] é um vetor, de vetor. então isso tem que ser levado em
     * consideração também. Você tem que adicionar um vetor<double> dentro
     * do matrix[indice], pois por padrão nada existe.
     */
    vector<vector<double> > matrix;
    
    /* tenta abrir o arquivo e avisa em caso de erro. */
    ifstream fin("generic2.dat");
    if (!fin.is_open()) {
        cout << "Erro, arquivo não encontrado ou sem permissao de leitura.";
        return 0;
    }
    
    /* Aqui é uma coisa importante.: você estava transformando tudo pra int
     * quando no seu caso você tem dois dados int ( x e y ) e um dado double
     * ( valor do indice ).  Então temos que ter uma variavel de cada tipo.
     */
    string line;
    while (getline(fin, line)) {
        unsigned int x, y;
        double data;
        
        /* nessa parte lemos uma linha e transformamos pra x, y e data.
         * sabemos que o arquivo é dividodo em 'int, int, double' então
         * usamos a mesma direção pra leitura. >> x, >> y, >> data.
         */
        istringstream lineStream(line);
        lineStream >> x >> y >> data;
        
        /* Aqui temos que montar a matriz. Como a leitura dos x e dos y não
         é sequencial ( depois de um 15, pode-se voltar a zero ) temos que
         testar se o valor já existe dentro do vetor. Entrando no if significa que
         não existe ainda essa linha, então adicionamos um vetor vazio. */
        if (matrix.size() <= x)
            matrix.push_back( std::vector<double>());
        
        // Aqui adicionamos um valor novo dentro do vetor descrito por matrix[i], que virá a ser o matrix[i][j];
        matrix[x].push_back(data);
    }
    
    //    std::cout << "row 0 contains " << matrix[0].size() << " columns\n";
    //    std::cout << "matrix contains " << matrix.size() << " rows\n";
    //    std::cout << "row 13, column 1 is " << matrix[13][1] << '\n';
    

    
//      double coefcjk [elementos_cjk] [elementos_cjk] ;
    // indices negativos
    
//    double **coefcjk = new double*[elementos_cjk+1]; // vetor de ponteiros de double
//    for(int i = 0; i < (elementos_cjk+1); i++){
//        coefcjk[i] = new double[elementos_cjk+1];
//    }
    
//    int i = 0;
	int count = 0;
    for(double x = inicio_x ; x <= fim_x ; x += incremento_x){	//--Valores de x e y para tomar da matriz
        for(double y = inicio_y ; y <= fim_y ; y += incremento_y){
			somaFxy = 0;
            for( int k1 = min_k1; k1 <= max_k1; k1++ ) {
                for( int k2 = min_k2; k2 <= max_k2; k2++ ) {
                    double a = pow(2,-l)* k1 ;      		//--Gerando a matriz
                    double b = pow(2,-l)* ( k1 + 1 ) ;
                    double c = pow(2,-l)* k2 ;
                    double d = pow(2,-l)* ( k2 + 1 ) ;
                    double phi = pow(2,(l*0.5));
                    double cjk = integral( a , b , c , d , matrix) ;     //Calculo da integral
//                    double cjk = integral( a , b , c , d ) ;     //Calculo da integral
//                    int k1_m = floor(x / pow(2,-l)) ;        //VERFIFICAR !! x corresponde a qual par k1 k2 (quadrante)
//                    int k2_m = floor(y / pow(2,-l)) ;
                    Fxy = 0;
//                    int indice_k1 = k1_m - floor(inicio_x / pow(2,-l));
//                    int indice_k2 = k2_m - floor(inicio_y / pow(2,-l));
//                    cout << cjk << endl;
					//cout << min_k1 << " " << min_k2 << " " << max_k1 << " " << max_k2 << endl;
                    double coefcjk_matrix = cjk * phi * phi ;
                    if ( (x >= a && x <=  b) && (y >= c && y <= d)) {
                        Fxy = coefcjk_matrix * phi *phi;
                        cout << coefcjk_matrix << "  " << phi << endl;
                    }
					
					cout << count << endl;
					count++;
					
                    somaFxy += Fxy ;
                }
            }
            //cout << "  " << x << "  " << y << "     " << i << "   " << somaFxy [i] << endl;
            double diff = 0;
            if (( x > dom_inf_x && x < dom_sup_x ) && ( y > dom_inf_y && y < dom_sup_y )) {
                diff = ((x*x + x + y + 1) - somaFxy );
            }
            myfile2 << x << "        " << y << "        " <<  diff << endl;
            myfile << x << "        " << y << "        " << somaFxy << endl;
            //cout << "Soma e diferenca:  " <<  x << "  " << y << "  " << diff << "   " << somaFxy << endl;
//            cout << x << "  " << y <<  "  " << somaFxy << endl;
        }
    }
    myfile.close();
    myfile2.close();
    return 0;
}
