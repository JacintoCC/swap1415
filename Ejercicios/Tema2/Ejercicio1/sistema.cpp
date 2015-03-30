#include <iostream>
#include <vector>

using namespace std;

class Componente{
private:
    vector<float> replicas;
    float disponibilidad;
public:
    Componente(float disp){
        replicas.push_back(disp);
        disponibilidad=disp;
    }

    void calcularDisponibilidad(){
        float disp=replicas.at(0);
        for (int i=1;i<replicas.size();i++){
            disp+=(1-disp)*replicas.at(i);
        }

        disponibilidad=disp;
    }

    float getDisponibilidad(){
        calcularDisponibilidad();
        return disponibilidad;
    }

    void replicarElemento(){
        replicas.push_back(replicas.at(0));
    }

    void replicarElemento(float nueva_disp){
        replicas.push_back(nueva_disp);
    }

    void print(){
        for(int i=0;i<replicas.size();i++){
            cout<< "\t" << i+1 << ") " << replicas.at(i) << endl;
        }
        cout << "\tDisponibilidad elemento-> " << getDisponibilidad();
    }
};

class Sistema{
private:
    vector<Componente> componentes;
    float disponibilidad;

public:
    Sistema(){
        disponibilidad=1;
    }

    void calcularDisponibilidad(){
        disponibilidad=1;
        for(int i=0;i<componentes.size();i++){
            disponibilidad*=componentes.at(i).getDisponibilidad();
        }
    }

    float getDisponibilidad(){
        calcularDisponibilidad();
        return disponibilidad;
    }

    void nuevoComponente(float disp_nuevo_comp){
        Componente nuevo_comp=Componente(disp_nuevo_comp);
        componentes.push_back(nuevo_comp);

    }

    void nuevaReplica(int i){
        if(i<componentes.size())
            componentes.at(i).replicarElemento();
    }

    void nuevaReplica(int i, float nueva_disp){
        if(i<componentes.size())
            componentes.at(i).replicarElemento(nueva_disp);
    }

    void print(){
        for(int i=0;i<componentes.size();i++){
            cout<< i+1 << ".- ";
            componentes.at(i).print();
            cout << endl;
        }
        cout << "Disponibilidad global-> " << getDisponibilidad() << endl;
    }
};

