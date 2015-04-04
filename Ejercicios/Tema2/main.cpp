/* 
 * File:   main.cpp
 * Author: Jacinto
 *
 * Created on 30 de marzo de 2015, 20:20
 */

#include <iostream>
#include "sistema.cpp"

using namespace std;

void mostrarMenu(){
    cout<<  "D-> Duplicar componente\n"
        <<  "R-> Réplica de un componente\n"
        <<  "N-> Nuevo componente\n"
        <<  "P-> Imprimir\n"
        <<  "S-> Salir\n";
    cout<<  "Introduzca la opción elegida-> ";
}

int main()
{
    Sistema sistema;
    bool salir=false;
    char tecla;
    int comp;
    float disp;

    while(!salir){
        mostrarMenu();
        cin>> tecla;
        switch(toupper(tecla)){
        case 'D':
            cout<<"Introduzca el numero de componente a duplicar-> ";
            cin>>comp;
            sistema.nuevaReplica(comp-1);
            break;
        case 'R':
            cout<<"Introduzca el numero de componente a replicar-> ";
            cin>>comp;
            cout<<"Introduzca la disponibilidad de la réplica-> ";
            cin>>disp;
            sistema.nuevaReplica(comp-1,disp);
            break;
        case 'N':
            cout<<"Introduzca la disponibilidad del nuevo componente-> ";
            cin>>disp;
            sistema.nuevoComponente(disp);
            break;
        case 'P':
            sistema.print();
            break;
        case 'S':
            salir=true;
            break;
        }
    }
}