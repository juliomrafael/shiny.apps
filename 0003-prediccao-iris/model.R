####################################
# Júlio Rafael                    #
# http://github.com/juliomrafael   #
####################################

# Modificado a partir de Data Professor
# https://github.com/dataprofessor

# Importando pacotes
library(RCurl) # para baixar ficheiro de irir em CSV for downloading
library(randomForest)
library(caret)

# Importando dataset
iris <- read.csv(text = getURL("iris.csv") )

# Executa a divisão aleatória estratificada do conjunto de dados
TrainingIndex <- createDataPartition(iris$Species, p=0.8, list = FALSE)
TrainingSet <- iris[TrainingIndex,] # Conjunto de treino
TestingSet <- iris[-TrainingIndex,] # Conjunto de teste

write.csv(TrainingSet, "training.csv")
write.csv(TestingSet, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

# Construindo modelo aleatório
model <- randomForest(Species ~ ., data = TrainSet, ntree = 500, mtry = 4, importance = TRUE)

# Guarda o modelo no ficheiro RDS
saveRDS(model, "model.rds")
