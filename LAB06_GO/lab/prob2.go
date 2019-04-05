package main

import("fmt"
		"math/rand"
)

func main() {
	vector := []float64{0,1,2,3}
	a := [][]float64{
		{0, 1, 2, 3},
		{4, 5, 6, 7},
		{8, 9, 10, 11},
		{12, 13, 14, 15},
	}
	

}



//  1. Hola mundo
func helloWorld() {
	fmt.Println("Hola Mundo!")
}


//  2. crear vector de tamano n con 0s 
func createVector(n int) []float64{
	v := make([]float64, n)
	return v
}

// 3. crear vector de tamano n con numeros random
func createRandomVector(n int) []float64{
	v := make([]float64, n)
	for i := 0; i <= n-1; i++ {
		v[i] = rand.Float64()
	}
	return v

}

// 4. funcion que regresa una matriz cuadrada de 0s
func createMatrix(n int) [][]float64{
	v := make([][]float64, n)
	for i := 0; i <= n-1; i++ {
		v[i] = make([]float64, n)
	}
	return v
}

// 5. igual que cuatro pero con numero aleatorios
func createRandomMatrix(n int) [][]float64{
	v := make([][]float64, n)
	for i := 0; i <= n-1; i++ {
		v[i] = make([]float64, n)
		for j := 0; j <= n-1; j++ {
			v[i][j] = rand.Float64()
		}
	}
	return v
}

// 6. funcion que multiplica vector por matriz
func multiplyVectorByMatrix(v []float64, m [][]float64) []float64{
	r := make([]float64, len(v))
	toAdd := make([]float64, len(v))

	for i := 0; i < len(v); i++ {
		for j := 0; j < len(v); j++ {
			// fmt.Println(v[j], " ", m[i][j])
			toAdd[j] = v[j] * m[i][j]
			// print("value: ", toAdd[j])
		}
		// fmt.Println("vector to add", toAdd)
		r[i] = addValuesOfVector(toAdd)
		// fmt.Println("result", r[i])
	}
	// fmt.Println("final result: ", r)
	return r
}

func addValuesOfVector(v []float64) float64{
	var total float64
	for i := 0; i < len(v); i++ {
		total = total + v[i]
	}
	// fmt.Println("total ", total)
	return total
}

// 7. funcion que resulenve un sistema de ecuaciones recibiendo una matriz triangular y un vector objetivo


func printSlice(s string, x [][]float64) {
	fmt.Printf("%s len=%d cap=%d %v\n",
		s, len(x), cap(x), x)
}

