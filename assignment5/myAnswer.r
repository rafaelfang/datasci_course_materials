dataset <- read.csv(file="seaflow_21min.csv",head=TRUE,sep=",")

summary(dataset)

library(caret)
set.seed(1)
trainIndex <- createDataPartition(dataset$pop, p = .5,
                                  list = FALSE,
                                  times = 1)

dataTrain <- dataset[ trainIndex,]
dataTest  <- dataset[-trainIndex,]
summary(dataTrain)


library(ggplot2)

a <- ggplot(data = dataset, aes(x = pe, y = chl_small,col = pop))+ geom_point()+ xlab("pe") + ylab("chl_small") + ggtitle("pe-chl_small")


library(rpart)
fol <- formula(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
model <- rpart(fol, method="class", data=dataTrain)
print(model)

predictResults=predict(model,dataTest,type="class")
classLabels=dataTest$pop
predAcc=sum(predictResults==classLabels)/length(classLabels)
table(pred = predictResults, true = dataTest$pop)


library(randomForest)
model <- randomForest(fol, data=dataTrain)
predictResultsRandomForest=predict(model,dataTest,type="class")
predAcc=sum(predictResultsRandomForest==classLabels)/length(classLabels)
table(pred = predictResultsRandomForest, true = dataTest$pop)

importance(model)

library(e1071)
model <- svm(fol, data=dataTrain)
predictResultsSVM=predict(model,dataTest,type="class")
predAcc=sum(predictResultsSVM==classLabels)/length(classLabels)
table(pred = predictResultsSVM, true = dataTest$pop)

b <- ggplot(data = dataset, aes(x = time, y = chl_big,col = pop))+ geom_point()+ xlab("time") + ylab("chl_big") + ggtitle("time-chl_big")





newdata <- dataset[ which(dataset$file_id!=208), ]
set.seed(1)
trainIndex <- createDataPartition(newdata$pop, p = .5,
                                  list = FALSE,
                                  times = 1)

dataTrain <- newdata[ trainIndex,]
dataTest  <- newdata[-trainIndex,]
model <- svm(fol, data=dataTrain)
predictResultsSVM=predict(model,dataTest,type="class")
classLabels=dataTest$pop
predAcc=sum(predictResultsSVM==classLabels)/length(classLabels)


