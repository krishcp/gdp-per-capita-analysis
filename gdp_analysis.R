data <- read.csv("C:/Users/HP/OneDrive/Desktop/world bank data.csv", na.strings = "..")
data <- data[1:217, ]

gdp2023 <- data$X2023..YR2023.

sum(is.na(gdp2023))
length(gdp2023) - sum(is.na(gdp2023))

summary(gdp2023, na.rm = TRUE)
mean(gdp2023, na.rm = TRUE)
median(gdp2023, na.rm = TRUE)
sd(gdp2023, na.rm = TRUE)
var(gdp2023, na.rm = TRUE)
IQR(gdp2023, na.rm = TRUE)
library(moments)
skewness(gdp2023, na.rm = TRUE)
kurtosis(gdp2023, na.rm = TRUE)
log_gdp2023 <- log(gdp2023)
skewness(log_gdp2023, na.rm = TRUE)
kurtosis(log_gdp2023, na.rm = TRUE)
hist(gdp2023, main = "Raw GDP per capita", breaks = 30)
hist(log_gdp2023, main = "Log GDP per capita", breaks = 30)
qqnorm(log_gdp2023, main = "QQ Plot: Log GDP per capita")
qqline(log_gdp2023, col = "red")
life_exp <- read.csv("C:/Users/HP/OneDrive/Desktop/Life expectancy.csv", na.strings = "..")
life_exp <- life_exp[1:217, ]

merged <- merge(data, life_exp, by = "Country.Code")
dim(merged)   # check your merged row count
names(merged)

gdp2023_m <- merged$X2023..YR2023..x
life_exp2023 <- merged$X2023..YR2023..y
log_gdp2023_m <- log(gdp2023_m)

sum(is.na(gdp2023_m))
sum(is.na(life_exp2023))

cor(gdp2023_m, life_exp2023, use = "complete.obs")
cor(log_gdp2023_m, life_exp2023, use = "complete.obs")

plot(gdp2023_m, life_exp2023, main = "Raw GDP vs Life Expectancy", xlab = "GDP per capita", ylab = "Life expectancy")
plot(log_gdp2023_m, life_exp2023, main = "Log GDP vs Life Expectancy", xlab = "Log GDP per capita", ylab = "Life expectancy")

model <- lm(life_exp2023 ~ log_gdp2023_m)
summary(model)
merged$residuals <- residuals(model)
merged[order(merged$residuals), c("Country.Name.x", "residuals")][1:5, ]

merged_complete <- merged[complete.cases(merged$X2023..YR2023..x, merged$X2023..YR2023..y), ]
merged_complete$residuals <- residuals(model)

merged_complete[order(merged_complete$residuals), c("Country.Name.x", "residuals")][1:5, ]

write.csv(merged_complete, "gdp_life_exp_final.csv", row.names = FALSE)
getwd()