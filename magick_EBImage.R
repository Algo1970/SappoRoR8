library(dplyr)
library(magick)
library(EBImage)


### magick ##################################################################################
magick::image_read('img2/dog.jpg')
dog <- magick::image_read('img2/dog.jpg')
dog %>% class()
dog
# resize
magick::image_scale(dog, "200")   # 同時にViewer表示する
magick::image_scale(dog, "x200") 
# cut (transformation)
magick::image_crop(dog, "300x400+150+150")

dog1 <- magick::image_scale(dog, "200")  
dog2 <- magick::image_scale(dog, "x200") 
dog3 <- magick::image_crop(dog, "300x400+150+150")
dog123 <- c(dog1,dog2,dog3)
dog123 <- image_append(dog123) 
dog123
image_write(dog123, path = "img2/dog123.png", format = "png")

# coverting formats
magick::image_convert(dog, "png") %>% image_info()
magick::image_write(dog,"img2/dog.png",format = "png")

# preview
# IDE’s with a built-in web browser (such as RStudio) automatically display magick images in the viewer. 
image_browse(dog)
dog
dim(dog)
object.size(dog)
typeof(dog)
summary(dog)

# rotate,flip,flop (transformation)
magick::image_rotate(dog, 45)
magick::image_flip(dog)
magick::image_flop(dog)

dog1 <- magick::image_rotate(dog, 45)
dog2 <- magick::image_flip(dog)
dog3 <- magick::image_flop(dog)
dog4 <- magick::image_read('img2/dog_translate.jpg')
dog1234 <- c(dog1,dog2,dog3,dog4)
dog1234 <- image_append(image_scale(dog1234, "x200")) 
magick::image_write(dog1234,"img2/dog1234.jpg",format = "jpg")

# filter (transformation)
magick::image_blur(dog, 10, 5)
magick::image_noise(dog,noisetype = "gaussian") 
magick::image_oilpaint(dog,radius = 10)
magick::image_charcoal(dog)
magick::image_edge(dog,radius = 5)
magick::image_emboss(dog, radius = 1, sigma = 0.5)
magick::image_negate(dog)

dog.fl1 <- magick::image_blur(dog, 10, 5)
dog.fl2 <- magick::image_noise(dog,noisetype = "gaussian") 
dog.fl3 <- magick::image_oilpaint(dog,radius = 10)
dog.fl4 <- magick::image_charcoal(dog)
dog.fl5 <- magick::image_edge(dog,radius = 5)
dog.fl6 <- magick::image_emboss(dog, radius = 1, sigma = 0.5)
dog.fl7 <- magick::image_negate(dog)
dog.fl <- c(dog.fl1,dog.fl2,dog.fl3,dog.fl4,dog.fl5,dog.fl6,dog.fl7)
dog.fl <- image_append(image_scale(dog.fl, "x200")) 
magick::image_write(dog.fl,"img2/dog_fl.jpg",format = "jpg")

# annotate (transformation)
magick::image_annotate(dog,"I am a dog!",size=70,gravity='northeast',color='red') 
magick::image_annotate(dog, "I've been working like a dog", size = 30, color = "red",
                       boxcolor = "pink",degrees = 10, location = "+150+600")
try(image_annotate(dog, "The quick brown fox", font = 'times-new-roman', size = 30), silent = T)

# color?
image_colorize(dog, 30, "black")

# append (editing)
magick::image_rotate(dog, 45)->dog2
magick::image_flip(dog)->dog3
img <- c(dog,dog2,dog3)
magick::image_append(image_scale(img, "x200")) 
magick::image_append(image_scale(img, "200"),stack = T) 

# layer (editing)
logo <- magick::image_read("https://www.r-project.org/logo/Rlogo.png")
magick::image_scale(dog, "500") ->dog500
magick::image_scale(logo, "200") ->logo200
img <- c(dog500 ,logo200)
image_mosaic(img)

# raster image
dog %>% magick::image_scale("200") %>% as.raster() %>% plot()
dog %>% magick::image_scale("200") %>% as.raster() ->dog.raster
dog.raster %>% object.size()
dog.raster %>% dim()
dog.raster %>% typeof()  
dog.raster

