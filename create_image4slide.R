library(magick)
library(dplyr)

NL1 <- magick::image_read('img/NL1.jpg')
NL2 <- magick::image_read('img/NL2.jpg') %>% image_scale("400")
NL1
NL2
NL = image_append(c(NL1,NL2),stack = T)
NL = image_append(c(NL1,NL2),stack = T) %>% image_annotate("Normal Liver",size=40,gravity='north',color='green') 
NL

NAFLD1 <- magick::image_read('img/NAFLD1.jpg') %>% image_scale("400")
NAFLD2 <- magick::image_read('img/NAFLD2.jpg') %>% image_scale("400")
NAFLD3 <- magick::image_read('img/NAFLD3.png') %>% image_scale("400")
NAFLD3
NAFLD = image_append(c(NAFLD1,NAFLD2),stack = T)
NAFLD = image_append(c(NAFLD1,NAFLD2),stack = T) %>% image_annotate("Fatty Liver",size=40,gravity='north',color='green') 
NAFLD

NL_FL = image_append(c(NL,NAFLD))
NL_FL

magick::image_write(NL_FL,"img/NL_FL.png",format = "png")



NASH1 <- magick::image_read('img/NASH1.jpg') %>% image_scale("x200")
NASH2 <- magick::image_read('img/NASH2.jpg') %>% image_scale("x200")
NASH3 <- magick::image_read('img/NASH3.jpg') %>% image_scale("x200")
NASH = c(NASH1, NASH2, NASH3)
NASH = image_append(NASH,stack = F) %>% image_scale("600")
NASH

laparo1 <- magick::image_read('img/laparo1.png') %>% image_scale("x200")
laparo2 <- magick::image_read('img/laparo2.jpg') %>% image_scale("x200")
laparo3 <- magick::image_read('img/laparo4.jpg') %>% image_scale("x200")
laparo = c(laparo1, laparo2, laparo3)
laparo = image_append(laparo,stack = F) %>% image_scale("600")
laparo

NASH2LC = image_append(c(laparo, NASH), stack = T)
NASH2LC
magick::image_write(NASH2LC,"img/NASH2LC.png",format = "png")
