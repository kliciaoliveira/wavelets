// Reescrita do programa ondaletas bidimensional em Cplusplus
// com o modelo acamadado

#include <iostream>
#include <cmath>
#include <fstream>
using namespace std;


#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

int main() {
    std::vector<std::vector<double> > allData;
    
    std::ifstream fin("generic2.dat");
    std::string line;
    while (std::getline(fin, line)) {      // for each line
        std::vector<double> lineData;           // create a new row
        int val;
        std::istringstream lineStream(line);
        while (lineStream >> val) {          // for each value in line
            lineData.push_back(val);           // add to the current row
        }
        allData.push_back(lineData);         // add row to allData
    }
    
    std::cout << "row 0 contains " << allData[0].size() << " columns\n";
    std::cout << "row 13, column 1 is " << allData[13][1] << '\n';
}
