////////////////////Ejercicio01/////////////////
// let string =""
// let llamados = 7

// let i = string.length
// for (i;i<llamados;i++){
//     string += "#"
//     console.log(string)
// }

////////////////////Ejercicio02/////////////////

// for (n=1;n<=100; n++){
//      if (n%3==0&&n%5==0){
//         console.log("FizzBuzz")
//      } else if (n%3==0) {
//         console.log("Fizz")
//      } else if (n%5==0){
//         console.log("Buzz")
//      } else{
//         console.log(n)
//      }
// }

////////////////////Ejercicio03/////////////////

let string = "";
let dimensionDelTablero = 8;


for (columna=0;columna<dimensionDelTablero;columna++) {
  if (columna%2==0){
    for (i = 0; i < dimensionDelTablero; i++) {
        if (i % 2 == 0) {
          string += "#";
        } else {
          string += " ";
        }
      }
     string += "\n"
  } else {
    for (i = 0; i < dimensionDelTablero; i++) {
        if (i % 2 == 0) {
          string += " ";
        } else {
          string += "#";
        }
      }
     string += "\n"
  }
}
console.log(string);