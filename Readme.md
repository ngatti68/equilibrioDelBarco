# 📦 Equilibrio de Barco Porta Contenedores

### Descripción
Este programa en R simula la carga de contenedores en un barco porta contenedores.
Genera un archivo plano separado por comas (CSV) con los siguientes datos de cada contenedor:
• 	Peso (toneladas)
• 	Coordenada X
• 	Coordenada Y
Posteriormente, calcula el equilibrio del barco en función de la distribución de los contenedores.
El modelo estadístico asume que:
• 	El peso promedio de los contenedores es 19.8 toneladas.
• 	El desvío estándar es 3 toneladas.
• 	La distribución de probabilidad de los pesos sigue una distribución normal (gaussiana).

## 📊 Ejercicios Estadísticos
1. Probabilidad de encontrar un contenedor de 30 toneladas o más
Se calcula:

La probabilidad de que un contenedor pese 30 toneladas o más es:

👉 Es extremadamente raro encontrar un contenedor tan pesado bajo esta distribución.

2. Tres contenedores de 30 toneladas en tres barcos distintos
Cada barco descarga sus contenedores en grupos separados. Seleccionamos tres contenedores al azar de cada grupo y obtenemos tres contenedores de 30 toneladas.
La probabilidad de que un contenedor pese 30 toneladas o más ya vimos que es:

La probabilidad de obtener tres contenedores de 30 toneladas en tres grupos independientes es:

👉 Este valor es prácticamente nulo.
Con un nivel de confianza del 90%, podemos afirmar que no es compatible con la hipótesis de que los contenedores provienen de un barco cuyo promedio es 19.8 toneladas y desviación estándar de 3 toneladas.
En otras palabras, si realmente se observaron tres contenedores de 30 toneladas, lo más probable es que provengan de otra distribución (quizás otro barco con un promedio mayor).

## 🚀 Uso del programa
1. 	Ejecutar el script principal en R:

```
source("contenedores.R")
```

2. 	Se generará un archivo  con los datos simulados.
3. 	El programa calculará automáticamente el equilibrio del barco y mostrará los resultados.

## 📂 Estructura del proyecto

```
equilibriDelBarco
├──.gitignore
├── analisis_contenedores.R
├── contenedores.R
├── README.md
```
