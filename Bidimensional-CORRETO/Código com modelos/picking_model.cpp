#include <iostream>
#include <cmath>
#include <fstream>
#include <vector>
#include <sstream>
#include <string>
using namespace std;


int main (int argc, char **argv)
{
    ofstream myfile;
	myfile.open("picked_m1.dat");
	
	double inicio_x = 0 ;
	double inicio_y = 0 ;
	double fim_x = 15 ;
	double fim_y = 7.5 ;
	double incremento = 0.5;
	double data = 0;
	
	cout << "Insira dados no formato X.X para cada coordenada do modelo:" << endl;
	
    for(double x = inicio_x ; x <= fim_x ; x += incremento){
        for(double y = inicio_y ; y <= fim_y ; y += incremento){

			cout << x << "  " << y << "  " << endl;
			cin >> data ;
			myfile << x << "	" << y << "		" << data << endl;
		}
	}

}