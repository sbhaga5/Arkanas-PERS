library(plotly)
library(tidyverse)
APERSData <- read_csv("APERS_numeric.csv", col_names = TRUE, na = c(""), skip_empty_rows = TRUE, col_types = NULL)

APERSData$investments <- APERSData$investments*1e-6
APERSData$benefit_changes <- APERSData$benefit_changes*1e-6
APERSData$assumption_method_changes <- APERSData$assumption_method_changes*1e-6
APERSData$negative_amo <- APERSData$negative_amo*1e-6
APERSData$demographic <- APERSData$demographic*1e-6
APERSData$pay_increase <- APERSData$pay_increase*1e-6

APERSData$investments <- as.numeric(APERSData$investments)
APERSData$benefit_changes <- as.numeric(APERSData$benefit_changes)
APERSData$assumption_method_changes <- as.numeric(APERSData$assumption_method_changes)
APERSData$negative_amo <- as.numeric(APERSData$negative_amo)
APERSData$demographic <- as.numeric(APERSData$demographic)
APERSData$pay_increase <- as.numeric(APERSData$pay_increase)

APERSData$investments[which(is.na(APERSData$investments))] <- 0
APERSData$benefit_changes[which(is.na(APERSData$benefit_changes))] <- 0
APERSData$assumption_method_changes[which(is.na(APERSData$assumption_method_changes))] <- 0
APERSData$negative_amo[which(is.na(APERSData$negative_amo))] <- 0
APERSData$demographic[which(is.na(APERSData$demographic))] <- 0
APERSData$pay_increase[which(is.na(APERSData$pay_increase))] <- 0

x= list("Underperforming Investments", "Benefit Changes & Other", "Changes in Methods and Assumption", "Negative Amortization", "Actual Demographic Performance", "Pay Increase not given","Net Change to Unfunded Liability")
measure= c("relative", "relative", "relative", "relative", "relative","relative", "total")
y= c(sum(APERSData$investments), sum(APERSData$benefit_changes), sum(APERSData$assumption_method_changes), sum(APERSData$negative_amo), sum(APERSData$demographic), sum(APERSData$pay_increase), 0)
data = data.frame(x=factor(x,levels=x),measure,y)

fig <- plot_ly(
  data, name = "Data", type = "waterfall", measure = ~measure,
  x = ~x, textposition = "outside", y= ~y, text =~"",
  connector = list(line = list(color= "rgb(63, 63, 63)"))) 
fig <- fig %>%
  layout(title = "Causes of Pension Debt",
         xaxis = list(title = ""),
         yaxis = list(title = "Change in Unfunded Liability ($Billions)"),
         autosize = TRUE,
         showlegend = FALSE)

fig
