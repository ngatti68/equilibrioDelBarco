# Generador de contenedores
set.seed(42)

n_x <- 10
n_y <- 20
n_z <- 5
ancho <- 2
largo <- 5
alto <- 2
mu <- 19.8
sigma <- 3

x_coords <- seq(-(n_x/2 - 0.5) * ancho, (n_x/2 - 0.5) * ancho, by = ancho)
y_coords <- seq(-(n_y/2 - 0.5) * largo, (n_y/2 - 0.5) * largo, by = largo)
z_coords <- seq(1, (2*n_z - 1), by = alto)

contenedores <- data.frame(id = integer(), peso = numeric(), x = numeric(), y = numeric(), z = numeric())
id <- 1

for (x in x_coords) {
  for (y in y_coords) {
    for (z in z_coords) {
      peso <- rnorm(1, mean = mu, sd = sigma)
      contenedores <- rbind(contenedores, data.frame(id = id, peso = peso, x = x, y = y, z = z))
      id <- id + 1
    }
  }
}

# Exportar sin comillas en encabezados y sin columna de row.names
write.csv(contenedores, "contenedores.csv", row.names = FALSE, quote = FALSE)