# 16進から10進への変換は前に0xを付ければいいみたい。> 0xff [1] 255
# 10進から16進へはちょっと面倒で、> sprintf("%X",255) [1] "FF"
code <- "#e5e0d5"
start <- c(2,4,6)
end <- c(3,5,7)
RGB16 <- substring(code,start,end)

colorcode2RGB <- function(code){
  start <- c(2,4,6)
  end <- c(3,5,7)
  RGB16 <- substring(code,start,end)
  #function(x) { eval(parse(text =sprintf("0x%s",x))) }
  to10 <- function(x) { eval(parse(text =sprintf("0x%s",x))) }
  RGB <- c(to10(RGB16[1]),to10(RGB16[2]),to10(RGB16[3]))
}
colorcode2RGB(code) %>% print()

RGB2YUB

rgb2hsv(code)

# graph+image
plot(cars)
rasterImage(dog, 20, 0, 25, 40)
# ggplot+image
library(ggplot2)
library(grid)
qplot(speed, dist, data = cars, geom = c("point", "smooth"))+theme_bw()
grid::grid.raster(image_scale(dog, "100"),x=0.8,y=0.2,width=0.18,height=0.24)

# OCR
img = image_read("img/US_sample.jpg")
crop_img = image_crop(img, geometry = "250x25+170+6")
crop_img
image_ocr(crop_img)

### EBImage #################################################################################
EBImage::readImage("img2/dog.jpg")
dog <- EBImage::readImage("img2/dog.jpg")
colorMode(dog) <- Grayscale
#options("EBImage.display")

dog %>% display()
dog %>% class()
dog %>% is.array()
dog
dog %>% display(method="raster")# Rstudioのviewer上で表示
#dog[1,1,]

# フォーマット変更 
EBImage::writeImage(dog, "img2/dog.png", quality = 95)

# resize
dog <- EBImage::resize(dog,600,800)
EBImage::resize(dog,120,160) %>% display(method="raster")  

# rotate
EBImage::rotate(dog,45) %>% display(method="raster")   # browserを消して、マウスカーソルをRstudioに戻すが面倒
EBImage::flip(dog) %>% display(method="raster")  
EBImage::flop(dog) %>% display(method="raster")   
dog[150:450, 150:550,] %>% display(method="raster")      # cut
EBImage::translate(dog,c(50,100)) %>% display(method="raster") 
EBImage::translate(dog,c(50,100))  ->dog_translate
EBImage::writeImage(dog_translate, "img2/dog_translate.jpg", quality = 95)

# filter h
temp <- makeBrush(21, shape='disc', step=FALSE)
temp <- temp/sum(temp)
filter2(dog, temp) %>% display()
# フィルターはmatrix
temp <- matrix(1, ncol=3, nrow=3)
temp[2,2] <- -8;temp
filter2(dog, temp) %>% display(title="Laplacian Filter")
temp <- matrix(-1, ncol=5, nrow=5)
temp[3,3] <- 24;temp
filter2(dog, temp) %>% display(title="High-pass filter")
x <- c(-1,-2,-1,0,0,0,1,2,1)
temp <- matrix(x, ncol=3, nrow=3,byrow = T);temp
filter2(dog, temp) %>% display(title="Sobel filter")
x <- c(1,2,1,2,4,2,1,2,1)*(1/16);x
temp <- matrix(x, ncol=3, nrow=3,byrow = T);temp
filter2(dog, temp) %>% display(title="Gaussian filter")

# annotate
dog %>% display(method="raster")
text(x = 20, y = 20, label = "dog", adj = c(0,1), col = "orange", cex = 2)
#font <- drawfont(weight=600,size=28)             drawfontはなくなった。
#drawtext(dog, xy=c(125, 200),font=font, labels="I am a dog", col="red") 

# append
dog_temp <- rbind(dog[,,1],EBImage::flip(dog)[,,1])
dog_temp
dog_temp %>% display()

# colormode
colorMode(dog) <- Grayscale
dog %>% display()
colorMode(dog) <- Color   
dog %>% display()


