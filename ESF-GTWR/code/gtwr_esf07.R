rm(list=ls())
library(sp)
library(GWmodel)
library(spmoran)
library(spacetime)
library(openxlsx)

lm_str <- c('xco2~Zat+Zco2bio+Ztp+Zws+Zntl+Zlc+Zghf+Zet+Zndvi+ZAlbe',
            'xco2~Zghf+Zndvi+Zsw+Zssr+Zco2bio+Zat+Zntl+Zlw',
            'xco2~Zat+ZAlbe+Zssr+Zlw+Zghf+Zap+Zsw',
            'xco2~Zat+Zlw+Zghf+Zws+Zet+Zsw+Ztp+Zssr',
            'xco2~Zet+ZAlbe+Zlc+Zghf+Zskt+Zlw+Zntl+Zndvi+Zsw',
            'xco2~Zap+Ztp+Zet+ZAlbe+Zghf',
            'xco2~Zap+ZAlbe+Zghf+Zet+Ztp+Zskt+Zntl+Zco2bio+Zlw+Zndvi+Zssr')

x_str <- list(c("Zat","Zco2bio","Ztp","Zws","Zntl","Zlc","Zghf","Zet","Zndvi","ZAlbe"),
              c("Zghf","Zndvi","Zsw","Zssr","Zco2bio","Zat","Zntl","Zlw"),
              c("Zat","ZAlbe","Zssr","Zlw","Zghf","Zap","Zsw"),
              c("Zat","Zlw","Zghf","Zws","Zet","Zsw","Ztp","Zssr"),
              c("Zet","ZAlbe","Zlc","Zghf","Zskt","Zlw","Zntl","Zndvi","Zsw"),
              c("Zap","Ztp","Zet","ZAlbe","Zghf"),
              c("Zap","ZAlbe","Zghf","Zet","Ztp","Zskt","Zntl","Zco2bio","Zlw", "Zndvi","Zssr"))

inputpath <- 'E:/zhudaoyong/aili/'
files <- list.files(path = inputpath, pattern = '*.xlsx')
index_result <- data.frame(r=NULL, aic=NULL, aicc=NULL, rmse=NULL, bw=NULL)
n <- 2

data <- read.xlsx(paste(inputpath, files[n], sep = ''))
data <- na.omit(data)  # 删除含有缺失值的行

coords <- data[,c("x","y")]
meig <- meigen(coords = coords,model = "gau",threshold = 0.25)
y <- data[,"xco2"]
esf_model <- esf(y = y, x = data[,x_str[[n]]], meig = meig, fn="aic")
selected_sf <- meig$sf[,esf_model[["other"]][["sf_id"]]]
selected_evdata <- meig$ev[esf_model[["other"]][["sf_id"]]]
selected_sf <- as.data.frame(selected_sf)
names(selected_sf) <- paste('ev', esf_model[["other"]][["sf_id"]], sep = '')

newdata <- cbind(data, selected_sf)
time <- data$Zdow  # 时间戳列

spdata <- sp:::SpatialPointsDataFrame(cbind(data$x,data$y), newdata)

newlm_str <- lm_str[n]

Rmax <- 0
bw <- bw.gtwr(newlm_str, data = spdata, obs.tv = time, kernel = "gaussian", adaptive = TRUE)
for(i in c(1:ncol(selected_sf)))
{
  newlm_str <- paste(newlm_str, names(selected_sf)[i], sep = '+')
  result <- GWmodel:::gtwr(newlm_str, data = spdata, obs.tv = time, st.bw = bw, kernel = "gaussian", adaptive = TRUE)
  temp <- result[["GTW.diagnostic"]][["gwR2.adj"]]
  if(temp > Rmax){
    Rmax <- temp
    result_z <- result
  }else{
    length_of_element <- nchar(names(selected_sf)[i]) + 1  # 加1是为了包含 '+'
    newlm_str <- substr(newlm_str, 1, nchar(newlm_str) - length_of_element)
  }
}

model <- as.data.frame(result_z$SDF)
rmse <- sqrt(mean(model$residual^2))

residuals_result <- model[, c('coords.x1', 'coords.x2', 'residual')]
names(residuals_result) <- c('x', 'y', 'residual')

tmp_index <- c(result_z[["GTW.diagnostic"]][["gwR2.adj"]], result_z[["GTW.diagnostic"]][["AIC"]], result_z[["GTW.diagnostic"]][["AICc"]],
               rmse, bw)
tmp_index <- matrix(tmp_index, nrow=1)
index_result <- rbind(index_result, tmp_index)

image_path <- paste('E:/zhudaoyong/esf_scripts/esf-gtwr/esf-gtwr07.Rdata')
save.image(image_path)

names(index_result) <- c('r.adjusted', 'aic', 'aicc', 'rmse', 'bw')
write.csv(index_result, file=paste('E:/zhudaoyong/esf_scripts/esf-gtwr/results07.csv'))
