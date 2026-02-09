# Cargar librerías necesarias
library(ggplot2)

# 1) Verificación del equilibrio del barco
# ----------------------------------------

# Cargar datos desde archivo CSV
contenedores <- read.csv("contenedores.csv", header = TRUE, quote = "")

# Dimensiones del barco
ancho_contenedor <- 2
largo_contenedor <- 5
cantidad_x <- 10
cantidad_y <- 20

ancho_barco <- cantidad_x * ancho_contenedor
largo_barco <- cantidad_y * largo_contenedor

# Inicialización
peso_total <- 0
Mx <- 0 # nolint
My <- 0

# Recorrer cada contenedor
for (i in 1:nrow(contenedores)) {
  peso <- contenedores$peso[i]
  x <- contenedores$x[i]
  y <- contenedores$y[i]

  peso_total <- peso_total + peso
  Mx <- Mx + (x * peso)
  My <- My + (y * peso)
}

# Cálculo de tolerancias
tolerancia_x <- peso_total * (ancho_barco / 2)
tolerancia_y <- peso_total * (largo_barco / 2)

# Verificación
if (abs(Mx) <= tolerancia_x && abs(My) <= tolerancia_y) {
  cat("✅ El barco está balanceado\n")
} else {
  cat("❌ El barco no está balanceado\n")
}

# 2) Probabilidad de encontrar un contenedor ≥ 30 toneladas
# ----------------------------------------------------------

mu <- 19.8
sigma <- 3
p_30 <- 1 - pnorm(30, mean = mu, sd = sigma)
cat(sprintf("📊 Probabilidad de encontrar un contenedor ≥ 30 toneladas: %.5f\n", p_30))

# 3) Verificación de compatibilidad con nivel de confianza del 90%
# ----------------------------------------------------------------

# Probabilidad de obtener al menos uno de 30 toneladas en una muestra de 3
p_uno_en_tres <- 1 - (1 - p_30)^3

# Probabilidad de que ocurra en los tres grupos independientes
p_tres_grupos <- p_uno_en_tres^3

cat(sprintf("📦 Probabilidad de obtener ≥1 contenedor de 30t en cada grupo: %.5f\n", p_uno_en_tres))
cat(sprintf("🧮 Probabilidad total en los tres grupos: %.10f\n", p_tres_grupos))

if (p_tres_grupos < 0.10) {
  cat("❌ No es compatible con un nivel de confianza del 90%\n")
} else {
  cat("✅ Es compatible con un nivel de confianza del 90%\n")
}

# 4) Parámetros de la distribución
# --------------------------------

# Parámetros de la distribución
mu <- 19.8
sigma <- 3
p_30 <- 1 - pnorm(30, mean = mu, sd = sigma)

# Crear secuencia de pesos
x_vals <- seq(10, 35, length.out = 500)
densidad <- dnorm(x_vals, mean = mu, sd = sigma)

# Data frame para graficar
df_grafico <- data.frame(x = x_vals, y = densidad)

# Construir gráfico
grafico <- ggplot(df_grafico, aes(x = x, y = y)) +
  geom_line(color = "blue", linewidth = 1) +

  # Área sombreada entre µ - σ y µ + σ
  geom_area(
    data = subset(df_grafico, x >= mu - sigma & x <= mu + sigma),
    aes(x = x, y = y), fill = "lightgreen", alpha = 0.4
  ) +

  # Área sombreada para P(X ≥ 30)
  geom_area(
    data = subset(df_grafico, x >= 30),
    aes(x = x, y = y), fill = "lightblue", alpha = 0.5
  ) +

  # Líneas de referencia
  geom_vline(xintercept = mu, color = "red", linetype = "dashed", linewidth = 1) +
  geom_vline(xintercept = mu - sigma, color = "darkgreen", linetype = "dotted", linewidth = 1) +
  geom_vline(xintercept = mu + sigma, color = "darkgreen", linetype = "dotted", linewidth = 1) +
  geom_vline(xintercept = mu - 2 * sigma, color = "purple", linetype = "dotdash", linewidth = 1) +
  geom_vline(xintercept = mu + 2 * sigma, color = "purple", linetype = "dotdash", linewidth = 1) +
  labs(
    title = "Distribución de pesos de contenedores",
    x = "Peso (toneladas)",
    y = "Densidad"
  ) +

  # Anotaciones
  annotate("text",
    x = 30.5, y = 0.02,
    label = paste0("P(X ≥ 30) = ", round(p_30, 5)),
    hjust = 0, size = 4
  ) +
  annotate("text",
    x = mu + 0.5, y = max(densidad) / 2,
    label = paste0("Media = ", mu, " t"),
    color = "red", hjust = 0, size = 4
  ) +
  annotate("text",
    x = mu + sigma + 0.5, y = max(densidad) / 3,
    label = paste0("σ = ", sigma, " t"),
    color = "darkgreen", hjust = 0, size = 4
  ) +
  annotate("text",
    x = mu + 2 * sigma + 0.5, y = max(densidad) / 4,
    label = paste0("2σ = ", 2 * sigma, " t"),
    color = "purple", hjust = 0, size = 4
  )

# Mostrar gráfico en pantalla
print(grafico)
