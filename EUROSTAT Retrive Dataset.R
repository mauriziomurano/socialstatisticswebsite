if (!require(eurostat)) install.packages("eurostat", dependencies = TRUE)
if (!require(kableExtra)) install.packages("kableExtra", dependencies = TRUE)
if (!require(dplyr)) install.packages("dplyr", dependencies = TRUE)
if (!require(data.table)) install.packages("data.table", dependencies = TRUE)

library(eurostat)
library(kableExtra)
library(dplyr)
library(data.table)

search_results <- search_eurostat("drink")

print(search_results %>%
        select(title, code, data.start, data.end) %>%
        kable("simple"))

# ---

cat("\nInserisci il 'code' del dataset che desideri scaricare (es. gbv_ipv_type): ")
selected_code <- readLines(n=1)

selected_code <- trimws(selected_code)

if (selected_code %in% search_results$code) {
  message(paste("Scaricando il dataset con codice:", selected_code))
  # Assegna il dataset scaricato alla variabile 'data'
  data <- get_eurostat(selected_code)
  setDT(data) # Converti 'data' in data.table
  print(head(data))
} else {
  print(paste("Errore: Il codice", selected_code, "non è stato trovato tra i dataset disponibili o non è valido."))
}

