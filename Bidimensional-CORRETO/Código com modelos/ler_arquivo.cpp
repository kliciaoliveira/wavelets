// Reescrita do programa ondaletas bidimensional em Cplusplus
// com o modelo acamadado

#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

int main() {
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
    ifstream fin("generic_zeroed_lessdata.txt");
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
    
    std::cout << "row 0 contains " << matrix[0].size() << " columns\n";
    std::cout << "matrix contains " << matrix.size() << " rows\n";
    std::cout << "row 13, column 1 is " << matrix[13][1] << '\n';
}