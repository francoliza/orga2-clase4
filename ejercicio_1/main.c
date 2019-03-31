#include <stdio.h>

struct alumno {
    short comision; //off_set: 0
    char * nombre;  //off_set: 8
    int edad;       //off_set: 16
}; //STRUCT SIZE 16

struct alumno nuevo_alumno = {4, "Pepe", 21};

extern void mostrarAlumno(struct alumno * un_alumno);

int main(int argc, char * argv[]) {
    // Comision: 4, Nombre: Pepe, edad: 21
    mostrarAlumno(&nuevo_alumno);
    return 0;
}
