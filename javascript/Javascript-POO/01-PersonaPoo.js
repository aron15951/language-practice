//clase basica
class Persona {
  constructor(nombre, edad, profesion) {
    this.nombre = nombre;
    this.edad = edad;
    this.profesion = profesion;
  }
  saludar() {
    console.log(`Hola ${this.nombre} espero te encuentres bien`);
  }
  describir() {
    console.log(
      `Tienes ${this.edad} años de edad y tu profesion es ${this.profesion}`,
    );
  }
}

let persona1 = new Persona("Aron", 28, "Desarrollador");

//Herencia simple
class Estudiante extends Persona {
  constructor(nombre, edad, carrera) {
    super(nombre, edad);
    this.carrera = carrera;
  }

  estudiar() {
    console.log(`${this.nombre} esta estudiando ${this.carrera}`);
  }
}

const estudiante1 = new Estudiante("aron", 25, "desarrollador");
estudiante1.saludar();
estudiante1.estudiar();
