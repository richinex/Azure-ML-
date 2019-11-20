
require(dplyr)
require(tidyr)
require(ggplot2)
library(gridExtra)
source("src/rf_grid2.R")
superconductivity_data <- maml.mapInputPort(1)


require(randomForest)
model_rf <- randomForest(data = superconductivity_data, 
                         critical_temp ~ ., 
                         mtry = 5,
                         ntree = 500,
                         importance = TRUE)

graphics.off()
# Create new plot with desired size
png("myplot.png",width=1000,height=800) 
# Get rid of default rViz file
file.remove(Sys.glob("*rViz*png"))

plot1 <- plot_feature_IncMSE(model_rf)
plot2 <- plot_feature_IncNodePurity(model_rf)
grid.arrange(plot1,plot2,nrow=2,widths=c(200,200))